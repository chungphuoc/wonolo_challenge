class HomesController < ApplicationController
  def index

  end

  def search_result
    result = call_api(params)
    @result = Kaminari.paginate_array(result['data']).page(params[:page] || 1).per(5)
    render 'not_found' if @result.count == 0
    @map_data = create_map_data(@result)
    render 'normal_view' if params[:view] == 'normal'
  end

private

  def call_api(params)
    # lat: 10.790261
    # lng: 106.658642
    hydra = Typhoeus::Hydra.hydra
    req = API.call_api('search', :get, {
        access_token: ACCESS_TOKEN,
        lat: params[:latitude],
        lng: params[:longitude],
        distance: params[:distance]
      }.reject { |k, v| v.nil? }
    )
    hydra.queue req
    hydra.run
    JSON.parse(req.response.body)
  end

  def create_map_data(data)
    result = Array.new
    data.each do |e|
      caption = e['caption'].present? ? e['caption']['text'] : ""
      result << {lat: e['location']['latitude'],
                 lng: e['location']['longitude'],
                 infowindow: "<a href=#{e['link']} target='_blank'><img src=#{e['images']['standard_resolution']['url']} width='200' height='150'></a><br> #{caption}" }
    end
    result
  end
end
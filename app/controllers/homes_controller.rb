class HomesController < ApplicationController
  def index

  end

  def search_result
    result = call_api(params)
    @result = Kaminari.paginate_array(result['data']).page(params[:page] || 1).per(5)
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
end
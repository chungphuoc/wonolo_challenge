class HomesController < ApplicationController
  def index
    # https://api.instagram.com/v1/media/search?access_token=206925589.1fb234f.13e36282e6574598924aba96ba302d11&
    # lat=48.858844&
    # lng=2.294351&
    # distance=1000
    hydra = Typhoeus::Hydra.hydra
    req = API.call_api('search', :get, {
        access_token: ACCESS_TOKEN,
        lat: 10.790261,
        lng: 106.658642
        # distance: 1000
      }.reject { |k, v| v.nil? }
    )
    hydra.queue req
    hydra.run
    @result = JSON.parse(req.response.body)
  end
end
# def getDistanceFromLatLonInKm(lat1,lon1,lat2,lon2) {
#   var R = 6371; // Radius of the earth in km
#   var dLat = deg2rad(lat2-lat1);  // deg2rad below
#   var dLon = deg2rad(lon2-lon1);
#   var a =
#     Math.sin(dLat/2) * Math.sin(dLat/2) +
#     Math.cos(deg2rad(lat1)) * Math.cos(deg2rad(lat2)) *
#     Math.sin(dLon/2) * Math.sin(dLon/2)
#     ;
#   var c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a));
#   var d = R * c; // Distance in km
#   return d;
# }

#   deg2rad(deg) {
#     return deg * (Math.PI/180)
#   }
# end
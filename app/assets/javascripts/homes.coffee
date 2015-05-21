map_data = $('#coordinates').data('value')
console.log(map_data[0].lat)
handler = Gmaps.build('Google')
handler.buildMap { internal: id: 'map' }, ->
  markers = handler.addMarkers(map_data)
  handler.bounds.extendWith markers
  handler.fitMapToBounds()
  return

class Supplier1Presenter < BasePresenter
  property :id
  property :destination_id
  property :name
  property :description

  property :amenity, as: -> (p) {
    amenity = Amenity.new
    p[:represented].amenity = amenity
    json = OpenStruct.new(p[:input])
    amenity.general = json.facilities
  }

  property :location, as: -> (p) {
    location = Location.new
    p[:represented].location = location
    json = OpenStruct.new(p[:input])

    location.lat = json.latitude
    location.lng = json.longitude
    location.address = json.address
    location.city = json.city
    location.country = json.country
  }

end
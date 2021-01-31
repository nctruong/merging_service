class Supplier3Presenter < BasePresenter
  property :id
  property :destination_id, as: :destination
  property :name
  property :description, as: :info

  property :location, as: -> (p) {
    location = Location.new
    p[:represented].location = location
    json = OpenStruct.new(p[:input])

    location.lat = json.lat
    location.lng = json.lng
    location.address = json.address
  }
end
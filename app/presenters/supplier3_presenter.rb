class Supplier3Presenter < BasePresenter
  property :id
  property :destination_id, as: :destination
  property :name
  property :description, as: :info
  
  property :amenity, as: -> (p) {
    amenity                 = Amenity.new
    p[:represented].amenity = amenity
    json                    = OpenStruct.new(p[:input])
    amenity.general         = json.facilities
  }
  
  property :location, as: -> (p) {
    location                 = Location.new
    p[:represented].location = location
    json                     = OpenStruct.new(p[:input])
    
    location.lat     = json.lat
    location.lng     = json.lng
    location.address = json.address
  }
  
  property :images, class: ImageCollection do
    collection :rooms, class: Image do
      property :link, as: :url
      property :description
    end
    
    collection :amenities, class: Image do
      property :link, as: :url
      property :description
    end
  end
end

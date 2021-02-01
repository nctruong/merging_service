class HotelPresenter < BasePresenter
  property :id
  property :destination_id
  property :name
  property :description
  property :booking_conditions
  
  property :location, extend: LocationPresenter, class: Location
  
  property :amenity, as: :amenities, extend: AmenityPresenter, class: Amenity
  
  property :images, class: ImageCollection do
    collection :rooms, class: Image do
      property :link
      property :description, as: :caption
    end
    
    collection :site, class: Image do
      property :link
      property :description, as: :caption
    end
  end
end

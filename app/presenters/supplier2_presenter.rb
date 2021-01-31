class Supplier2Presenter < BasePresenter
  property :id, as: :hotel_id
  property :destination_id
  property :name, as: :hotel_name
  property :description, as: :details
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
class Supplier2Presenter < BasePresenter
  property :id, as: :hotel_id
  property :destination_id
  property :name, as: :hotel_name
  property :description, as: :details

  property :location, extend: LocationPresenter, class: Location
end
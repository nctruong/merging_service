class ImageCollectionPresenter < BasePresenter
  collection :rooms, class: Image do
    property :link
    property :description, as: :caption
  end
  property :site
  property :amenities
end
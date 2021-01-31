module HotelProcurements
  class MergeImage < BaseService
    attr_reader :values

    def initialize(values)
      @values = values
      @images = ImageCollection.new
    end

    def call
      @images.rooms = []
      @images.site = []
      @images.amenities = []

      values.compact.each do |image_collection|
        @images.rooms += image_collection.rooms if image_collection.rooms
        @images.site += image_collection.site if image_collection.site
        @images.amenities += image_collection.amenities if image_collection.amenities
      end

      @images.rooms = select_uniq_image(@images.rooms)
      @images.site = select_uniq_image(@images.site)
      @images.amenities = select_uniq_image(@images.amenities)
      @images
    end

    private

    def select_uniq_image(images)
      visited = {}
      res = []
      images.each do |image|
        next if visited[image.link]

        res << image
        visited[image.link] = 1
      end
      res
    end
  end
end
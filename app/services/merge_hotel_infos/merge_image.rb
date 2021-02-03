module MergeHotelInfos
  class MergeImage < BaseService
    attr_reader :image_collection
    attr_reader :rooms, :site, :amenities
    
    def initialize(image_collection)
      @image_collection = image_collection
      
      @rooms     = []
      @site      = []
      @amenities = []
    end
    
    def call
      image_collection.compact.each do |collection|
        collect_images(collection)
      end
      
      ImageCollection.new(
        rooms: select_uniq_image(rooms),
        site: select_uniq_image(site),
        amenities: select_uniq_image(amenities)
      )
    end
    
    private
    
    def collect_images(image_collection)
      @amenities += image_collection.amenities if image_collection.amenities
      @site      += image_collection.site if image_collection.site
      @rooms     += image_collection.rooms if image_collection.rooms
    end
    
    def select_uniq_image(images)
      visited = {}
      res     = []
      images.each do |image|
        next if visited[image.link]
        
        res << image
        visited[image.link] = 1
      end
      res
    end
  end
end

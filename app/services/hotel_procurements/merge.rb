module HotelProcurements
  class Merge < BaseService
    attr_reader :hotels, :hotel
    
    def initialize(hotels)
      @hotels = hotels
      @hotel  = Hotel.new
    end
    
    def call
      @hotel.id             = hotels.first.id
      @hotel.destination_id = hotels.first.destination_id
      
      @hotel.name               = merge_name(attribute_collection.name)
      @hotel.location           = merge_location(attribute_collection.location)
      @hotel.description        = merge_description(attribute_collection.description)
      @hotel.amenity            = merge_amenities(attribute_collection.amenity)
      @hotel.images             = merge_images(attribute_collection.images)
      @hotel.booking_conditions = merge_booking_conditions(attribute_collection.booking_conditions)
      
      hotel
    end
    
    private
    
    def attribute_collection
      @attribute_collection ||= CollectAttribute.call(hotels)
    end
    
    def merge_name(names)
      MergeName.call(names)
    end
    
    def merge_location(locations)
      MergeLocation.call(locations)
    end
    
    def merge_description(descriptions)
      MergeDescription.call(descriptions)
    end
    
    def merge_amenities(amenities)
      MergeAmenity.call(amenities)
    end
    
    def merge_images(images)
      MergeImage.call(images)
    end
    
    def merge_booking_conditions(booking_conditions)
      MergeBookingCondition.call(booking_conditions)
    end
  end
end

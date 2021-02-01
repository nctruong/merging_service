module HotelProcurements
  class MergeInfo < BaseService
    attr_reader :hotels, :hotel
    
    def initialize(hotels)
      @hotels = hotels
      @hotel  = Hotel.new
    end
    
    def call
      @hotel.id             = hotels.first.id
      @hotel.destination_id = hotels.first.destination_id
      
      @hotel.name               = MergeName.call(attribute_collection.name)
      @hotel.location           = MergeLocation.call(attribute_collection.location)
      @hotel.description        = MergeDescription.call(attribute_collection.description)
      @hotel.amenity            = MergeAmenity.call(attribute_collection.amenity)
      @hotel.images             = MergeImage.call(attribute_collection.images)
      @hotel.booking_conditions = MergeBookingCondition.call(attribute_collection.booking_conditions)
      
      hotel
    end
    
    private
    
    def attribute_collection
      @attribute_collection ||= CollectAttribute.call(hotels)
    end
    
  end
end

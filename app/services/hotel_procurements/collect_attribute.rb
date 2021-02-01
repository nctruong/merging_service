module HotelProcurements
  class CollectAttribute < BaseService
    attr_reader :hotels, :hotel
    
    def initialize(hotels)
      @hotels = hotels
      @hotel  = Hotel.new
      
      init_attribute_value
    end
    
    def call
      hotels.each do |hotel|
        @hotel.name << hotel.name
        @hotel.description << hotel.description
        @hotel.amenity << hotel.amenity
        @hotel.images << hotel.images
        @hotel.booking_conditions << hotel.booking_conditions
        @hotel.location << hotel.location
      end
      
      hotel
    end
    
    private
    
    def init_attribute_value
      @hotel.name               = []
      @hotel.description        = []
      @hotel.amenity            = []
      @hotel.images             = []
      @hotel.booking_conditions = []
      @hotel.location           = []
    end
  end
end

module HotelProcurements
  class Merge < BaseService
    attr_reader :hotels, :merged_hotel

    def initialize(*hotels)
      @hotels = hotels
      @merged_hotel = Hotel.new
    end

    def call
      @merged_hotel.id = hotels.first.id
      @merged_hotel.destination_id = hotels.first.destination_id

      @merged_hotel.name = merge_name(hotel.name)
      @merged_hotel.location = merge_location(hotel.location)
      @merged_hotel.description = merge_description(hotel.description)
      @merged_hotel.amenity = merge_amenities(hotel.amenity)
      @merged_hotel.images = merge_images(hotel.images)
      @merged_hotel.booking_conditions = merge_booking_conditions(hotel.booking_conditions)

      merged_hotel
    end

    private

    def hotel
      @hotel ||= CollectAttribute.call(*hotels)
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
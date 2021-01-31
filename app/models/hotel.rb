class Hotel

  attr_accessor :id,
                :destination_id,
                :name,
                :description

  attr_accessor :amenity,
                :images,
                :booking_conditions

  attr_accessor :location

  delegate :lat, :lng, :address, :city, :country, to: :location
end
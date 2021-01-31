module HotelProcurements
  class MergeAmenity < BaseService
    attr_reader :values, :engine, :amenity

    def initialize(values, **options)
      @values = values
      @engine = options[:engine] || DataSelectionEngines::CollectUniqueData

      @amenity = Amenity.new
    end

    def call
      @amenity.general = []
      @amenity.room = []
      values.each do |value|
        @amenity.general += value.general if value.general
        @amenity.room += value.room if value.room
      end

      @amenity.general = engine.call(@amenity.general)
      @amenity.room = engine.call(@amenity.room)
      amenity
    end
  end
end
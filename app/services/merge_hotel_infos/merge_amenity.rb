module MergeHotelInfos
  class MergeAmenity < BaseService
    attr_reader :values, :engine
    
    def initialize(values, **options)
      @values = values
      @engine = SelectionEngines::CollectUniqueData
    end
    
    def call
      general = []
      room    = []
      values.compact.each do |value|
        general += value.general if value.general
        room    += value.room if value.room
      end
      
      Amenity.new(
        general: engine.call(general),
        room:    engine.call(room)
      )
    end
  end
end

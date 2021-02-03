module MergeHotelInfos
  class MergeLocation < BaseService
    attr_reader :values
    
    def initialize(values)
      @values = values
    end
    
    def call
      location = Location.new

      values.each do |loc|
        location.lat     ||= loc.lat if loc.lat
        location.lng     ||= loc.lng if loc.lng
        location.city    ||= loc.city if loc.city
        location.country ||= loc.country if loc.country
        location.address ||= loc.address if loc.address
      end
      
      location
    end
  end
end

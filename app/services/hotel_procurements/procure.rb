module HotelProcurements
  class Procure < BaseService
    attr_reader :hotels
    
    def initialize
      @hotels = {}
    end
    
    def call
      HotelProcurement.find_in_batches(batch_size: 100) do |hotel_procurements|
        hotel_procurements.each do |hotel_procurement|
          @hotels[hotel_procurement.hotel_id] = [] unless hotels[hotel_procurement.hotel_id]
          @hotels[hotel_procurement.hotel_id] << Hotel.new
          presenter(hotel_procurement).new(hotels[hotel_procurement.hotel_id].last)
            .from_json(hotel_procurement.response.to_json)
          
          procure
          clean
        end
      end
    end
    
    private
    
    def presenter(hotel_procurement)
      return Supplier1Presenter if hotel_procurement.supplier1?
      return Supplier2Presenter if hotel_procurement.supplier2?
      Supplier3Presenter if hotel_procurement.supplier3?
    end
    
    def clean
      HotelProcurement.delete_all
      @hotels = {}
    end
    
    def procure
      hotels.values.each do |hotels|
        hotel = MergeHotelInfos::Merge.call(hotels)
        ProcuredHotel.create(
          hotel_id:       hotel.id,
          destination_id: hotel.destination_id,
          data:           hotel.to_json
        )
      end
    end
  
  end
end

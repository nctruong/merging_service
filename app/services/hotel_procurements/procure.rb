module HotelProcurements
  class Procure < BaseService
    attr_reader :hotels
    
    def initialize
      @hotels = {}
    end
    
    def call
      ProcuredHotel.delete_all
      
      HotelProcurement.find_in_batches(batch_size: 100) do |hotel_procurements|
        
        hotel_procurements.each do |hotel_procurement|
          collect_hotels(hotel_procurement)

          procure
          clean
        end
      end
    end
    
    private

    def collect_hotels(hotel_procurement)
      @hotels[hotel_procurement.hotel_id] = [] unless hotels[hotel_procurement.hotel_id]
      @hotels[hotel_procurement.hotel_id] << Hotel.new
  
      presenter(hotel_procurement).new(hotels[hotel_procurement.hotel_id].last)
        .from_json(hotel_procurement.response.to_json)
    end

    def presenter(hotel_procurement)
      return Supplier1Presenter if hotel_procurement.supplier1?
      return Supplier2Presenter if hotel_procurement.supplier2?
      Supplier3Presenter if hotel_procurement.supplier3?
    end
    
    def clean
      @hotels = {}
    end
    
    def procure
      hotels.each do |hotel_id, hotels|
        hotel = ProcuredHotel.find_by(hotel_id: hotel_id)
        
        if hotel.present?
          hotels << HotelPresenter.new(Hotel.new).from_json(hotel.data)
          hotel.update(data: merge_hotels(hotels).to_json)
        else
          procured_hotel = merge_hotels(hotels)
          ProcuredHotel.create(
            hotel_id:       procured_hotel.id,
            destination_id: procured_hotel.destination_id,
            data:           procured_hotel.to_json
          )
        end
      end
    end

    def merge_hotels(hotels)
      MergeHotelInfos::Merge.call(hotels)
    end

  end
end

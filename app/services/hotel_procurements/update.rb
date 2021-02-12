module HotelProcurements
  class Update < BaseService
    def call
      clean_existing_procurement
      create_procurement
    end
    
    private
    
    def create_procurement
      Suppliers::HotelInfo.call do |supplier, hotel_json|
        
        HotelProcurement.create(
          supplier:       supplier[:name],
          hotel_id:       hotel_json[:id],
          destination_id: hotel_json[:destination_id].to_i,
          response:       hotel_json)
      end
    end
    
    def clean_existing_procurement
      HotelProcurement.delete_all
    end
  end
end

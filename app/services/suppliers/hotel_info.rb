require 'net/http'
require 'roar/json'

module Suppliers
  class HotelInfo
    def self.call
      suppliers = JSON.parse(File.read('config/suppliers.json'))

      suppliers.each do |supplier|
        response = JSON.parse(Net::HTTP.get(URI(supplier['endpoint'])))
        response.each do |hotel_data|
          yield(
            supplier.transform_keys(&:to_sym),
              JSON.parse(hotel_data.transform_keys(&:underscore).to_json)
          )
        end
      end
    end
  end
end

class HotelProcurement < ApplicationRecord
  enum supplier: %w(supplier1 supplier2 supplier3)
end

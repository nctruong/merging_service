class AddIndexToHotelProcurement < ActiveRecord::Migration[5.2]
  def change
    add_index :hotel_procurements, :hotel_id
    add_index :hotel_procurements, :destination_id
  end
end

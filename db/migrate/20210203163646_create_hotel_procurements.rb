class CreateHotelProcurements < ActiveRecord::Migration[5.2]
  def change
    create_table :hotel_procurements do |t|
      t.string :hotel_id
      t.integer :destination_id
      t.json :response

      t.timestamps
    end
  end
end

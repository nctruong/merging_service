class CreateProcuredHotels < ActiveRecord::Migration[5.2]
  def change
    create_table :procured_hotels do |t|
      t.string :hotel_id
      t.integer :destination_id
      t.json :data
      
      t.index :hotel_id
      t.index :destination_id

      t.timestamps
    end
  end
end

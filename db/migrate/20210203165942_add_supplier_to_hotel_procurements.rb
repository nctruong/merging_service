class AddSupplierToHotelProcurements < ActiveRecord::Migration[5.2]
  def change
    add_column :hotel_procurements, :supplier, :integer
  end
end

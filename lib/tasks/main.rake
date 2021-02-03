require 'roar/json'

desc 'Merge Hotel Info'
task update_procurement: :environment do
  HotelProcurements::Update.call
end

task procure: :environment do
  HotelProcurements::Procure.call
end

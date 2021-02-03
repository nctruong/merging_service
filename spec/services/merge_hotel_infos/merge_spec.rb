require 'rails_helper'

describe MergeHotelInfos::Merge do
  let(:response1) { JSON.parse(File.read('spec/data/supplier1.json')) }
  let(:response2) { JSON.parse(File.read('spec/data/supplier2.json')) }
  let(:response3) { JSON.parse(File.read('spec/data/supplier3.json')) }
  
  let(:hotel1) { Hotel.new }
  let(:hotel2) { Hotel.new }
  let(:hotel3) { Hotel.new }
  
  let(:hotel) {
    Supplier1Presenter.new(hotel1).from_json(
      response1.first.transform_keys(&:underscore).to_json
    )
    
    Supplier2Presenter.new(hotel2).from_json(
      response2.first.transform_keys(&:underscore).to_json
    )
    
    Supplier3Presenter.new(hotel3).from_json(
      response3.first.transform_keys(&:underscore).to_json
    )

    MergeHotelInfos::Merge.call([hotel1, hotel2, hotel3])
  }
  
  describe '.call' do
    it 'keeps id' do
      expect(hotel.id).to eq('iJhz')
    end
    
    it 'keeps destination' do
      expect(hotel.destination_id).to eq(5432)
    end
    
    it 'merges hotel name' do
      expect(hotel.name).to eq(['Beach Villas Singapore'])
    end
    
    it 'merges amenities' do
      expect(hotel.amenity.general.include?('Pool')).to be_truthy
    end
    
    it 'merges booking conditions' do
      expect(hotel.booking_conditions).to eq([
                                               "All children are welcome. One child under 12 years stays free of charge when using existing beds. One child under 2 years stays free of charge in a child's cot/crib. One child under 4 years stays free of charge when using existing beds. One older child or adult is charged SGD 82.39 per person per night in an extra bed. The maximum number of children's cots/cribs in a room is 1. There is no capacity for extra beds in the room.",
                                               "Pets are not allowed.",
                                               "WiFi is available in all areas and is free of charge.",
                                               "Free private parking is possible on site (reservation is not needed).",
                                               "Guests are required to show a photo identification and credit card upon check-in. Please note that all Special Requests are subject to availability and additional charges may apply. Payment before arrival via bank transfer is required. The property will contact you after you book to provide instructions. Please note that the full amount of the reservation is due before arrival. Resorts World Sentosa will send a confirmation with detailed payment information. After full payment is taken, the property's details, including the address and where to collect keys, will be emailed to you. Bag checks will be conducted prior to entry to Adventure Cove Waterpark. === Upon check-in, guests will be provided with complimentary Sentosa Pass (monorail) to enjoy unlimited transportation between Sentosa Island and Harbour Front (VivoCity). === Prepayment for non refundable bookings will be charged by RWS Call Centre. === All guests can enjoy complimentary parking during their stay, limited to one exit from the hotel per day. === Room reservation charges will be charged upon check-in. Credit card provided upon reservation is for guarantee purpose. === For reservations made with inclusive breakfast, please note that breakfast is applicable only for number of adults paid in the room rate. Any children or additional adults are charged separately for breakfast and are to paid directly to the hotel."
                                             ])
    end
    
    it 'merges description' do
      expect(hotel.description.include?("Surrounded by tropical gardens, these upscale villas in elegant Colonial-style buildings are part of the Resorts World Sentosa complex and a 2-minute walk from the Waterfront train station. Featuring sundecks and pool, garden or sea views, the plush 1- to 3-bedroom villas offer free Wi-Fi and flat-screens, as well as free-standing baths, minibars, and tea and coffeemaking facilities. Upgraded villas add private pools, fridges and microwaves; some have wine cellars. A 4-bedroom unit offers a kitchen and a living room. There's 24-hour room and butler service. Amenities include posh restaurant, plus an outdoor pool, a hot tub, and free parking.")).to be_truthy
    end
    
    context 'when images merged' do
      context 'when rooms images merged' do
        it 'merges exact unique images' do
          expect(hotel.images.rooms.any? { |image| image.link == 'https://d2ey9sqrvkqdfs.cloudfront.net/0qZF/2.jpg' }).to be_truthy
          expect(hotel.images.rooms.any? { |image| image.link == 'https://d2ey9sqrvkqdfs.cloudfront.net/0qZF/3.jpg' }).to be_truthy
          expect(hotel.images.rooms.any? { |image| image.link == 'https://d2ey9sqrvkqdfs.cloudfront.net/0qZF/4.jpg' }).to be_truthy
        end
        
        it 'does not duplicate images' do
          expect(hotel.images.rooms.size).to eq(3)
          expect(hotel.images.rooms.count { |image| image.link == 'https://d2ey9sqrvkqdfs.cloudfront.net/0qZF/2.jpg' }).to eq(1)
        end
      end
      
      context 'when site images merged' do
        it 'merges exact unique images' do
          expect(hotel.images.site.any? { |image| image.link == 'https://d2ey9sqrvkqdfs.cloudfront.net/0qZF/1.jpg' }).to be_truthy
        end
        
        it 'does not duplicate images' do
          expect(hotel.images.site.size).to eq(1)
        end
      end
      
      context 'when amenities images merged' do
        it 'merges exact unique images' do
          expect(hotel.images.amenities.any? { |image| image.link == 'https://d2ey9sqrvkqdfs.cloudfront.net/0qZF/0.jpg' }).to be_truthy
          expect(hotel.images.amenities.any? { |image| image.link == 'https://d2ey9sqrvkqdfs.cloudfront.net/0qZF/6.jpg' }).to be_truthy
        end
        
        it 'does not duplicate images' do
          expect(hotel.images.amenities.size).to eq(2)
        end
      end
    end
    
    it 'merges locations' do
      expect(hotel.location.lat).to eq(1.264751)
      expect(hotel.location.lng).to eq(103.824006)
      expect(hotel.location.city).to eq('Singapore')
      expect(hotel.location.country).to eq('SG')
      expect(hotel.location.address).to eq(' 8 Sentosa Gateway, Beach Villas ')
    end
  end
end

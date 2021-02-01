require 'rails_helper'

describe Supplier2Presenter do
  let(:response) {
    JSON.parse(File.read('spec/data/supplier2.json'))
  }

  let(:hotel) {
    hotel = Hotel.new
    Supplier2Presenter.new(hotel).from_json(
        response.first.transform_keys(&:underscore).to_json
    )
  }

  describe '#id' do
    it 'returns exact id' do
      expect(hotel.id).to eq('iJhz')
    end
  end

  describe '#destination_id' do
    it 'returns exact destination_id' do
      expect(hotel.destination_id).to eq(5432)
    end
  end

  describe '#name' do
    it 'returns exact name' do
      expect(hotel.name).to eq('Beach Villas Singapore')
    end
  end

  describe '#location' do
    it 'returns exact location' do
      expect(hotel.address).to eq('8 Sentosa Gateway, Beach Villas, 098269')
      expect(hotel.city).to be_nil
      expect(hotel.country).to eq('Singapore')
      expect(hotel.lat).to be_nil
      expect(hotel.lng).to be_nil
    end
  end

  describe '#description' do
    it 'returns exact description' do
      expect(hotel.description).to eq("Surrounded by tropical gardens, these upscale villas in elegant Colonial-style buildings are part of the Resorts World Sentosa complex and a 2-minute walk from the Waterfront train station. Featuring sundecks and pool, garden or sea views, the plush 1- to 3-bedroom villas offer free Wi-Fi and flat-screens, as well as free-standing baths, minibars, and tea and coffeemaking facilities. Upgraded villas add private pools, fridges and microwaves; some have wine cellars. A 4-bedroom unit offers a kitchen and a living room. There's 24-hour room and butler service. Amenities include posh restaurant, plus an outdoor pool, a hot tub, and free parking.")
    end
  end

  describe '#images' do
    it 'returns exact images' do
      expect(hotel.images.rooms.first.link).to eq('https://d2ey9sqrvkqdfs.cloudfront.net/0qZF/2.jpg')
      expect(hotel.images.rooms.first.description).to eq('Double room')
    end
  end

end


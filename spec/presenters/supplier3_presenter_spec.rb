require 'rails_helper'

describe Supplier3Presenter do
  let(:response) {
    JSON.parse(File.read('spec/data/supplier3.json'))
  }

  before(:each) do
    @hotel = Hotel.new
    Supplier3Presenter.new(@hotel).from_json(
        response.first.transform_keys(&:underscore).to_json
    )
  end

  describe '#id' do
    it 'returns exact id' do
      expect(@hotel.id).to eq('iJhz')
    end
  end

  describe '#destination_id' do
    it 'returns exact destination_id' do
      expect(@hotel.destination_id).to eq(5432)
    end
  end

  describe '#name' do
    it 'returns exact name' do
      expect(@hotel.name).to eq('Beach Villas Singapore')
    end
  end

  describe '#location' do
    it 'returns exact location' do
      expect(@hotel.address).to eq('8 Sentosa Gateway, Beach Villas, 098269')
      expect(@hotel.lat).to eq(1.264751)
      expect(@hotel.lng).to eq(103.824006)
    end
  end

  describe '#description' do
    it 'returns exact description' do
      expect(@hotel.description).to eq('Located at the western tip of Resorts World Sentosa, guests at the Beach Villas are guaranteed privacy while they enjoy spectacular views of glittering waters. Guests will find themselves in paradise with this series of exquisite tropical sanctuaries, making it the perfect setting for an idyllic retreat. Within each villa, guests will discover living areas and bedrooms that open out to mini gardens, private timber sundecks and verandahs elegantly framing either lush greenery or an expanse of sea. Guests are assured of a superior slumber with goose feather pillows and luxe mattresses paired with 400 thread count Egyptian cotton bed linen, tastefully paired with a full complement of luxurious in-room amenities and bathrooms boasting rain showers and free-standing tubs coupled with an exclusive array of ESPA amenities and toiletries. Guests also get to enjoy complimentary day access to the facilities at Asia’s flagship spa – the world-renowned ESPA.')
    end
  end

  describe '#images' do
    it 'returns exact images' do
      expect(@hotel.images.rooms.first.link).to eq('https://d2ey9sqrvkqdfs.cloudfront.net/0qZF/2.jpg')
      expect(@hotel.images.rooms.first.description).to eq('Double room')
    end
  end
end


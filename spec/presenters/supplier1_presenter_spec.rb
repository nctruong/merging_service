require 'rails_helper'

describe Supplier1Presenter do
  let(:response) {
    JSON.parse(File.read('spec/data/supplier1.json'))
  }
  let(:hotel) {
    hotel = Hotel.new
    Supplier1Presenter.new(hotel).from_json(
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
      expect(hotel.address).to eq(' 8 Sentosa Gateway, Beach Villas ')
      expect(hotel.city).to eq('Singapore')
      expect(hotel.country).to eq('SG')
      expect(hotel.lat).to eq(1.264751)
      expect(hotel.lng).to eq(103.824006)
    end
  end

  describe '#description' do
    it 'returns exact description' do
      expect(hotel.description).to eq('  This 5 star hotel is located on the coastline of Singapore.')
    end
  end

end


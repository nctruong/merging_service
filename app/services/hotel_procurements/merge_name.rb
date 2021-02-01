module HotelProcurements
  class MergeName < BaseService
    attr_reader :values, :engine

    def initialize(values)
      @values = values
      @engine = DataSelectionEngines::CollectUniqueData
    end

    def call
      engine.call(values)
    end
  end
end

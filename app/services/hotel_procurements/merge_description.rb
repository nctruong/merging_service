module HotelProcurements
  class MergeDescription < BaseService
    attr_reader :values, :engine

    def initialize(values, **options)
      @values = values
      @engine = DataSelectionEngines::CollectUniqueData
    end

    def call
      engine.call(values)
    end
  end
end

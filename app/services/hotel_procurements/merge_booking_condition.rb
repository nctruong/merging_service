module HotelProcurements
  class MergeBookingCondition < BaseService
    attr_reader :values, :engine

    def initialize(values, **options)
      @values = values
      @engine = options[:engine] || DataSelectionEngines::CollectUniqueData
    end

    def call
      engine.call(values).flatten
    end
  end
end
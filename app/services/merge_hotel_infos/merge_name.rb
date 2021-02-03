module MergeHotelInfos
  class MergeName < BaseService
    attr_reader :values, :engine

    def initialize(values)
      @values = values
      @engine = SelectionEngines::CollectUniqueData
    end

    def call
      engine.call(values)
    end
  end
end

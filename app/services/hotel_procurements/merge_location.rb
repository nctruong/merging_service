module HotelProcurements
  class MergeLocation < BaseService
    attr_reader :values

    def initialize(values)
      @values = values
    end

    def call
      values
    end
  end
end
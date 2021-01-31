module DataSelectionEngines
  class CollectUniqueData < BaseService
    attr_reader :values, :selected_values, :counter

    def initialize(values)
      @values = values
      @selected_values = []
      @counter = {}
    end

    def call
      values.each do |value|
        next if counter[value]

        @selected_values << value
        @counter[value] = 1
      end

      selected_values.compact
    end
  end
end
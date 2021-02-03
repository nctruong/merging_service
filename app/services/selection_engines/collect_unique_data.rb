module SelectionEngines
  class CollectUniqueData < BaseService
    attr_reader :values
    
    def initialize(values)
      @values  = values
      @result  = []
      @counter = {}
    end
    
    def call
      values.each do |value|
        next if @counter[value]
        
        @result << value
        
        block_given? ? @counter = yield(@counter, value) : @counter[value] = 1
      end
      
      @result.compact
    end
  end
end

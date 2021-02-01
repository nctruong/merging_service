class Amenity
  attr_accessor :general, :room
  
  def initialize(**params)
    @general = params[:general] || []
    @room    = params[:room] || []
  end
end

class ImageCollection
  attr_accessor :rooms, :site, :amenities
  
  def initialize(**params)
    @rooms     = params[:rooms] || []
    @site      = params[:site] || []
    @amenities = params[:amenities] || []
  end
end

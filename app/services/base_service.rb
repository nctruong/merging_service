class BaseService
  def self.call(*args)
    service = new(*args)
    service.call
  end
end

class ModelException < StandardError
  def initialize(opts = {})
    super "Test exception"
  end
end

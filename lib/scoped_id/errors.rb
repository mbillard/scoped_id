module ScopedId

  class ReadonlyAttributeError < StandardError
    attr_reader :attribute

    def initialize(attr_name, message = nil)
      @attribute = attr_name
      message ||= "#{attr_name} is readonly."
      super(message)
    end
  end

end

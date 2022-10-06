# frozen_string_literal: true

require_relative "md2starter/version"
require_relative "md2starter/converter"

module MD2Starter
  class << self
    def convert!(input)
      Converter.new(input)
    end
  end
end

module MD2Starter
  class Converter
    def to_s
      @starter
    end

    def initialize(markdown)
      @starter = open(markdown).read.upcase
    end
  end
end
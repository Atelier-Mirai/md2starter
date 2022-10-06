require_relative "md2starter/markdown"

module MD2Starter
  class << self
    def convert!(input)
      render_extensions = {}
      render_extensions[:link_in_footnote] = false
      render_extensions[:table_caption] = true

      parse_extensions = {}
      parse_extensions[:tables] = true
      parse_extensions[:strikethrough] = true
      parse_extensions[:fenced_code_blocks] = true
      parse_extensions[:footnotes] = true
      parse_extensions[:no_intra_emphasis] = true
      parse_extensions[:autolink] = true

      md = MD2Starter::Markdown.new(render_extensions, parse_extensions)
      md_doc = open(input).read

      p '----'
      puts md_doc.frozen?
      p "----"
      
      starter_doc = md.render(md_doc)
    end
  end
end

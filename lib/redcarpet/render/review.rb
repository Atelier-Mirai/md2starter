# frozen_string_literal: false

require 'digest/md5'
require 'uri'

module Redcarpet
  module Render
    class ReVIEW < Base

      # initialize
      ########################################################################
      def initialize(render_extensions={})
        super()
        @math = render_extensions[:math]
        @links = {}
        @math_inline_buf = []
        @math_block_buf = []
        @ruby_buf = []
      end

      # preprocess
      ########################################################################
      def preprocess(text)
        b_counter = -1
        while %r|\$\$(.+?)\$\$| =~ text
          text.sub!(%r|\$\$(.+?)\$\$|) do
            b_counter += 1
            @math_block_buf[b_counter] = $1
            "〓MATHBLOCK:#{b_counter}:〓"
          end
        end

        if @math
          i_counter = -1
          while %r|\$(.+?)\$| =~ text
            text.sub!(%r|\$(.+?)\$|) do
              i_counter += 1
              @math_inline_buf[i_counter] = $1
              "〓MATHINLINE:#{i_counter}:〓"
            end
          end
        end

        # るび
        r_counter = -1
        while %r|\{(.+?\|.+?)\}| =~ text
          text.sub!(%r|\{(.+?\|.+?)\}|) do
            r_counter += 1
            @ruby_buf[r_counter] = $1
            "〓RUBY:#{r_counter}:〓"
          end
        end

        text
      end

      # normal text
      ########################################################################
      def normal_text(text)
        text
      end

      # escape
      ########################################################################
      def escape_inline(text)
        ## }  -> \}
        ## \} -> \\\}
        ## .}  -> .\}
        text.gsub(/(.)?}/) do
          if $1 == '\\'
            replaced = '\\\\\\}'
          elsif $1
            replaced = $1 + '\\}'
          else
            replaced = '\\}'
          end
          replaced
        end
      end

      def escape_href(text)
        text.to_s.gsub(/,/){ '\\,' }
      end
      alias_method :escape_comma, :escape_href

      # block code
      ########################################################################
      def block_code(code, language)
        code_text = normal_text(code).chomp
        lang      = ""
        caption   = ""

        if language
          # lang, caption = "java: main.java".split(":").map(&:strip)
          lang, caption = language.split(":").map(&:strip)

          # if language =~ /caption=\"(.*)\"/
          #   caption = "["+$1+"]"
          # else
            # caption = "[][#{language}]"
          # end
        end

        if lang == "math"
          "//texequation[][#{caption}]{\n#{code.chomp}\n//}\n\n"
        elsif lang == "output"
          "//output[][#{caption}]{\n#{code_text}\n//}\n\n"
        elsif lang == "terminal"
          "//terminal[][#{caption}]{\n#{code_text}\n//}\n\n"
        elsif lang == "note"
          "//note[][#{caption}]{\n#{code_text}\n//}\n\n"
        elsif lang == "memo"
          "//memo[#{caption}]{\n#{code_text}\n//}\n\n"
        elsif lang == "tip"
          "//tip[#{caption}]{\n#{code_text}\n//}\n\n"
        elsif lang == "info"
          "//info[#{caption}]{\n#{code_text}\n//}\n\n"
        elsif lang == "warning"
          "//warning[#{caption}]{\n#{code_text}\n//}\n\n"
        elsif lang == "important"
          "//important[#{caption}]{\n#{code_text}\n//}\n\n"
        elsif lang == "caution"
          "//caution[#{caption}]{\n#{code_text}\n//}\n\n"
        elsif lang == "notice"
          "//notice[#{caption}]{\n#{code_text}\n//}\n\n"
        elsif lang == "column"
          "===[column] #{caption}\n#{code_text}\n\n===[/column]\n\n"
        elsif lang == "flushright"
          "//flushright{\n#{code_text}\n//}\n\n"
        elsif lang == "centering"
          "//centering{\n#{code_text}\n//}\n\n"
        elsif lang == "abstract"
          if caption.nil? || caption == "toc=on"
            "//abstract{\n#{code_text}\n//}\n\n//makechaptitlepage[toc=on]\n\n"
          else
            "//abstract{\n#{code_text}\n//}\n\n"
          end
        elsif lang == "chapterauthor"
          if caption.nil? || caption.empty?
            "//chapterauthor[#{code_text}]\n\n"
          else
            "//chapterauthor[#{caption}]\n\n"
          end
        elsif lang == "include"
          filename = File&.basename(caption.to_s)
          "//list[][#{filename}][file=source/#{caption},1]{\n//}\n\n"
        elsif lang == "image" || lang == "sideimage"
          if !code_text.empty?
            link = caption + '&content=' + code_text
          else
            link = caption
          end
          title = ""
          alt_text = ""
          image(link, title, alt_text) + "\n\n"
        else
          "//list[][#{caption}][1]{\n#{code_text}\n//}\n\n"
        end
      end

      # codespan
      ########################################################################
      def codespan(code)
        "@<code>{#{escape_inline(code)}}"
      end

      def block_quote(quote)
        quote_text = normal_text(quote).chomp
        quote_text.gsub!(/\A\n\n/, '')
        "//quote{\n#{quote_text}//}\n\n"
      end

      def block_html(raw_html)
        html_text = raw_html.chomp

        # html コメントなら 何も出力しない
        if html_text[0..3] == "<!--" && html_text[-3..-1] == "-->"
          return
        end

        # エラーメッセージを表示
        warning = "XXX: BLOCK_HTML: YOU SHOULD REWRITE IT"
        "\n//list[][]{\n#{warning}\n#{html_text}\n//}\n"
      end


      # header
      ########################################################################
      def header(title, level, anchor="")
        "#{"="*level} #{title}\n"
      end

      # table
      ########################################################################
      def paragraph(text)
        if text =~ /\ATable:(.*)\z/
          @table_caption = $1.strip
          "" # no output line
        elsif text =~ /\Achapterauthor:(.*)\z/
          @chapterauthor = $1.strip
          "//chapterauthor[#{@chapterauthor}]\n\n"
        elsif text =~ /\Ainclude:(.*)\z/
            link = $1.strip
            filename = File.basename(link)
            "//list[][#{filename}][file=source/#{link},1]{\n//}\n\n"
        else
          # "\n\n#{text}\n\n"
          "#{text}\n\n"
        end
      end

      def table(header, body)
        body.chomp!

        if @table_caption
          caption = @table_caption
          @table_caption = nil
        end

        column_count = 0
        body.each_line do |line|
          column_count = line.split(",").size
          break
        end

        tsize = "//tsize[][#{'|l'*column_count+'|'}]\n"
        "#{tsize}//table[][#{caption}][csv=on,headerrows=1]{\n#{header}#{body}\n//}\n\n"
      end

      def table_row(content)
        @sep = nil
        content+"\n"
      end

      def table_cell(content, alignment)
        sep = @sep
        @sep = ", "
        if content == ""
          content = " "
        end
        "#{sep}#{content}"
      end

      # image
      ########################################################################
      def image(link, title, alt_text)
        allowed_params = %w(width border side sep boxwidth content caption)

        path, query = link.split("?")
        filename = File.basename(path, ".*")

        if query
          query.gsub!("&", ",")
          hash = query.split(",").map { |attr| attr&.split("=") }.to_h

          # Remove unauthorized parameters
          hash.each do |key, value|
            !allowed_params.include? key and hash.delete(key)
          end

          if hash.key? "caption"
            alt_text = hash["caption"]
            hash.delete("caption")
          end

          # for sideimage
          sideimage = "side" if hash.key? "side"
          width     = hash.delete("width") if sideimage
          content   = hash.delete("content")
          content << "\n" if content
          option    = hash.map { |k, v| [k, v].join("=") }.join(",")
        end

        if sideimage
          "//sideimage[#{filename}][#{width}][#{option}]{\n#{content}//}"
        else
          "//image[#{filename}][#{alt_text}][#{option}]"
        end
      end

      # link
      ########################################################################
      def autolink(link, link_type)
        "@<href>{#{link}}"
      end

      def link(link, title, content)
        if content == "include"
          filename = File.basename(link)
          "//list[][#{filename}][file=source/#{link},1]{\n//}"
        else
          "@<href>{#{link},#{content}}"
        end
      end

      # decoration
      ########################################################################
      def emphasis(text)
        sandwitch_link('b', text)
      end

      def double_emphasis(text)
        "@<B>{#{escape_inline(text)}}"
      end

      def strikethrough(text)
        "@<del>{#{escape_inline(text)}}"
      end

      # list
      ########################################################################
      def list(content, list_type)
        ret = ""
        content.each_line do |item|
          case list_type
          when :ordered
            if item =~ /^ +(\d+\.) (.*)/
              ## XXX not support yet in Re:VIEW
              ret << " #{$1} #{$2.chomp}" << "\n"
            else
              ret << " 1. " << item
            end
          when :unordered
            if item =~ /^ (\*+) (.*)/
              ret << " *#{$1} #{$2.chomp}" << "\n"
            else
              ret << " * " << item
            end
          else
            # :nocov:
            raise "invalid type: #{list_type}"
            # :nocov:
          end
        end
        ret << "\n"
        ret
      end

      def list_item(content, list_type)
        content.gsub!(%r<\n//(image|indepimage)\[([^\]]*?)\][^\{]*({\n//})?\n>){
          "@<icon>{"+$2+"}\n"
        }
        case list_type
        when :ordered
          item = content.gsub(/\n(\s+[^0-9])/){ $1 }.gsub(/\n(\s+[0-9]+[^.])/){ $1 }.strip
          "#{item}\n"
        when :unordered
          item = content.gsub(/\n(\s*[^* ])/){ $1 }.strip
          "#{item}\n"
        else
          # :nocov:
          raise "invalid type: #{list_type}"
          # :nocov:
        end
      end

      # hr / br
      ########################################################################
      def hrule
        "//hr\n\n"
      end

      def linebreak
        "@<br>{}\n"
      end

      # footnote
      ########################################################################
      def footnote_ref(number)
        "@<fn>{#{number}}"
      end

      def footnotes(text)
        "#{text}"
      end

      def footnote_def(text, number)
        "//footnote[#{number}][#{text.strip}]\n"
      end

      # ruby
      ########################################################################
      def ruby(text)
        rt, rb = text.split(/\|/, 2)
        "@<ruby>{#{escape_inline(rt)},#{escape_inline(rb)}}"
      end

      # postprocess
      ########################################################################
      def postprocess(text)
        text = text.gsub(%r|^[ \t]+(//image\[[^\]]+\]\[[^\]]+\]{$\n^//})|, '\1')
        while %r|〓MATHBLOCK:(\d+):〓| =~ text
          # text.sub!(%r|〓MATHBLOCK:(\d+):〓|){ "\n//texequation[][]{\n" + escape_inline(@math_block_buf[$1.to_i]) + "\n//}\n" }
          text.sub!(%r|〓MATHBLOCK:(\d+):〓|){ "\n//texequation[][]{\n" + (@math_block_buf[$1.to_i]) + "\n//}\n" }
        end

        while %r|〓MATHINLINE:(\d+):〓| =~ text
          text.sub!(%r|〓MATHINLINE:(\d+):〓|){ "@<m>{" + escape_inline(@math_inline_buf[$1.to_i]) + "}" }
        end

        while %r|〓RUBY:(\d+):〓| =~ text
          text.sub!(%r|〓RUBY:(\d+):〓|){ ruby(@ruby_buf[$1.to_i]) }
        end

        text + @links.map { |key, link| footnote_def(link, key) }.join
      end

      def remove_inline_markups(text)
        text.gsub(/@<(?:b|strong|tt)>{([^}]*)}/, '\1')
      end

      def sandwitch_link(op, text)
        head, match, tail = text.partition(/@<href>{(?:\\,|[^}])*}/)

        if match.empty? && tail.empty?
          return "@<#{op}>{#{escape_inline(text)}}"
        end

        sandwitch_link(op, head) + match + sandwitch_link(op, tail)
      end
    end
  end
end

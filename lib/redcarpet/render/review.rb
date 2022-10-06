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
        @link_in_footnote = render_extensions[:link_in_footnote]

        @links = {}
        @cmd = render_extensions[:enable_cmd]

        @table_rlc = nil

        @math_inline_buf = []
        @math_block_buf = []
        @ruby_buf = []
      end

      # preprocess
      ########################################################################
      def preprocess(text)
        b_counter = -1
        while %r|\$\$(.+?)\$\$| =~ text
          t = +text
          t.sub!(%r|\$\$(.+?)\$\$|) do
            b_counter += 1
            @math_block_buf[b_counter] = $1
            "〓MATHBLOCK:#{b_counter}:〓"
          end
        end

        i_counter = -1
        while %r|\$(.+?)\$| =~ text
          t = +text
          t.sub!(%r|\$(.+?)\$|) do
            i_counter += 1
            @math_inline_buf[i_counter] = $1
            "〓MATHINLINE:#{i_counter}:〓"
          end
        end

        # るび
        r_counter = -1
        while %r|\{(.+?\|.+?)\}| =~ text
          t = +text
          t.sub!(%r|\{(.+?\|.+?)\}|) do
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
        caption = ""
        if language
          if language =~ /caption=\"(.*)\"/
            caption = "["+$1+"]"
          else
            caption = "[][#{language}]"
          end
        end

        if @cmd && (language == "shell-session" || language == "console")
          "\n//cmd[][]{\n#{code_text}\n//}\n"
        elsif language == "math"
          "\n//texequation[][]{\n#{code.chomp}\n//}\n"
        else
          "\n//list[#{caption}][]{\n#{code_text}\n//}\n"
        end
      end

      def block_quote(quote)
        quote_text = normal_text(quote).chomp
        quote_text.gsub!(/\A\n\n/, '')
        "\n//quote{\n#{quote_text}\n//}\n"
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

      # codespan
      ########################################################################
      def codespan(code)
        "@<code>{#{escape_inline(code)}}"
      end

      # header
      ########################################################################
      def header(title, level, anchor="")
        "\n#{"="*level} #{title}\n\n"
      end

      # table
      ########################################################################
      def paragraph(text)
        if text =~ /\ATable:(.*)\z/
          @table_caption = $1.strip  
          "" # no output line
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
        allowed_params = %w(width border side sep boxwidth content)

        path, query = link.split("?")
        filename = File.basename(path, ".*")

        if query
          query.gsub!("&", ",")
          # "width=50%,border=on"

          hash = query.split(",").map { |attr| attr&.split("=") }.to_h
          # {"width"=>"50%", "border"=>"on"}
          # {"width"=>"50%", "border"=>"on", "foo"=>"bar"}

          # 許可されていないパラメタを削除
          hash.each do |key, value|
            !allowed_params.include? key and hash.delete(key)
          end

          # sideimage の為に
          side = "side" if hash.key? "side"
          width = hash.delete("width") if side
          content = hash.delete("content")
          content << "\n" if content

          option = hash.map { |k, v| [k, v].join("=") }.join(",")
          # "width=50%,border=on"
        end

        if side
          "//sideimage[#{filename}][#{width}][#{option}]{\n#{content}//}"
        else
          "//image[#{filename}][#{alt_text}][#{option}]{\n//}"
        end
      end

      # link
      ########################################################################
      def autolink(link, link_type)
        # "@<href>{#{escape_href(link)}}"
        "@<href>{#{link}}"
      end

      def link(link, title, content)
        if @link_in_footnote
          key = Digest::MD5.hexdigest(link)
          @links[key] ||= link
          footnotes(content) + footnote_ref(key)
        else
          # content = escape_inline(remove_inline_markups(content))
          # "@<href>{#{escape_href(link)},#{escape_comma(content)}}"
          # "@<href>{#{escape_href(link)},#{content}}"
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
        "\n//hr\n"
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
        "\n//footnote[#{number}][#{text.strip}]\n"
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

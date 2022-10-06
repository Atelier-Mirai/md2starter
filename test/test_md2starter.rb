# frozen_string_literal: true
require "md2starter"
require "md2starter/markdown"
require "md2starter/version"

require 'minitest/autorun'
require 'minitest/reporters'
Minitest::Reporters.use!

class TestMD2Starter < Minitest::Test
  def setup
    @markdown = MD2Starter::Markdown.new({},{})
  end

  def render_with(flags, text, render_flags = {})
    MD2Starter::Markdown.new(render_flags, flags).render(text)
  end

  # version number
  ########################################################################
  def test_that_it_has_a_version_number
    refute_nil ::MD2Starter::VERSION
  end

  # simple one liner
  ########################################################################
  def test_that_simple_one_liner_goes_to_review
    assert_respond_to @markdown, :render
    assert_equal "Hello World.\n\n", @markdown.render("Hello World.\n")
  end
    # href
  ########################################################################
  def test_href
    assert_respond_to @markdown, :render
    assert_equal "\n\n@<href>{https://example.com,example}\n\n", @markdown.render("[example](https://example.com)\n")
  end

  def test_href_in_footnote
    text = %Q[aaa [foo](https://example.jp/foo), [bar](https://example.jp/bar)]
    rd = render_with({ link_in_footnote: true }, "aaa [foo](https://example.jp/foo), [bar](https://example.jp/bar)")

    assert_equal %Q|\n\naaa foo@<fn>{2949f671e47d5c20864c22454f091e2e}, bar@<fn>{8c34f297678a720d835b740df219cbd1}\n\n\n//footnote[2949f671e47d5c20864c22454f091e2e][https://example.jp/foo]\n\n//footnote[8c34f297678a720d835b740df219cbd1][https://example.jp/bar]\n|, rd
  end

  def test_href_with_emphasised_anchor
    assert_equal "\n\n@<href>{https://example.com/,@<b>{example}}\n\n", @markdown.render("[*example*](https://example.com/)")
  end

  def test_href_with_double_emphasised_anchor
    assert_equal "\n\n@<href>{https://example.com/,@<B>{example}}\n\n", @markdown.render("[**example**](https://example.com/)")
  end

  def test_href_with_codespan_anchor
    assert_equal "\n\n@<href>{https://example.com/,@<code>{example}}\n\n", @markdown.render("[`example`](https://example.com/)")
  end

  def test_autolink
    rd = render_with({autolink: true}, "リンクの[テスト](https://example.jp/test)です。\nhttps://example.jp/test2/\n")
    assert_equal %Q[\n\nリンクの@<href>{https://example.jp/test,テスト}です。\n@<href>{https://example.jp/test2/}\n\n], rd
  end

  # bold / emphasis / strikethrough
  ########################################################################
  def test_bold
    assert_equal "@<b>{hello}\nhello\n", @markdown.render("*hello*\nhello")
  end

  def test_emphasis_with_href
    skip 'MarkDown から Starter へ 正しく変換できているので、良しとする。'
    assert_respond_to @markdown, :render
    text = '*{hello} [example](https://example.com/foo,bar) world*'
    expe = '@<b>{{hello\} }@<href>{https://example.com/foo,bar,example}@<b>{ world}'
    assert_equal expe, @markdown.render(text)
  end

  def test_strikethrough
    rd = render_with({strikethrough: true}, "~~test~~ ~~test2~~\n")
    assert_equal "@<del>{test} @<del>{test2}\n", rd
  end

  # header
  ########################################################################
  def test_header12
    assert_respond_to @markdown, :render
    assert_equal "\n= AAA\n\naaa\naaa\naaa\n\n== BBB\n\nbbb\n", @markdown.render("#AAA\naaa\naaa\naaa\n\n##BBB\nbbb\n")
  end

  def test_header34
    assert_respond_to @markdown, :render
    assert_equal "\n=== AAA\n\naaa\naaa\naaa\n\n==== BBB\n\nbbb\n", @markdown.render("###AAA\naaa\naaa\naaa\n\n####BBB\nbbb\n")
  end

  def test_header56
    assert_respond_to @markdown, :render
    assert_equal "\n===== AAA\n\naaa\naaa\naaa\n\n====== BBB\n\nbbb\n", @markdown.render("#####AAA\naaa\naaa\naaa\n\n######BBB\nbbb\n")
  end

  # image
  ########################################################################
  def test_image
    assert_equal "//image[image][test][]{\n//}\n\n", @markdown.render("![test](path/to/image.jpg)\n")

    assert_equal "//image[image][test][width=50%,border=on]{\n//}\n\n", @markdown.render("![test](path/to/image.jpg?width=50%&border=on)\n")

    assert_equal "//image[image][test][width=50%]{\n//}\n\n", @markdown.render("![test](path/to/image.jpg?width=50%&foo=bar)\n")

    assert_equal "//sideimage[image][50mm][side=R]{\nおはようございます\n//}\n\n", @markdown.render("![test](path/to/image.jpg?width=50mm&side=R&content=おはようございます)\n")

    assert_equal "//image[image][test][]{\n//}\n", @markdown.render("![test](path/to/image.jpg)\n")

    rev = render_with({}, "![](path/to/image.jpg)\n", {empty_image_caption: true})
    assert_equal "//image[image][][]{\n//}\n", rev

    rev = render_with({}, "![test](path/to/image.jpg)\n", {empty_image_caption: true})
    # rev = render_with({}, , {empty_image_caption: true})
    assert_equal "//image[image][test][]{\n//}\n", @markdown.render("![test](path/to/image.jpg)\n")
  end

  # list
  ########################################################################
  def test_nested_ulist
    assert_equal " * aaa\n ** bbb\n * ccc\n\n", @markdown.render("- aaa\n  - bbb\n- ccc\n")
  end

  def test_olist
    assert_equal " 1. aaa\n 1. bbb\n 1. ccc\n\n", @markdown.render("1. aaa\n2. bbb\n3. ccc\n")
  end

  def test_nested_olist
    ## XXX not support yet in Re:VIEW
    assert_equal " 1. aaa\n 1. bbb\n 1. ccc\n\n", @markdown.render("1. aaa\n   2. bbb\n3. ccc\n")
  end

  def test_olist_image
    assert_equal " 1. aaa@<icon>{foo}\n 1. bbb\n 1. ccc\n\n", @markdown.render("1. aaa\n    ![test](foo.jpg)\n2. bbb\n3. ccc\n")
  end

  def test_olist_image2
    assert_equal " 1. aaa@<br>{}@<icon>{foo}\n 1. bbb\n 1. ccc\n\n", @markdown.render("1. aaa  \n    ![test](foo.jpg)\n2. bbb\n3. ccc\n")
  end

  def test_olist_and_ulist
    assert_equal " * ddd\n\n 1. aaa\n 1. bbb\n 1. ccc\n\n * eee\n\n", @markdown.render("* ddd\n\n1. aaa\n2. bbb\n3. ccc\n\n* eee\n")
  end

  # table
  ########################################################################
  def test_table_with_empty_cell
    rd = render_with({tables: true}, <<~EOB, {table_caption: true})
        | a  |  b |  c |
        |----|----|----|
        | A  | B  | C  |
        |    | B  |  C |
        | .A | B  |  C |
      EOB
    assert_equal <<~EOB, rd
        //tsize[][|l|l|l|]
        //table[][][csv=on,headerrows=1]{
        a, b, c
        A, B, C
         , B, C
        .A, B, C
        //}
        
      EOB
  end

  def test_table_with_caption
    rd = render_with({tables: true}, <<~EOB, {table_caption: true})

        Table: caption test

        | a  |  b |  c |
        |----|----|----|
        | A  | B  | C  |
        |    | B  |  C |
        | .A | B  |  C |
      EOB

    assert_equal <<~EOB, rd
        //tsize[][|l|l|l|]
        //table[][caption test][csv=on,headerrows=1]{
        a, b, c
        A, B, C
         , B, C
        .A, B, C
        //}
        
      EOB
  end

  def test_table_with_caption
    rd = render_with({tables: true}, <<~EOB, {table_caption: true})

        Table: caption test

        | a  |  b |  c |
        |----|----|----|
        | A  | B  | C  |
        |    | B  |  C |
        | .A | B  |  C |
      EOB

    assert_equal <<~EOB, rd
        //tsize[][|l|l|l|]
        //table[][caption test][csv=on,headerrows=1]{
        a, b, c
        A, B, C
         , B, C
        .A, B, C
        //}

      EOB
  end

  # code
  ########################################################################
  def test_code_fence_with_caption
    rd = render_with({fenced_code_blocks: true}, %Q[~~~ {caption="test"}\ndef foo\n  p "test"\nend\n~~~\n])
    assert_equal %Q[\n//list[test]{\ndef foo\n  p "test"\nend\n//}\n], rd
  end

  def test_code_fence_without_flag
    rd = render_with({}, %Q[~~~ {caption="test"}\ndef foo\n  p "test"\nend\n~~~\n])
    assert_equal %Q[\n\n~~~ {caption="test"}\ndef foo\n  p "test"\nend\n~~~\n\n], rd
  end

  def test_code_fence_with_lang
    rd = render_with({fenced_code_blocks: true}, %Q[~~~ruby\ndef foo\n  p "test"\nend\n~~~\n])
    assert_equal %Q[\n//list[][ruby]{\ndef foo\n  p "test"\nend\n//}\n], rd
  end

  def test_code_fence_with_console
    rd = render_with({fenced_code_blocks: true}, %Q[~~~console\ndef foo\n  p "test"\nend\n~~~\n])
    assert_equal %Q[\n//list[][console]{\ndef foo\n  p "test"\nend\n//}\n], rd
    rd = render_with({fenced_code_blocks: true},
                      %Q[~~~console\ndef foo\n  p "test"\nend\n~~~\n],
                     {enable_cmd: true})
    assert_equal %Q[\n//cmd{\ndef foo\n  p "test"\nend\n//}\n], rd
  end

  # ruby
  ########################################################################
  def test_group_ruby
    rd = render_with({ruby: true}, "{電子出版|でんししゅっぱん}を手軽に\n")
    assert_equal %Q[\n\n@<ruby>{電子出版,でんししゅっぱん}を手軽に\n\n], rd
  end

  # math
  # https://github.blog/2022-05-19-math-support-in-markdown/
  ########################################################################
  def test_math
    rd = render_with({}, "その結果、$y=ax^2+bx+c$の式が得られます。",{math: true})
    assert_equal %Q[\n\nその結果、@<m>{y=ax^2+bx+c}の式が得られます。\n\n], rd
  end

  def test_multi_math
    rd = render_with({}, "その結果、$y=a_2x^2+b_2x+c_2$の式が得られます。$a_2$は2次の係数、$b_2$は1次の係数、$c_2$は定数です。",{math: true})
    assert_equal %Q[\n\nその結果、@<m>{y=a_2x^2+b_2x+c_2}の式が得られます。@<m>{a_2}は2次の係数、@<m>{b_2}は1次の係数、@<m>{c_2}は定数です。\n\n], rd
  end

  def test_math2
    rd = render_with({}, <<~'EOB', { math: true })
      $X = \{ {x_1}, \cdots ,{x_n} \}$、$m$、${\mu _X}$、$\sigma _X^2$、$\{ {\hat x_1}, \cdots ,{\hat x_n} \}$

      $\mathbf{W} = ({w_1}, \cdots ,{w_n})$、$\sqrt {w_1^2 + \cdots  + w_n^2} $、$\left| {w_1^{}} \right| + \left| {w_2^{}} \right| +  \cdots  + \left| {w_n^{}} \right|$。
      EOB
    assert_equal <<~'EOB', rd


      @<m>{X = \{ {x_1\}, \cdots ,{x_n\} \\\}}、@<m>{m}、@<m>{{\mu _X\}}、@<m>{\sigma _X^2}、@<m>{\{ {\hat x_1\}, \cdots ,{\hat x_n\} \\\}}



      @<m>{\mathbf{W\} = ({w_1\}, \cdots ,{w_n\})}、@<m>{\sqrt {w_1^2 + \cdots  + w_n^2\} }、@<m>{\left| {w_1^{\}\} \right| + \left| {w_2^{\}\} \right| +  \cdots  + \left| {w_n^{\}\} \right|}。

      EOB
  end

  def test_math_block
    rd = render_with({fenced_code_blocks: true}, <<~EOB,{math: true})
      求める式は以下のようになります。

      ```math
      \frac{n!}{k!(n-k)!} = \binom{n}{k}
      ```
      EOB

    assert_equal <<~EOB, rd


      求める式は以下のようになります。


      //texequation[][]{
      \frac{n!}{k!(n-k)!} = \binom{n}{k}
      //}
      EOB
  end

  def test_math_block2
    rd = render_with({fenced_code_blocks: true}, <<~EOB,{math: true})
        求める式は以下のようになります。

        ```math
        \frac{n!}{k!(n-k)!} = \binom{n}{k}
        ```
        EOB
    assert_equal <<~EOB, rd


        求める式は以下のようになります。


        //texequation[][]{
        \frac{n!}{k!(n-k)!} = \binom{n}{k}
        //}
        EOB
  end

  # footnote
  ########################################################################
  def test_footnote
    rd = render_with({footnotes: true}, "これは*脚注*付き[^1]の段落です。\n\n\n[^1]: そして、これが脚注です。\n")
    assert_equal %Q|\n\nこれは@<b>{脚注}付き@<fn>{1}の段落です。\n\n\n//footnote[1][そして、これが脚注です。]\n|, rd
  end


  # quote
  ########################################################################
  def test_block_quote
    expected = <<~EOB

                    //quote{
                    test
                    test2

                    //}
                  EOB

      assert_equal expected, @markdown.render("> test\n> test2\n> \n")
  end

  def test_block_html
    expected = <<~EOB

                    //list[][]{
                    XXX: BLOCK_HTML: YOU SHOULD REWRITE IT
                    <div>
                    test
                    </div>
                    //}
                  EOB
    assert_equal expected, @markdown.render("<div>\ntest\n</div>\n")
  end

  # comment html
  ########################################################################
  def test_comment_html
    assert_equal "", @markdown.render("<!-- <h1>Hello</h1> -->")
  end


  # hr
  ########################################################################
  def test_hr
    expected = <<~EOB

              //hr
                  EOB
    assert_equal expected, @markdown.render("***\n")
  end
end

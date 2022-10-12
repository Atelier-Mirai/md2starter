# frozen_string_literal: false
require "tmpdir"

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

  # 各種変換テスト
  Dir.glob("test/fixtures/*.md").each do |file|
    define_method("test_template_#{File.basename(file, ".md")}") do
      assert_valid_from_markdown?(file.sub!(".md", ""))
    end
  end

  # version number
  ########################################################################
  def test_that_it_has_a_version_number
    refute_nil ::MD2Starter::VERSION
  end

  # simple one liner
  ########################################################################
  def test_that_simple_one_liner_goes_to_review_starter
    assert_respond_to @markdown, :render
    assert_equal "Hello World.\n\n", @markdown.render("Hello World.\n")
  end

    # href
  ########################################################################
  def test_href_in_footnote
    text = %Q[aaa [foo](https://example.jp/foo), [bar](https://example.jp/bar)]
    rd = render_with({ link_in_footnote: true }, "aaa [foo](https://example.jp/foo), [bar](https://example.jp/bar)")

    assert_equal %Q|\n\naaa foo@<fn>{2949f671e47d5c20864c22454f091e2e}, bar@<fn>{8c34f297678a720d835b740df219cbd1}\n\n\n//footnote[2949f671e47d5c20864c22454f091e2e][https://example.jp/foo]\n\n//footnote[8c34f297678a720d835b740df219cbd1][https://example.jp/bar]\n|, rd
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

  private

  def assert_valid_from_markdown?(file)
    IO.popen("bin/md2starter #{file}.md -", "r") do |f|
      assert_equal File.read("#{file}.re"), f.read
    end
  end
end

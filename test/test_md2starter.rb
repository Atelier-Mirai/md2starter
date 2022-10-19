# frozen_string_literal: false
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
  def test_that_simple_one_liner_goes_to_review_starter
    assert_respond_to @markdown, :render
    assert_equal "Hello World.\n\n", @markdown.render("Hello World.\n")
  end

  # Various conversion tests from markdown file
  ########################################################################
  Dir.glob("test/fixtures/*.md").each do |file|
    define_method("test_template_#{File.basename(file, ".md")}") do
      assert_valid_from_markdown?(file.sub!(".md", ""))
    end
  end

  private

  def assert_valid_from_markdown?(file)
    IO.popen("bin/md2starter #{file}.md -", "r") do |f|
      assert_equal File.read("#{file}.re"), f.read
    end
  end
end

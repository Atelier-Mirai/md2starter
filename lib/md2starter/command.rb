require 'optparse'
require 'md2starter'

module MD2Starter
  class Command

    def initialize(args)
      @args    = args
      @options = {}
    end

    def run
      @opts = OptionParser.new(&method(:set_opts))
      @opts.parse!(@args)
      process!
      exit 0
    rescue Exception => ex
      raise ex if @options[:trace] || SystemExit === ex
      $stderr.print "#{ex.class}: " if ex.class != RuntimeError
      $stderr.puts ex.message
      $stderr.puts '  Use --trace for backtrace.'
      exit 1
    end

    protected

    def set_opts(opts)
      opts.banner = "Usage: md2starter INPUT_FILENAME_OR_DIRECTORY [OUTPUT_FILENAME_OR_DIRECTORY] [options]"

      opts.on('--trace', :NONE, 'Show a full traceback on error') do
        @options[:trace] = true
      end

      opts.on_tail('-h', '--help', 'Show this message') do
        puts opts
        exit
      end

      opts.on_tail('-v', '--version', 'Print version') do
        puts "md2starter #{MD2Starter::VERSION}"
        exit
      end

      opts.on('-d', '--delete', "Delete markdown files") do
        @options[:delete] = true
      end

      opts.on('-m', '--math', "Math markdown enable") do
        @options[:math] = true
      end
    end

    def process!
      args = @args.dup

      @options[:input]  = file        = args.shift
      @options[:input]  = file        = "-" unless file
      @options[:output] = destination = args.shift

      if file == "-"
        puts @opts.to_s
        exit
      end

      if File.directory?(@options[:input])
        Dir["#{@options[:input]}/**/*.md"].each { |file| _process(file, destination) }
      else
        _process(file, destination)
      end
    end

    private

    def input_is_dir?
      File.directory? @options[:input]
    end

    def _process(file, destination = nil)
      require 'fileutils'
      starter_file = file.sub(/\.md/, '.re')

      if input_is_dir? && destination
        FileUtils.mkdir_p(File.dirname(starter_file).sub(@options[:input].chomp('/'), destination))
        starter_file.sub!(@options[:input].chomp('/'), destination)
      else
        starter_file = destination || starter_file
      end

      fail(ArgumentError, "Source and destination files can't be the same.") if @options[:input] != '-' && file == starter_file

      in_file = if @options[:input] == "-"
        $stdin
      else
        File.open(file, 'r')
      end

      @options[:output] = starter_file && starter_file != '-' ? File.open(starter_file, 'w') : $stdout
      @options[:output].puts MD2Starter.convert!(in_file, @options)
      @options[:output].close

      File.delete(file) if @options[:delete]
    end
  end
end

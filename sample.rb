# https://docs.ruby-lang.org/ja/latest/library/optparse.html

require "optparse"
require_relative "lib/md2starter/version"
opt = OptionParser.new
Version = Md2starter::VERSION

params = {}

opt.on('-a', '--aaa=[VAL]', 'description of -a') { |v| p v }
opt.on('-b', '--bbb') { |v| p v }
opt.on('-c', '--ccc') { |v| p v }
opt.on('-d') { |v| p v }
opt.on('--foo') { |v| p v }
opt.on('--bar') { |v| p v }
opt.on('--baz') { |v| p v }

# p "----"
# argv = opt.parse(ARGV)
# p ARGV
# p argv

# p "----"
opt.parse!(ARGV, into: params) # intoオプションにハッシュを渡す
p ARGV
p params
# p params[:a]

p "====="
# params = ARGV.getopts("a:b:", "foo", "bar:")
params = ARGV.getopts("a" "b:", "foo", "bar:")
p params

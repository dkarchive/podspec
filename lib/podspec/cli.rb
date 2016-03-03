# Command line interface
module Podspec  
  require 'podspec/parse'
  require 'podspec/spec'
  require 'podspec/version'

  class << self

    def usage
      puts "Usage: #{PRODUCT} <GitHub Repo>\n  i.e. #{PRODUCT} postmates/PMJSON"
    end

    def cli
      elapsed_time_start = Time.now

      puts "#{PRODUCT} #{VERSION}"

      if ARGV.count == 0
        usage
        exit
      end

      repo = ARGV[0].sub('https://github.com/', '')

      unless repo.include? '/'
        usage
        exit
      end

      parsed = parse repo

      e = parsed['error']
      unless e.nil?
        puts "Error: #{e}"
        exit
      end

      w = parsed['warnings']
      w.each do |x|
        puts "Warning: #{x}"
      end

      s = create_spec parsed

      filename = "#{parsed['name']}.podspec"
      File.open(filename, 'w') { |f| f.write(s) }
      elapsed_seconds = Time.now - elapsed_time_start

      puts "Wrote #{filename} in #{elapsed_seconds.round}s ✨"

      puts %{
• You can use an alternative author / authors format
• The deployment target(s) should be edited manually
Details → https://guides.cocoapods.org/syntax/podspec.html
}
    end # cli

  end # class
end # module

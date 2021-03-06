require "option_parser"
require "./converter.cr"

format = :all
color_blocks = true
color_strs = [] of String

OptionParser.parse do |parser|
  parser.banner = "Usage: colorconv [options] color ..."
  parser.on("-x", "--hex", "Format as hex") { format = :hex }
  parser.on("-X", "--hexa", "Format as hex+alpha") { format = :hexa }
  parser.on("-r", "--rgb", "Format as rgb") { format = :rgb }
  parser.on("-R", "--rgba", "Format as rgb+alpha") { format = :rgba }
  parser.on("-h", "--hsl", "Format as hsl") { format = :hsl }
  parser.on("-H", "--hsla", "Format as hsl+alpha") { format = :hsla }
  parser.on("-n", "--no-color", "Do not output color blocks") { color_blocks = false }
  parser.on("--help", "Print usage information") { puts parser; exit }

  parser.unknown_args {|positional| color_strs = positional}

  parser.invalid_option do |flag|
    STDERR.puts "ERROR: #{flag} is not a valid option."
    STDERR.puts parser
    exit(1)
  end
end

def make_bar(conv : Converter, count : Int32)
  "\033[38;2;#{conv.red};#{conv.green};#{conv.blue}m#{"\u2588" * count}\033[0m"
end

color_strs.each do |str|
  conv = Converter.new(str)

  if conv.is_valid
    if color_blocks && STDOUT.tty? && ENV["COLORTERM"]? == "truecolor"
      if format == :all
        puts make_bar(conv, 80)
      else
        print "#{make_bar(conv, 2)} "
      end
    end

    if format == :hex
      puts conv.hex()
    end
    if format == :hexa
      puts conv.hexa()
    end
    if format == :rgb
      puts conv.rgb()
    end
    if format == :rgba
      puts conv.rgb()
    end
    if format == :hsl
      puts conv.hsl()
    end
    if format == :hsla
      puts conv.hsla()
    end
    if format == :all
      puts "input:\t#{str}"
      puts "hex:\t#{conv.hex()}"
      puts "hexa:\t#{conv.hexa()}"
      puts "rgb:\t#{conv.rgb()}"
      puts "rgba:\t#{conv.rgba()}"
      puts "hsl:\t#{conv.hsl()}"
      puts "hsla:\t#{conv.hsla()}"
    end
  else
    STDERR.puts "malformed color: #{str}"
    exit(1)
  end
end

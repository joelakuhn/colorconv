require "./converter.cr"

ARGV.each do |arg|
  conv = Converter.new(arg)

  if conv.is_valid
    puts "input:\t#{arg}"
    puts "hex:\t#{conv.hex()}"
    puts "hexa:\t#{conv.hexa()}"
    puts "rgb:\t#{conv.rgb()}"
    puts "rgba:\t#{conv.rgba()}"
    puts "hsl:\t#{conv.hsl()}"
    puts "hsla:\t#{conv.hsla()}"
  else
    puts "malformed color: #{arg}"
  end
end

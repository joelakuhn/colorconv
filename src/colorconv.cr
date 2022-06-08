require "./hsl.cr"
require "./named_colors.cr"

ARGV.each do |arg|
  red : Int32 = 0
  green : Int32 = 0
  blue : Int32 = 0
  alpha : Float64 = 1.0
  hue : Float64 = 0.0
  saturation : Float64 = 0.0
  luminance : Float64 = 0.0
  hsl_set = false

  if NamedColors.colors.has_key?(arg)
    red, green, blue = NamedColors.colors[arg]
  elsif !(match = arg.match(/^#?([0-9a-fA-F][0-9a-fA-F])([0-9a-fA-F][0-9a-fA-F])([0-9a-fA-F][0-9a-fA-F])([0-9a-fA-F][0-9a-fA-F])$/)).nil?
    red = match[1].to_i(16)
    green = match[2].to_i(16)
    blue = match[3].to_i(16)
    alpha = match[4].to_i(16) / 255.0
  elsif !(match = arg.match(/^#?([0-9a-fA-F][0-9a-fA-F])([0-9a-fA-F][0-9a-fA-F])([0-9a-fA-F][0-9a-fA-F])$/)).nil?
    red = match[1].to_i(16)
    green = match[2].to_i(16)
    blue = match[3].to_i(16)
  elsif !(match = arg.match(/^#?([0-9a-fA-F])([0-9a-fA-F])([0-9a-fA-F])([0-9a-fA-F])$/)).nil?
    red = "#{match[1]}#{match[1]}".to_i(16)
    green = "#{match[2]}#{match[2]}".to_i(16)
    blue = "#{match[3]}#{match[3]}".to_i(16)
    alpha = "#{match[4]}#{match[3]}".to_i(16) / 255.0
  elsif !(match = arg.match(/^#?([0-9a-fA-F])([0-9a-fA-F])([0-9a-fA-F])$/)).nil?
    red = "#{match[1]}#{match[1]}".to_i(16)
    green = "#{match[2]}#{match[2]}".to_i(16)
    blue = "#{match[3]}#{match[3]}".to_i(16)
  elsif !(match = arg.match(/^hsla\s*\(\s*(\d+)\s*,\s*(\d+)\%\s*,\s*(\d+)\%\s*,\s*([\d\.]+)\)$/)).nil?
    hue = match[1].to_f
    saturation = match[2].to_f
    luminance = match[3].to_f
    hsl_set = true
    red, green, blue = hsl2rgb(hue, saturation, luminance)
    alpha = match[4].to_f
  elsif !(match = arg.match(/^hsl\s*\(\s*(\d+)\s*,\s*(\d+)\%\s*,\s*(\d+)\%\s*\)$/)).nil?
    hue = match[1].to_f
    saturation = match[2].to_f
    luminance = match[3].to_f
    hsl_set = true
    red, green, blue = hsl2rgb(hue, saturation, luminance)
  elsif !(match = arg.match(/^rgba\s*\(\s*(\d+)\s*,\s*(\d+)\s*,\s*(\d+)\s*,\s*([\d\.]+)\)$/)).nil?
    red = match[1].to_i
    green = match[2].to_i
    blue = match[3].to_i
    alpha = match[4].to_f
  elsif !(match = arg.match(/^rgb\s*\(\s*(\d+)\s*,\s*(\d+)\s*,\s*(\d+)\s*\)$/)).nil?
    red = match[1].to_i
    green = match[2].to_i
    blue = match[3].to_i
  else
    puts "malformed color: #{arg}"
    next
  end

  if !hsl_set
    hue, saturation, luminance = rgb2hsl(red, green, blue)
  end
  puts "input:\t#{arg}"
  puts "hex:\t##{red.to_s(16).rjust(2, '0')}#{green.to_s(16).rjust(2, '0')}#{blue.to_s(16).rjust(2, '0')}"
  puts "hexa:\t##{red.to_s(16).rjust(2, '0')}#{green.to_s(16).rjust(2, '0')}#{blue.to_s(16).rjust(2, '0')}#{(alpha * 255).to_i.to_s(16).rjust(2, '0')}"
  puts "rgb:\trgb(#{red}, #{green}, #{blue})"
  puts "rgba:\trgba(#{red}, #{green}, #{blue}, #{alpha.round(3)})"
  puts "hsl:\thsl(#{hue}, #{saturation}%, #{luminance}%)"
  puts "hsla:\thsla(#{hue}, #{saturation}%, #{luminance}%, #{alpha.round(3)})"
end

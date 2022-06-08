require "./hsl.cr"
require "./named_colors.cr"

class Converter
  property red : Int32 = 0
  property green : Int32 = 0
  property blue : Int32 = 0
  property alpha : Float64 = 1.0
  property hue : Float64 = 0.0
  property saturation : Float64 = 0.0
  property luminance : Float64 = 0.0
  property hsl_set : Bool = false
  property is_valid : Bool = true

  def initialize(str)
    if NamedColors.colors.has_key?(str)
      @red, @green, @blue = NamedColors.colors[str]
    elsif !(match = str.match(/^#?([0-9a-fA-F][0-9a-fA-F])([0-9a-fA-F][0-9a-fA-F])([0-9a-fA-F][0-9a-fA-F])([0-9a-fA-F][0-9a-fA-F])$/)).nil?
      @red = match[1].to_i(16)
      @green = match[2].to_i(16)
      @blue = match[3].to_i(16)
      @alpha = match[4].to_i(16) / 255.0
    elsif !(match = str.match(/^#?([0-9a-fA-F][0-9a-fA-F])([0-9a-fA-F][0-9a-fA-F])([0-9a-fA-F][0-9a-fA-F])$/)).nil?
      @red = match[1].to_i(16)
      @green = match[2].to_i(16)
      @blue = match[3].to_i(16)
    elsif !(match = str.match(/^#?([0-9a-fA-F])([0-9a-fA-F])([0-9a-fA-F])([0-9a-fA-F])$/)).nil?
      @red = "#{match[1]}#{match[1]}".to_i(16)
      @green = "#{match[2]}#{match[2]}".to_i(16)
      @blue = "#{match[3]}#{match[3]}".to_i(16)
      @alpha = "#{match[4]}#{match[3]}".to_i(16) / 255.0
    elsif !(match = str.match(/^#?([0-9a-fA-F])([0-9a-fA-F])([0-9a-fA-F])$/)).nil?
      @red = "#{match[1]}#{match[1]}".to_i(16)
      @green = "#{match[2]}#{match[2]}".to_i(16)
      @blue = "#{match[3]}#{match[3]}".to_i(16)
    elsif !(match = str.match(/^hsla\s*\(\s*(\d+)\s*,\s*(\d+)\%\s*,\s*(\d+)\%\s*,\s*([\d\.]+)\)$/)).nil?
      @hue = match[1].to_f
      @saturation = match[2].to_f
      @luminance = match[3].to_f
      @hsl_set = true
      @red, @green, @blue = hsl2rgb(@hue, @saturation, @luminance)
      @alpha = match[4].to_f
    elsif !(match = str.match(/^hsl\s*\(\s*(\d+)\s*,\s*(\d+)\%\s*,\s*(\d+)\%\s*\)$/)).nil?
      @hue = match[1].to_f
      @saturation = match[2].to_f
      @luminance = match[3].to_f
      @hsl_set = true
      @red, @green, @blue = hsl2rgb(@hue, @saturation, @luminance)
    elsif !(match = str.match(/^rgba\s*\(\s*(\d+)\s*,\s*(\d+)\s*,\s*(\d+)\s*,\s*([\d\.]+)\)$/)).nil?
      @red = match[1].to_i
      @green = match[2].to_i
      @blue = match[3].to_i
      @alpha = match[4].to_f
    elsif !(match = str.match(/^rgb\s*\(\s*(\d+)\s*,\s*(\d+)\s*,\s*(\d+)\s*\)$/)).nil?
      @red = match[1].to_i
      @green = match[2].to_i
      @blue = match[3].to_i
    else
      @is_valid = false
    end

    if !@hsl_set
      @hue, @saturation, @luminance = rgb2hsl(@red, @green, @blue)
    end

  end

  def hex()
    "##{@red.to_s(16).rjust(2, '0')}#{@green.to_s(16).rjust(2, '0')}#{@blue.to_s(16).rjust(2, '0')}"
  end

  def hexa()
    "##{@red.to_s(16).rjust(2, '0')}#{@green.to_s(16).rjust(2, '0')}#{@blue.to_s(16).rjust(2, '0')}#{(@alpha * 255).to_i.to_s(16).rjust(2, '0')}"
  end

  def rgb()
    "rgb(#{@red}, #{@green}, #{@blue})"
  end

  def rgba()
    "rgba(#{@red}, #{@green}, #{@blue}, #{@alpha.round(3)})"
  end

  def hsl()
    "hsl(#{@hue}, #{@saturation}%, #{@luminance}%)"
  end

  def hsla()
    "hsla(#{@hue}, #{@saturation}%, #{@luminance}%, #{@alpha.round(3)})"
  end
end

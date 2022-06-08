def hue2rgb(p : Float64, q : Float64, t : Float64) : Float64
  if t < 0; t += 1; end
  if t > 1; t -= 1; end
  if t < 1.0 / 6.0; return p + (q - p) * 6 * t; end
  if t < 1.0 / 2.0; return q; end
  if t < 2.0 / 3.0; return p + (q - p) * (2/3 - t) * 6; end
  return p;
end

def hsl2rgb(h : Float64, s : Float64, l : Float64) : Tuple(Int32, Int32, Int32)
  r : Float64 = 0
  g : Float64 = 0
  b : Float64 = 0

  hf : Float64 = h / 360.0
  sf : Float64 = s / 100.0
  lf : Float64 = l / 100.0

  if s == 0
    r = g = b = lf;
  else
    q : Float64 = lf < 0.5 ? lf * (1 + sf) : lf + sf - lf * sf;
    p : Float64 = 2 * lf - q;
    r = hue2rgb(p, q, hf + 1.0 / 3.0)
    g = hue2rgb(p, q, hf)
    b = hue2rgb(p, q, hf - 1.0 / 3.0)
  end

  return { (r * 255).round.to_i, (g * 255).round.to_i, (b * 255).round.to_i };
end


def rgb2hsl(r : Int32, g : Int32, b : Int32) : Tuple(Float64, Float64, Float64)
  rf : Float64 = r.to_f / 255.0
  gf : Float64 = g.to_f / 255.0
  bf : Float64 = b.to_f / 255.0
  max : Float64 = [rf, gf, bf].max
  min : Float64 = [rf, gf, bf].min
  h : Float64 = 0.0
  s : Float64 = 0.0
  l : Float64 = (max + min) / 2.0

  if r == g && g == b
      h = 0.0
      s = 0.0
  else
    d : Float64 = max - min;
    s = l > 0.5 ? d / (2.0 - max - min) : d / (max + min)
    h = case max
    when rf
      (gf - bf) / d + (gf < bf ? 6.0 : 0.0)
    when gf
      (bf - rf) / d + 2.0
    when bf
      (rf - gf) / d + 4.0
    else
      0.0
    end
    h = h / 6.0
  end

  return (h * 360).round(3), (s * 100).round(3), (l * 100).round(3)
end

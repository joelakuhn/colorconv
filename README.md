# colorconv

Command line CSS color converter

## Building

```shell
shards build --release
```

## Usage

Just give colorconv a css string as an argument and colorconv will parse it and output all currently supported color formats (excluding short hex formats)

```shell
$ colorconv 'rgba(24, 90, 220, .9)'
input:	rgba(24, 90, 220, .9)
hex:	#185adc
hexa:	#185adce5
rgb:	rgb(24, 90, 220)
rgba:	rgba(24, 90, 220, 0.9)
hsl:	hsl(219.796, 80.328%, 47.843%)
hsla:	hsla(219.796, 80.328%, 47.843%, 0.9)
```

```shell
$ colorconv '#fa4616'
input:	#fa4616
hex:	#fa4616
hexa:	#fa4616ff
rgb:	rgb(250, 70, 22)
rgba:	rgba(250, 70, 22, 1.0)
hsl:	hsl(12.632, 95.798%, 53.333%)
hsla:	hsla(12.632, 95.798%, 53.333%, 1.0)
```
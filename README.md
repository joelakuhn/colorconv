# colorconv

Command line CSS color converter

## Building

```shell
shards build --release
```

## Usage

Just give colorconv a css string as an argument and colorconv will parse it and output all currently supported color formats (excluding short hex formats). You can specify options to output specific color formats.

```shell
Usage: colorconv [options] color ...
    -x, --hex                        Format as hex
    -X, --hexa                       Format as hex+alpha
    -r, --rgb                        Format as rgb
    -R, --rgba                       Format as rgb+alpha
    -h, --hsl                        Format as hsl
    -H, --hsla                       Format as hsl+alpha
    --help                           Print usage information
```

## Examples

Print all formats for a given rgba color

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

Print the rgb format for a given hex color

```shell
$ colorconv -r '#fa4616'
rgb(250, 70, 22)
```

Print the hsl format for a given named color

```shell
$ colorconv -h 'aliceblue'
hsl(208.0, 100.0%, 97.059%)
```

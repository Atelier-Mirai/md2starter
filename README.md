# MD2Starter

MD2Starter is a CLI tool to convert from Markdown into [Re:VIEW Starter](https://kauplan.org/reviewstarter/).
This command uses Redcarpet gem to parse markdown.

## Installation

Install it yourself as:

    $ gem install md2starter

## Usage

You may convert files using the included executables `md2starter`.

    $ md2starter -h
    Usage: md2starter INPUT_FILENAME_OR_DIRECTORY [OUTPUT_FILENAME_OR_DIRECTORY] [options]
            --trace                      Show a full traceback on error
        -d, --delete                     Delete markdown files
        -m, --math                       Math markdown enable
        -h, --help                       Show this message
        -v, --version                    Print version

See [USAGE.md](./USAGE.md) for more information on Markdown and Starter format notation.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## History

### v1.0.0
- Initial release

## Author

[Atelier Mirai](https://atelier-mirai.net)

## Thanks

This Gem is based on [html2slim](https://github.com/slim-template/html2slim) and [md2review](https://github.com/takahashim/md2review). We thank the authors.

## OFFICIAL REPOSITORY

[https://github.com/Atelier-Mirai/md2starter](https://github.com/Atelier-Mirai/md2starter)

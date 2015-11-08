# WorkGuide

WorkGuide is a CLI tool to listup your routine tasks.

```
+-----+-----+--------+------------------+-------------------------+
|index|cycle|priorify|description       |done_at                  |
+-----+-----+--------+------------------+-------------------------+
|0    |daily|high    |Study langueages  |2015-11-07 00:04:44 +0900|
|1    |daily|medium  |Review team repos |2015-11-07 00:13:56 +0900|
|2    |daily|low     |Running at gym    |2015-11-07 18:58:15 +0900|
+-----+-----+--------+------------------+-------------------------+
```

## Installation

    $ gem install work_guide

## Usage

```
Commands:
  wguide add [guide description]  # Add a new guide
  wguide delete [index]           # Delete a guide
  wguide done [index]             # Mark as done
  wguide help [COMMAND]           # Describe available commands or one specific command
  wguide list                     # List guides
  wguide update [index]           # Edit a guide
```

## Development

`rake test` to test all.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/work_guide. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

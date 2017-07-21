# JupyterToScrapbox

The Jupyter Notebook http://jupyter.org is an open-source web application that allows you to create and share documents that contain live code and explanatory text.

Scrapbox http://scrapbox.io is a novel note-taking service for teams.

This tool converts jupyter notebook files to json file suitable for import to scrapbox.

## Installation

This tool, written in Ruby, is distributed via rubygem. https://rubygems.org/gems/jupyter_to_scrapbox

To install, invoke gem install command:

```ruby
gem install jupyter_to_scrapbox
```

## Usage

Input files are jupyter notebook files. (file extension = .ipynb)

Invoke this tool by:

```ruby
    $ bundle exec jupyter_to_scrapbox convert FILES > scrapbox.json
```

To import `scrapbox.json` to scrapbox, follow the instruction of "import pages" tool of "scrapbox" at the url:
    https://scrapbox.io/help/インポート・エクスポートする

Specify `scrapbox.json` created by this tool.

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/hsugawa8651/jupyter_to_scrapbox_gem.

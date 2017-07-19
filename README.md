# JupyterToScrapbox

The Jupyter Notebook http://jupyter.org is an open-source web application that allows you to create and share documents that contain live code and explanatory text.

Scrapbox http://scrapbox.io is a novel note-taking service for teams.

This tool converts jupyter notebook file to json file suitable for import to scrapbox.

TODO: Delete this and the text above, and describe your gem

Warning : under condtruction. do not believe the instruction below.

## Installation

Add this line to your application's Gemfile:

```ruby
gem install jupyter_to_scrapbox
```

## Usage


    $ bundle exec jupyter_to_scrapbox convert FILE > scrapbox.json

Follow the instruction of scrapbox's "import pages" tool at the url:
    https://scrapbox.io/help/インポート・エクスポートする

Specify the scrapbox.json file created by this tool.

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/hsugawa8651/jupyter_to_scrapbox_gem.

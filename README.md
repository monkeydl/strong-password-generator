# Strong::Password::Generator

Simple gem that helps you create a strong password, as the name suggested.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'strong-password-generator'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install strong-password-generator

## Usage

Quick and easy way to get you a 8 characters length password with at least:
- One special character
- One numeric
- One uppercase letter
```
password = StrongPassword::Generator.new.execute
```
Or you can specify the exact combination that you wants
```
generator = StrongPassword::Generator.new(mixed_case: 2, numeric: 2, special_char: 2, total_chars: 16)
password = generator.execute
``` 

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/monkeydl/strong-password-generator. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).


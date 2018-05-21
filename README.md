# SpreeDhlShippingLabeler

This gem let us generate labels for shippings and get status tracking of our shippings

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'spree_dhl_shipping_labeler'
```

And then execute:

```shell
bundle
bundle exec rails g spree_dhl_shipping_labeler:install
```

Or install it yourself as:

```shell
    $ gem install spree_dhl_shipping_labeler
```

Config your access keys:
```
common: &test_environment_settings
  userId:        'YOUR_USER_KEY_ID_DEVELOPMENT'
  key:           'YOUR_SECRET_KEY'
  accountId:     'YOUR_ACCOUNT_ID'

production:
  userId:        'YOUR_USER_KEY_ID_PRODUCTION'
  key:           'YOUR_SECRET_KEY_PRODUCTION'
  accountId:     'YOUR_ACCOUNT_ID'

development:
  <<: *test_environment_settings

```
## Test
Testing with Rspec

```shell
    $ rspec spec
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/2bedigital/spree_dhl_shipping_labeler.


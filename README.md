# SendGridClient

The SendGrid gem simplifies email dispatch via SendGrid's API

## Installation

1. Add this gem to your `Gemfile`
```shell
gem 'send_grid_client', github: 'gojilabs/send_grid_client', tag: '<latest tag>'
```
2. Install gem
```shell
bundle install
```
3. Generate initializer:
```shell
rails generate send_grid_client:install
```
4. Open initializer `config/initializers/send_grid_client.rb`
- set SendGrid settings (API key and default sender email address)

## Usage

### Create SendGrid email attachement

```ruby
# @param file_path_or_blob [Pathname, ActiveStorage::Blob] full path to file or Active Storage blob record
# @param disposition [String] (Optional) attachment disposition, inline by default
# @param content_id [String] (Optional) attachment unique content identifier
::SendGridClient::PayloadGenerators::AttachmentGenerator.call(file_path_or_blob)

# An example:
file_attachment = ::SendGridClient::PayloadGenerators::AttachmentGenerator.call(
  Rails.root.join("app/assets/images/logo.png"), 
  disposition: 'inline',
  content_id: 'unique-img-src-in-template'
)

# One more example:
blob_attachment = ::SendGridClient::PayloadGenerators::AttachmentGenerator.call(
  SomeModel.first.image.blob,
  disposition: 'inline',
  content_id: 'unique-img-src-in-template'
)
```

### Send email notification
```ruby
# @param email_to [String] receiver email address
# @param template_id [String] SendGrid template identifier
# @param template_data [Hash] SendGrid template payload
# @param attachments [Array<SendGrid::Attachment>] (Optional) array of SendGrid attachments
::SendGridClient::SendEmailService.call(email_to:, template_id:, template_data:)

# An example:
::SendGridClient::SendEmailService.call(
  email_to: 'test@example.com',
  template_id: 'd-b7c8345kj6h3lkj4h56k3546',
  template_data: {
    full_name: 'John Doe',
    button_url: 'https://universal_link_somewhere'
  },
  attachments: [file_attachment, blob_attachment]
)
```

## Development

Feel free to improve something, add more unit test or extend this gem with new logic.
Steps to do this:
- open PR
- test your code, confirm that it does not break existing functionality
- bump gem version in your PR
- once it will be merged, on the main branch - create a new tag with your version, create a release

# frozen_string_literal: true

require_relative 'lib/send_grid_client/version'

Gem::Specification.new do |spec|
  spec.name = 'send_grid_client'
  spec.version = SendGridClient::VERSION
  spec.authors = ['Bohdan Malets']
  spec.email = ['bohdan@gojilabs.com']

  spec.summary = 'SendGrid client gem'
  spec.description = 'The SendGrid gem simplifies email dispatch via SendGrid\'s API'
  spec.required_ruby_version = '>= 3.3'

  spec.metadata['source_code_uri'] = 'https://github.com/gojilabs/send_grid_client'
  spec.metadata['changelog_uri'] = 'https://github.com/gojilabs/send_grid_client/blob/main/CHANGELOG.md'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .circleci appveyor Gemfile])
    end
  end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'rails', '~> 7.0'
  spec.add_dependency 'sendgrid-ruby', '~> 6.6.2'

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
  spec.metadata['rubygems_mfa_required'] = 'true'
end

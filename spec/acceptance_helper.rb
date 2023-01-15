require 'rails_helper'
require 'rspec_api_documentation/dsl'

RspecApiDocumentation.configure do |config|
  config.format = :json
  config.request_body_formatter = proc do |params|
    if RSpec.current_example.metadata[:headers].try(:[], 'Content-Type').eql?('application/json')
      params.empty? ? nil : params.to_json
    else
      params
    end
  end
  config.curl_host = 'http://localhost:3000'
  config.api_name = 'Bid API'
  config.request_headers_to_include = %w[Accept Content-Type Access-Token]
  config.response_headers_to_include = %w[Content-Type Access-Token]
  config.curl_headers_to_filter = %w[Cookie Host]
  config.keep_source_order = true
end

Gem::Specification.new do |s|
  s.name = "ruby-whatcounts"
  s.version = "0.1.0"
  s.date = "2008-06-03"
  s.summary = "Ruby library for the WhatCounts HTTP API"
  s.email = "pdsphil@gmail.com"
  s.homepage = "http://github.com/pdsphil/ruby-whatcounts"
  s.description = "This library allows you to send a message using the WhatCounts HTTP API. It uses the One-Off-Message 'send' method."
  s.authors = ["Phil Ripperger, Kevin Weller"]
  s.platform = Gem::Platform::RUBY
  
  # output from - Dir.glob("{lib}/**/*")
  # github does not like the Dir.glob command, just paste results from running locally here
  s.files = ["lib/ruby-whatcounts.rb", "lib/whatcounts", "lib/whatcounts/api.rb", "lib/whatcounts/api_request.rb", "lib/whatcounts/api_response.rb", "lib/whatcounts/base.rb", "lib/whatcounts/certs", "lib/whatcounts/certs/cacert.pem", "lib/whatcounts/log", "lib/whatcounts/log/error.log", "lib/whatcounts/spec", "lib/whatcounts/spec/api_request_spec.rb", "lib/whatcounts/spec/api_response_spec.rb", "lib/whatcounts/spec/base_spec.rb", "lib/whatcounts/spec/spec_helper.rb"]
  
  s.has_rdoc = true
  s.extra_rdoc_files = ["README"]
  
  s.require_path = "lib"
  s.autorequire = "ruby-whatcounts"
  
#  s.add_dependency("mime-types", ["> 0.0.0"])
end
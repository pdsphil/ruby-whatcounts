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
  s.files = ["lib/what_counts", "lib/what_counts/api.rb", "lib/what_counts/api_request.rb", "lib/what_counts/api_response.rb", "lib/what_counts/base.rb", "lib/what_counts/certs", "lib/what_counts/certs/cacert.pem", "lib/what_counts/log", "lib/what_counts/spec", "lib/what_counts/spec/api_request_spec.rb", "lib/what_counts/spec/api_response_spec.rb", "lib/what_counts/spec/base_spec.rb", "lib/what_counts/spec/spec_helper.rb", "lib/what_counts.rb"]
  
  s.has_rdoc = true
  s.extra_rdoc_files = ["README"]
  
  s.require_path = "lib"
  s.autorequire = "what_counts"
  
#  s.add_dependency("mime-types", ["> 0.0.0"])
end
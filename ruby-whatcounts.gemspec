Gem::Specification.new do |s|
  s.name = "ruby-whatcounts"
  s.version = "0.1.0"
  s.date = "2008-06-03"
  s.summary = "Ruby library for the WhatCounts HTTP API"
  s.email = "pdsphil@gmail.com"
  s.homepage = "http://github.com/pdsphil/ruby-whatcounts"
  s.description = "This library allows you to send a message using the WhatCounts HTTP API. It uses the One-Off-Message 'send' method."
  s.authors = ["Phil Ripperger"]
  s.platform = Gem::Platform::RUBY
  
  candidates = Dir.glob("{lib}/**/*")
  s.files = candidates.delete_if { |item| item.include?(".log") || item.include?("rdoc") }
  
  s.has_rdoc = true
  s.extra_rdoc_files = ["README"]
  
  s.require_path = "lib"
  s.autorequire = "what_counts"
  
#  s.add_dependency("mime-types", ["> 0.0.0"])
end
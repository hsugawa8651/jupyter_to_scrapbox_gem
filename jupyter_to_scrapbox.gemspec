# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "jupyter_to_scrapbox/version"

Gem::Specification.new do |spec|
  spec.name          = "jupyter_to_scrapbox"
  spec.version       = JupyterToScrapbox::VERSION
  spec.authors       = ["Hiroharu Sugawara"]
  spec.email         = ["hsugawa@tmu.ac.jp"]

  spec.summary       = %q{convert jupyter-notebook to scrapbox-ready-json}
  spec.description   = %q{}
  spec.homepage      = %q{http://github.com/hsugawa8651/juoyter_to_scrapbox_gem}
  spec.licenses      = [ "MIT" ]


  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 10.0"

  spec.add_dependency "thor"

end

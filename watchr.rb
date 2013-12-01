watch(%r{rgkit/(\w+).rb}) do |m|
  system("rspec --require rgkit/*.rb --fail-fast --color rgkit/spec/spec_*.rb") or exit(1)
end
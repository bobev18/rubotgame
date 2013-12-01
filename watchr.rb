watch(%r{rgkit/(\w+).rb}) do |m|
  system("cd rgkit")
  system("rspec --require ./*.rb --fail-fast --color ./specs/spec_*.rb") or exit(1)
end
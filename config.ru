require './lib/libraries'

if Deployinator.log_file?
  log = File.new(Deployinator.log_file, "a")
  $stdout.reopen(log)
  $stderr.reopen(log)
  puts "Logging #{Deployinator.log_file}"
end

# Ignore the ssl cert on github:fi
ENV["GIT_SSL_NO_VERIFY"] = "true"

ENV['HTTP_X_USERNAME'] = 'chef'
ENV['HTTP_X_GROUPS'] = 'chef%7Cadmin'

use Rack::CommonLogger

use Deployinator::Stream
run Deployinator::App.new

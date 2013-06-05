LINT_CONFIG = "test/fixtures/coffeelint.json"

# Print a notification.
def notify(message)
  padding = 4
  line = '*' * (message.length + padding)
  puts line
  puts "* #{message.downcase} *"
  puts line
end

desc "Run unit tests."
task :test => [:compile] do
  sh("node_modules/.bin/vows --spec test/*.coffee")
  notify("tested!")
end

desc "Lint the linter."
task :lint => [:compile] do
  sh("./bin/coffeelint -r -f #{LINT_CONFIG} src/ test/*.coffee")
  notify("linted!")
end

desc "Lint the linter."
task :'lint:csv' => [:compile] do
  sh("./bin/coffeelint --csv -r -f #{LINT_CONFIG} src/ test/*.coffee")
  notify("linted!")
end

desc "Lint the linter."
task :'lint:csv' => [:compile] do
  sh("./bin/coffeelint --jslint -r -f #{LINT_CONFIG} src/ test/*.coffee")
  notify("linted!")
end

desc "Compile the source."
task :compile do

  # If this is being installed from a git repo the coffeemodule amy not
  # exist here yet.
  if File.exists? 'node_modules/.bin/coffee'
    sh("node_modules/.bin/coffee -c -o lib src")
  else
    sh("coffee -c -o lib src")
  end

  # Add a hack for adding node shebang.
  node='#!/usr/bin/env node'
  sh("mkdir -p bin")
  sh("echo '#{node}' | cat - lib/commandline.js > bin/coffeelint")
  sh("chmod +x bin/coffeelint")
  sh("rm lib/commandline.js")
  notify("compiled!")
end

desc "preinstall: Only needed if installing direct from a git repo"
task :preinstall do
  if not File.exists? 'bin/coffeelint'
      Rake::Task["compile"].invoke
  end
end

desc "Publish the package."
task :publish => [:default] do
  sh("npm publish")
end

task :default => [:compile, :test, :lint]

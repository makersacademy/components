require "middleman-gh-pages"
require "json"

desc "Bumps bower version and deploys."
task :deploy_to_bower do
  deploy_to_bower
end

desc "Publishes to github pages and deploys to bower"
task :deploy do
  deploy_to_bower
  # This runs GitHub pages publish method
  Rake::Task["publish"].invoke
end

def deploy_to_bower
  puts "Please enter a version number, previous version was #{bower["version"]}:"
  new_version = $stdin.gets
  puts "Compiling Sass files into CSS"
  `compass compile`
  puts "Committing files to Git"
  `git add .`
  `git commit -m "Compiles and updates stylesheets in preperation for new version"`
  `bower version #{new_version}`
  puts "Pushing new tags to Github"
  `git push origin --tags`
  puts "Done!"
end

def bower
  JSON.load(File.new("bower.json"))
end

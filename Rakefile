require "middleman-gh-pages"

desc 'Bumps bower version and deploys.'
task :deploy_to_bower do
  puts "Please enter a version number, e.g. '0.1.3':"
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


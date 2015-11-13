Rake::Task["db:drop"].enhance do
  Rake::Task["my_tasks:rem"].invoke
end
namespace :my_tasks do
  desc "Remove the 'uploads' directory and contents"
  task :rem => [:environment] do
    FileUtils.remove_dir(UPLOAD_PATH, true) if File.directory?(UPLOAD_PATH)
  end
end

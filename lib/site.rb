require 'fileutils'

class Site
  include DataMapper::Resource
  
  property :id,     Serial
  property :name,   String
  property :repo,   String
  property :folder, String
  
  def deploy
    FileUtils.mkdir_p folder
    Dir.chdir folder
    
    if File.exists? File.join(folder, '.git')
      system "git pull"
    else
      system "git clone #{repo} ."
    end
  end
end

require 'spec/spec_helper'

describe Site do
  describe '#deploy' do
    before :each do
      FileUtils.stub! :mkdir_p  => true
      Dir.stub!       :chdir    => true
      
      @site = Site.new
      @site.attributes = {
        :name   => 'demo-site',
        :repo   => 'git://github.com/user/demo-site',
        :folder => '/var/www/demo-site'
      }
      @site.stub!(:system => true)
    end
    
    it "should create the site directory" do
      FileUtils.should_receive(:mkdir_p).with(@site.folder)
      
      @site.deploy
    end
    
    it "should shift locations into the site directory" do
      Dir.should_receive(:chdir).with(@site.folder)
      
      @site.deploy
    end
    
    it "should clone if the folder isn't containing a git repository" do
      File.should_receive(:exists?).and_return false
      @site.should_receive(:system).with("git clone #{@site.repo} .")
      
      @site.deploy
    end
    
    it "should pull the latest changes if there is already a git repository" do
      File.should_receive(:exists?).and_return true
      @site.should_receive(:system).with("git pull")
      
      @site.deploy
    end
    
    it "should not clone if the folder contains a git repository already" do
      File.should_receive(:exists?).and_return true
      @site.should_not_receive(:system).with("git clone #{@site.repo} .")
      
      @site.deploy
    end
  end
end

require 'rubygems'
require 'bundler'
require 'bundler/setup'
require 'rake/clean'
require 'flashsdk'

def copy_assets
  source = "html-template/assets"
  destination = "bin-debug" 
  system "rsync -ruv #{source} #{destination}"
end

def copy_html
  source = "html-template/index.html"
  destination = "bin-debug/" 
  system "rsync -ruv #{source} #{destination}"
end

def configure t
  copy_assets
  copy_html
  t.library_path << 'libs'
  t.default_frame_rate = 31
  t.optimize = true
  t.target_player = '10.1'
  t.default_background_color = '0x000000'
  t.default_size = '1152,720'
end

mxmlc "bin-debug/main.swf" do |t|
  configure t
  t.input = "src/Main.as"
  t.debug = true
  t.define_conditional << 'CONFIG::release,false'
  t.define_conditional << 'CONFIG::debug,true'
end

desc "Compile release version"
mxmlc "bin-release/main.swf" do |t|
  configure t
  t.input = "src/Main.as"
  t.debug = false
  t.define_conditional << 'CONFIG::release,true'
  t.define_conditional << 'CONFIG::debug,false'
end

desc "Compile and run the debug swf"
flashplayer :run => "bin-debug/main.swf"

desc "Generate documentation at doc/"
asdoc 'doc' do |t|
  t.doc_sources << "src"
  t.library_path << 'libs'
  t.output = "doc/asdoc"
  t.lenient = "true"
end

task :default => :run


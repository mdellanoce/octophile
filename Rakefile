require 'fileutils'
require 'nokogiri'
require 'uglifier'

dev = "public"
dist = "dist"

def uglify(js_out, js_in)
  compiled = Uglifier.compile(File.read(js_in))

  File.open(js_out, 'w') do |f|
    f.write compiled
  end
end

desc "Copy static files to dist directory"
task :copy => Dir.glob("#{dev}/**/*") do |t|
  FileUtils.cp_r "#{dev}/.", dist
end

desc "Minify javascript files"
task :minify => :copy do
  Dir.glob("#{dist}/**/*.js").each do |js|
    uglify(js, js)
  end
end

desc "Combines scripts, stylesheets, and HTML files"
task :combine => :minify do
  file = "#{dist}/follow_button.html"
  html = File.read file
  doc = Nokogiri::HTML html

  head = doc.xpath("//head").first
  doc.xpath("//link[@type='text/css']").each do |css|
    href = "#{dist}/#{css['href']}"
    style = Nokogiri::XML::Node.new "style", doc
    style.content = File.read href
    style['type'] = "text/css"

    css.remove
    head.add_child style

    File.delete href
  end

  doc.xpath("//script[@type='text/javascript']").each do |js|
    src = "#{dist}/#{js['src']}"
    js.content = File.read src
    js.remove_attribute 'src'

    File.delete src
  end

  File.open(file, 'w') do |f|
    f.write doc.to_html
  end
end

desc "Remove generated files"
task :clean do
  FileUtils.rm_rf Dir.glob("#{dist}/**/*")
end

task :default => [:combine]

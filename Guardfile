# create an rb bundle

CONCAT_FILES = %w(
  config/env
  lib/comp/transaction
  lib/comp/tx_viz
  lib/modules/tx_fetcher
  app
)

BUNDLE = "dist/bundle.rb"

# :concat, type: "rb", files: files, input_dir: "lib", output: "dist/bundle" do

guard :shell do
  watch /^(?!dist\/bundle)(.+)\.rb$/ do |m|
    puts "bundling........."
    bundle = []
    for file in CONCAT_FILES
      bundle << File.read("#{file}.rb")
    end
    File.open(BUNDLE, "w"){ |f| f.write bundle.join("\n") }
    puts "bundled!"
  end
end

guard :shell do
  watch %r{^#{BUNDLE}$} do |m|
    puts "building........."
    puts `ruby build.rb`
    puts "#{m[0]} changed, regenerated opal bundle"
    puts "built!"
    puts
    puts
  end
end

# if guard doesn't work
#
# listener = Listen.to('.') do |modified, added, removed|
#   puts "modified absolute path: #{modified}"
# end
# listener.start # not blocking
# sleep

guard :shell do
  watch %r{.rb} do |m|
    puts `ruby build.rb`
    puts "#{m[0]} changed, regenerated opal bundle"
  end
end

# required: opal + browser
`self.$require("browser");`
`self.$require("browser/http");`
# `self.$require("browser/interval");` # can't make it work atm

WINDOW = Native.convert $window

module SetInterval
  def self.included(base)
    base.class_eval do
      before_mount { @interval = [] }
      before_unmount do
        # abort associated timer of a component right before unmount
        @interval.each { |i| `#{WINDOW}.clearInterval(#{i})` }
      end
    end
  end

  def set_interval(seconds, &block)
    every = 1
    @interval << `#{WINDOW}.setInterval(#{block}, #{every} * 1000)`
  end
end

class TickTock
  include React::Component
  include SetInterval

  define_state(:seconds) { 0 }

  before_mount do
    set_interval(1) { self.seconds = self.seconds + 1 }
    set_interval(1) { puts "Tick!" }
  end

  def render
    span do
      "React has been running for: #{self.seconds}"
    end
  end
end

React.render(React.create_element(TickTock), $document.body.to_n)


after = 5

unmount_component = lambda do
  React.unmount_component_at_node($document.body.to_n)
end
`#{WINDOW}.setTimeout(#{unmount_component.to_n}, #{after} * 1000)`



# notes:

# Browser::HTTP.get "/test.json" do
#   on :success do |res|
#     alert res.json.inspect
#   end
# end

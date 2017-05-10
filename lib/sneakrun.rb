require 'sneakers'
require 'sneakers/runner'

class MyWorker
  include Sneakers::Worker
  from_queue 'other_stock_in_invoice'

  def work(msg)
    logger.info "hello #{msg}"
  end
end

opts = {
  # what ever you want
}

Sneakers.configure(opts)
r = Sneakers::Runner.new([MyWorker])

r.run
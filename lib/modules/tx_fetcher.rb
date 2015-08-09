module TxFetcher
  def load_transactions
    tx_viz = self
    Browser::Socket.new 'wss://ws.blockchain.info/inv' do
      on :open do
        puts '{"op":"unconfirmed_sub"}'
      end

      on :message do |e|
        data  = `JSON.parse(e.native.data).x`
        out   = `data.out`
        hash  = `data.hash`
        value = out.map{ |o| `o.value` / 10 ** 8 }.inject :+
        value = value.round 8
        tx    = { value: value, hash: hash }
        # `console.log(tx)`
        tx_viz.transactions =  [tx] + tx_viz.transactions[0..1000]
      end
    end
  end
end

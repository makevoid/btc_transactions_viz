`console.log("loading app environment")`

`self.$require("browser");`

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

class Transaction
  include React::Component

  def tx_url(tx_hash)
    "https://blockchain.info/tx/#{tx_hash}"
  end

  def render
    a href: tx_url(params[:tx][:hash]) do
      div style: { width: "#{params[:tx][:value].round}%" } do
        params[:tx][:value]
      end
    end
  end
end

class TxViz
  include React::Component
  include TxFetcher
  after_mount :load_transactions

  define_state(:transactions) { [] }

  def render
    div do
      div className: "header" do
        h3 { "Bitcoin Transactions" }
        p className: "mini" do
          "realtime transactions visualizer, bitcoin network - opal, react, css3, websockets, bitcoin, blockchain, blockchain.com, bitcoind"
        end
      end
      div className: "tx_list" do
        self.transactions.each_with_index.map do |tx, idx|
          present Transaction, tx: tx, key: tx[:hash]
        end
      end
    end
  end
end

`console.log("asd")`


React.render(
  React.create_element(TxViz),
  $document.body.to_n
  # $document.getElementById "container"
)

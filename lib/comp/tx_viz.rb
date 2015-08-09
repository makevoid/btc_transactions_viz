class TxViz
  include React::Component
  include TxFetcher
  after_mount :load_transactions

  define_state(:transactions) { [] }

  def render
    div do
      div className: "header" do
        h3 { "Transactions" }
        p class: mini {
          "realtime transactions visualizer, bitcoin network - opal, react, css3, websockets, bitcoin, blockchain, blockchain.com, bitcoind"
        }
      end
      div className: "tx_list" do
        self.transactions.each_with_index.map do |tx, idx|
          present Transaction, tx: tx, key: tx[:hash]
        end
      end
    end
  end
end

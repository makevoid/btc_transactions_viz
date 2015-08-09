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

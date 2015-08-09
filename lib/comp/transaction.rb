class Transaction
  include React::Component

  def tx_url(tx_hash)
    "https://blockchain.info/tx/#{tx_hash}"
  end

  def render
    element = a href: tx_url(params[:tx][:hash]) do
      "#{params[:tx][:value]} BTC"
      # TODO:
      #
      # n. output
      # type (apply color)
    end

    width = params[:tx][:value].round
    width = "#{width}%"
    `
      var divStyle = {
        width: width
      }
    `
    # { color: "red", width: "#{params[:tx][:value].round}%", maxWidth: "#{params[:tx][:value].round}%" }

    div style: `divStyle` do
      element
    end
  end
end

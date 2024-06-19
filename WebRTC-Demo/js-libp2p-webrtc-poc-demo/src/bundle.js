const TCP = require("libp2p-tcp")
const Mplex = require("libp2p-mplex")
const Libp2p = require("libp2p")

class Node extends Libp2p {
  constructor (options) {
    options = options || {}

    options.modules = {
      transport: [TCP],
      streamMuxer: [Mplex]
    }
    super(options)
  }
}

module.exports = Node

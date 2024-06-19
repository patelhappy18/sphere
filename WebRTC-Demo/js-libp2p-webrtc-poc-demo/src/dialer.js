'use strict'
/* eslint-disable no-console */

/*
 * Listener Node
 */

const PeerId = require('peer-id')
const PeerInfo = require('peer-info')
const Node = require('./bundle')
// const pull = require('pull-stream')
const series = require('async/series')

let listenerId
let listenerNode

series([
  (cb) => {
    PeerId.createFromJSON(require('./id-d'), (err, id) => {
      if (err) { return cb(err) }
      listenerId = id
      cb()
    })
  },
  (cb) => {
    const listenerPeerInfo = new PeerInfo(listenerId)
    listenerPeerInfo.multiaddrs.add('/ip4/0.0.0.0/tcp/0')
    listenerNode = new Node({
      peerInfo: listenerPeerInfo,
      config: {
        relay: {
          enabled: true
        }
      }
    })

    // listenerNode.on('peer:connect', (peerInfo) => {
    //   console.log('received dial to me from:', peerInfo.id.toB58String())
    // })

    // listenerNode.handle('/echo/1.0.0', (protocol, conn) => pull(conn, conn))
    listenerNode.start(cb)
  },
  (cb) => {
    // console.log("a")
    listenerNode.dial(`/ip4/0.0.0.0/tcp/10333/ipfs/${require('./id-h').id}`, cb)
  },
  (cb) => {
    setTimeout(cb, 2000)
  },
  (cb) => {
    // console.log("b")
    listenerNode.dial(`/p2p-circuit/ipfs/${require('./id-l').id}`, cb)
    // console.log(`/p2p-circuit/ipfs/${require('./id-l').id}`)
    // cb()
  }
], (err) => {
  if (err) { throw err }

  console.log('Hop ready, listening on:')
  listenerNode.peerInfo.multiaddrs.forEach((ma) => {
    console.log(ma.toString() + '/p2p/' + listenerId.toB58String())
  })
})

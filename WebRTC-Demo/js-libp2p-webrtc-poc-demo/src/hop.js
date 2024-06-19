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
    PeerId.createFromJSON(require('./id-h'), (err, id) => {
      if (err) { return cb(err) }
      listenerId = id
      cb()
    })
  },
  (cb) => {
    const listenerPeerInfo = new PeerInfo(listenerId)
    listenerPeerInfo.multiaddrs.add('/ip4/0.0.0.0/tcp/10333')
    listenerNode = new Node({
      peerInfo: listenerPeerInfo,
      config: {
        relay: {
          enabled: true,
          hop: {
            enabled: true
          }
        }
      }
    })

    // listenerNode.on('peer:connect', (peerInfo) => {
    //   console.log('received dial to me from:', peerInfo.id.toB58String())
    // })

    // listenerNode.handle('/echo/1.0.0', (protocol, conn) => pull(conn, conn))
    listenerNode.start(cb)
  }
], (err) => {
  if (err) { throw err }

  console.log('Hop ready, listening on:')
  listenerNode.peerInfo.multiaddrs.forEach((ma) => {
    console.log(ma.toString() + '/p2p/' + listenerId.toB58String())
  })
})

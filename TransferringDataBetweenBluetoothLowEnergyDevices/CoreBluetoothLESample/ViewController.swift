//
//  ViewController.swift
//  CoreBluetoothLESample
//
//  Created by Appstute-Sachin on 10/15/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit
import MultipeerConnectivity


class ViewController: UIViewController, MCNearbyServiceAdvertiserDelegate , MCNearbyServiceBrowserDelegate{

    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var uuidLabel: UILabel!
    
    var peerID: MCPeerID!
    var advertiser: MCNearbyServiceAdvertiser!
    var browser: MCNearbyServiceBrowser!

        
        override func viewDidLoad() {
            super.viewDidLoad()
            // Do any additional setup after loading the view.
              peerID = MCPeerID(displayName: UIDevice.current.name)
            let deviceId = UIDevice.current.identifierForVendor?.uuidString
            
    //        let deviceId = "CB74D4EE"

            print("deviceId->",deviceId as Any)
            uuidLabel.numberOfLines = 3
            uuidLabel.text = "Device Name - \(String(describing: peerID.displayName)) and Device 3IID - \(deviceId ?? "")"
            advertiser = MCNearbyServiceAdvertiser(peer: peerID, discoveryInfo: ["deviceId":deviceId ?? ""], serviceType: "my-test")
            browser = MCNearbyServiceBrowser(peer: peerID, serviceType: "my-test")
            advertiser.delegate = self
            browser.delegate = self
        }
        @IBAction func advertiseButtonPressed(_ sender: Any) {
            advertiser.startAdvertisingPeer()
        }
        @IBAction func browseButtonPressed(_ sender: Any) {
            browser.startBrowsingForPeers()
        }
        
        func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID, withContext context: Data?, invitationHandler: @escaping (Bool, MCSession?) -> Void) {
            print("didReceiveInvitationFromPeer->",peerID)

        }
        
        func browser(_ browser: MCNearbyServiceBrowser, foundPeer peerID: MCPeerID, withDiscoveryInfo info: [String : String]?) {
            print("peerID->",peerID.displayName)
            if let info = info{
            print("info->",info)
                infoLabel.text = "Neerby device name - \(peerID.displayName) and Device 3IID - \(info["deviceId"] ?? "")"
                infoLabel.numberOfLines = 3

            }
        }
        
        func browser(_ browser: MCNearbyServiceBrowser, lostPeer peerID: MCPeerID) {
            print("lostPeer->",peerID)

        }
        
    }

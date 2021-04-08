//
//  AgentChannelPersistancyManager.swift
//  SDKDemo1
//
//  Created by Vishal on 19/06/18.
//  Copyright © 2018 CL-macmini-88. All rights reserved.
//

import Foundation

class AgentChannelPersistancyManager {
    static let shared = AgentChannelPersistancyManager()
    
    private var channels = [HippoChannel]()
    let maxChannelCount = 5
    
    
    private init() {
    }
    
    func getChannelBy(id: Int) -> HippoChannel {
        
        if let channel = findChannelWithID(id: id) {
            return channel
        }
        
        let newChannel = createNewChannelWith(id: id)
        return newChannel
    }
    
    private func findChannelWithID(id: Int) -> HippoChannel? {
        for channel in channels {
            if channel.id == id {
                return channel
            }
        }
        
        return nil
    }
    
    private func createNewChannelWith(id: Int) -> HippoChannel {
        if channels.count >= maxChannelCount {
            removeLeastPriorityChannel()
        }
        
        let newChannel = HippoChannel(id: id)
        channels.append(newChannel)
        
        return newChannel
    }
    
    private func removeLeastPriorityChannel() {
        guard channels.count > 0 else {
            return
        }
        
        channels.remove(at: 0)
    }
    
    func clearChannels() {
        channels.removeAll()
    }
    
}

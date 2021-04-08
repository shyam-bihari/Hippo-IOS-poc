//
//  ContentView.swift
//  Hippo Chat POC
//
//  Created by Shyam Bihari Swami on 12/02/21.
//  Copyright © 2021 smallcase. All rights reserved.
//

import SwiftUI
import Hippo

struct ContentView: View {
    @State var uid: String = ""
    @State var transactionId: String = ""
    @State var channelId: String = ""
    var body: some View {
        VStack(alignment: .center) {
                    
            
            Button(action: {

                // Dev API key
                HippoConfig.shared.setCredential(withAppSecretKey: "b773d7e44d71810e5dc0d94e085dcca9", appType: "1")
                
                HippoConfig.shared.switchEnvironment(.dev)
                let hippotheme = HippoTheme.defaultTheme()
                hippotheme.backgroundColor = .black
                hippotheme.headerBackgroundColor = .black
                hippotheme.headerTextColor = .black
                hippotheme.headerText = "support"
                HippoConfig.shared.setCustomisedHippoTheme(theme: hippotheme)
            
                print("Done")
            }) {
                Text("Init SDK")
            }
            
            
            TextField("Enter UID", text: $uid).padding()
                Button(action: {
                
                    //Get the user object for the current installation
                    let hippoUserDetail = HippoUserDetail(fullName: "Shyam IOS",
                        email: "shyam.bihari@smallcase.com",phoneNumber: "+918239199344",
                        userUniqueKey: uid,
                        addressAttribute: HippoAttributes(address: HippoAddress(addressLine1: "ADDRESS", addressLine2: "ADDRESS", city: "ADDRESS", region: "ADDRESS", country: "ADDRESS", zipCode: "ADDRESS")),
                        customAttributes: ["a":1, "b":2, "c":3, "d":4, "e":5, "f":6, "g":7, "h":8, "i":9])
                    
                        //Call updateUserDetails so that
                        //the user information is synced with Hippo servers
                        HippoConfig.shared.updateUserDetail(userDetail: hippoUserDetail)
                        print("Print Chat")
                    
                }){
                    Text("Set User Data")
                }.padding()
            
            Button(action: {
                HippoConfig.shared.presentChatsViewController()
            }){
                Text("Show all Conversaction")
            }
            
            // TRANSACTION
            TextField("Transaction ID", text: $transactionId).padding()
            Button(action: {
                let generalChat = GeneralChat.init(uniqueChatId: transactionId, myUniqueId: transactionId, groupingTags: [], channelName: "Support", tags: [])
                
                HippoConfig.shared.openChatByTransactionId(data: generalChat) { (_, _) in
                }

////                HippoConfig.shared.openChat
//                HippoConfig.shared.openChatScreen(withTransactionId: transactionId,
//                tags: ["Tag 1", "Tag 2"],
//                channelName: "Support"){(_, _) in print("HELLO")}
            }){
                Text("Open Chat")
            }
            
            
            // By Channel
            TextField("Channel ID", text: $channelId).padding()
            Button(action: {
                
                HippoConfig.shared.openChatWith(channelId: 1) { (success, error) in
                    print(success)
                }
            }){
                Text("Open Chat From Channel ID")
            }
            
            
                    Text("Your UID: \(uid)")
                }.padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



//
//  ChatViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import Firebase
class ChatViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
    
    let db = Firestore.firestore()
    
    var messages: [Message] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        navigationItem.hidesBackButton = true
        navigationItem.title = K.appName
        
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil ), forCellReuseIdentifier: K.cellIdentifier)
        
        loadMsgs()
    }
    func loadMsgs(){
        
        db.collection(K.FStore.collectionName).order(by: K.FStore.dateField).addSnapshotListener {(querySnapshot , error ) in if let e = error {
            print("There was an issue retrieving from  Firestore , \(e)" )
        }
            
        else {
            self.messages = []
            if let queryDocs = querySnapshot?.documents{
                for doc in queryDocs    //looping on all the documents in the collection
                {
                    
                    let data = doc.data()
                    if let messageSender = data[K.FStore.senderField] as? String , let messageBody = data[K.FStore.bodyField] as? String {
                        let newMsg = Message(sender: messageSender, body: messageBody )
                        self.messages.append(newMsg)   //saving the messages in a dictionary
                        
                        //------ to reload table view every new message and get view to the last message for better user experience
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                            let indexPath = IndexPath(row: self.messages.count-1 , section: 0)
                            self.tableView.scrollToRow(at: indexPath, at: .top, animated: false)
                        }
                        //---------
                    }
                }
            }
            }
            
        }
        
    }
    
    @IBAction func sendPressed(_ sender: UIButton) {
        if let messageBody = messageTextfield.text , let messageSender = Auth.auth().currentUser?.email{
            db.collection(K.FStore.collectionName).addDocument(data: [
                K.FStore.senderField: messageSender,K.FStore.bodyField: messageBody, K.FStore.dateField: Date().timeIntervalSince1970
            ]){
                (error) in if let e=error {
                    print("There was an issue saving to Firestore , \(e)" )
                }
                else {
                    print("Saved successfully to firestore" )
//                    DispatchQueue.main.async {
//                        self.messageTextfield.text = ""
//                    }
                }
            }
        }
        messageTextfield.text = ""
    }
    
    @IBAction func signoutPressed(_ sender: UIBarButtonItem) {
        
        do {
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        
    }
    
}

extension ChatViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messages[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier , for: indexPath) as! MessageCell
        cell.label1.text = message.body
        
        if message.sender == Auth.auth().currentUser?.email {
            cell.leftImageView1.isHidden = true
            cell.rightImageView1.isHidden = false
            cell.msgbubble.backgroundColor = UIColor(named: K.BrandColors.lightPurple)
            cell.label1.textColor = UIColor(named: K.BrandColors.purple)
            
        }
        else {
            cell.leftImageView1.isHidden = false
            cell.rightImageView1.isHidden = true
            cell.msgbubble.backgroundColor = UIColor(named: K.BrandColors.purple)
            cell.label1.textColor = UIColor(named: K.BrandColors.lightPurple)
        }
        
        
        
        
        
        return cell
    }
    
    
}

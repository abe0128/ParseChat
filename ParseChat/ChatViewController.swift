//
//  ChatViewController.swift
//  ParseChat
//
//  Created by Abraham De Alba on 10/23/18.
//  Copyright © 2018 Abraham De Alba. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController, UITableViewDataSource
{
    var messages : [PFObject] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var chatMessageField: UITextField!
    
    
    @IBAction func onSend(_ sender: Any)
    {
        let message = PFObject(className: "Message")
        message["text"] = chatMessageField.text ?? ""
        message["user"] = PFUser.current()
        message.saveInBackground { (success, error) in
            if success {
                print("The message was saved!")
                self.chatMessageField.text = ""
            } else if let error = error {
                print("Problem saving message: \(error.localizedDescription)")
            }
        }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.separatorStyle = .none
        fetchMessages()
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.onTimer), userInfo: nil, repeats: true)
        tableView.rowHeight = UITableView.automaticDimension
        // Provide an estimated row height. Used for calculating scroll indicator
        tableView.estimatedRowHeight = 50
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell", for: indexPath) as! ChatCell
        
        cell.messageLabel.text = messages[indexPath.row]["text"] as? String
        if let user = messages[indexPath.row]["user"] as? PFUser {
            // User found! update username label with username
            cell.usernameLabel.text = user.username
        } else {
            // No user found, set default username
            cell.usernameLabel.text = "🤖"
        }
        
        return cell
    }
    
    func fetchMessages(){
        let query = Message.query()
        query?.includeKey("user")
        query?.addDescendingOrder("createdAt")
        query?.limit = 20
        
        query?.findObjectsInBackground{ (messages: [PFObject]?,error: Error?) -> Void in
            if let messages = messages{
                self.messages = messages
                self.tableView.reloadData()
                print(messages)
            }
            else{
            }
        }
    }
    
    @objc func onTimer(){
        fetchMessages()
    }

}

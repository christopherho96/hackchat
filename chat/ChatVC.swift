//
//  ChatVC.swift
//  chat
//
//  Created by Christopher Ho on 2017-05-27.
//  Copyright © 2017 Christopher Ho. All rights reserved.
//

import UIKit
import JSQMessagesViewController
import MobileCoreServices
import AVKit

class ChatVC: JSQMessagesViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    private var messages = [JSQMessage]();
    
    let picker = UIImagePickerController();
    

    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self;
        self.senderId = AuthProvider.Instance.userID()
        self.senderDisplayName = AuthProvider.Instance.userName;
        
    }
    
    //Collection view functions
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAt indexPath: IndexPath!) -> JSQMessageBubbleImageDataSource! {
       
        let bubbleFactory = JSQMessagesBubbleImageFactory();
      //  let message = messages[indexPath.item];
       
        return bubbleFactory?.outgoingMessagesBubbleImage(with: UIColor.blue)
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAt indexPath: IndexPath!) -> JSQMessageAvatarImageDataSource!{
        return JSQMessagesAvatarImageFactory.avatarImage(with: UIImage(named: "avatar"), diameter: 30);
    }
    
 
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageDataForItemAt indexPath: IndexPath!) -> JSQMessageData! {
        return messages[indexPath.item];
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, didTapMessageBubbleAt indexPath: IndexPath!) {
        
        let msg = messages [ indexPath.item];
        if msg.isMediaMessage {
            if let mediaItem = msg.media as? JSQVideoMediaItem{
                let player = AVPlayer(url: mediaItem.fileURL);
                let playerController = AVPlayerViewController();
                playerController.player = player;
                self.present(playerController, animated: true, completion: nil);
            }
    }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return messages.count;
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = super.collectionView(collectionView, cellForItemAt: indexPath) as! JSQMessagesCollectionViewCell
        
        return cell;
    }
    
    //END COLLECTION VIEW FUNCTIONS
    
    // SENDING BUTTONS FUNCTIONS
    
    
    override func didPressSend(_ button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: Date!) {
        
        
        MessagesHandler.Instance.sendMessage(senderID: senderId, senderName: senderDisplayName, text: text);
  //      messages.append(JSQMessage(senderId: senderId, displayName: senderDisplayName, text: text))
        
        collectionView.reloadData();
        
        //this will remove text from text field
        finishSendingMessage();
    }
    
    override func didPressAccessoryButton(_ sender: UIButton!) {
        let alert = UIAlertController(title: "Media Messages", message: "Please Select A Media", preferredStyle:.actionSheet);
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil);
        let photos = UIAlertAction (title : "Photos", style: .default, handler: {(alert: UIAlertAction) in
            self.chooseMedia(type: kUTTypeImage);
        })
        
        let videos = UIAlertAction (title : "Videos", style: .default, handler: {(alert: UIAlertAction) in
             self.chooseMedia(type: kUTTypeMovie);
        })
        
        alert.addAction(photos);
        alert.addAction(videos);
        alert.addAction(cancel);
        present(alert,animated:true, completion: nil);
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let pic = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            let img = JSQPhotoMediaItem(image: pic);
            self.messages.append (JSQMessage(senderId: senderId, displayName: senderDisplayName, media: img));
            
        }else if let vidUrl = info[UIImagePickerControllerMediaURL] as? URL {
            
            let video = JSQVideoMediaItem(fileURL: vidUrl, isReadyToPlay: true);
            messages.append(JSQMessage(senderId: senderId, displayName: senderDisplayName, media: video));
        }
        self.dismiss(animated: true, completion: nil);
        collectionView.reloadData();
    }
    
    
    
    //END SENDING BUTTINS FUNCTIONS

    //PICKER VIEW FUNCTIONS
    private func chooseMedia(type : CFString) {
        picker.mediaTypes = [type as String]
        present(picker,animated: true, completion: nil);
    
    }
    //END PICKER VIEW FUNCTIONS
    
    
    @IBAction func backBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

}// class

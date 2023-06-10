//
//  HomeCell.swift
//  HamHam Lezzetler
//
//  Created by Defne Çetiner on 3.06.2023.
//

import UIKit
import Firebase
import FirebaseFirestore

class HomeCell: UITableViewCell {
    
    @IBOutlet weak var userEmailLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var documentIdLabel: UILabel!
    
    
    @IBAction func likeButtonClicked(_ sender: Any) {
        let fireStoreDatabase = Firestore.firestore()
        
        // Kullanıcının daha önce like attığı kontrol ediliyor
        let likedPostsCollection = fireStoreDatabase.collection("LikedPosts")
        let userId = Auth.auth().currentUser?.uid
        let postId = documentIdLabel.text!
        
        likedPostsCollection.whereField("userId", isEqualTo: userId).whereField("postId", isEqualTo: postId).getDocuments { (snapshot, error) in
            if let error = error {
                print("Error checking liked posts: \(error.localizedDescription)")
                return
            }
            
            if let snapshot = snapshot, !snapshot.isEmpty {
                // Kullanıcı bu postu daha önce beğenmiş, işlem yapma
                print("Already liked this post")
                return
            }
            
            // Eğer kullanıcı bu postu daha önce beğenmediyse, like işlemi gerçekleştir
            if var likeCount = Int(self.likeLabel.text!) {
                likeCount += 1
                let likeStore = ["likes": likeCount] as [String: Any]
                fireStoreDatabase.collection("Posts").document(self.documentIdLabel.text!).setData(likeStore, merge: true) { (error) in
                    if let error = error {
                        print("Error updating like count: \(error.localizedDescription)")
                    } else {
                        // Kullanıcının like'ı kaydet
                        let likedPostData = ["userId": userId, "postId": postId]
                        likedPostsCollection.addDocument(data: likedPostData) { (error) in
                            if let error = error {
                                print("Error saving liked post: \(error.localizedDescription)")
                            }
                        }
                    }
                }
            }
        }
    }
    
}

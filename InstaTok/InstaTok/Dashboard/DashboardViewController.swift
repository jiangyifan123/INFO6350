//
//  DashboardViewController.swift
//  InstaTok
//
//  Created by 江一帆 on 11/17/22.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class DashboardViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let arr = ["Ashish", "Mark", "Tom", "Bill"]
    
    var posts: [PostsClass] = [PostsClass]()
    
    var db: Firestore?
    
    @IBOutlet weak var tblView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        db = Firestore.firestore()
        getPosts()
    }
    
    func getPosts(){
        guard let uid = Auth.auth().currentUser?.uid else {return}
        guard let db = db else {return}
        
        db.collection("Posts").whereField("UID", isEqualTo: uid)
            .getDocuments(){ (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                self.posts = [PostsClass]()
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                    guard let values = document.data() as? [String: Any] else {return}
                    guard let caption = values["Caption"] as? String else {return}
                    guard let location = values["Location"] as? String else {return}
//                    guard let dateTime = values["Timestamp"] as? Timestamp else {return}
                    guard let ImageURL = values["ImageURL"] as? String else {return}
                    
                    let post = PostsClass()
                    post.caption = caption
                    post.dateTime = ""
                    post.location = location
                    post.imageURL = ImageURL
                    self.posts.append(post)
                    
                }
                self.tblView.reloadData()
            }
                    
        }
    }

    
    @IBAction func logoutAction(_ sender: Any) {
        let keychain = KeyChainService().keyChain
        keychain.clear()

        do {
            try Auth.auth().signOut()
        }
        catch{
            print("Unable to logout")
        }

        self.navigationController?.popViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let ceil = Bundle.main.loadNibNamed("ImagePostTableViewCell", owner: self)?.first as! ImagePostTableViewCell
        
        ceil.imgView.image = UIImage(named: "SpaceNeedle")
        ceil.caption.text = posts[indexPath.row].caption
        ceil.location.text = posts[indexPath.row].location
        ceil.datetime.text = posts[indexPath.row].dateTime
        return ceil
    }
}

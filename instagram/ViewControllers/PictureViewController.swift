//
//  pictureViewController.swift
//  instagram
//
//  Created by Joseph Davey on 2/4/18.
//  Copyright © 2018 Joseph Davey. All rights reserved.
//

import UIKit
import Parse

class pictureViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var posts: [PFObject] = []
    var refresher: UIRefreshControl!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        refresher = UIRefreshControl()
        refresher.addTarget(self, action: #selector(pictureViewController.getPosts), for: .valueChanged)
        tableView.insertSubview(refresher, at: 0)
        
        //self.navigationController?.pushViewController(vc, animated: true)
        //self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        getPosts()
    }
    
    @objc func getPosts() {
        let query = PFQuery(className: "Post")
        query.addDescendingOrder("createdAt")
        query.includeKey("user")
        query.limit = 20
        query.findObjectsInBackground(block:  { (posts, error) in
            if error != nil {
                print(error?.localizedDescription)
                self.refresher.endRefreshing()
            } else if let posts = posts {
                self.posts = posts
                self.tableView.reloadData()
                self.refresher.endRefreshing()
            }
        })
    }
    
    @IBAction func onUpload(_ sender: Any) {
        self.performSegue(withIdentifier: "uploadSegue", sender: nil)
    }
    
    @IBAction func onLogout(_ sender: Any) {
        PFUser.logOut()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateInitialViewController()
        present(viewController!, animated: true, completion: nil)
        print("User has been logged out")
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostCell
        let post = posts[indexPath.row]
        
        if let user = post["user"] as? PFUser {
            cell.usernameLabel.text = user.username
        } else {
            cell.usernameLabel.text = "🤖"
        }
        
        if let imageFile = post["photo"] as? PFFile {
            imageFile.getDataInBackground(block: {
                (imageData: Data!, error: Error!) -> Void in
                    if (error == nil) {
                        let image = UIImage(data: imageData)
                        cell.postImage.image = image
                    }
            })
        }

        if let comment = post["comment"] as? String {
            cell.commentLabel.text = comment
        }
        
        if let time = post["date"] as? String {
            cell.timestampLabel.text = time
        }
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailSegue" {
            let cell = sender as! UITableViewCell
            if let indexPath = tableView.indexPath(for: cell) {
                let post = posts[indexPath.row]
                let dvc = segue.destination as! PhotoDetailViewController
                dvc.post = post
            }
        }
    }
 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

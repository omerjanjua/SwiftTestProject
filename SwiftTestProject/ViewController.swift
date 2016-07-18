//
//  ViewController.swift
//  SwiftTestProject
//
//  Created by Omer Janjua on 16/07/2016.
//  Copyright © 2016 Janjua Ltd. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var retryButton: UIButton!
    
    // Data Variables
    var posts: [Post]?
    let postDataSource: PostDataSource = PostDataSource()
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let posts: [Post] = PostDataSource.fetchPost() where posts.count != 0 {
            self.posts = posts
            self.layoutForSuccess()
        } else {
            self.layoutForFetching()
            self.fetchPosts()
        }
    }
    
    // MARK: - Memory Management
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Button Interactions
    
    @IBAction func retryFetching() {
        self.layoutForFetching()
        self.fetchPosts()
    }
    
    // MARK: - Networking
    
    func fetchPosts() {
        self.postDataSource.postList(success: {
            self.posts = PostDataSource.fetchPost()
            self.layoutForSuccess()
            }, failure: {
                self.layoutForFailure()
        })
    }
    
    // MARK: - UI updates
    
    func layoutForFetching() {
        self.tableView.hidden = true
        
        self.errorLabel.hidden = false
        self.errorLabel.text = "Fetching data"
        
        self.activityIndicator.startAnimating()
        self.activityIndicator.hidden = false
        
        self.retryButton.hidden = true
    }
    
    func layoutForSuccess() {
        self.tableView.hidden = false
        self.tableView.reloadData()
        
        self.errorLabel.hidden = true
        
        self.activityIndicator.stopAnimating()
        self.activityIndicator.hidden = true
        
        self.retryButton.hidden = true
    }
    
    func layoutForFailure() {
        self.tableView.hidden = true
        
        self.errorLabel.text = "Error while fetching data"
        self.errorLabel.hidden = false
        
        self.activityIndicator.stopAnimating()
        self.activityIndicator.hidden = true
        
        self.retryButton.hidden = false
    }
    
    // MARK: - TableView Management
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard self.posts != nil else {
            return 0
        }
        return self.posts!.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let post:Post = self.posts![indexPath.row]
        
        let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("cell")!
        cell.textLabel!.text = post.title
        
        return cell
    }
    
}
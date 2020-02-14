//
//  ViewController.swift
//  MyNotebook
//
//  Created by Macbook Pro on 14/02/2020.
//  Copyright © 2020 Macbook Pro. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    

    var theText = "Starting here..."
    var textArray = [String]() //we initialize an empty String array
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() { //will only get called the very first time the app is launched
        super.viewDidLoad()
        textArray.append("Hello")
        textArray.append("How are you?")
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        textView.text = theText
    }
    
    
    @IBAction func SaveBtn(_ sender: UIButton) {
        theText = textView.text
        textArray.append(theText) //add the new text to the array
        tableView.reloadData()
        textView.text = ""
        print(theText)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return textArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell1")
        cell?.textLabel?.text = textArray[indexPath.row]
        return cell!
    }
}

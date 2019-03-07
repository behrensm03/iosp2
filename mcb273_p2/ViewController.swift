//
//  ViewController.swift
//  mcb273_p2
//
//  Created by Michael Behrens on 3/6/19.
//  Copyright © 2019 Michael Behrens. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // Main Text Views and Fields
    var headerTextView: UITextView!
    var itemTextField: UITextField!
    var quantityTextView: UITextView!
    var quantityTextField: UITextField!
    var addButton: UIButton!
    var groceryLabel: UILabel!
    var groceryTextView: UITextView!
    var groceryList: String = ""
    var displayModeLabel: UILabel!
    var removeButton: UIButton!
    
    // Array of items used for checking duplicate values
    var items: [String] = []
    
    // Feedback
    var feedbackTextView: UITextView!
    
    // Switch
    var toggleSwitch: UISwitch!
    
    // alphabetical or reverse alphabetical mode
    // dictionary data maintains a dict of all items added to grocery list where key is item name and value is quantity
    var data: [String : String] =  [:]
    var alphabeticalModeOn = true
    var reverseAlphabeticalModeOn = false
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        // Do any additional setup after loading the view, typically from a nib.
        
        headerTextView = UITextView()
        headerTextView.translatesAutoresizingMaskIntoConstraints = false
        headerTextView.text = "Grocery Item:"
        headerTextView.isEditable = false
        headerTextView.font = UIFont.systemFont(ofSize: 16)
        headerTextView.textColor = .black
        headerTextView.textAlignment = .right
        //headerTextView.backgroundColor = .gray
        view.addSubview(headerTextView)
        
        itemTextField = UITextField()
        itemTextField.translatesAutoresizingMaskIntoConstraints = false
        itemTextField.placeholder = "Enter item"
        itemTextField.font = UIFont.systemFont(ofSize: 16)
        itemTextField.textColor = .black
        itemTextField.backgroundColor = .gray
        view.addSubview(itemTextField)
        
        quantityTextView = UITextView()
        quantityTextView.translatesAutoresizingMaskIntoConstraints = false
        quantityTextView.text = "Quantity:"
        quantityTextView.isEditable = false
        quantityTextView.font = UIFont.systemFont(ofSize: 16)
        quantityTextView.textColor = .black
        quantityTextView.textAlignment = .right
        view.addSubview(quantityTextView)
        
        quantityTextField = UITextField()
        quantityTextField.translatesAutoresizingMaskIntoConstraints = false
        quantityTextField.placeholder = "Enter quantity"
        quantityTextField.font = UIFont.systemFont(ofSize: 16)
        quantityTextField.textColor = .black
        quantityTextField.backgroundColor = .gray
        view.addSubview(quantityTextField)
        
        addButton = UIButton()
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.setTitle("Add Item", for: .normal)
        addButton.setTitleColor(UIColor.blue, for: .normal)
        addButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        addButton.addTarget(self, action: #selector(addItem), for: .touchUpInside)
        view.addSubview(addButton)
        
        groceryLabel = UILabel()
        groceryLabel.translatesAutoresizingMaskIntoConstraints = false
        groceryLabel.text = "Grocery List:"
        groceryLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        groceryLabel.textColor = .black
        groceryLabel.textAlignment = .center;
        view.addSubview(groceryLabel)
        
        groceryTextView = UITextView()
        groceryTextView.translatesAutoresizingMaskIntoConstraints = false
        groceryTextView.text = groceryList
        groceryTextView.isEditable = false
        groceryTextView.font = UIFont.systemFont(ofSize: 12)
        groceryTextView.textColor = .black
        groceryTextView.textAlignment = .center
        view.addSubview(groceryTextView)
        
        feedbackTextView = UITextView()
        feedbackTextView.translatesAutoresizingMaskIntoConstraints = false
        feedbackTextView.text = ""
        feedbackTextView.isEditable = false
        feedbackTextView.font = UIFont.systemFont(ofSize: 12)
        feedbackTextView.textColor = .red
        feedbackTextView.textAlignment = .center
        view.addSubview(feedbackTextView)
        
        let modes = ["Alphabetically", "Reverse"]
        let seg = UISegmentedControl(items: modes)
        //let segFrame = UIScreen.main.bounds
        seg.layer.cornerRadius = 5.0
        seg.frame = CGRect(x: 5, y: 800, width: view.frame.width-10, height: 30)
        seg.backgroundColor = UIColor.darkGray
        seg.tintColor = UIColor.lightGray
        seg.selectedSegmentIndex = 0
        seg.addTarget(self, action: #selector(changeOrder(sender:)), for: .valueChanged)
        view.addSubview(seg)
        
        displayModeLabel = UILabel()
        displayModeLabel.translatesAutoresizingMaskIntoConstraints = false
        displayModeLabel.text = "Display Mode:"
        displayModeLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        displayModeLabel.textColor = .black
        displayModeLabel.textAlignment = .center
        view.addSubview(displayModeLabel)
        
        removeButton = UIButton()
        removeButton.translatesAutoresizingMaskIntoConstraints = false
        removeButton.setTitle("Remove Item", for: .normal)
        removeButton.setTitleColor(.red, for: .normal)
        removeButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        removeButton.addTarget(self, action: #selector(removeItem), for: .touchUpInside)
        view.addSubview(removeButton)
        
        createSwitch()
        setupConstraints()
    }
    
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
//            headerTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 60),
            headerTextView.widthAnchor.constraint(equalToConstant: 120),
            headerTextView.trailingAnchor.constraint(equalTo: view.centerXAnchor),
            headerTextView.heightAnchor.constraint(equalToConstant: 30),
            headerTextView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20)
            ])
        
        NSLayoutConstraint.activate([
            itemTextField.leadingAnchor.constraint(equalTo: headerTextView.trailingAnchor, constant: 10),
            itemTextField.widthAnchor.constraint(equalToConstant: 150),
            itemTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            itemTextField.heightAnchor.constraint(equalToConstant: 30)
            ])
        
        NSLayoutConstraint.activate([
            quantityTextView.widthAnchor.constraint(equalToConstant: 120),
            quantityTextView.heightAnchor.constraint(equalToConstant: 30),
            quantityTextView.topAnchor.constraint(equalTo: headerTextView.bottomAnchor, constant: 20),
            quantityTextView.trailingAnchor.constraint(equalTo: view.centerXAnchor)
            ])
        
        NSLayoutConstraint.activate([
            quantityTextField.leadingAnchor.constraint(equalTo: quantityTextView.trailingAnchor, constant: 10),
            quantityTextField.widthAnchor.constraint(equalToConstant: 150),
            quantityTextField.topAnchor.constraint(equalTo: itemTextField.bottomAnchor, constant: 20),
            quantityTextField.heightAnchor.constraint(equalToConstant: 30)
            ])
        
        NSLayoutConstraint.activate([
            addButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addButton.widthAnchor.constraint(equalToConstant: 200),
            addButton.topAnchor.constraint(equalTo: quantityTextField.bottomAnchor, constant: 75),
            addButton.heightAnchor.constraint(equalToConstant: 30)
            ])
        
        NSLayoutConstraint.activate([
            groceryLabel.topAnchor.constraint(equalTo: addButton.bottomAnchor, constant: 100),
            groceryLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            groceryLabel.widthAnchor.constraint(equalToConstant: 200),
            groceryLabel.heightAnchor.constraint(equalToConstant: 30)
            ])
        
        NSLayoutConstraint.activate([
            groceryTextView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            groceryTextView.topAnchor.constraint(equalTo: groceryLabel.bottomAnchor, constant: 5),
            groceryTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            groceryTextView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -100)
            ])
        
        NSLayoutConstraint.activate([
            feedbackTextView.widthAnchor.constraint(equalToConstant: 200),
            feedbackTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            feedbackTextView.topAnchor.constraint(equalTo: addButton.bottomAnchor, constant: 30),
            feedbackTextView.heightAnchor.constraint(equalToConstant: 60)
            ])
        
        NSLayoutConstraint.activate([
            displayModeLabel.topAnchor.constraint(equalTo: toggleSwitch.bottomAnchor, constant: 75),
            displayModeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            displayModeLabel.widthAnchor.constraint(equalToConstant: 200),
            displayModeLabel.heightAnchor.constraint(equalToConstant: 30)
            ])
        
        NSLayoutConstraint.activate([
            removeButton.topAnchor.constraint(equalTo: addButton.bottomAnchor, constant: 5),
            removeButton.widthAnchor.constraint(equalTo: addButton.widthAnchor),
            removeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            removeButton.heightAnchor.constraint(equalToConstant: 30)
            ])
        
    }
    
    @objc func addItem() {
        let s: String = (itemTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines))!
        let q: String = (quantityTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines))!
        
        if toggleSwitch.isOn == false {
            showToggleFeedback()
        }
        else if items.contains(s) {
            // item s is already in the grocery list
            duplicateItemFeedback()
        }
        else if (s=="" || q=="") {
            // no value for one or both inputs
            emptyInputFeedback()
        }
        else {
            if (alphabeticalModeOn) {
                insertItemAlphabetically()
                resetFields()
            }
            else {
                insertItemReverseAlphabetically()
            }
        }
    }
    
    // add to the end of the grocery list
    func addinOrder() {
        groceryList = groceryList + "\nItem: " + itemTextField.text! + ", Quantity: " + quantityTextField.text!
        groceryTextView.text = groceryList
        feedbackTextView.text = ""
        items.append(itemTextField.text!)
        data[itemTextField.text!] = quantityTextField.text
    }
    
    @objc func duplicateItemFeedback() {
        feedbackTextView.text = "This item is already in the grocery list."
    }
    
    func emptyInputFeedback() {
        feedbackTextView.text = "The item or quantity is empty. Please specify both values."
    }
    
    func createSwitch() {
        toggleSwitch = UISwitch()
        toggleSwitch.frame = CGRect(x: view.frame.width/2-30, y: 650, width: 0, height: 0)
        toggleSwitch.isOn = true
        view.addSubview(toggleSwitch)
    }
    
    func showToggleFeedback() {
        feedbackTextView.text = "Toggle switch is off. Please turn on in order to add items to the list."
    }
    
    // set groceryTextView.text to its value but in alphabetical order
    @objc func alphabetize() {
        let sorted = data.sorted(by: <)
        var result = ""
        for r in sorted {
            result = result + "\nItem: " + r.key + ", Quantity: " + r.value
        }
        groceryTextView.text = result
    }
    
    // set groceryTextView.text to its value but in reverse alphabetical order
    @objc func reverseAlphabetize() {
        let sorted = data.sorted(by: >)
        var result = ""
        for r in sorted {
            result = result + "\nItem: " + r.key + ", Quantity: " + r.value
        }
        groceryTextView.text = result
    }
    
    // UISegmented control - if left panel chosen, call alphabetize(). if right panel chosen, call reverseAlphabetize().
    @objc func changeOrder(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            alphabetize()
            alphabeticalModeOn = true
            reverseAlphabeticalModeOn = false
        case 1:
            reverseAlphabetize()
            alphabeticalModeOn = false
            reverseAlphabeticalModeOn = true
        default:
            alphabetize()
            alphabeticalModeOn = true
            reverseAlphabeticalModeOn = false
        }
    }
    
    func insertItemAlphabetically() {
        addinOrder()
        alphabetize()
    }
    
    func insertItemReverseAlphabetically() {
        addinOrder()
        reverseAlphabetize()
    }
    
    func reorder() {
        if (alphabeticalModeOn) {
            alphabetize()
        }
        else {
            reverseAlphabetize()
        }
    }
    
    @objc func removeItem() {
        if (items.contains(itemTextField.text!)) {
            let x = items.firstIndex(of: itemTextField.text!)
            items.remove(at: x!)
            data.removeValue(forKey: itemTextField.text!)
            reorder()
            feedbackTextView.text = ""
            resetFields()
        }
        else {
            feedbackTextView.text = "This item cannot be removed as it is not in the list."
        }
    }
    
    func resetFields() {
        itemTextField.text=nil
        quantityTextField.text=nil
    }
    


}


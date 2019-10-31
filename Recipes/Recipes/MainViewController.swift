//
//  MainViewController.swift
//  Recipes
//
//  Created by Christy Hicks on 10/30/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var searchTextField: UITextField!
    
    // MARK: - Properties
    let networkClient = RecipesNetworkClient()
    var allRecipes: [Recipe] = [] {
        didSet {
            filterRecipes()
        }
    }
    
    var recipesTableViewController: RecipesTableViewController? {
        didSet {
            self.recipesTableViewController?.recipes = filteredRecipes
        }
    }
    
    var filteredRecipes: [Recipe] = [] {
        didSet {
            recipesTableViewController?.recipes = filteredRecipes
            recipesTableViewController?.tableView.reloadData()
        }
    }
    
    // MARK: - View
    override func viewDidLoad() {
        super.viewDidLoad()
        networkClient.fetchRecipes { (recipes, error) in
            if let error = error {
                NSLog("Error loading data \(error)")
                return
            }
            self.allRecipes = recipes ?? []
        }
    }
    
    // MARK: - Actions
    @IBAction func textFieldAction(_ sender: UITextField) {
        self.searchTextField.resignFirstResponder()
        filterRecipes()
    }
    
    // MARK: - Methods
    func filterRecipes() {
        DispatchQueue.main.async {
            if let text = self.searchTextField.text, text != "" {
              self.filteredRecipes = self.allRecipes.filter( {(recipe) in recipe.name.contains(text) || recipe.instructions.contains(text)} )
            } else {
            self.filteredRecipes = self.allRecipes
            }
        }
    }
    
    
    // MARK: - Navigation

   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "embeddedTableViewSegue" {
            let vc = segue.destination as! RecipesTableViewController
                recipesTableViewController = vc
        }
    }
}

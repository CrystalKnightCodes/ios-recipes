//
//  RecipeDetailViewController.swift
//  Recipes
//
//  Created by Christy Hicks on 10/30/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var recipeNameLabel: UILabel!
    @IBOutlet weak var recipeTextView: UITextView!
    
    // MARK: - Properties
    
    var recipe: Recipe? {
        didSet {
            updateViews()
        }
    }
    
    // MARK: - View
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    func updateViews() {
        guard let recipe = recipe else { return }
        if isViewLoaded {
            recipeNameLabel.text = recipe.name
            recipeTextView.text = recipe.instructions
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//
//  ConcentrationThemeChooserViewController.swift
//  Concentration
//
//  Created by Larisa Diana Mihuț on 15.04.2021.
//

import UIKit

class ConcentrationThemeChooserViewController: UIViewController, UISplitViewControllerDelegate {
    
    // MARK: - Properties
    
    private var splitViewDetailConcentrationViewController: ConcentrationViewController? {
        return splitViewController?.viewControllers.last as? ConcentrationViewController
    }
    private var lastSeguedToConcetrationViewController: ConcentrationViewController?
    
    // MARK: - Actions
    
    @IBAction func changeTheme(_ sender: Any) {
        splitViewController?.preferredDisplayMode
        if let cvc = splitViewDetailConcentrationViewController {
            if let themeName = (sender as? UIButton)?.currentTitle, let theme = Theme().getNewTheme(theme: themeName) {
                cvc.theme = theme
            }
        } else if let cvc = lastSeguedToConcetrationViewController {
            if let themeName = (sender as? UIButton)?.currentTitle, let theme = Theme().getNewTheme(theme: themeName) {
                cvc.theme = theme
            }
            navigationController?.pushViewController(cvc, animated: true)
        } else {
            performSegue(withIdentifier: "Choose Theme", sender: sender)
        }
    }
    
    // MARK: - Life Cycle
    
    override func awakeFromNib() {
        splitViewController?.delegate = self
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Choose Theme" {
            if let themeName = (sender as? UIButton)?.currentTitle, let theme = Theme().getNewTheme(theme: themeName) {
                if let cvc = segue.destination as? ConcentrationViewController {
                    cvc.theme = theme
                    lastSeguedToConcetrationViewController = cvc
                }
            }
        }
    }
    
    // MARK: - Utils
    
    func splitViewController(_ splitViewController: UISplitViewController,
                             collapseSecondary secondaryViewController: UIViewController,
                             onto primaryViewController: UIViewController) -> Bool {
        if let cvc = secondaryViewController as? ConcentrationViewController {
            if cvc.theme == nil {
                return true
            }
        }
        return false
    }
}

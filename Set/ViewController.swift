//
//  ViewController.swift
//  Set
//
//  Created by Luke on 7/15/18.
//  Copyright © 2018 Luke Yuan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // MARK: Properties
    private var game = Set()
    
    // MARK: UI Elements

    @IBOutlet weak var dealCardsButton: UIButton!
    @IBOutlet var cardButtons: [UIButton]!
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBAction func dealCards(_ sender: UIButton) {
        game.addThreeCards()
        updateViewFromModel()
    }
    
    @IBAction func touchCard(_ sender: UIButton) {
        game.selectCard(game.cardsBeingPlayed[cardButtons.index(of: sender)!])
        updateViewFromModel()
    }
    
    @IBAction func newGame(_ sender: UIButton) {
        game = Set()
        updateViewFromModel()
    }
    
    func updateViewFromModel() {
        
        for index in 0..<game.cardsBeingPlayed.count {
            
            var text: String!
            var strokeColor: UIColor!
            var strokeWidth: NSNumber = 0.0
            switch game.cardsBeingPlayed[index].shape {
            case .circle: text = "●"
            case .square: text = "■"
            case .triangle: text = "▲"
            }

            switch game.cardsBeingPlayed[index].color {
            case .black: strokeColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            case .blue: strokeColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
            case .red: strokeColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
            }
            var foregroundColor = strokeColor!
            switch game.cardsBeingPlayed[index].shading {
            case .empty: strokeWidth = 3.0
            case .solid: foregroundColor = foregroundColor.withAlphaComponent(1.0); strokeWidth = -2.0
            case .striped: foregroundColor = foregroundColor.withAlphaComponent(0.15)
            }
            switch game.cardsBeingPlayed[index].number {
            case 1: break
            case 2: text = text + text
            case 3: text = text + text + text
            default: break
            }
            cardButtons[index].layer.borderColor = UIColor.blue.cgColor
            cardButtons[index].setAttributedTitle(NSAttributedString(string: text, attributes: [.strokeWidth: strokeWidth, .foregroundColor: foregroundColor, .strokeColor: strokeColor]), for: .normal)
            cardButtons[index].isEnabled = true
        }
        
        // custom display selected/matched card(s)
        if game.matched() {
            for card in game.selectedCards {
                cardButtons[game.cardsBeingPlayed.index(of: card)!].layer.borderColor = UIColor.green.cgColor
            }
        } else if !game.matched() && game.selectedCards.count == 3 {
            for card in game.selectedCards {
                cardButtons[game.cardsBeingPlayed.index(of: card)!].layer.borderColor = UIColor.red.cgColor
            }
        } else {
            for card in game.selectedCards {
                cardButtons[game.cardsBeingPlayed.index(of: card)!].layer.borderColor = UIColor.purple.cgColor
            }
        }

        if game.cardsBeingPlayed.count < 24 {
            for index in game.cardsBeingPlayed.count...23 {
                cardButtons[index].isEnabled = false
                cardButtons[index].setAttributedTitle(nil, for: .normal)
                cardButtons[index].layer.borderColor = UIColor.black.cgColor
            }    
        }
        
        scoreLabel.text = String(game.score)
        
        if (game.cards.count < 3 || (game.cardsBeingPlayed.count >= 24 && !game.matched())) {
            dealCardsButton.isEnabled = false
        } else {
            dealCardsButton.isEnabled = true
        }
    }
    
    private func resetButtons() {
        
    }
    override func viewDidLoad() {
        for cardButton in cardButtons {
            cardButton.layer.cornerRadius = 8.0
            cardButton.layer.borderWidth = 3.0
        }
        updateViewFromModel()
    }
}


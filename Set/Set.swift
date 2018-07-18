//
//  Set.swift
//  Set
//
//  Created by Luke on 7/15/18.
//  Copyright © 2018 Luke Yuan. All rights reserved.
//

import Foundation

class Set {
    // MARK: Properties
    private(set) var score: Int
    private(set) var cards: [Card]
    private(set) var matchedCards: [Card]
    private(set) var cardsBeingPlayed: [Card]
    private(set) var selectedCards: [Card]
    
    // MARK: Initialization
    init() {
        cards = []
        matchedCards = []
        cardsBeingPlayed = []
        selectedCards = []
        score = 0
        
        // add cards
        for shading in Card.Shading.all {
            for shape in Card.Shape.all {
                for color in Card.Color.all {
                    for number in 1...3 {
                        cards.append(Card(number: number, shading: shading, shape: shape, color: color))
                    }
                }
            }
        }
        
        // shuffle cards
        for index in 0..<cards.count {
            let temp = cards[index]
            let randomIndex = Int(arc4random_uniform(UInt32(cards.count)))
            cards[index] = cards[randomIndex]
            cards[randomIndex] = temp
        }
        
        for _ in 0...11 {
            cardsBeingPlayed.append(cards.remove(at: 0))
        }
    }
    
    func matched() -> Bool {
        if selectedCards.count == 3 {
            let colors = (selectedCards[0].color == selectedCards[1].color && selectedCards[1].color == selectedCards[2].color) || (selectedCards[0].color != selectedCards[1].color && selectedCards[0].color != selectedCards[2].color && selectedCards[1].color != selectedCards[2].color)
            let shadings = (selectedCards[0].shading == selectedCards[1].shading && selectedCards[1].shading == selectedCards[2].shading) || (selectedCards[0].shading != selectedCards[1].shading && selectedCards[0].shading != selectedCards[2].shading && selectedCards[1].shading != selectedCards[2].shading)
            let shapes = (selectedCards[0].shape == selectedCards[1].shape && selectedCards[1].shape == selectedCards[2].shape) || (selectedCards[0].shape != selectedCards[1].shape && selectedCards[0].shape != selectedCards[2].shape && selectedCards[1].shape != selectedCards[2].shape)
            let numbers = (selectedCards[0].number == selectedCards[1].number && selectedCards[1].number == selectedCards[2].number) || (selectedCards[0].number != selectedCards[1].number && selectedCards[0].number != selectedCards[2].number && selectedCards[1].number != selectedCards[2].number)
            
            return colors && shadings && shapes && numbers
        }
        return false
    }
    
    func addThreeCards() {
        if matched() {
            removeMatchedCards()
            selectedCards = []
        }
        if cards.count >= 3 {
            for _ in 0...2 {
                cardsBeingPlayed.append(cards.remove(at: 0))
            }
        }
    }
    
    func selectCard(_ card: Card) {
        if matched() {
            // if a set is already found, delete the matched cards and add three cards
            if !selectedCards.contains(card) {
                addThreeCards()
                selectedCards = [card]
            }
        } else if selectedCards.count < 3 {
            if !selectedCards.contains(card) {
                selectedCards.append(card)
                if matched() {
                    score += 3
                    matchedCards.append(contentsOf: selectedCards)
                } else if !matched() && selectedCards.count == 3 {
                    score -= 5
                }
            } else {
                selectedCards.remove(at: selectedCards.index(of: card)!)
            }
            
        } else { // mismatch
            selectedCards = [card]
        }
    }
    
    private func removeMatchedCards() {
        for card in selectedCards {
            cardsBeingPlayed.remove(at: cardsBeingPlayed.index(of: card)!)
        }
    }
}

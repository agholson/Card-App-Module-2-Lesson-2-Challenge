//
//  ContentView.swift
//  Lesson2-Challenge
//
//  Created by Shepherd on 7/15/21.
//

import SwiftUI

struct ContentView: View {
    
    // MARK: Properties
    // Instance of our array of cards, state so it allows us to change it
    @State private var deck = [Card]()
    
    // Used to change the color of the suits
    @State private var currentlyRed:Bool = true
    
    // Tracks the status of each activity; defaults
    @State private var cardStatus:String = "Empty deck"
    
    // Tracks the state of the card, which appears on the screen.
    @State private var currentCard:Card = Card()
    
    
    // MARK: UI Swift Code
    var body: some View {
        VStack {
            
            // Text at the top
            Text(cardStatus)
                .font(.title)
                .fontWeight(.medium)
            
            // Holds our draw card information
            HStack {
                
                Button("Add card") {
                   addCard()
                }
                .padding()
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                
                Button("Draw card") {
                    drawCard()
                }
                .padding()
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                
            }
            
            // MARK: CARD Design
            
            ZStack {
                // Place a rectangle, which will represent our card
                Rectangle()
                    .foregroundColor(.white)
                    .padding()
                    .cornerRadius(30)
                    .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                
                VStack {
                    // Top left card
                    HStack {
                        
                        if currentlyRed == true {
                            Label(currentCard.name, systemImage: "suit.\(currentCard.suit).fill")
                                .padding()
                                .padding()
                                .foregroundColor(.red)
                                
                        } else {
                            Label(currentCard.name, systemImage: "suit.\(currentCard.suit).fill")
                                .padding()
                                .padding()
                                .foregroundColor(.black)
                        }
                        
                        Spacer()
                    }
                    
                    Spacer()
                    
                    // Bottom right card
                    HStack {
                        // Makes the text go to the far-right
                        Spacer()
                        
                        // Changes color based on suit
                        if currentlyRed == true {
                            // Makes the suit symbol like suit.club.fill
                            Label(currentCard.name, systemImage: "suit.\(currentCard.suit).fill")
                                .padding()
                                .padding()
                                .foregroundColor(.red)
                        } else {
                            Label(currentCard.name, systemImage: "suit.\(currentCard.suit).fill")
                                .padding()
                                .padding()
                                .foregroundColor(.black)
                        }
                    }
                    
                }
            }
            
        }
    }
    
    // MARK: Methods
    func addCard() {
        
        let suitChoices = ["club", "diamond", "heart", "diamond"]
        
        // Initializes new card
        var newCard = Card()
        
        // Add the number
        newCard.number = Int.random(in: 1...13)
        
        // Add suit randomly from our list of four choices
        newCard.suit = suitChoices.randomElement()!
        
        // See if the card is a named card e.g. "Jack"
        newCard.name = newCard.determineIfRoyalty(number: newCard.number)
        
        // See if exists in deck already
        if deck.contains(newCard) {
            // If it exists, say no new card made
            cardStatus = "Generated duplicate card."
            
        // Else, add the new card to the deck, and update the status label
        } else {
            deck.append(newCard)
            // Makes it look like "Generated a King of Clubs
            cardStatus = "Generated a \(newCard.name) of \(newCard.suit.capitalized)s"
        }
        
    }
    
    /*
     Draws a random card from our deck, if there are cards in the deck.
     */
    func drawCard() {
        
        // If there are no cards in the deck, then say so.
        if deck.count == 0 {
            // Update the top text
            cardStatus = "No cards in the deck."
        } else {
            // Grab a random card from the deck
            currentCard = deck.randomElement()!
            
            // Change the color to red/ black depending on the card's suit
            currentlyRed = currentCard.determineColor(suit: currentCard.suit)
            
            // Say which card we drew, which updates the label at the top
            cardStatus = "Drew a \(currentCard.name) of \(currentCard.suit.capitalized)s"
            
        }
        
    }

    
}

/*
 Structure, which represents a playing card.
 
 Create a new structure to represent a playing card

 It should keep track of a number from 1 to 13 (representing Ace to King)
 It should also keep track of the suit (Spades, Clubs, Hearts, Diamonds)
 
 */
struct Card: Equatable {
    var number:Int = 0
    var suit:String = ""
    var name:String = ""
    
    /*
     Sets the name, if the number is above 11, or a 1, because these are named cards.
     */
    func determineIfRoyalty(number: Int) -> String {
        var royalName:String = ""
        // If the card is a royal, then change its name
        if number > 10 {
            if number == 11 {
                royalName = "Jack"
            } else if number == 12 {
                royalName = "Queen"
            } else if number == 13 {
                royalName = "King"
            }
        // We check if it is an Ace at 1, then assign it here
        } else if number == 1 {
            royalName = "Ace"
        // Else we assign the name to the card's number
        } else {
            royalName = String(number)
        }
        
        return royalName
    }
    
    /*
     Determines, whether/ not the color should be black based on the suit.
     */
    func determineColor(suit: String) -> Bool {
        // Assume it is not read, then it is black
        var redColor = false
        
        // Unless we find here that it is red
        if suit == "diamond" || suit == "heart" {
            redColor = true
        // If the suit is not red, then it is black
        }
        
        return redColor
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

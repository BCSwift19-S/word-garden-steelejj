//
//  ViewController.swift
//  Word Garden
//
//  Created by James Steele on 2/3/19.
//  Copyright © 2019 James Steele. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var userGuessLabel: UILabel!
    @IBOutlet weak var guessedLetterField: UITextField!
    @IBOutlet weak var guessedLetterButton: UIButton!
    @IBOutlet weak var guessCountLabel: UILabel!
    @IBOutlet weak var playAgainButton: UIButton!
    @IBOutlet weak var flowerImageView: UIImageView!
    
    var wordToGuess = "CODE"
    var lettersGuessed = ""
    let maxNumberOfWrongGuesses = 8
    var wrongGuessesRemaining = 8
    var guessCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guessedLetterButton.isEnabled = false
        playAgainButton.isHidden = true
        formatUserGuessLabel()
    }
    
    func updateUIAfterGuess(){
        guessedLetterField.resignFirstResponder()
        guessedLetterField.text = ""
    }
    
    func formatUserGuessLabel() {
        
        var revealedWord = ""
        lettersGuessed += guessedLetterField.text!
        
        for letter in wordToGuess {
            if lettersGuessed.contains(letter) {
                revealedWord = revealedWord + " \(letter)"
            } else {
                revealedWord += " _"
            }
        }
        revealedWord.removeFirst()
        userGuessLabel.text = revealedWord
        

    }
    
    func guessALetter() {
        formatUserGuessLabel()
        guessCount += 1
        
        let currentLetterGuessed = guessedLetterField.text!
        if !wordToGuess.contains(currentLetterGuessed) {
            wrongGuessesRemaining = wrongGuessesRemaining - 1
            flowerImageView.image = UIImage(named: "flower\(wrongGuessesRemaining)")
        }
        
        //stop game if wrongGuessesRemaining = 0
        if wrongGuessesRemaining == 0 {
            playAgainButton.isHidden = false
            guessedLetterField.isEnabled = false
            guessedLetterButton.isEnabled = false
            guessCountLabel.text = "So sorry, you're all out of guesses. Try again?"
        } else if !userGuessLabel.text!.contains("_") {
            playAgainButton.isHidden = false
            guessedLetterField.isEnabled = false
            guessedLetterButton.isEnabled = false
            guessCountLabel.text = "You've got it! It took you  \(guessCount) guesses to guess the word!"
        } else {
            let guess = ( guessCount == 1 ? "guess" : "guesses")
            guessCountLabel.text = "You've made \(guessCount) \(guess)."
        }
    }
    
    
    @IBAction func guessedLetterFieldChanged(_ sender: UITextField) {
        if let letterGuessed = guessedLetterField.text?.last {
            guessedLetterField.text = "\(letterGuessed)"
            guessedLetterButton.isEnabled = true
        } else {
            // disable the button if I don't have a single character in the guessedLetterField
            guessedLetterButton.isEnabled = false
        }
    }
    
    @IBAction func guessLetterButtonPressed(_ sender: UIButton) {
        guessALetter()
        updateUIAfterGuess()
        
    }
    
    @IBAction func playAgainButtonPressed(_ sender: UIButton) {
        playAgainButton.isHidden = false
        guessedLetterField.isEnabled = true
        guessedLetterButton.isEnabled = false
        flowerImageView.image = UIImage(named: "flower8")
        wrongGuessesRemaining = maxNumberOfWrongGuesses
        lettersGuessed = ""
        formatUserGuessLabel()
        guessCountLabel.text = "You've made 0 guesses"
        guessCount = 0
    }
    
    @IBAction func doneKeyPressed(_ sender: UITextField) {
        guessALetter()
        updateUIAfterGuess()
        
    }
    
}


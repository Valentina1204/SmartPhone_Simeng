//
//  ViewController.swift
//  Card Game
//
//  Created by Valentina Song on 9/23/20.
//  Copyright © 2020 Simeng Song. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    @IBOutlet weak var card1: UIImageView!
    @IBOutlet weak var card2: UIImageView!
    @IBOutlet weak var card3: UIImageView!
    @IBOutlet weak var card4: UIImageView!
    @IBOutlet weak var card5: UIImageView!
    @IBOutlet weak var card6: UIImageView!
    
    let imagesName = ["2_of_clubs", "2_of_diamonds","2_of_hearts", "2_of_spades", "3_of_clubs", "3_of_diamonds","3_of_hearts", "3_of_spades", "4_of_clubs", "4_of_diamonds","4_of_hearts", "4_of_spades", "5_of_clubs", "5_of_diamonds","5_of_hearts", "5_of_spades", "6_of_clubs", "6_of_diamonds","6_of_hearts", "6_of_spades", "7_of_clubs", "7_of_diamonds","7_of_hearts", "7_of_spades", "8_of_clubs", "8_of_diamonds","8_of_hearts", "8_of_spades", "9_of_clubs", "9_of_diamonds","9_of_hearts", "9_of_spades", "10_of_clubs", "10_of_diamonds","10_of_hearts", "10_of_spades", "jack_of_clubs", "jack_of_diamonds","jack_of_hearts", "jack_of_spades", "queen_of_clubs", "queen_of_diamonds","queen_of_hearts", "queen_of_spades", "king_of_clubs", "king_of_diamonds","king_of_hearts", "king_of_spades", "ace_of_clubs", "ace_of_diamonds","ace_of_hearts", "ace_of_spades"]
    
    var cardValues = [-1, -1, -1, -1, -1, -1]
    
    func playCards(numberOfRandoms: Int, minNum: Int, maxNum: UInt32)
    {
        var uniqueNumbers = Set<Int>()
        // Make sure that all six random numbers are unique
        while uniqueNumbers.count < numberOfRandoms
        {
            uniqueNumbers.insert(Int(arc4random_uniform(maxNum + 1)) + minNum)
        }
        var index = 0;
        for values in uniqueNumbers
        {
            cardValues[index] = values
            index += 1
        }
        
        card1.image = UIImage(named: imagesName[cardValues[0]])
        card2.image = UIImage(named: imagesName[cardValues[1]])
        card3.image = UIImage(named: imagesName[cardValues[2]])
        card4.image = UIImage(named: imagesName[cardValues[3]])
        card5.image = UIImage(named: imagesName[cardValues[4]])
        card6.image = UIImage(named: imagesName[cardValues[5]])
    }
    
    @IBOutlet weak var Winner: UILabel!
    func findWinner()
    {
        if (cardValues[0] == 51 || cardValues[1] == 51 || cardValues[2] == 51)
        {
            Winner.text = "Player 1 Won!!!"
        }
        if (cardValues[3] == 51 || cardValues[4] == 51 || cardValues[5] == 51)
        {
            Winner.text = "Player 2 Won!!!"
        }
        
        if (Winner.text != "No Winner")
        {
            let alert = UIAlertController(title: "Play Again?", message: "", preferredStyle: .alert)

            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: {ACTION in self.rePlay()}))
                
            alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: {ACTION in exit(0)}))
            
            self.present(alert, animated: true)
        }
    }
    
    func rePlay()
    {
        Winner.text = "No Winner"
    }
    
    @IBAction func Play(_ sender: UIButton)
    {
        playCards(numberOfRandoms: 6, minNum: 0, maxNum: 51)
        findWinner()
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        playCards(numberOfRandoms: 6, minNum: 0, maxNum: 51)
        
    }
}


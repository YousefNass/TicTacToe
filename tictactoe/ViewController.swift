//
//  ViewController.swift
//  tictactoe
//
//  Created by Yousef Nasser on 5/30/25.
//

import UIKit

class ViewController: UIViewController {
    enum Turn {
        case Noguht
        case Cross
    }

    // MARK: outlets and variables
    
    @IBOutlet weak var turnLabel: UILabel!
    @IBOutlet weak var a1: UIButton!
    @IBOutlet weak var a2: UIButton!
    @IBOutlet weak var a3: UIButton!
    @IBOutlet weak var b1: UIButton!
    @IBOutlet weak var b2: UIButton!
    @IBOutlet weak var b3: UIButton!
    @IBOutlet weak var c1: UIButton!
    @IBOutlet weak var c2: UIButton!
    @IBOutlet weak var c3: UIButton!
    
    var firstturn = Turn.Cross
    var currentTurn = Turn.Noguht
    
    var NOUGHT = "O"
    var CROSS = "X"
    
    var board = [UIButton]()
    var noughtScore = 0
    var crossScore = 0
    
    
    // MARK: FUNCTIONS
    func initBoard(){
        
        board.append(a1)
        board.append(a2)
        board.append(a3)
        board.append(b1)
        board.append(b2)
        board.append(b3)
        board.append(c1)
        board.append(c2)
        board.append(c3)

    }
    
    
    func addToBoard ( _ sender : UIButton  ){
        if (sender.title(for : .normal) == nil)
        {
            if(currentTurn == Turn.Noguht){
                sender.setTitle(NOUGHT, for: .normal)
                currentTurn = Turn.Cross
                turnLabel.text = CROSS
            }
            else if (currentTurn == Turn.Cross){
                sender.setTitle(CROSS, for: .normal)
                currentTurn = Turn.Noguht
                turnLabel.text = NOUGHT
            }
            sender.isEnabled = false
        }
    }
    
    
    
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        addToBoard(sender)
        
        if checkForVictory(CROSS){
            crossScore += 1
            resultAlert(title: "cross win")
        }
        if checkForVictory(NOUGHT){
            noughtScore += 1
            resultAlert(title: "nought win")
        }
        if (fullBoard()){
            resultAlert(title: "Draw ")
        }
    }
    
    
    
    
    func fullBoard() -> Bool{
        for button in board{
            if button.title(for : .normal) == nil {
                return false
            }
        }
        return true
    }
    
    
    
    
    func resultAlert (title: String){
        let msg = "\nNoughts : " +  String(noughtScore) + "\n\nCrosses " + String(crossScore)
        let ac = UIAlertController(title: title, message: msg, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "Reset", style: .default, handler: { (_) in
            self.resetBoard()
        }))
        self.present(ac, animated: true)
    }
    
    
    func checkForVictory(_ s: String) -> Bool{
        //horizontal wins
        if thisSymbol(a1, s) && thisSymbol(a2, s) && thisSymbol(a3, s)
        {return true}
        if thisSymbol(b1, s) && thisSymbol(b2, s) && thisSymbol(b3, s)
        {return true}
        if thisSymbol(c1, s) && thisSymbol(c2, s) && thisSymbol(c3, s)
        {return true}
        
        //vertical wins
        if thisSymbol(a1, s) && thisSymbol(b1, s) && thisSymbol(c1, s)
        {return true}
        if thisSymbol(a2, s) && thisSymbol(b2, s) && thisSymbol(c2, s)
        {return true}
        if thisSymbol(a3, s) && thisSymbol(b3, s) && thisSymbol(c3, s)
        {return true}
        
        //diagonal wins
        if thisSymbol(a1, s) && thisSymbol(b2, s) && thisSymbol(c3, s)
        {return true}
        if thisSymbol(a3, s) && thisSymbol(b2, s) && thisSymbol(c1, s)
        {return true}
        else{
            return false
        }
    }
    func thisSymbol ( _ button : UIButton, _ symbol : String) -> Bool{
        return button.title (for: .normal) == symbol
    }
    
    
    func resetBoard (){
        for button in board {
             button.setTitle(nil, for: .normal)
            button.isEnabled = true
        }
        if (firstturn == Turn.Noguht){
            firstturn = Turn.Cross
            turnLabel.text = CROSS
        }
        else if (firstturn == Turn.Cross){
            firstturn = Turn.Noguht
            turnLabel.text = NOUGHT
        }
        currentTurn = firstturn
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initBoard()
    }
}


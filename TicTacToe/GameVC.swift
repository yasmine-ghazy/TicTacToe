//
//  GameVC.swift
//  TicTacToe
//
//  Created by Yasmine Ghazy on 2/23/18.
//  Copyright © 2018 Yasmine Ghazy. All rights reserved.
//

import UIKit

class GameVC: UIViewController {

    @IBOutlet weak var playLevel: UISegmentedControl!
    @IBOutlet weak var player1Score: UILabel!
    @IBOutlet weak var player2Score: UILabel!
    @IBOutlet weak var board: UIView!
    @IBOutlet weak var playerTurn: UILabel!
    
    var activePlayer : Int = 1
    var winner : Int = -1
    var steps: Int = 0
    var player1 = [Int]()
    var player2 = [Int]()
    var count1 : Int = 0
    var count2 : Int = 0
    private var _playMode: Int = 1
    var playMode : Int {
        get{
            return _playMode
        }
        set{
            _playMode = newValue
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    @IBAction func BtnClick(_ sender: UIButton) {
        
        let Btn = sender as! UIButton
        if playMode == 1 {
            if(activePlayer == 1){
                PlayGame(selectedBtn: Btn)
            }
            if(activePlayer == 2){
                autoPlay()
            }
          
        }
        else{
           PlayGame(selectedBtn: Btn)
        }
    }
    

    
    func PlayGame(selectedBtn : UIButton){
        
        if(activePlayer == 1){
            selectedBtn.setTitle("X", for: UIControlState.normal)
            selectedBtn.setTitleColor(UIColor.red, for: UIControlState.normal)
            player1.append(selectedBtn.tag)
            activePlayer = 2
        }
        else{
            selectedBtn.setTitle("O", for: UIControlState.normal)
            selectedBtn.setTitleColor(UIColor.blue, for: UIControlState.normal)
            player2.append(selectedBtn.tag)
            activePlayer = 1

        }
        selectedBtn.isEnabled = false
        steps += 1
        
        findWinner()
        
        playerTurn.text = String(activePlayer)
        
        
    }
    
    
    func findWinner(){
       var winner = -1
        let winBtns = [[1,2,3],[4,5,6],[7,8,9],[1,5,9],[3,5,7],[1,4,7],[2,5,8],[3,6,9]]
        for tags in winBtns{
            if(player1.contains(tags[0]) && player1.contains(tags[1]) && player1.contains(tags[2]) ){
                winner = 1
                count1 += 1
            }
            else if(player2.contains(tags[0]) && player2.contains(tags[1]) && player2.contains(tags[2]) ){
                winner = 2
                count2 += 1
            }
        }
        if(winner != -1){
            var msg = ""
            if(winner == 1){
                msg = "Winner is the first player"
            }
            else if(winner == 2){
                msg = "Winner is the Second Player"
            }
            let alert = UIAlertController(title:"Winner", message:msg , preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "ok",style: UIAlertActionStyle.default){ _ in
                self.newGame()
    
            
            })
            self.present(alert, animated: true, completion: nil)
            activePlayer = winner
            
        }
        if(steps == 9){
            newGame()
        }
        
    }
    
    func newGame(){
        player1 = [Int]()
        player2 = [Int]()
        player1Score.text = String(count1)
        player2Score.text = String(count2)
        steps = 0
        winner = -1
        var btn : UIButton
        for tag in 1...9 {
            btn = board.viewWithTag(tag) as! UIButton
            btn.setTitle(" ", for: UIControlState.normal)
            btn.isEnabled = true
        }
        if(activePlayer == 2){
            autoPlay()
        }
    }
    
    func autoPlay(){
        
        //scan empty cells
        var emptyCellsArray = [Int]()
        for index in 1...9 {
            if !(player1.contains(index) || player2.contains(index)){
                emptyCellsArray.append(index)
            }
        }
        

        let level : Int = playLevel.selectedSegmentIndex
        var cellID = 5
        if !(emptyCellsArray.contains(5)){
            switch(level) {
            case 0: //Easy Level
                cellID = EasyMode(emptyCells: emptyCellsArray)
            case  1://Defence Level
                cellID = DefenceMode(emptyCells: emptyCellsArray)
            case 2:// Attack Level
                cellID = AttackMode(emptyCells: emptyCellsArray)
            case 3://Hard Level
                cellID = HardMode(emptyCells: emptyCellsArray)
            default :
                cellID = EasyMode(emptyCells: emptyCellsArray)
            }
        }
        
                var btn : UIButton
        btn = board.viewWithTag(cellID) as! UIButton
        PlayGame(selectedBtn: btn)
    }
    
    func EasyMode(emptyCells : [Int])-> Int{
        let randIndex = arc4random_uniform(UInt32(emptyCells.count))
        let cellID = emptyCells[Int(randIndex)]
        return cellID
    }
    
    func DefenceMode(emptyCells : [Int])-> Int{
        
        var cellID = EasyMode(emptyCells: emptyCells)
        
        let winBtns = [[1,2,3],[4,5,6],[7,8,9],[1,5,9],[3,5,7],[1,4,7],[2,5,8],[3,6,9]]
        
        for tags in winBtns{
            if(emptyCells.contains(tags[0]) && player1.contains(tags[1]) && player1.contains(tags[2]) ){
                cellID = tags[0]
            }
            else if(player1.contains(tags[0]) && emptyCells.contains(tags[1]) && player1.contains(tags[2]) ){
                cellID = tags[1]
            }
            else if(player1.contains(tags[0]) && player1.contains(tags[1]) && emptyCells.contains(tags[2]) ){
                cellID = tags[2]
            }
        }

        return cellID

    }
    
    func AttackMode(emptyCells : [Int])-> Int{
        
        var cellID = EasyMode(emptyCells: emptyCells)
        
        let winBtns = [[1,2,3],[4,5,6],[7,8,9],[1,5,9],[3,5,7],[1,4,7],[2,5,8],[3,6,9]]
        
        for tags in winBtns{
            if(emptyCells.contains(tags[0]) && player2.contains(tags[1]) && player2.contains(tags[2]) ){
                cellID = tags[0]
            }
            else if(player2.contains(tags[0]) && emptyCells.contains(tags[1]) && player2.contains(tags[2])){
                cellID = tags[1]
            }
            else if(player2.contains(tags[0]) && player2.contains(tags[1]) && emptyCells.contains(tags[2])){
                cellID = tags[2]
            }
        }
        
        return cellID
        
    }
    func HardMode(emptyCells : [Int])-> Int{
        
        var cellID = EasyMode(emptyCells: emptyCells)
        
        let winBtns = [[1,2,3],[4,5,6],[7,8,9],[1,5,9],[3,5,7],[1,4,7],[2,5,8],[3,6,9]]
        
        for tags in winBtns{
            //attack to win  1 empty cell
            if(emptyCells.contains(tags[0]) && player2.contains(tags[1]) && player2.contains(tags[2]) ){
                cellID = tags[0]
            }
            else if(player2.contains(tags[0]) && emptyCells.contains(tags[1]) && player2.contains(tags[2])){
                cellID = tags[1]
            }
            else if(player2.contains(tags[0]) && player2.contains(tags[1]) && emptyCells.contains(tags[2])){
                cellID = tags[2]
            }
            //defence to not lose  1 empty cell
            else if(emptyCells.contains(tags[0]) && player1.contains(tags[1]) && player1.contains(tags[2]) ){
                cellID = tags[0]
            }
            else if(player1.contains(tags[0]) && emptyCells.contains(tags[1]) && player1.contains(tags[2]) ){
                cellID = tags[1]
            }
            else if(player1.contains(tags[0]) && player1.contains(tags[1]) && emptyCells.contains(tags[2]) ){
                cellID = tags[2]
            }
            
        }
        
        return cellID
        
    }


}


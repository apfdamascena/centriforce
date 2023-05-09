//
//  GameScene.swift
//  centriforce
//
//  Created by alexdamascena on 19/04/23.
//

import SwiftUI
import SpriteKit

class GameScene: SKScene {
    
    var actionForMarth: (() -> ())?
    
    var background: GameBackground?
    var car: Car?
    var floor: Floor?
    var cardInstructions: CardInstruction?
    var nextArrow: NextArrow?
    var weightArrow: ForceArrow?
    var normalArrow: ForceArrow?
    var centripetalArrow: ForceArrow?
    
    let userTextVelocity: UITextField = {
        let text = UITextField(frame: .zero)
        text.backgroundColor = .white
        text.layer.cornerRadius = 12
        text.layer.masksToBounds = true
        text.keyboardType = .phonePad
        return text
    }()
    
    let userTextVelocityLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 18)
        return label
    }()
    
    let playButton: UIButton = {
        let button = UIButton(configuration: UIButton.Configuration.filled())
        button.setTitle("PLAY", for: .normal)
        button.tintColor = UIColor.blue
     
        button.tintColor = .blue
        
        return button
    }()
    
    let goMarsButton: UIButton = {
        let button = UIButton(configuration: UIButton.Configuration.filled())
        button.setTitle("GO MARS", for: .normal)
        button.tintColor = UIColor(named: "orange")
        return button
    }()
    
    var velocity = 31
    
    var isCarTurnOn = false
    var isOnboarding = true
    var allForces = false
    
    let sceneSize: CGSize
    
    var index = 0
    
    let planet: RouteScreen
    
    init(withSize size: CGSize, planet: RouteScreen){
        self.sceneSize = size
        self.planet = planet
        super.init(size: size)
        
        if planet == .mars {
            isOnboarding = false
        }

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {

        background = GameBackground(withSize: view.bounds.size, planet: planet)
        car = Car(withSceneSize: view.bounds.size, planet: planet)
        floor = Floor(withSceneSize: view.bounds.size)
        cardInstructions = CardInstruction(withSceneSize: view.bounds.size)
        nextArrow = NextArrow(withSceneSize: view.bounds.size)
        weightArrow = ForceArrow(withSceneSize: view.bounds.size,
                                 forceArrowType: .weight)
        normalArrow = ForceArrow(withSceneSize: view.bounds.size,
                                 forceArrowType: .normal)
        centripetalArrow = ForceArrow(withSceneSize: view.bounds.size,
                                      forceArrowType: .centripetal)
        
        configureAdditionalViews()
    
        
        [background,
         car,
         floor,
         cardInstructions,
         nextArrow,
        ].forEach{ node in
            addChild( node ?? SKNode())
        }
                
        if planet == .mars {
            cardInstructions?.marsOnAppear()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let touchLocation = touch.location(in: self)
        let nodes = self.nodes(at: touchLocation)
        let node = nodes[0]
        
        if node.name == "arrow-right" && planet == .earth {
            guard let index = cardInstructions?.userTapNextArrow() else { return }
            
            if index >= 6 {
                car?.userEndOnboarding()
            }

            if index == 1 {
                addChild(weightArrow ?? SKNode())
            }
            
            if index == 2 {
                addChild(normalArrow ?? SKNode())
            }
            
            if index == 4 {
                addChild(centripetalArrow ?? SKNode())
            }
        }
        
        if node.name == "arrow-right" && self.planet == .mars {
            cardInstructions?.removeFromParent()
            nextArrow?.removeFromParent()
            
            addPlayedMarsButton()
        }
    
    }
    
    private func addPlayedMarsButton(){
        self.view?.addSubview(userTextVelocity)
        self.view?.addSubview(userTextVelocityLabel)
        self.view?.addSubview(playButton)
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        if isCarTurnOn {
            car?.update(with: velocity)
            guard let endPlay = car?.refreshIfNeeded() else { return }
            
            if endPlay {
                isCarTurnOn = false
            }
            
        }
        
        if isOnboarding {
            
            guard let _ = car?.update(onOnboarding: 10) else { return }
            guard let endOnboarding = car?.refreshIfNeeded() else { return }
            
            if endOnboarding {
                isOnboarding = false
                removeForcesArrow()
                removeCardInformation()
             
        
                self.view?.addSubview(userTextVelocity)
                self.view?.addSubview(userTextVelocityLabel)
                self.view?.addSubview(playButton)
                self.view?.addSubview(goMarsButton)
                
                allForces.toggle()
            }
            
        }

    }
    
    private func removeCardInformation(){
        let removeAction = SKAction.scale(by: 0.4, duration: 1.5)
        cardInstructions?.run(removeAction)
        nextArrow?.run(removeAction)
        self.cardInstructions?.removeFromParent()
        self.nextArrow?.removeFromParent()
    }
    
    private func removeForcesArrow(){
        
        let removeAction = SKAction.move(to: CGPoint(x: 0, y: 0), duration: 1.5)
        weightArrow?.run(removeAction)
        normalArrow?.run(removeAction)
        centripetalArrow?.run(removeAction)
        self.weightArrow?.removeFromParent()
        self.normalArrow?.removeFromParent()
        self.centripetalArrow?.removeFromParent()
    }
    
    private func configureAdditionalViews(){
        
        playButton.addTarget(self, action: #selector(didUserTapPlay), for: .touchUpInside)
        goMarsButton.addTarget(self, action: #selector(didUserTapGoMars), for: .touchUpInside)
        
        playButton.tintColor = planet == .earth ? .blue : UIColor(named: "universe-color")
  

        
        let additionalText = planet == .earth ? "\nYou can go to mars to see the influence of gravity" : ""
    
        userTextVelocityLabel.text = "Enter speed value between 9 and 20 miles/h\(additionalText)"
        
        userTextVelocity.frame = CGRect(x: 80,
                                        y: size.height/2 - 90,
                                        width: 250, height: 50)
        
        userTextVelocityLabel.frame = CGRect(x: 80,
                                             y: size.height/2 - 150,
                                             width: 450,
                                             height: 60)
        
        playButton.frame = CGRect(x: 80 + 250 + 8,
                                  y: size.height/2 - 85,
                                  width: 120,
                                  height: 40)
 
        goMarsButton.frame = CGRect(x: 80 + 250 + 120 + 8 + 12,
                                  y: size.height/2 - 85,
                                  width: 120,
                                height: 40)
    }
    
    @objc func didUserTapGoMars(){
        actionForMarth?()
    }
    
    @objc func didUserTapPlay(){
        guard let velocity = userTextVelocity.text else { return }
        guard let velocityNumber = Int(velocity) else {
            self.velocity = 12
            isCarTurnOn = true
            return
        }
        
        self.velocity = velocityNumber
        isCarTurnOn = true
    
    }
    
    private func createOnboardingOnMars(){
        cardInstructions?.marsOnAppear()
    }
}

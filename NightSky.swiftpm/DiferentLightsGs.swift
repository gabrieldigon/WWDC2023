//
//  DiferentLightsGs.swift
//  NightSky
//
//  Created by Gabriel Dias Goncalves on 10/04/23.
//

import Foundation
import SpriteKit

class DiferentLightGs : SKScene {
    var goodLamp  = LampNode()
    var badLamp  = LampNode()
    private var currentNode: SKNode?
    let background = SKSpriteNode(imageNamed: "backgroundDegrade")
    var goodLabel = SKLabelNode(fontNamed:"Marker Felt")
    var badLabel = SKLabelNode(fontNamed:"Marker Felt")
    let eye = SKSpriteNode(color: .white, size: CGSize(width: 100, height: 400))
    var drawCircle = circleNode()
    override func didMove(to view: SKView) {
        
       
       
        //adding background
        background.lightingBitMask = 1
        addChild(background)
        
        
        
        //adicionar olho
        eye.position = CGPoint(x: 200, y: 0.5)
        eye.shadowCastBitMask = 1
        
        addChild(eye)
        //adding circle
        
        drawCircle.position = CGPoint(x: 0.5, y: 0.5)
        drawCircle.DrawCircle.size = .init(width: 300, height: 300)
        addChild(drawCircle)
        // adding bad lamp
        goodLamp.name = "draggable"
        goodLamp.position = CGPoint(x: -330, y: -102)
        goodLamp.light.shadowColor = .white
        addChild(goodLamp)
        
        // adding good lamp
        badLamp.name = "draggable"
        badLamp.position = CGPoint(x: -343, y: 202)
        badLamp.light.shadowColor = .systemBlue
        addChild(badLamp)
        
        //label GoodLamp
        goodLabel.text = "This lamp is safe to use!"
        goodLabel.fontSize = 30
        goodLabel.position = CGPoint(x: 375, y: 0.5)
        goodLabel.fontColor = SKColor.black
        goodLabel.isHidden = true
        goodLabel.lineBreakMode = .byCharWrapping
        goodLabel.numberOfLines = 3
        goodLabel.preferredMaxLayoutWidth = 200
        addChild(goodLabel)
        
        //label GoodLamp
        badLabel.text = "This light causes glare in our eyes!"
        badLabel.fontSize = 30
        badLabel.position = CGPoint(x: 375, y: 0.5)
        badLabel.fontColor = SKColor.black
        badLabel.isHidden = true
        badLabel.lineBreakMode = .byCharWrapping
        badLabel.numberOfLines = 3
        badLabel.preferredMaxLayoutWidth = 200
        addChild(badLabel)

    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.currentNode = nil
    }
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.currentNode = nil
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first, let node = self.currentNode {
            let touchLocation = touch.location(in: self)
            node.position = touchLocation
            print(touchLocation)
            
            if goodLamp.position.x > -60 && goodLamp.position.x < 60 && goodLamp.position.y > -60 && goodLamp.position.y < 60 {
                goodLamp.light.categoryBitMask = 1
                goodLamp.imageLamp.texture = SKTexture(imageNamed: "lampDraw")
                goodLabel.isHidden = false
            }
            else{
                
                goodLamp.light.categoryBitMask = 0
                goodLamp.imageLamp.texture = SKTexture(imageNamed: "lampDrawOff")
                goodLabel.isHidden = true
            }
            if badLamp.position.x > -60 && badLamp.position.x < 60 && badLamp.position.y > -60 && badLamp.position.y < 60 {
                badLamp.light.categoryBitMask = 1
                badLamp.imageLamp.texture = SKTexture(imageNamed: "lampDraw")
                badLabel.isHidden = false
            }
            else{
                badLamp.light.categoryBitMask = 0
                badLamp.imageLamp.texture = SKTexture(imageNamed: "lampDrawOff")
                badLabel.isHidden = true
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)
            
            let touchedNodes = self.nodes(at: location)
            for node in touchedNodes.reversed() {
                if node.name == "draggable" {
                    self.currentNode = node
                }
            }
        }
    }
}

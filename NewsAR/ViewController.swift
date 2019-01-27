//
//  ViewController.swift
//  NewsAR
//
//  Created by Danish Dua on 2019-01-26.
//  Copyright © 2019 Danish Dua. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {
    
    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARImageTrackingConfiguration()
        
        
        
        if let trackedImages = ARReferenceImage.referenceImages(inGroupNamed: "NewsImages", bundle: Bundle.main) {
            
            configuration.trackingImages = trackedImages
            
            configuration.maximumNumberOfTrackedImages = 2
            
        }
        
        
        
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    // MARK: - ARSCNViewDelegate
    
    
    func setReferenceImgFromURL(){
        
    }
    
    
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        
        let node = SCNNode()
        
        if let imageAnchor = anchor as? ARImageAnchor {
            
            
            //            if (imageAnchor.referenceImage.name == "salad") {
            //                print("salad!!!!!!")
            //                let videoNodeTest = SKVideoNode(fileNamed: "test.mp4")
            //
            //                videoNodeTest.play()
            //
            //                let videoTestScene = SKScene(size: CGSize(width: 480, height: 360))
            //
            //                videoNodeTest.position = CGPoint(x: videoTestScene.size.width / 2, y: videoTestScene.size.height / 2)
            //
            //                videoNodeTest.yScale = -1.0
            //
            //                videoTestScene.addChild(videoNodeTest)
            //
            //
            //                testMaterial.diffuse.contents = videoTestScene
            //            }
            
            
            if (imageAnchor.referenceImage.name == "harrypotter") {
                print("pottererrrr!!!")
                
                let videoNode = SKVideoNode(fileNamed: "harrypotter.mp4")
                videoNode.play()
                let videoScene = SKScene(size: CGSize(width: 480, height: 360))
                videoNode.position = CGPoint(x: videoScene.size.width / 2, y: videoScene.size.height / 2)
                videoNode.yScale = -1.0
                videoScene.addChild(videoNode)
                
                let plane = SCNPlane(width: imageAnchor.referenceImage.physicalSize.width, height: imageAnchor.referenceImage.physicalSize.height)
                let hpMaterial: SCNMaterial = SCNMaterial()
                hpMaterial.diffuse.contents = videoScene
                plane.firstMaterial?.diffuse.contents = videoScene
                let planeNode = SCNNode(geometry: plane)
                planeNode.eulerAngles.x = -.pi / 2
                node.addChildNode(planeNode)
                
            }
            
            
            if (imageAnchor.referenceImage.name == "salad") {
                print("saladdddd!!!")
                
                let videoNode = SKVideoNode(fileNamed: "test.mp4")
                let videoScene = SKScene(size: CGSize(width: 480, height: 360))
                videoNode.position = CGPoint(x: videoScene.size.width / 2, y: videoScene.size.height / 2)
                videoNode.yScale = -1.0
                videoScene.addChild(videoNode)
                
                let plane = SCNPlane(width: imageAnchor.referenceImage.physicalSize.width, height: imageAnchor.referenceImage.physicalSize.height)
                let hpMaterial: SCNMaterial = SCNMaterial()
                hpMaterial.diffuse.contents = videoScene
                plane.firstMaterial?.diffuse.contents = videoScene
                let planeNode = SCNNode(geometry: plane)
                planeNode.eulerAngles.x = -.pi / 2
                node.addChildNode(planeNode)
                
            }
            
            
            
            
            //==========second video node
            
            
            //add all materials to plane
            //plane.firstMaterial? = hpMaterial
            
            //plane.materials.append(hpMaterial)
            
            
            
        }
        
        return node
        
    }
    
    
}

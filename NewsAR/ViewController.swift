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
    
    let webCacheURL =  "https://newsar.azurewebsites.net/cache" // removed container instance and copied the cache locally for demo
    
    @IBOutlet var sceneView: ARSCNView!
    
    var arReferenceImagesList: Set<ARReferenceImage> = Set<ARReferenceImage>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        sceneView.autoenablesDefaultLighting = true
        
        sceneView.automaticallyUpdatesLighting = true
    }
    
    
    func convertCIImageToCGImage(inputImage: CIImage) -> CGImage? {
        let context = CIContext(options: nil)
        
        if let cgImage = context.createCGImage(inputImage, from: inputImage.extent) {
            return cgImage
        }
        
        return nil
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARImageTrackingConfiguration()
        
        if let trackedImages = ARReferenceImage.referenceImages(inGroupNamed: "NewsImages", bundle: Bundle.main) {
            
            configuration.trackingImages = trackedImages
            
            // tracking multiple images at same time uses a lot of threds
            configuration.maximumNumberOfTrackedImages = 4
            
        }
        
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        
        let node = SCNNode()
        
        if let imageAnchor = anchor as? ARImageAnchor {
            
            if (imageAnchor.referenceImage.name == "harrypotter") || (imageAnchor.referenceImage.name == "salad") {
                
                _ = createVideoNodeWithWebView(node: node, imageAnchor: imageAnchor, filename: imageAnchor.referenceImage.name! + ".mp4")
            } else {
                _ = createVideoNode(node: node, imageAnchor: imageAnchor, filename: "video" + imageAnchor.referenceImage.name! + ".mp4")
            }
        }
        return node
    }
    
    func createVideoNode(node:SCNNode, imageAnchor: ARImageAnchor, filename: String) -> SCNNode {
        let videoNode = SKVideoNode(fileNamed: filename)
        videoNode.play()
        
        let videoScene = SKScene(size: CGSize(width: 480, height: 360))
        
        videoNode.position = CGPoint(x: videoScene.size.width / 2, y: videoScene.size.height / 2)
        videoNode.yScale = -1.0
        
        videoScene.addChild(videoNode)
        
        let plane = SCNPlane(width: imageAnchor.referenceImage.physicalSize.width, height: imageAnchor.referenceImage.physicalSize.height)
        
        let material: SCNMaterial = SCNMaterial()
        material.diffuse.contents = videoScene
        
        plane.firstMaterial?.diffuse.contents = videoScene
        
        let planeNode = SCNNode(geometry: plane)
        planeNode.eulerAngles.x = -.pi / 2
        
        node.addChildNode(planeNode)
        
        return planeNode
    }
    
    func createVideoNodeWithWebView(node:SCNNode, imageAnchor: ARImageAnchor, filename: String) {
        
        var planeNode = createVideoNode(node: node, imageAnchor: imageAnchor, filename: filename)
        
        if filename == "harrypotter" {
            displayWebViewDirected(on: planeNode, xOffset: imageAnchor.referenceImage.physicalSize.width, urlStr: "https://en.wikipedia.org/wiki/Harry_Potter", direction: "right")
        } else {
            displayWebViewDirected(on: planeNode, xOffset: imageAnchor.referenceImage.physicalSize.width, urlStr: "https://www.gimmesomeoven.com/everyday-salad-recipe/", direction: "left")
        }
    }
    
    // Xcode yells at us about the deprecation of UIWebView in iOS 12.0, but there is
    // currently a bug that does now allow us to use a WKWebView as a texture for our
    // webViewNode. Note that UIWebViews should only be instantiated on the main thread!
    func displayWebViewDirected(on rootNode: SCNNode, xOffset: CGFloat, urlStr: String, direction: String) {
        
        DispatchQueue.main.async {
            let request = URLRequest(url: URL(string: urlStr)!)
            
            let webView = UIWebView(frame: CGRect(x: 0, y: 0, width: 400, height: 672))
            
            webView.loadRequest(request)
            let webViewPlane = SCNPlane(width: xOffset, height: xOffset * 1.4)
            
            let webViewNode = SCNNode(geometry: webViewPlane)
            
            // Set the web view as webViewPlane's primary texture
            webViewNode.geometry?.firstMaterial?.diffuse.contents = webView
            webViewNode.opacity = 0
            
            rootNode.addChildNode(webViewNode)
            
            var directionInt = 1.1
            
            if direction == "left" {
                directionInt *= -1
            }
            
            webViewNode.runAction(.sequence([
                .wait(duration: 1.0),
                .fadeOpacity(to: 1.0, duration: 0.5),
                .moveBy(x: CGFloat(xOffset * CGFloat(directionInt)), y: 0, z: -0.5, duration: 1),
                .moveBy(x: 0, y: 0, z: 0.05, duration: 0.2)
                ])
            )
        }
    }
}

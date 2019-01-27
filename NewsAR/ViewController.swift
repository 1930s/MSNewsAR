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
    
    func addTrackImg(UIimg: UIImage, name:String) {
        let imageFromBundle = UIimg
        //2. Convert It To A CIImage
        let imageToCIImage = CIImage(image: imageFromBundle)
        //3. Then Convert The CIImage To A CGImage
        let cgImage = convertCIImageToCGImage(inputImage: imageToCIImage!)
        let arImage = ARReferenceImage(cgImage!, orientation: CGImagePropertyOrientation.up, physicalWidth: 0.2)
        arImage.name = name
        arReferenceImagesList.insert(arImage)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARImageTrackingConfiguration()
        
        if let UIImgHP = UIImage(named: "harrypotter1") {
            addTrackImg(UIimg: UIImgHP, name: "harrypotterT")
        }
        
        if let UIImgSA = UIImage (named:"salad1") {
            addTrackImg(UIimg: UIImgSA, name: "saladT")
        }
        
        
//        if let trackedImages = ARReferenceImage.referenceImages(inGroupNamed: "NewsImages", bundle: Bundle.main) {
//
//            configuration.trackingImages = trackedImages
//
//            configuration.maximumNumberOfTrackedImages = 2
//
//        }
        
        configuration.trackingImages = arReferenceImagesList
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
            
            
            
            
            if (imageAnchor.referenceImage.name == "harrypotterT") {
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
            
            
            if (imageAnchor.referenceImage.name == "saladT") {
                print("saladdddd!!!")
                
                let videoNode = SKVideoNode(fileNamed: "test.mp4")
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
            
            
            
            
            //==========second video node
            
            
            //add all materials to plane
            //plane.firstMaterial? = hpMaterial
            
            //plane.materials.append(hpMaterial)
            
            
            
        }
        
        return node
        
    }
    
    
    func displayWebView(on rootNode: SCNNode, xOffset: CGFloat) {
        // Xcode yells at us about the deprecation of UIWebView in iOS 12.0, but there is currently
        // a bug that does now allow us to use a WKWebView as a texture for our webViewNode
        // Note that UIWebViews should only be instantiated on the main thread!
        DispatchQueue.main.async {
            let request = URLRequest(url: URL(string: "https://www.youtube.com/embed/im0P-dcBpTE?autoplay=1")!)
            
            let webView = UIWebView(frame: CGRect(x: 0, y: 0, width: 400, height: 672))
            
            webView.loadRequest(request)
            let webViewPlane = SCNPlane(width: xOffset, height: xOffset * 1.4)
            //webViewPlane.cornerRadius = 0.25
            
            let webViewNode = SCNNode(geometry: webViewPlane)
            
            // Set the web view as webViewPlane's primary texture
            webViewNode.geometry?.firstMaterial?.diffuse.contents = webView
            //webViewNode.position.z -= 0.5
            
            webViewNode.opacity = 0
            rootNode.addChildNode(webViewNode)
            webViewNode.runAction(.sequence([
                .wait(duration: 0.5),
                .fadeOpacity(to: 1.0, duration: 0.5),
                .moveBy(x: xOffset * 1.1, y: 0, z: 0, duration: 0.5),
                .moveBy(x: 0, y: 0, z: 0.05, duration: 0.2)
                ])
            )
        }
    }
    
    func extractYoutubeIdFromLink(link: String) -> String? {
        let pattern = "((?<=(v|V)/)|(?<=be/)|(?<=(\\?|\\&)v=)|(?<=embed/))([\\w-]++)"
        guard let regExp = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive) else {
            return nil
        }
        let nsLink = link as NSString
        let options = NSRegularExpression.MatchingOptions(rawValue: 0)
        let range = NSRange(location: 0, length: nsLink.length)
        let matches = regExp.matches(in: link as String, options:options, range:range)
        if let firstMatch = matches.first {
            return nsLink.substring(with: firstMatch.range)
        }
        return nil
    }
    
    
}

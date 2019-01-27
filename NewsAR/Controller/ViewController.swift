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
import Alamofire
import SwiftyJSON


class ViewController: UIViewController, ARSCNViewDelegate {
    
    let webCacheURL =  "https://newsar.azurewebsites.net/cache"
    
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
        
        if let trackedImages = ARReferenceImage.referenceImages(inGroupNamed: "NewsImages", bundle: Bundle.main) {

            configuration.trackingImages = trackedImages

            configuration.maximumNumberOfTrackedImages = 4

        }
        
        // configuration.trackingImages = arReferenceImagesList
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
                
                displayWebViewRight(on: planeNode, xOffset: imageAnchor.referenceImage.physicalSize.width, urlStr: "https://en.wikipedia.org/wiki/Harry_Potter")
                }

            if (imageAnchor.referenceImage.name == "salad") {
                print("saladdddd!!!")

                let videoNode = SKVideoNode(fileNamed: "salad.mp4")
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
                displayWebViewLeft(on: planeNode, xOffset: imageAnchor.referenceImage.physicalSize.width, urlStr: "https://www.gimmesomeoven.com/everyday-salad-recipe/")
            }
            
            if (imageAnchor.referenceImage.name == "1") {
                print("1!!!")
                
                let videoNode = SKVideoNode(fileNamed: "video1.mp4")
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
                //displayWebView(on: planeNode, xOffset: imageAnchor.referenceImage.physicalSize.width, urlStr: "")
            }
            
            
            if (imageAnchor.referenceImage.name == "2") {
                print("2")
                
                let videoNode = SKVideoNode(fileNamed: "video2.mp4")
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
                //displayWebView(on: planeNode, xOffset: imageAnchor.referenceImage.physicalSize.width, urlStr: "")
            }
            
            if (imageAnchor.referenceImage.name == "3") {
                print("3!!!")
                
                let videoNode = SKVideoNode(fileNamed: "video3.mp4")
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
                //displayWebView(on: planeNode, xOffset: imageAnchor.referenceImage.physicalSize.width, urlStr: "")
            }
            
            if (imageAnchor.referenceImage.name == "4") {
                print("4")
                
                let videoNode = SKVideoNode(fileNamed: "video4.mp4")
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
                //displayWebView(on: planeNode, xOffset: imageAnchor.referenceImage.physicalSize.width, urlStr: "")
            }
            
            
            if (imageAnchor.referenceImage.name == "5") {
                print("5!!!")
                
                let videoNode = SKVideoNode(fileNamed: "video5.mp4")
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
                //displayWebView(on: planeNode, xOffset: imageAnchor.referenceImage.physicalSize.width, urlStr: "")
            }
            
            if (imageAnchor.referenceImage.name == "6") {
                print("6!!")
                
                let videoNode = SKVideoNode(fileNamed: "video6.mp4")
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
                //displayWebView(on: planeNode, xOffset: imageAnchor.referenceImage.physicalSize.width, urlStr: "")
            }
            
            if (imageAnchor.referenceImage.name == "7") {
                print("7!!!")
                
                let videoNode = SKVideoNode(fileNamed: "video7.mp4")
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
                //displayWebView(on: planeNode, xOffset: imageAnchor.referenceImage.physicalSize.width, urlStr: "")
            }
            
            if (imageAnchor.referenceImage.name == "8") {
                print("8!")
                
                let videoNode = SKVideoNode(fileNamed: "video8.mp4")
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
                //displayWebView(on: planeNode, xOffset: imageAnchor.referenceImage.physicalSize.width, urlStr: "")
            }
            
            if (imageAnchor.referenceImage.name == "9") {
                print("9!!!")
                
                let videoNode = SKVideoNode(fileNamed: "video9.mp4")
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
                //displayWebView(on: planeNode, xOffset: imageAnchor.referenceImage.physicalSize.width, urlStr: "")
            }
            
            if (imageAnchor.referenceImage.name == "10") {
                print("10!!")
                
                let videoNode = SKVideoNode(fileNamed: "video10.mp4")
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
                //displayWebView(on: planeNode, xOffset: imageAnchor.referenceImage.physicalSize.width, urlStr: "")
            }
            
            if (imageAnchor.referenceImage.name == "11") {
                print("11!!!")
                
                let videoNode = SKVideoNode(fileNamed: "video11.mp4")
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
                //displayWebView(on: planeNode, xOffset: imageAnchor.referenceImage.physicalSize.width, urlStr: "")
            }
            
            if (imageAnchor.referenceImage.name == "12") {
                print("12!!!")
                
                let videoNode = SKVideoNode(fileNamed: "video12.mp4")
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
                //displayWebView(on: planeNode, xOffset: imageAnchor.referenceImage.physicalSize.width, urlStr: "")
            }
            
            if (imageAnchor.referenceImage.name == "13") {
                print("13!!")
                
                let videoNode = SKVideoNode(fileNamed: "video13.mp4")
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
                //displayWebView(on: planeNode, xOffset: imageAnchor.referenceImage.physicalSize.width, urlStr: "")
            }
            
            if (imageAnchor.referenceImage.name == "14") {
                print("14!!")
                
                let videoNode = SKVideoNode(fileNamed: "video14.mp4")
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
                //displayWebView(on: planeNode, xOffset: imageAnchor.referenceImage.physicalSize.width, urlStr: "")
            }
            
            if (imageAnchor.referenceImage.name == "15") {
                print("15!")
                
                let videoNode = SKVideoNode(fileNamed: "video15.mp4")
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
                //displayWebView(on: planeNode, xOffset: imageAnchor.referenceImage.physicalSize.width, urlStr: "")
            }
            
            if (imageAnchor.referenceImage.name == "16") {
                print("16!")
                
                let videoNode = SKVideoNode(fileNamed: "video16.mp4")
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
                //displayWebView(on: planeNode, xOffset: imageAnchor.referenceImage.physicalSize.width, urlStr: "")
            }
            //==========second video node
            //add all materials to plane
            //plane.firstMaterial? = hpMaterial

            //plane.materials.append(hpMaterial)
            
            if (imageAnchor.referenceImage.name == "17") {
                print("17!")
                
                let videoNode = SKVideoNode(fileNamed: "video17.mp4")
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
                //displayWebView(on: planeNode, xOffset: imageAnchor.referenceImage.physicalSize.width, urlStr: "")
            }
            
            if (imageAnchor.referenceImage.name == "18") {
                print("18!")
                
                let videoNode = SKVideoNode(fileNamed: "video18.mp4")
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
                //displayWebView(on: planeNode, xOffset: imageAnchor.referenceImage.physicalSize.width, urlStr: "")
            }
            if (imageAnchor.referenceImage.name == "19") {
                print("19!")
                
                let videoNode = SKVideoNode(fileNamed: "video19.mp4")
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
                //displayWebView(on: planeNode, xOffset: imageAnchor.referenceImage.physicalSize.width, urlStr: "")
            }
            if (imageAnchor.referenceImage.name == "20") {
                print("20!")
                
                let videoNode = SKVideoNode(fileNamed: "video20.mp4")
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
                //displayWebView(on: planeNode, xOffset: imageAnchor.referenceImage.physicalSize.width, urlStr: "")
            }
            if (imageAnchor.referenceImage.name == "21") {
                print("21!")
                
                let videoNode = SKVideoNode(fileNamed: "video21.mp4")
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
                //displayWebView(on: planeNode, xOffset: imageAnchor.referenceImage.physicalSize.width, urlStr: "")
            }
            
            if (imageAnchor.referenceImage.name == "22") {
                print("22!")
                
                let videoNode = SKVideoNode(fileNamed: "video22.mp4")
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
                //displayWebView(on: planeNode, xOffset: imageAnchor.referenceImage.physicalSize.width, urlStr: "")
            }
            //==========second video node
            //add all materials to plane
            //plane.firstMaterial? = hpMaterial
            
            //plane.materials.append(hpMaterial)
        }
        return node
    }
    
    
    func displayWebViewRight(on rootNode: SCNNode, xOffset: CGFloat, urlStr: String) {
        // Xcode yells at us about the deprecation of UIWebView in iOS 12.0, but there is currently
        // a bug that does now allow us to use a WKWebView as a texture for our webViewNode
        // Note that UIWebViews should only be instantiated on the main thread!
        DispatchQueue.main.async {
            let request = URLRequest(url: URL(string: urlStr)!)

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
                .wait(duration: 1.0),
                .fadeOpacity(to: 1.0, duration: 0.5),
                .moveBy(x: xOffset * 1.1, y: 0, z: -0.5, duration: 1),
                .moveBy(x: 0, y: 0, z: 0.05, duration: 0.2)
                ])
            )
        }
    }
    
    
    func displayWebViewLeft(on rootNode: SCNNode, xOffset: CGFloat, urlStr: String) {
        // Xcode yells at us about the deprecation of UIWebView in iOS 12.0, but there is currently
        // a bug that does now allow us to use a WKWebView as a texture for our webViewNode
        // Note that UIWebViews should only be instantiated on the main thread!
        DispatchQueue.main.async {
            let request = URLRequest(url: URL(string: urlStr)!)
            
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
                .wait(duration: 1.0),
                .fadeOpacity(to: 1.0, duration: 0.5),
                .moveBy(x: xOffset * (-1.1), y: 0, z: -0.5, duration: 1),
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
    
    
    
    
    //==================================================
    
    func getWebsiteData() {
        Alamofire.request("https://httpbin.org/get").responseJSON { response in
//            print("Request: \(String(describing: response.request))")   // original url request
//            print("Response: \(String(describing: response.response))") // http url response
//            print("Result: \(response.result)")                         // response serialization result
//
//            if let json = response.result.value {
//                print("JSON: \(json)") // serialized json response
//            }
//
//            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
//                print("Data: \(utf8Text)") // original server data as UTF8 string
//            }
            if response.result.isSuccess {
                print("successfully get JSON data!")
                let jso: JSON = JSON(response.result.value!)
                //                print(jso)
                self.updateWebsiteData(json: jso)
                self.performSegue(withIdentifier: "toFoodDataViewController", sender:UIViewController.self)
                //                self.delegate?.userSelectedANutritionEntry()
                
            }else{
                print("fail to get JSON response!")
            }
        }
    }
    
    func updateWebsiteData(json: JSON) {
        
    }

    
}

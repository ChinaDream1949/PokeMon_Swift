//
//  ViewController.swift
//  PokeMon_Swift
//
//  Created by MR.Sahw on 2020/11/13.
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
        
        sceneView.autoenablesDefaultLighting = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        configuration.detectionImages = ARReferenceImage.referenceImages(inGroupNamed: "Poke Cards", bundle: nil)
        configuration.maximumNumberOfTrackedImages = 1
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }

    // MARK: - ARSCNViewDelegate
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        guard let imageAchor = anchor as? ARImageAnchor else {return}
        
        DispatchQueue.main.async {
            let palneNode = SCNNode(geometry: SCNPlane(width: imageAchor.referenceImage.physicalSize.width, height: imageAchor.referenceImage.physicalSize.height))
            palneNode.opacity = 0.25
            palneNode.eulerAngles.x = -.pi/2
            // 找到模型下的节点
            guard let eevenNode = SCNScene(named: "art.scnassets/eevee.scn")?.rootNode.childNode(withName: "eevee", recursively: true) else {return}
            
            node.addChildNode(palneNode)
            node.addChildNode(eevenNode)
        }
    }
}

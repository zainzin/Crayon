//
//  ViewController.swift
//  Crayon
//
//  Created by Zain Hatim on 9/30/15.
//  Copyright © 2015 Zain. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var red : CGFloat = 0.0
    var green : CGFloat = 0.0
    var blue : CGFloat = 0.0
    var zeroPoint = CGPoint.zero
    var brushThickness : CGFloat = 10.0
    var blend = CGBlendMode.Normal
    var drawing = false
    var colors : [(CGFloat, CGFloat, CGFloat)] = [(0,0,0),(0,0,0),(0,0,0)]
    
    @IBOutlet weak var brushWidth: UISlider!
    @IBAction func saveButn(sender: UIButton) {
        UIGraphicsBeginImageContext(imageCanvas.frame.size)
        imageCanvas.image?.drawInRect(CGRect(x: 0, y: 0, width: imageCanvas.frame.size.width, height: imageCanvas.frame.size.height))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        let saveImage = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        presentViewController(saveImage, animated: true, completion: nil)
    }
    @IBAction func eraseButn(sender: AnyObject) {
        imageCanvas.image = nil
    }
    // Color button
    @IBAction func colorButn(sender: AnyObject) {
        var index = sender.tag ?? 0
        if index < 0 || index >= colors.count{
            index = 0
        }
        switch sender.tag {
        // Black Color
        case 0:
            red = 0
            green = 0
            blue = 0
            colors[index] = (red,green,blue)
            break
        case 1:
            // Red Color
            red = 1
            green = 0
            blue = 0
            colors[index] = (red,green,blue)
            break
        case 2:
            // Green Color
            red = 0
            green = 1
            blue = 0
            colors[index] = (red,green,blue)
            break
        case 3:
            // Blue Color
            red = 0
            green = 0
            blue = 1
            colors[index] = (red,green,blue)
            break
        case 4:
            // White Color
            red = 1
            green = 1
            blue = 1
            colors[index] = (red,green,blue)
            break
        case 5:
            // Yellow Color
            red = 1
            green = 1
            blue = 0
            colors[index] = (red,green,blue)
            break
        default:
            red = 0
            green = 0
            blue = 0
            colors[index] = (red,green,blue)
            break
        }
    }
    
    @IBAction func style(sender: AnyObject) {
        switch sender.tag {
        case 10:
            blend = CGBlendMode.Normal
            break
        case 11:
            blend = CGBlendMode.PlusLighter
            break
        case 12:
            blend = CGBlendMode.Luminosity
            break
        default:
            blend = CGBlendMode.Normal
            break
        }
    }
    // function to draw on the imageView
    func line(from: CGPoint, to: CGPoint){
        UIGraphicsBeginImageContext(imageCanvas.frame.size)
        let context = UIGraphicsGetCurrentContext()
        // sets the imageView size to be drawalbe
        imageCanvas.image?.drawInRect(CGRect(x: 0, y: 0, width: imageCanvas.frame.size.width, height: imageCanvas.frame.size.height))
        // sets the colors value
        CGContextSetRGBStrokeColor(context, red, green, blue, 1.0)
        CGContextMoveToPoint(context, from.x, from.y)
        CGContextAddLineToPoint(context, to.x,to.y)
        // sets the brush thickness depending on the slider position
        CGContextSetLineWidth(context, brushThickness)
        brushThickness = CGFloat(brushWidth.value)
        CGContextSetLineCap(context, CGLineCap.Round)
        CGContextSetBlendMode(context, blend)
        CGContextStrokePath(context)
        imageCanvas.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }
    @IBOutlet weak var imageCanvas: UIImageView!
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        drawing = false
        if let touch = touches.first as UITouch!{
            zeroPoint = touch.locationInView(self.view)
        }
    }
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        drawing = true
        if let touch = touches.first as UITouch!{
            let currentPoint = touch.locationInView(imageCanvas)
            line(zeroPoint, to: currentPoint)
            zeroPoint = currentPoint
        }
    }
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if !drawing {
            line(zeroPoint, to: zeroPoint)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


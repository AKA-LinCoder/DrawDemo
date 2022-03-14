//
//  Canvas.swift
//  DrawDemo
//
//  Created by lsaac on 2022/3/14.
//

import Foundation
import UIKit

class Canvas: UIView{
    
    func undo(){
        _ = lines.popLast()
        setNeedsDisplay()
    }
    
    func clear(){
        lines.removeAll()
        setNeedsDisplay()
    }
    
    var stokeColor = UIColor.black
    
    func setStrokeColor(color:UIColor){
        self.stokeColor = color
    }
    
    var width : CGFloat = 1
    
    func setWidth(width:CGFloat){
        self.width = width
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        guard let context = UIGraphicsGetCurrentContext() else{
            return
        }
        
//        let stratPoint = CGPoint(x: 0, y: 0)
//        let endPoint = CGPoint(x: 100, y: 100)
//        context.move(to: stratPoint)
//        context.addLine(to: endPoint)
       
//        context.setLineCap(.butt)
        
        lines.forEach { line in
            context.setStrokeColor(line.color.cgColor)
            context.setLineWidth(CGFloat(line.strokeWidth))
            context.setLineCap(.round)
            for(i,p) in line.points.enumerated(){
                if i == 0 {
                    context.move(to: p)
                }else{
                    context.addLine(to: p)
                }
                
            }
            context.strokePath()        }
        
        
      
        
        
        
        
        
        
        
    }
    
//    var line = [CGPoint]()
    var lines = [Line]()
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        lines.append(Line(strokeWidth: Float(width), color: stokeColor, points: []))
    }
    
    
    //MARK:-跟踪手指移动
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let point =  touches.first?.location(in: nil) else{
            return
        }
        print("point\(point)")
        
        
        guard var lastLine = lines.popLast() else{
            return
        }
        
//        line.append(point)
//        var lastLine = lines.last
        lastLine.points.append(point)
        lines.append(lastLine)
        ///重绘
        setNeedsDisplay()
    }
    
}

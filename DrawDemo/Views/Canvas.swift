//
//  Canvas.swift
//  DrawDemo
//
//  Created by lsaac on 2022/3/14.
//

import Foundation
import UIKit

extension UIBezierPath {
    func addArrow(start: CGPoint, end: CGPoint, pointerLineLength: CGFloat, arrowAngle: CGFloat) {
        self.move(to: start)
        self.addLine(to: end)
        
        let startEndAngle = atan((end.y - start.y) / (end.x - start.x)) + ((end.x - start.x) < 0 ? CGFloat(Double.pi) : 0)
        let arrowLine1 = CGPoint(x: end.x + pointerLineLength * cos(CGFloat(Double.pi) - startEndAngle + arrowAngle), y: end.y - pointerLineLength * sin(CGFloat(Double.pi) - startEndAngle + arrowAngle))
        let arrowLine2 = CGPoint(x: end.x + pointerLineLength * cos(CGFloat(Double.pi) - startEndAngle - arrowAngle), y: end.y - pointerLineLength * sin(CGFloat(Double.pi) - startEndAngle - arrowAngle))
        
        self.addLine(to: arrowLine1)
        self.move(to: end)
        self.addLine(to: arrowLine2)
    }
}




class Canvas: UIView{
    
    
    var isArrow:Bool = false
    
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
            var start: CGPoint!
            var end : CGPoint!
            for(i,p) in line.points.enumerated(){
                if line.isArrow{
        
                    print("index:\(i) ----point\(p)")
//                    var start = CGPoint(x: 0, y: 0)
//                    var end = CGPoint(x: 0, y: 0)
                    if(i == 0 ){
                        start = p
                        context.move(to: p)
                    }else if(i==line.points.count-1){
                        print("here")
                        end = p
                        context.addLine(to: p)
                        context.move(to: p)
                        let arrow = getArrowPoint(fPoint: start, tPoint: end)
                        context.addLine(to: arrow.0)
                        context.move(to: arrow.0)
                        context.addLine(to: arrow.1)
                        context.move(to: arrow.1)
                        context.addLine(to: arrow.2)
                        context.move(to: arrow.2)
                        context.addLine(to: arrow.0)
                    }
                    
                  
//                    context.addLine(to: arrow.1)
                    
//                    context.move(to: start)
//                    context.addLine(to: end)
//                    /// 获取到箭头的起始点和终止点
//                    var pointerLineLength = width
//                    var arrowAngle = CGFloat(Double.pi / 5)
//                    let startEndAngle = atan((end.y - start.y) / (end.x - start.x)) + ((end.x - start.x) < 0 ? CGFloat(Double.pi) : 0)
//                            let arrowLine1 = CGPoint(x: end.x + pointerLineLength * cos(CGFloat(Double.pi) - startEndAngle + arrowAngle), y: end.y - pointerLineLength * sin(CGFloat(Double.pi) - startEndAngle + arrowAngle))
//                            let arrowLine2 = CGPoint(x: end.x + pointerLineLength * cos(CGFloat(Double.pi) - startEndAngle - arrowAngle), y: end.y - pointerLineLength * sin(CGFloat(Double.pi) - startEndAngle - arrowAngle))
//
//                    context.addLine(to: arrowLine1)
//                    context.move(to: end)
//                    context.addLine(to: arrowLine2)
                    
                    
                }else{
                    if i == 0 {
                        context.move(to: p)
                    }else{
                        context.addLine(to: p)
                    }
                }
                
                
//                if (!isArrow){
//                    print("isNoArrow\(isArrow)")
//                    if i == 0 {
//                        context.move(to: p)
//                    }else{
//                        context.addLine(to: p)
//                    }
//                }else{
//                    print("isArrow\(isArrow)")
////                    var start = CGPoint(x: 100, y: 100)
////                    var end = CGPoint(x: 400, y: 300)
//                    print("p:\(p)")
//                    print(lines.count)
//                    if(i == 0 ){
////                        start = p
////                        context.move(to: start)
//                        context.move(to: p)
////                        print(start)
//                    }else if(i==lines.count-1){
//                        ///最后一个
////                        end = p
////                        print(end)
//                        context.addLine(to: p)
////                        context.addLine(to: end)
//                    }
//
//
//
//
//
//
//
//
//
//                }
                
            }
            /// 绘制路径
            context.strokePath()        }
        
        
        
        
        
        
        
        
        
        
    }
    
    //    var line = [CGPoint]()
    var lines = [Line]()
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        lines.append(Line(strokeWidth: Float(width), color: stokeColor, points: [],isArrow: isArrow))
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
    
    
    
    func getArrowPoint(fPoint:CGPoint,tPoint:CGPoint) -> (CGPoint,CGPoint,CGPoint) {
        var p1 = CGPoint.zero           //箭头点1
        var p2 = CGPoint.zero           //箭头点2
        var p3 = CGPoint.zero           //箭头最前面点
        //假设箭头边长20,箭头是一个等腰三角形
        let line = sqrt(pow(abs(tPoint.x-fPoint.x), 2)+pow(abs(tPoint.y-fPoint.y), 2))
        let arrowH:CGFloat = line>40 ? 20 : line/3
        //线与水平方向的夹角
        let angle = getAnglesWithThreePoints(p1: fPoint, p2: tPoint, p3: CGPoint(x: fPoint.x, y: tPoint.y))
        let _x = CGFloat(fabs(sin(angle)))*arrowH/2
        let _y = CGFloat(fabs(cos(angle)))*arrowH/2
        //向右上角、水平向右
        if tPoint.x >= fPoint.x && tPoint.y <= fPoint.y{
            p1.x = tPoint.x-_x
            p1.y = tPoint.y-_y
            
            p2.x = tPoint.x+_x
            p2.y = tPoint.y+_y
            
            p3.x = tPoint.x+_y*2
            p3.y = tPoint.y-_x*2
            
        }else if tPoint.x > fPoint.x && tPoint.y > fPoint.y{
            //向右下角
            p1.x = tPoint.x+_x
            p1.y = tPoint.y-_y
            
            p2.x = tPoint.x-_x
            p2.y = tPoint.y+_y
            
            p3.x = tPoint.x+_y*2
            p3.y = tPoint.y+_x*2
        }else if tPoint.x < fPoint.x && tPoint.y < fPoint.y{
            //向左上角
            p1.x = tPoint.x-_x
            p1.y = tPoint.y+_y
            
            p2.x = tPoint.x+_x
            p2.y = tPoint.y-_y
            
            p3.x = tPoint.x-_y*2
            p3.y = tPoint.y-_x*2
            
        }else if tPoint.x < fPoint.x && tPoint.y >= fPoint.y{
            //向左下角,水平向左
            p1.x = tPoint.x-_x
            p1.y = tPoint.y-_y
            
            p2.x = tPoint.x+_x
            p2.y = tPoint.y+_y
            
            p3.x = tPoint.x-_y*2
            p3.y = tPoint.y+_x*2
        }else if fPoint.x==tPoint.x {
            //竖直方向
            p1.x=tPoint.x-arrowH/2
            p1.y=tPoint.y
            p2.x=tPoint.x+arrowH/2
            p2.y=tPoint.y
            p3.x=tPoint.x
            p3.y = tPoint.y>fPoint.y ? tPoint.y+arrowH : tPoint.y-arrowH
        }
        
        return (p1,p2,p3)
    }
    
    /// 计算三点之间的角度
    ///
    /// - Parameters:
    ///   - p1: 点1
    ///   - p2: 点2（也是角度所在点）
    ///   - p3: 点3
    /// - Returns: 角度（180度制）
    func getAnglesWithThreePoints(p1:CGPoint,p2:CGPoint,p3:CGPoint) -> Double {
        //排除特殊情况，三个点一条线
        if (p1.x == p2.x && p2.x == p3.x) || ( p1.y == p2.x && p2.x == p3.x){
            return 0
        }
        
        let a = fabs(p1.x - p2.x)
        let b = fabs(p1.y - p2.y)
        let c = fabs(p3.x - p2.x)
        let d = fabs(p3.y - p2.y)
        
        if (a < 1.0 && b < 1.0) || (c < 1.0 && d < 1.0){
            return 0
        }
        let e = a*c+b*d
        let f = sqrt(a*a+b*b)
        let g = sqrt(c*c+d*d)
        let r = Double(acos(e/(f*g)))
        return r        //弧度值
        
        //        return (180*r/Double.pi)      //角度值
        
    }
    
    
}

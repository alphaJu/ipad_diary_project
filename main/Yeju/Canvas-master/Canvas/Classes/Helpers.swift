//
//  Helpers.swift
//  Canvas
//
//  Created by Adeola Uthman on 1/10/18.
//

import Foundation

/** Canvas tools. */
public enum CanvasTool: Int {
    case pen = 0
    case eraser = 1
    case line = 2
    case rectangle = 3
    case ellipse = 4
    case eyedropper = 5
    case selection = 6
}


/** Returns the midpoint between two points. */
func midpoint(a: CGPoint, b: CGPoint) -> CGPoint {
    return CGPoint(x: (a.x + b.x) / 2, y: (a.y + b.y) / 2)
}

extension Comparable {
    func clamp<T: Comparable>(lower: T, _ upper: T) -> T {
        return min(max(self as! T, lower), upper)
    }
}

extension CGPoint {
    func distance(to: CGPoint) -> CGFloat {
        let xComp = (to.x - x) ** 2
        let yComp = (to.y - y) ** 2
        return sqrt(xComp + yComp)
    }
}

/** lhs to the power of rhs. */
infix operator **
func **(lhs: CGFloat, rhs: CGFloat) -> CGFloat {
    return pow(lhs, rhs)
}
func **(lhs: Int, rhs: Int) -> Int {
    return Int(pow(CGFloat(lhs), CGFloat(rhs)))
}

/** Returns an array of points that lie on this line. */
func pointsOnLine(startPoint : CGPoint, endPoint : CGPoint) -> [CGPoint] {
    var allPoints: [CGPoint] = [CGPoint]()
    
    let deltaX = fabs(endPoint.x - startPoint.x)
    let deltaY = fabs(endPoint.y - startPoint.y)
    
    var x = startPoint.x
    var y = startPoint.y
    var err = deltaX - deltaY
    
    var sx = -0.5
    var sy = -0.5
    if(startPoint.x < endPoint.x){ sx = 0.5 }
    if(startPoint.y < endPoint.y){ sy = 0.5; }
    
    repeat {
        let pointObj = CGPoint(x: x, y: y)
        allPoints.append(pointObj)
        
        let e = 2*err
        if(e > -deltaY) {
            err -= deltaY
            x += CGFloat(sx)
        }
        if(e < deltaX) {
            err += deltaX
            y += CGFloat(sy)
        }
    } while (round(x) != round(endPoint.x) && round(y) != round(endPoint.y));
    
    allPoints.append(endPoint)
    return allPoints
}

/** Builds a CGMutablePath from an array of points and instructions. */
func buildPath(from bTypes: [CGPathElementType], bPoints: [[CGPoint]], type: CanvasTool) -> CGMutablePath {
    let mutablePath = CGMutablePath()
    mutablePath.move(to: bPoints[0][0])
    
    for i in 0..<bTypes.count {
        switch bTypes[i] {
        case .moveToPoint:
            if type != .pen {
                mutablePath.move(to: CGPoint(x: bPoints[i][0].x, y: bPoints[i][0].y))
            }
            break
        case .addLineToPoint:
            mutablePath.addLine(to: CGPoint(x: bPoints[i][0].x, y: bPoints[i][0].y))
            break
        case .addQuadCurveToPoint:
            mutablePath.addQuadCurve(to: CGPoint(x: bPoints[i][0].x, y: bPoints[i][0].y), control: CGPoint(x: bPoints[i][1].x, y: bPoints[i][1].y))
            break
        case .addCurveToPoint:
            mutablePath.addCurve(to: CGPoint(x: bPoints[i][0].x, y: bPoints[i][0].y), control1: CGPoint(x: bPoints[i][1].x, y: bPoints[i][1].y), control2: CGPoint(x: bPoints[i][2].x, y: bPoints[i][2].y))
            break
        default:
            mutablePath.closeSubpath()
            break
        }
    }
    return mutablePath
}




import UIKit

var algorithm = "(U' R U') (R' U R) U R'"

algorithm = algorithm.replacingOccurrences(of: "(", with: "").replacingOccurrences(of: ")", with: "")
    
let moves = algorithm.split(separator: " ")

var mirroredAlgorithm = ""

// Loop through each move
for move in moves {
    switch move {
    case "R":
        mirroredAlgorithm.append("L' ")
        break
    case "R'":
        mirroredAlgorithm.append("L ")
        break
    case "U":
        mirroredAlgorithm.append("U' ")
        break
    case "U'":
        mirroredAlgorithm.append("U ")
        break
    case "L":
        mirroredAlgorithm.append("R' ")
        break
    case "L'":
        mirroredAlgorithm.append("R ")
        break
    case "d":
        mirroredAlgorithm.append("d' ")
        break
    case "d'":
        mirroredAlgorithm.append("d ")
        break
    case "2R":
        mirroredAlgorithm.append("2L' ")
        break
    case "2L":
        mirroredAlgorithm.append("2R' ")
        break
    case "f":
        mirroredAlgorithm.append("f' ")
        break
    case "f'":
        mirroredAlgorithm.append("f ")
        break
    case "y":
        mirroredAlgorithm.append("y' ")
        break
        case "y'":
        mirroredAlgorithm.append("y ")
        break
    default:
        mirroredAlgorithm.append("? ")
        print("case not found: \(move)")
    }
}

print(algorithm.replacingOccurrences(of: " ", with: "\t"))
print(mirroredAlgorithm.replacingOccurrences(of: " ", with: "\t"))

print("\n\(mirroredAlgorithm)")

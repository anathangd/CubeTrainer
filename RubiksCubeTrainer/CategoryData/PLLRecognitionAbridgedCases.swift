//
//  PLLRecognitionAbridgedCases.swift
//  RubiksCubeTrainer
//
//  Created by Nathan Davis on 10/19/25.
//

import Foundation

struct PLLRecognitionAbridgedCases {
    static let cases: [Algorithm] = [
        Algorithm(name: "oneblockoutside1", algorithm: "(No rotation) It’s V when there’s a block on the outside", note: ""),
        Algorithm(name: "oneblockoutside5", algorithm: "(U, mirrored alg) It’s V when there’s a block on the outside", note: ""),
        Algorithm(name: "oneblockinside1", algorithm: "(No rotation, mirrored) It’s Y when there’s a block on the inside and the corners are different", note: ""),
        Algorithm(name: "oneblockinside5", algorithm: "(U) It’s Y when there’s a block on the inside and the corners are different", note: ""),
        Algorithm(name: "noblockscheckerinside1", algorithm: "(U') It’s V when there’s a checker pattern on the inside and the corners are different", note: ""),
        Algorithm(name: "noblockscheckeroutside1", algorithm: "(U') It’s Y when there’s a checker pattern on the outside", note: ""),
        Algorithm(name: "noblocksnochecker1", algorithm: "(No rotation) It’s E when there are no blocks and no checker in checker", note: ""),
        Algorithm(name: "noblocksnochecker5", algorithm: "(U) It’s E when there are no blocks and no checker in checker", note: ""),
        Algorithm(name: "outerblockrightnotcheckered1", algorithm: "(U) It’s Ga when the block is on the right and it's not checkered", note: ""),
        Algorithm(name: "outerblockleftnotcheckered1", algorithm: "(No rotation) It’s Gc when the block is on the left and it's not checkered", note: ""),
        Algorithm(name: "inneradjleft1", algorithm: "(No rotation) It’s Ga when the inner block is on the left and the corner beside the block is adjacent", note: ""),
        Algorithm(name: "inneradjright1", algorithm: "(U) It’s Gc when the inner block is on the right and the corner beside the block is adjacent", note: ""),
        Algorithm(name: "inneroppleft1", algorithm: "(U') It’s Gb when the inner block is on the left and the corner beside the block is opposite", note: ""),
        Algorithm(name: "inneroppright1", algorithm: "(U2) It’s Gd when the inner block is on the right and the corner beside the block is opposite", note: ""),
        Algorithm(name: "outerrightopp1", algorithm: "(No rotation) It’s Gb when the outer block is on the right and it checkers in the middle", note: ""),
        Algorithm(name: "outerleftopp1", algorithm: "(U) It’s Gd when the outer block is on the left and it checkers in the middle", note: ""),
        Algorithm(name: "outerleftoppnochecker1", algorithm: "(No rotation) It’s Aa when the outer block is on the left and it doesn't checker in the middle", note: ""),
        Algorithm(name: "outerrightoppnochecker1", algorithm: "(U) It’s Aa mirrored when the outer block is on the right and it doesn't checker in the middle", note: ""),
        Algorithm(name: "outerleftadjchecker1", algorithm: "(U') It’s Ra when the block is on the left and it checkers in the middle (more adj colors)", note: ""),
        Algorithm(name: "outerrightadjchecker1", algorithm: "(U2) It’s Rb when the block is on the right and it checkers in the middle (more adj colors)", note: ""),
        Algorithm(name: "outerleftadjnochecker1", algorithm: "(No rotation) It’s T when the block is on the left and it doesn't checker in the middle (and it's an adjacent corner)", note: ""),
        Algorithm(name: "outerrightadjnochecker1", algorithm: "(U) It’s T mirrored when the block is on the right and it doesn't checker in the middle (and it's an adjacent corner)", note: ""),
        Algorithm(name: "oppinhead3right1", algorithm: "(U2) It’s Gb when there are 3 colors and the headlights are on the right containing the opposite color", note: ""),
        Algorithm(name: "oppinhead3left1", algorithm: "(U') It’s Gd when there are 3 colors and the headlights are on the left containing the opposite color", note: ""),
        Algorithm(name: "oppinheadleft1", algorithm: "(U) It’s Gb when there's an opposite color in the headlights on the left (and no other pattern)", note: ""),
        Algorithm(name: "oppinheadright1", algorithm: "(No rotation) It’s Gd when there's an opposite color in the headlights on the right (and no other pattern)", note: ""),
        Algorithm(name: "adjinheadleft1", algorithm: "(No rotation) It’s Rb when there's an adjacent color in the headlights on the left with an extended checker pattern", note: ""),
        Algorithm(name: "adjinheadright1", algorithm: "(U) It’s Ra when there's an adjacent color in the headlights on the right with an extended checker pattern", note: ""),
        Algorithm(name: "adjinheadrightchecker1", algorithm: "(U2) It’s Ga when there's an adjacent color in the headlights on the right and there is a checker pattern", note: ""),
        Algorithm(name: "adjinheadleftchecker1", algorithm: "(U') It’s Gc when when there's an adjacent color in the headlights on the left and there is a checker pattern", note: ""),
        Algorithm(name: "adjinheadrightnochecker1", algorithm: "(U') It’s Aa when when there's an adjacent color in the headlights on the right and there is no checker pattern", note: ""),
        Algorithm(name: "adjinheadleftnochecker1", algorithm: "(U') It’s Ab when when there's an adjacent color in the headlights on the left and there is no checker pattern", note: ""),
        Algorithm(name: "3colorcheckermiddle1", algorithm: "(U') It's F when it checkers in the middle and the corners are the same color (look for the opposite edge)", note: ""),
        Algorithm(name: "3colorcheckermiddle5", algorithm: "(No rotation) It's F when it checkers in the middle and the corners are the same color (look for the opposite edge)", note: ""),
        Algorithm(name: "oppoutercornerright1", algorithm: "(U') It’s Ga when it's checker within checker and there are more opposite colors in the middle", note: ""),
        Algorithm(name: "oppoutercornerleft1", algorithm: "(U2) It’s Gc when it's checker within checker and there are more opposite colors in the middle", note: ""),
        Algorithm(name: "oppinnercornerright1", algorithm: "(U2) It’s Ra when it's checker within checker and there are more adj colors in the middle", note: ""),
        Algorithm(name: "oppinnercornerleft1", algorithm: "(U') It’s Rb when it's checker within checker and there are more adj colors in the middle", note: ""),
        Algorithm(name: "1outerleft1inner1", algorithm: "(U) It’s Ja when the 2x1 block on the outside is on the left (more adj colors)", note: ""),
        Algorithm(name: "1outerright1inner1", algorithm: "(No rotation) It’s Jb when the 2x1 block on the outside is on the right (more adj colors)", note: ""),
        Algorithm(name: "outerblockrightcheckered1", algorithm: "(U) It’s Ab mirrored when the block is on the right and it's checkered", note: ""),
        Algorithm(name: "outerblockleftcheckered1", algorithm: "(No rotation) It’s Ab when the block is on the left and it's checkered", note: ""),
        Algorithm(name: "1outerright1inneropp1", algorithm: "(U') It’s Jb when there are two 2x1 blocks, outer on the right (more opp colors)", note: ""),
        Algorithm(name: "1outerleft1inneropp1", algorithm: "(U2) It’s Ja when there are two 2x1 blocks, outer on the left (more opp colors)", note: "")
    ]
}

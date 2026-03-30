//
//  PLLRecognitionAbridgedCases.swift
//  RubiksCubeTrainer
//
//  Created by Nathan Davis on 10/19/25.
//

import Foundation

struct PLLRecognitionAbridgedCases {
    static let cases: [Algorithm] = [
        Algorithm(name: "oneblockoutside1", algorithm: "(No rotation) V: different block on outside, mostly opp", note: ""),
        Algorithm(name: "oneblockoutside5", algorithm: "(U) V mirrored: different block on outside, mostly opp", note: ""),
        Algorithm(name: "oneblockinside1", algorithm: "(No rotation) Y mirrored: block on the inside different corners", note: ""),
        Algorithm(name: "oneblockinside5", algorithm: "(U) Y: block on the inside different corners", note: ""),
        Algorithm(name: "noblockscheckerinside1", algorithm: "(U') V: checker inside, different corners", note: ""),
        Algorithm(name: "noblockscheckeroutside1", algorithm: "(U') Y: checker outside", note: ""),
        Algorithm(name: "noblocksnochecker1", algorithm: "(No rotation) E: no blocks, no checker in checker", note: ""),
        Algorithm(name: "noblocksnochecker5", algorithm: "(U) E: no blocks, no checker in checker", note: ""),
        Algorithm(name: "outerblockrightnotcheckered1", algorithm: "(U) Ga: block outside, adj corner, adj in headlights", note: ""),
        Algorithm(name: "outerblockleftnotcheckered1", algorithm: "(No rotation) Gc: block outside, adj corner, adj in headlights", note: ""),
        Algorithm(name: "inneradjleft1", algorithm: "(No rotation) Ga: inner block, checkers with adj corner", note: ""),
        Algorithm(name: "inneradjright1", algorithm: "(U) Gc: inner block, checkers with adj corner", note: ""),
        Algorithm(name: "inneroppleft1", algorithm: "(U') Gb: inner block, checkers with opp corner", note: ""),
        Algorithm(name: "inneroppright1", algorithm: "(U2) Gd: inner block, checkers with opp corner", note: ""),
        Algorithm(name: "outerrightopp1", algorithm: "(No rotation) Gb: outer block on right, checkers with opp corner", note: ""),
        Algorithm(name: "outerleftopp1", algorithm: "(U) Gd: outer block on left, checkers with opp corner", note: ""),
        Algorithm(name: "outerleftoppnochecker1", algorithm: "(No rotation) Aa: outer block on left, no checker, opp corner", note: ""),
        Algorithm(name: "outerrightoppnochecker1", algorithm: "(U) Aa mirrored: outer block on right, no checker, opp corner", note: ""),
        Algorithm(name: "outerleftadjchecker1", algorithm: "(U') Ra: outer block on left, checkers with adj corner (checker to opp side)", note: ""),
        Algorithm(name: "outerrightadjchecker1", algorithm: "(U2) Rb: outer block on right, checkers with adj corner (checker to opp side)", note: ""),
        Algorithm(name: "outerleftadjnochecker1", algorithm: "(No rotation) T: outer block on left, no checker, adj corner", note: ""),
        Algorithm(name: "outerrightadjnochecker1", algorithm: "(U') T: outer block on right, no checker, adj corner", note: ""),
        Algorithm(name: "oppinhead3right1", algorithm: "(U2) Gb: full checker minus middle left which will point away", note: ""),
        Algorithm(name: "oppinhead3left1", algorithm: "(U') Gd: full checker minus middle right which will point away", note: ""),
        Algorithm(name: "oppinheadleft1", algorithm: "(U) Gb: opp in headlights, no other pattern", note: ""),
        Algorithm(name: "oppinheadright1", algorithm: "(No rotation) Gd: opp in headlights, no other pattern", note: ""),
        Algorithm(name: "adjinheadleft1", algorithm: "(No rotation) Rb: full checker minus outer right", note: ""),
        Algorithm(name: "adjinheadright1", algorithm: "(U) Ra: full checker minus outer left", note: ""),
        Algorithm(name: "adjinheadrightchecker1", algorithm: "(U2) Ga: adj in headlights which checkers, no other pattern", note: ""),
        Algorithm(name: "adjinheadleftchecker1", algorithm: "(U') Gc: adj in headlights which checkers, no other pattern", note: ""),
        Algorithm(name: "adjinheadrightnochecker1", algorithm: "(U') Aa: adj in headlights, 3 different other colors", note: ""),
        Algorithm(name: "adjinheadleftnochecker1", algorithm: "(U') Ab: adj in headlights, 3 different other colors", note: ""),
        Algorithm(name: "3colorcheckermiddle1", algorithm: "(U') F: checkers in middle, outer corners same (look for outer opp pair)", note: ""),
        Algorithm(name: "3colorcheckermiddle5", algorithm: "(No rotation) F: checkers in middle, outer corners same (look for outer opp pair)", note: ""),
        Algorithm(name: "oppoutercornerright1", algorithm: "(U') Ga: checker in checker, more opp (inner checker to opp side)", note: ""),
        Algorithm(name: "oppoutercornerleft1", algorithm: "(U2) Gc: checker in checker, more opp (inner checker to opp side)", note: ""),
        Algorithm(name: "oppinnercornerright1", algorithm: "(U2) Ra: checker in checker, more adj (inner checker to opp side)", note: ""),
        Algorithm(name: "oppinnercornerleft1", algorithm: "(U') Rb: checker in checker, more adj (inner checker to opp side)", note: ""),
        Algorithm(name: "1outerleft1inner1", algorithm: "(U) Ja: two blocks, outer on left, more adj", note: ""),
        Algorithm(name: "1outerright1inner1", algorithm: "(No rotation) Jb: two blocks, outer on right, more adj", note: ""),
        Algorithm(name: "outerblockrightcheckered1", algorithm: "(U) Ab mirrored: outer block on right, checkers", note: ""),
        Algorithm(name: "outerblockleftcheckered1", algorithm: "(No rotation) Ab: outer block left, checkers", note: ""),
        Algorithm(name: "1outerright1inneropp1", algorithm: "(U') Jb: two blocks, outer on right, more opp (adj will face away)", note: ""),
        Algorithm(name: "1outerleft1inneropp1", algorithm: "(U2) Ja: two blocks, outer on left, more opp (adj will face away)", note: ""),
        Algorithm(name: "one3x1leftopp1", algorithm: "(U) It’s Ub when an opposite edge color is on the right", note: ""),
        Algorithm(name: "one3x1leftadj1", algorithm: "(U) It’s Ua when an adjacent edge color is on the right", note: ""),
        Algorithm(name: "one3x1rightopp1", algorithm: "(U') It’s Ua when an opposite edge color is on the left", note: ""),
        Algorithm(name: "one3x1rightadj1", algorithm: "(U') It’s Ub when an adjacent edge color is on the left", note: ""),
        Algorithm(name: "no3x1atleast1oppright1", algorithm: "(No rotation) It’s Ua when an opposite edge color is on the right", note: ""),
        Algorithm(name: "no3x1atleast1oppleft1", algorithm: "(U) It’s Ub when an opposite edge color is on the left", note: ""),
        Algorithm(name: "no3x1nooppcheckerleft1", algorithm: "(U) It’s Ua when a checker pattern is only on the left", note: ""),
        Algorithm(name: "no3x1nooppcheckerright1", algorithm: "(No rotation) It’s Ub when a checker pattern is only on the right", note: ""),
    ]
}

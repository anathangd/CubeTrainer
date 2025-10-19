//
//  PLLRecognitionCases.swift
//  RubiksCubeTrainer
//
//  Created by Nathan Davis on 10/19/25.
//

import Foundation

struct PLLRecognitionCases {
    static let cases: [Algorithm] = [
        // EPLL
        // Category 1: One 3x1 Block
        // When the block is on the left:
        Algorithm(name: "one3x1leftopp1", algorithm: "(U) It’s Ub when an opposite edge color is on the right", note: ""),
        Algorithm(name: "one3x1leftopp2", algorithm: "(U) It’s Ub when an opposite edge color is on the right", note: ""),
        Algorithm(name: "one3x1leftopp3", algorithm: "(U) It’s Ub when an opposite edge color is on the right", note: ""),
        Algorithm(name: "one3x1leftopp4", algorithm: "(U) It’s Ub when an opposite edge color is on the right", note: ""),
        
        Algorithm(name: "one3x1leftadj1", algorithm: "(U) It’s Ua when an adjacent edge color is on the right", note: ""),
        Algorithm(name: "one3x1leftadj2", algorithm: "(U) It’s Ua when an adjacent edge color is on the right", note: ""),
        Algorithm(name: "one3x1leftadj3", algorithm: "(U) It’s Ua when an adjacent edge color is on the right", note: ""),
        Algorithm(name: "one3x1leftadj4", algorithm: "(U) It’s Ua when an adjacent edge color is on the right", note: ""),
        // When the block is on the right:
        Algorithm(name: "one3x1rightopp1", algorithm: "(U') It’s Ua when an opposite edge color is on the left", note: ""),
        Algorithm(name: "one3x1rightopp2", algorithm: "(U') It’s Ua when an opposite edge color is on the left", note: ""),
        Algorithm(name: "one3x1rightopp3", algorithm: "(U') It’s Ua when an opposite edge color is on the left", note: ""),
        Algorithm(name: "one3x1rightopp4", algorithm: "(U') It’s Ua when an opposite edge color is on the left", note: ""),
        
        Algorithm(name: "one3x1rightadj1", algorithm: "(U') It’s Ub when an adjacent edge color is on the left", note: ""),
        Algorithm(name: "one3x1rightadj2", algorithm: "(U') It’s Ub when an adjacent edge color is on the left", note: ""),
        Algorithm(name: "one3x1rightadj3", algorithm: "(U') It’s Ub when an adjacent edge color is on the left", note: ""),
        Algorithm(name: "one3x1rightadj4", algorithm: "(U') It’s Ub when an adjacent edge color is on the left", note: ""),
        
        // Category 2: No 3x1 Blocks & At Least One Opposite Edge
        Algorithm(name: "no3x1atleast1oppright1", algorithm: "(No rotation) It’s Ua when an opposite edge color is on the right", note: ""),
        Algorithm(name: "no3x1atleast1oppright2", algorithm: "(No rotation) It’s Ua when an opposite edge color is on the right", note: ""),
        Algorithm(name: "no3x1atleast1oppright3", algorithm: "(No rotation) It’s Ua when an opposite edge color is on the right", note: ""),
        Algorithm(name: "no3x1atleast1oppright4", algorithm: "(No rotation) It’s Ua when an opposite edge color is on the right", note: ""),
        
        Algorithm(name: "no3x1atleast1oppleft1", algorithm: "(U) It’s Ub when an opposite edge color is on the left", note: ""),
        Algorithm(name: "no3x1atleast1oppleft2", algorithm: "(U) It’s Ub when an opposite edge color is on the left", note: ""),
        Algorithm(name: "no3x1atleast1oppleft3", algorithm: "(U) It’s Ub when an opposite edge color is on the left", note: ""),
        Algorithm(name: "no3x1atleast1oppleft4", algorithm: "(U) It’s Ub when an opposite edge color is on the left", note: ""),
        
        Algorithm(name: "no3x1bothopp1", algorithm: "(No rotation) It’s H when an opposite edge color is on each side", note: ""),
        Algorithm(name: "no3x1bothopp2", algorithm: "(No rotation) It’s H when an opposite edge color is on each side", note: ""),
        Algorithm(name: "no3x1bothopp3", algorithm: "(No rotation) It’s H when an opposite edge color is on each side", note: ""),
        Algorithm(name: "no3x1bothopp4", algorithm: "(No rotation) It’s H when an opposite edge color is on each side", note: ""),
        
        // Category 3: No 3x1 Blocks & No Opposite Edges
        // When there are no opposite edges:
        Algorithm(name: "no3x1nooppcheckerleft1", algorithm: "(U) It’s Ua when a checker pattern is only on the left", note: ""),
        Algorithm(name: "no3x1nooppcheckerleft2", algorithm: "(U) It’s Ua when a checker pattern is only on the left", note: ""),
        Algorithm(name: "no3x1nooppcheckerleft3", algorithm: "(U) It’s Ua when a checker pattern is only on the left", note: ""),
        Algorithm(name: "no3x1nooppcheckerleft4", algorithm: "(U) It’s Ua when a checker pattern is only on the left", note: ""),
        
        Algorithm(name: "no3x1nooppcheckerright1", algorithm: "(No rotation) It’s Ub when a checker pattern is only on the right", note: ""),
        Algorithm(name: "no3x1nooppcheckerright2", algorithm: "(No rotation) It’s Ub when a checker pattern is only on the right", note: ""),
        Algorithm(name: "no3x1nooppcheckerright3", algorithm: "(No rotation) It’s Ub when a checker pattern is only on the right", note: ""),
        Algorithm(name: "no3x1nooppcheckerright4", algorithm: "(No rotation) It’s Ub when a checker pattern is only on the right", note: ""),
        // Otherwise:
        Algorithm(name: "no3x1nooppfullchecker1", algorithm: "(No rotation) No 3x1, no opposite edges, full checker pattern? It's Z.", note: ""),
        Algorithm(name: "no3x1nooppfullchecker2", algorithm: "(No rotation) No 3x1, no opposite edges, full checker pattern? It's Z.", note: ""),
        Algorithm(name: "no3x1nooppfullchecker3", algorithm: "(No rotation) No 3x1, no opposite edges, full checker pattern? It's Z.", note: ""),
        Algorithm(name: "no3x1nooppfullchecker4", algorithm: "(No rotation) No 3x1, no opposite edges, full checker pattern? It's Z.", note: ""),
        
        Algorithm(name: "no3x1nooppnochecker1", algorithm: "(No rotation) No 3x1, no opposite edges, no checker pattern? It's Z mirrored.", note: ""),
        Algorithm(name: "no3x1nooppnochecker2", algorithm: "(No rotation) No 3x1, no opposite edges, no checker pattern? It's Z mirrored.", note: ""),
        Algorithm(name: "no3x1nooppnochecker3", algorithm: "(No rotation) No 3x1, no opposite edges, no checker pattern? It's Z mirrored.", note: ""),
        Algorithm(name: "no3x1nooppnochecker4", algorithm: "(No rotation) No 3x1, no opposite edges, no checker pattern? It's Z mirrored.", note: ""),
        
        // Diagonal Corner Permutation
        // Category 1: Two Blocks
        Algorithm(name: "twoblocksinside1", algorithm: "(U) It’s V when the blocks are both on the inside and the colors on the outside are different", note: ""),
        Algorithm(name: "twoblocksinside2", algorithm: "(U) It’s V when the blocks are both on the inside and the colors on the outside are different", note: ""),
        Algorithm(name: "twoblocksinside3", algorithm: "(U) It’s V when the blocks are both on the inside and the colors on the outside are different", note: ""),
        Algorithm(name: "twoblocksinside4", algorithm: "(U) It’s V when the blocks are both on the inside and the colors on the outside are different", note: ""),
        
        Algorithm(name: "twoblocksoutside1", algorithm: "(No rotation) It’s Y when the blocks are both on the outside", note: ""),
        Algorithm(name: "twoblocksoutside2", algorithm: "(No rotation) It’s Y when the blocks are both on the outside", note: ""),
        Algorithm(name: "twoblocksoutside3", algorithm: "(No rotation) It’s Y when the blocks are both on the outside", note: ""),
        Algorithm(name: "twoblocksoutside4", algorithm: "(No rotation) It’s Y when the blocks are both on the outside", note: ""),
        
        Algorithm(name: "twoblocksleft1", algorithm: "(No rotation) It’s Na when the fully-visible corner is part of the left block and each side has opposite colors", note: ""),
        Algorithm(name: "twoblocksleft2", algorithm: "(No rotation) It’s Na when the fully-visible corner is part of the left block and each side has opposite colors", note: ""),
        Algorithm(name: "twoblocksleft3", algorithm: "(No rotation) It’s Na when the fully-visible corner is part of the left block and each side has opposite colors", note: ""),
        Algorithm(name: "twoblocksleft4", algorithm: "(No rotation) It’s Na when the fully-visible corner is part of the left block and each side has opposite colors", note: ""),
        
        Algorithm(name: "twoblocksright1", algorithm: "(No rotation) It’s Nb when the fully-visible corner is part of the right block and each side has opposite colors", note: ""),
        Algorithm(name: "twoblocksright2", algorithm: "(No rotation) It’s Nb when the fully-visible corner is part of the right block and each side has opposite colors", note: ""),
        Algorithm(name: "twoblocksright3", algorithm: "(No rotation) It’s Nb when the fully-visible corner is part of the right block and each side has opposite colors", note: ""),
        Algorithm(name: "twoblocksright4", algorithm: "(No rotation) It’s Nb when the fully-visible corner is part of the right block and each side has opposite colors", note: ""),
        
        // Category 2: One Block
        Algorithm(name: "oneblockoutside1", algorithm: "(No rotation) It’s V when there’s a block on the outside", note: ""),
        Algorithm(name: "oneblockoutside2", algorithm: "(No rotation) It’s V when there’s a block on the outside", note: ""),
        Algorithm(name: "oneblockoutside3", algorithm: "(No rotation) It’s V when there’s a block on the outside", note: ""),
        Algorithm(name: "oneblockoutside4", algorithm: "(No rotation) It’s V when there’s a block on the outside", note: ""),
        Algorithm(name: "oneblockoutside5", algorithm: "(U, mirrored alg) It’s V when there’s a block on the outside", note: ""),
        Algorithm(name: "oneblockoutside6", algorithm: "(U, mirrored alg) It’s V when there’s a block on the outside", note: ""),
        Algorithm(name: "oneblockoutside7", algorithm: "(U, mirrored alg) It’s V when there’s a block on the outside", note: ""),
        Algorithm(name: "oneblockoutside8", algorithm: "(U, mirrored alg) It’s V when there’s a block on the outside", note: ""),
        
        Algorithm(name: "oneblockinside1", algorithm: "(No rotation, mirrored) It’s Y when there’s a block on the inside and the corners are different", note: ""),
        Algorithm(name: "oneblockinside2", algorithm: "(No rotation, mirrored) It’s Y when there’s a block on the inside and the corners are different", note: ""),
        Algorithm(name: "oneblockinside3", algorithm: "(No rotation, mirrored) It’s Y when there’s a block on the inside and the corners are different", note: ""),
        Algorithm(name: "oneblockinside4", algorithm: "(No rotation, mirrored) It’s Y when there’s a block on the inside and the corners are different", note: ""),
        Algorithm(name: "oneblockinside5", algorithm: "(U) It’s Y when there’s a block on the inside and the corners are different", note: ""),
        Algorithm(name: "oneblockinside6", algorithm: "(U) It’s Y when there’s a block on the inside and the corners are different", note: ""),
        Algorithm(name: "oneblockinside7", algorithm: "(U) It’s Y when there’s a block on the inside and the corners are different", note: ""),
        Algorithm(name: "oneblockinside8", algorithm: "(U) It’s Y when there’s a block on the inside and the corners are different", note: ""),
        
        // Category 3: No Blocks
        Algorithm(name: "noblockscheckerinside1", algorithm: "(U') It’s V when there’s a checker pattern on the inside and the corners are different", note: ""),
        Algorithm(name: "noblockscheckerinside2", algorithm: "(U') It’s V when there’s a checker pattern on the inside and the corners are different", note: ""),
        Algorithm(name: "noblockscheckerinside3", algorithm: "(U') It’s V when there’s a checker pattern on the inside and the corners are different", note: ""),
        Algorithm(name: "noblockscheckerinside4", algorithm: "(U') It’s V when there’s a checker pattern on the inside and the corners are different", note: ""),
        
        Algorithm(name: "noblockscheckeroutside1", algorithm: "(U') It’s Y when there’s a checker pattern on the outside", note: ""),
        Algorithm(name: "noblockscheckeroutside2", algorithm: "(U') It’s Y when there’s a checker pattern on the outside", note: ""),
        Algorithm(name: "noblockscheckeroutside3", algorithm: "(U') It’s Y when there’s a checker pattern on the outside", note: ""),
        Algorithm(name: "noblockscheckeroutside4", algorithm: "(U') It’s Y when there’s a checker pattern on the outside", note: ""),
        
        Algorithm(name: "noblocksnochecker1", algorithm: "(No rotation) It’s E when there are no blocks and no checker in checker", note: ""),
        Algorithm(name: "noblocksnochecker2", algorithm: "(No rotation) It’s E when there are no blocks and no checker in checker", note: ""),
        Algorithm(name: "noblocksnochecker3", algorithm: "(No rotation) It’s E when there are no blocks and no checker in checker", note: ""),
        Algorithm(name: "noblocksnochecker4", algorithm: "(No rotation) It’s E when there are no blocks and no checker in checker", note: ""),
        Algorithm(name: "noblocksnochecker5", algorithm: "(U) It’s E when there are no blocks and no checker in checker", note: ""),
        Algorithm(name: "noblocksnochecker6", algorithm: "(U) It’s E when there are no blocks and no checker in checker", note: ""),
        Algorithm(name: "noblocksnochecker7", algorithm: "(U) It’s E when there are no blocks and no checker in checker", note: ""),
        Algorithm(name: "noblocksnochecker8", algorithm: "(U) It’s E when there are no blocks and no checker in checker", note: ""),
        
        // Adjacent Corner Permutation A
        // Category 1: A 3x1 Block & A 2x1 Block
        // When the 3x1 block is on the left
        Algorithm(name: "3x1left2x1inside1", algorithm: "(U') It's Ja when one color isn't solved on the right", note: ""),
        Algorithm(name: "3x1left2x1inside2", algorithm: "(U') It's Ja when one color isn't solved on the right", note: ""),
        Algorithm(name: "3x1left2x1inside3", algorithm: "(U') It's Ja when one color isn't solved on the right", note: ""),
        Algorithm(name: "3x1left2x1inside4", algorithm: "(U') It's Ja when one color isn't solved on the right", note: ""),
        
        Algorithm(name: "3x1left2x1outside1", algorithm: "(U) It's Jb when the 3x1 block is on the left and a block is on the right", note: ""),
        Algorithm(name: "3x1left2x1outside2", algorithm: "(U) It's Jb when the 3x1 block is on the left and a block is on the right", note: ""),
        Algorithm(name: "3x1left2x1outside3", algorithm: "(U) It's Jb when the 3x1 block is on the left and a block is on the right", note: ""),
        Algorithm(name: "3x1left2x1outside4", algorithm: "(U) It's Jb when the 3x1 block is on the left and a block is on the right", note: ""),
        // When the 3x1 block is on the right:
        Algorithm(name: "3x1right2x1inside1", algorithm: "(U2) It's Jb when one color isn't solved on the left", note: ""),
        Algorithm(name: "3x1right2x1inside2", algorithm: "(U2) It's Jb when one color isn't solved on the left", note: ""),
        Algorithm(name: "3x1right2x1inside3", algorithm: "(U2) It's Jb when one color isn't solved on the left", note: ""),
        Algorithm(name: "3x1right2x1inside4", algorithm: "(U2) It's Jb when one color isn't solved on the left", note: ""),
        
        Algorithm(name: "3x1right2x1outside1", algorithm: "(No rotation) It's Ja when the 3x1 block is on the right and a block is on the left", note: ""),
        Algorithm(name: "3x1right2x1outside2", algorithm: "(No rotation) It's Ja when the 3x1 block is on the right and a block is on the left", note: ""),
        Algorithm(name: "3x1right2x1outside3", algorithm: "(No rotation) It's Ja when the 3x1 block is on the right and a block is on the left", note: ""),
        Algorithm(name: "3x1right2x1outside4", algorithm: "(No rotation) It's Ja when the 3x1 block is on the right and a block is on the left", note: ""),
        
        // Category 2: One Outer 2x1 Block and One Inner 2x1 Block
        Algorithm(name: "1outerleft1inner1", algorithm: "(U) It’s Ja when the 2x1 block on the outside is on the left (more adj colors)", note: ""),
        Algorithm(name: "1outerleft1inner2", algorithm: "(U) It’s Ja when the 2x1 block on the outside is on the left (more adj colors)", note: ""),
        Algorithm(name: "1outerleft1inner3", algorithm: "(U) It’s Ja when the 2x1 block on the outside is on the left (more adj colors)", note: ""),
        Algorithm(name: "1outerleft1inner4", algorithm: "(U) It’s Ja when the 2x1 block on the outside is on the left (more adj colors)", note: ""),
        
        Algorithm(name: "1outerright1inner1", algorithm: "(No rotation) It’s Jb when the 2x1 block on the outside is on the right (more adj colors)", note: ""),
        Algorithm(name: "1outerright1inner2", algorithm: "(No rotation) It’s Jb when the 2x1 block on the outside is on the right (more adj colors)", note: ""),
        Algorithm(name: "1outerright1inner3", algorithm: "(No rotation) It’s Jb when the 2x1 block on the outside is on the right (more adj colors)", note: ""),
        Algorithm(name: "1outerright1inner4", algorithm: "(No rotation) It’s Jb when the 2x1 block on the outside is on the right (more adj colors)", note: ""),
        
        Algorithm(name: "1outerright1inneropp1", algorithm: "(U') It’s Jb when there are two 2x1 blocks, outer on the right (more opp colors)", note: ""),
        Algorithm(name: "1outerright1inneropp2", algorithm: "(U') It’s Jb when there are two 2x1 blocks, outer on the right (more opp colors)", note: ""),
        Algorithm(name: "1outerright1inneropp3", algorithm: "(U') It’s Jb when there are two 2x1 blocks, outer on the right (more opp colors)", note: ""),
        Algorithm(name: "1outerright1inneropp4", algorithm: "(U') It’s Jb when there are two 2x1 blocks, outer on the right (more opp colors)", note: ""),
        
        Algorithm(name: "1outerleft1inneropp1", algorithm: "(U2) It’s Ja when there are two 2x1 blocks, outer on the left (more opp colors)", note: ""),
        Algorithm(name: "1outerleft1inneropp2", algorithm: "(U2) It’s Ja when there are two 2x1 blocks, outer on the left (more opp colors)", note: ""),
        Algorithm(name: "1outerleft1inneropp3", algorithm: "(U2) It’s Ja when there are two 2x1 blocks, outer on the left (more opp colors)", note: ""),
        Algorithm(name: "1outerleft1inneropp4", algorithm: "(U2) It’s Ja when there are two 2x1 blocks, outer on the left (more opp colors)", note: ""),
        
        // Category 3: Two Inner 2x1 Blocks
        Algorithm(name: "2innerouterrightopp1", algorithm: "(U) It’s Aa when the outer corner on the right is opposite", note: ""),
        Algorithm(name: "2innerouterrightopp2", algorithm: "(U) It’s Aa when the outer corner on the right is opposite", note: ""),
        Algorithm(name: "2innerouterrightopp3", algorithm: "(U) It’s Aa when the outer corner on the right is opposite", note: ""),
        Algorithm(name: "2innerouterrightopp4", algorithm: "(U) It’s Aa when the outer corner on the right is opposite", note: ""),
        
        Algorithm(name: "2innerouterleftopp1", algorithm: "(U) It’s Ab when the outer corner on the left is opposite", note: ""),
        Algorithm(name: "2innerouterleftopp2", algorithm: "(U) It’s Ab when the outer corner on the left is opposite", note: ""),
        Algorithm(name: "2innerouterleftopp3", algorithm: "(U) It’s Ab when the outer corner on the left is opposite", note: ""),
        Algorithm(name: "2innerouterleftopp4", algorithm: "(U) It’s Ab when the outer corner on the left is opposite", note: ""),
        
        // Adjacent Corner Permutation B
        // Category 1: Inner Block
        Algorithm(name: "innerblockadjright1", algorithm: "(No rotation) It's Ra when the edge in between the headlights is adjacent and the block is on the right", note: ""),
        Algorithm(name: "innerblockadjright2", algorithm: "(No rotation) It's Ra when the edge in between the headlights is adjacent and the block is on the right", note: ""),
        Algorithm(name: "innerblockadjright3", algorithm: "(No rotation) It's Ra when the edge in between the headlights is adjacent and the block is on the right", note: ""),
        Algorithm(name: "innerblockadjright4", algorithm: "(No rotation) It's Ra when the edge in between the headlights is adjacent and the block is on the right", note: ""),
        
        Algorithm(name: "innerblockadjleft1", algorithm: "(U) It's Rb when the edge in between the headlights is adjacent and the block is on the left", note: ""),
        Algorithm(name: "innerblockadjleft2", algorithm: "(U) It's Rb when the edge in between the headlights is adjacent and the block is on the left", note: ""),
        Algorithm(name: "innerblockadjleft3", algorithm: "(U) It's Rb when the edge in between the headlights is adjacent and the block is on the left", note: ""),
        Algorithm(name: "innerblockadjleft4", algorithm: "(U) It's Rb when the edge in between the headlights is adjacent and the block is on the left", note: ""),
        
        Algorithm(name: "innerblockopp1", algorithm: "(U) It's T when the edge in between the headlights is opposite", note: ""),
        Algorithm(name: "innerblockopp2", algorithm: "(U) It's T when the edge in between the headlights is opposite", note: ""),
        Algorithm(name: "innerblockopp3", algorithm: "(U) It's T when the edge in between the headlights is opposite", note: ""),
        Algorithm(name: "innerblockopp4", algorithm: "(U) It's T when the edge in between the headlights is opposite", note: ""),
        
        Algorithm(name: "innerblockopp5", algorithm: "(No rotation, mirrored) It's T when the edge in between the headlights is opposite", note: ""),
        Algorithm(name: "innerblockopp6", algorithm: "(No rotation, mirrored) It's T when the edge in between the headlights is opposite", note: ""),
        Algorithm(name: "innerblockopp7", algorithm: "(No rotation, mirrored) It's T when the edge in between the headlights is opposite", note: ""),
        Algorithm(name: "innerblockopp8", algorithm: "(No rotation, mirrored) It's T when the edge in between the headlights is opposite", note: ""),
        
        // Category 2: Outer Block
        Algorithm(name: "outerblockrightcheckered1", algorithm: "(U) It’s Ab mirrored when the block is on the right and it's checkered", note: ""),
        Algorithm(name: "outerblockrightcheckered2", algorithm: "(U) It’s Ab mirrored when the block is on the right and it's checkered", note: ""),
        Algorithm(name: "outerblockrightcheckered3", algorithm: "(U) It’s Ab mirrored when the block is on the right and it's checkered", note: ""),
        Algorithm(name: "outerblockrightcheckered4", algorithm: "(U) It’s Ab mirrored when the block is on the right and it's checkered", note: ""),
        
        Algorithm(name: "outerblockleftcheckered1", algorithm: "(No rotation) It’s Ab when the block is on the left and it's checkered", note: ""),
        Algorithm(name: "outerblockleftcheckered2", algorithm: "(No rotation) It’s Ab when the block is on the left and it's checkered", note: ""),
        Algorithm(name: "outerblockleftcheckered3", algorithm: "(No rotation) It’s Ab when the block is on the left and it's checkered", note: ""),
        Algorithm(name: "outerblockleftcheckered4", algorithm: "(No rotation) It’s Ab when the block is on the left and it's checkered", note: ""),
        
        Algorithm(name: "outerblockrightnotcheckered1", algorithm: "(U) It’s Ga when the block is on the right and it's not checkered", note: ""),
        Algorithm(name: "outerblockrightnotcheckered2", algorithm: "(U) It’s Ga when the block is on the right and it's not checkered", note: ""),
        Algorithm(name: "outerblockrightnotcheckered3", algorithm: "(U) It’s Ga when the block is on the right and it's not checkered", note: ""),
        Algorithm(name: "outerblockrightnotcheckered4", algorithm: "(U) It’s Ga when the block is on the right and it's not checkered", note: ""),
        
        Algorithm(name: "outerblockleftnotcheckered1", algorithm: "(No rotation) It’s Gc when the block is on the left and it's not checkered", note: ""),
        Algorithm(name: "outerblockleftnotcheckered2", algorithm: "(No rotation) It’s Gc when the block is on the left and it's not checkered", note: ""),
        Algorithm(name: "outerblockleftnotcheckered3", algorithm: "(No rotation) It’s Gc when the block is on the left and it's not checkered", note: ""),
        Algorithm(name: "outerblockleftnotcheckered4", algorithm: "(No rotation) It’s Gc when the block is on the left and it's not checkered", note: ""),
        
        // Adjacent Corner Permutation C
        // Category 1: A 3x1 Block
        Algorithm(name: "3x1oppadj1", algorithm: "(U) It's F when there's a 3x1 block on the left and the colors go opposite adjacent", note: ""),
        Algorithm(name: "3x1oppadj2", algorithm: "(U) It's F when there's a 3x1 block on the left and the colors go opposite adjacent", note: ""),
        Algorithm(name: "3x1oppadj3", algorithm: "(U) It's F when there's a 3x1 block on the left and the colors go opposite adjacent", note: ""),
        Algorithm(name: "3x1oppadj4", algorithm: "(U) It's F when there's a 3x1 block on the left and the colors go opposite adjacent", note: ""),
        
        Algorithm(name: "3x1oppadj5", algorithm: "(No rotation) It's F when there's a 3x1 block on the right and the colors go opposite adjacent", note: ""),
        Algorithm(name: "3x1oppadj6", algorithm: "(No rotation) It's F when there's a 3x1 block on the right and the colors go opposite adjacent", note: ""),
        Algorithm(name: "3x1oppadj7", algorithm: "(No rotation) It's F when there's a 3x1 block on the right and the colors go opposite adjacent", note: ""),
        Algorithm(name: "3x1oppadj8", algorithm: "(No rotation) It's F when there's a 3x1 block on the right and the colors go opposite adjacent", note: ""),
        
        // Category 2: Inner Block
        Algorithm(name: "inneradjleft1", algorithm: "(No rotation) It’s Ga when the inner block is on the left and the corner beside the block is adjacent", note: ""),
        Algorithm(name: "inneradjleft2", algorithm: "(No rotation) It’s Ga when the inner block is on the left and the corner beside the block is adjacent", note: ""),
        Algorithm(name: "inneradjleft3", algorithm: "(No rotation) It’s Ga when the inner block is on the left and the corner beside the block is adjacent", note: ""),
        Algorithm(name: "inneradjleft4", algorithm: "(No rotation) It’s Ga when the inner block is on the left and the corner beside the block is adjacent", note: ""),
        
        Algorithm(name: "inneradjright1", algorithm: "(U) It’s Gc when the inner block is on the right and the corner beside the block is adjacent", note: ""),
        Algorithm(name: "inneradjright2", algorithm: "(U) It’s Gc when the inner block is on the right and the corner beside the block is adjacent", note: ""),
        Algorithm(name: "inneradjright3", algorithm: "(U) It’s Gc when the inner block is on the right and the corner beside the block is adjacent", note: ""),
        Algorithm(name: "inneradjright4", algorithm: "(U) It’s Gc when the inner block is on the right and the corner beside the block is adjacent", note: ""),
        
        Algorithm(name: "inneroppleft1", algorithm: "(U') It’s Gb when the inner block is on the left and the corner beside the block is opposite", note: ""),
        Algorithm(name: "inneroppleft2", algorithm: "(U') It’s Gb when the inner block is on the left and the corner beside the block is opposite", note: ""),
        Algorithm(name: "inneroppleft3", algorithm: "(U') It’s Gb when the inner block is on the left and the corner beside the block is opposite", note: ""),
        Algorithm(name: "inneroppleft4", algorithm: "(U') It’s Gb when the inner block is on the left and the corner beside the block is opposite", note: ""),
        
        Algorithm(name: "inneroppright1", algorithm: "(U2) It’s Gd when the inner block is on the right and the corner beside the block is opposite", note: ""),
        Algorithm(name: "inneroppright2", algorithm: "(U2) It’s Gd when the inner block is on the right and the corner beside the block is opposite", note: ""),
        Algorithm(name: "inneroppright3", algorithm: "(U2) It’s Gd when the inner block is on the right and the corner beside the block is opposite", note: ""),
        Algorithm(name: "inneroppright4", algorithm: "(U2) It’s Gd when the inner block is on the right and the corner beside the block is opposite", note: ""),
        
        // Category 3: Outer Block & Opposite Corner
        Algorithm(name: "outerrightopp1", algorithm: "(No rotation) It’s Gb when the outer block is on the right and it checkers in the middle", note: ""),
        Algorithm(name: "outerrightopp2", algorithm: "(No rotation) It’s Gb when the outer block is on the right and it checkers in the middle", note: ""),
        Algorithm(name: "outerrightopp3", algorithm: "(No rotation) It’s Gb when the outer block is on the right and it checkers in the middle", note: ""),
        Algorithm(name: "outerrightopp4", algorithm: "(No rotation) It’s Gb when the outer block is on the right and it checkers in the middle", note: ""),
        
        Algorithm(name: "outerleftopp1", algorithm: "(U) It’s Gd when the outer block is on the left and it checkers in the middle", note: ""),
        Algorithm(name: "outerleftopp2", algorithm: "(U) It’s Gd when the outer block is on the left and it checkers in the middle", note: ""),
        Algorithm(name: "outerleftopp3", algorithm: "(U) It’s Gd when the outer block is on the left and it checkers in the middle", note: ""),
        Algorithm(name: "outerleftopp4", algorithm: "(U) It’s Gd when the outer block is on the left and it checkers in the middle", note: ""),
        
        Algorithm(name: "outerleftoppnochecker1", algorithm: "(No rotation) It’s Aa when the outer block is on the left and it doesn't checker in the middle", note: ""),
        Algorithm(name: "outerleftoppnochecker2", algorithm: "(No rotation) It’s Aa when the outer block is on the left and it doesn't checker in the middle", note: ""),
        Algorithm(name: "outerleftoppnochecker3", algorithm: "(No rotation) It’s Aa when the outer block is on the left and it doesn't checker in the middle", note: ""),
        Algorithm(name: "outerleftoppnochecker4", algorithm: "(No rotation) It’s Aa when the outer block is on the left and it doesn't checker in the middle", note: ""),
        
        Algorithm(name: "outerrightoppnochecker1", algorithm: "(U) It’s Aa mirrored when the outer block is on the right and it doesn't checker in the middle", note: ""),
        Algorithm(name: "outerrightoppnochecker2", algorithm: "(U) It’s Aa mirrored when the outer block is on the right and it doesn't checker in the middle", note: ""),
        Algorithm(name: "outerrightoppnochecker3", algorithm: "(U) It’s Aa mirrored when the outer block is on the right and it doesn't checker in the middle", note: ""),
        Algorithm(name: "outerrightoppnochecker4", algorithm: "(U) It’s Aa mirrored when the outer block is on the right and it doesn't checker in the middle", note: ""),
        
        // Category 4: Outer Block & Adjacent Corner
        Algorithm(name: "outerleftadjchecker1", algorithm: "(U') It’s Ra when the block is on the left and it checkers in the middle (more adj colors)", note: ""),
        Algorithm(name: "outerleftadjchecker2", algorithm: "(U') It’s Ra when the block is on the left and it checkers in the middle (more adj colors)", note: ""),
        Algorithm(name: "outerleftadjchecker3", algorithm: "(U') It’s Ra when the block is on the left and it checkers in the middle (more adj colors)", note: ""),
        Algorithm(name: "outerleftadjchecker4", algorithm: "(U') It’s Ra when the block is on the left and it checkers in the middle (more adj colors)", note: ""),
        
        Algorithm(name: "outerrightadjchecker1", algorithm: "(U2) It’s Rb when the block is on the right and it checkers in the middle (more adj colors)", note: ""),
        Algorithm(name: "outerrightadjchecker2", algorithm: "(U2) It’s Rb when the block is on the right and it checkers in the middle (more adj colors)", note: ""),
        Algorithm(name: "outerrightadjchecker3", algorithm: "(U2) It’s Rb when the block is on the right and it checkers in the middle (more adj colors)", note: ""),
        Algorithm(name: "outerrightadjchecker4", algorithm: "(U2) It’s Rb when the block is on the right and it checkers in the middle (more adj colors)", note: ""),
        
        Algorithm(name: "outerleftadjnochecker1", algorithm: "(No rotation) It’s T when the block is on the left and it doesn't checker in the middle (and it's an adjacent corner)", note: ""),
        Algorithm(name: "outerleftadjnochecker2", algorithm: "(No rotation) It’s T when the block is on the left and it doesn't checker in the middle (and it's an adjacent corner)", note: ""),
        Algorithm(name: "outerleftadjnochecker3", algorithm: "(No rotation) It’s T when the block is on the left and it doesn't checker in the middle (and it's an adjacent corner)", note: ""),
        Algorithm(name: "outerleftadjnochecker4", algorithm: "(No rotation) It’s T when the block is on the left and it doesn't checker in the middle (and it's an adjacent corner)", note: ""),
        
        Algorithm(name: "outerrightadjnochecker1", algorithm: "(U) It’s T mirrored when the block is on the right and it doesn't checker in the middle (and it's an adjacent corner)", note: ""),
        Algorithm(name: "outerrightadjnochecker2", algorithm: "(U) It’s T mirrored when the block is on the right and it doesn't checker in the middle (and it's an adjacent corner)", note: ""),
        Algorithm(name: "outerrightadjnochecker3", algorithm: "(U) It’s T mirrored when the block is on the right and it doesn't checker in the middle (and it's an adjacent corner)", note: ""),
        Algorithm(name: "outerrightadjnochecker4", algorithm: "(U) It’s T mirrored when the block is on the right and it doesn't checker in the middle (and it's an adjacent corner)", note: ""),
        
        // Adjacent Corner Permutation D
        // Category 1: Opposite Edge In Between Headlights
        Algorithm(name: "oppinhead3right1", algorithm: "(U2) It’s Gb when there are 3 colors and the headlights are on the right containing the opposite color", note: ""),
        Algorithm(name: "oppinhead3right2", algorithm: "(U2) It’s Gb when there are 3 colors and the headlights are on the right containing the opposite color", note: ""),
        Algorithm(name: "oppinhead3right3", algorithm: "(U2) It’s Gb when there are 3 colors and the headlights are on the right containing the opposite color", note: ""),
        Algorithm(name: "oppinhead3right4", algorithm: "(U2) It’s Gb when there are 3 colors and the headlights are on the right containing the opposite color", note: ""),
        
        Algorithm(name: "oppinhead3left1", algorithm: "(U') It’s Gd when there are 3 colors and the headlights are on the left containing the opposite color", note: ""),
        Algorithm(name: "oppinhead3left2", algorithm: "(U') It’s Gd when there are 3 colors and the headlights are on the left containing the opposite color", note: ""),
        Algorithm(name: "oppinhead3left3", algorithm: "(U') It’s Gd when there are 3 colors and the headlights are on the left containing the opposite color", note: ""),
        Algorithm(name: "oppinhead3left4", algorithm: "(U') It’s Gd when there are 3 colors and the headlights are on the left containing the opposite color", note: ""),
        
        Algorithm(name: "oppinheadleft1", algorithm: "(U) It’s Gb when there's an opposite color in the headlights on the left (and no other pattern)", note: ""),
        Algorithm(name: "oppinheadleft2", algorithm: "(U) It’s Gb when there's an opposite color in the headlights on the left (and no other pattern)", note: ""),
        Algorithm(name: "oppinheadleft3", algorithm: "(U) It’s Gb when there's an opposite color in the headlights on the left (and no other pattern)", note: ""),
        Algorithm(name: "oppinheadleft4", algorithm: "(U) It’s Gb when there's an opposite color in the headlights on the left (and no other pattern)", note: ""),
        
        Algorithm(name: "oppinheadright1", algorithm: "(No rotation) It’s Gd when there's an opposite color in the headlights on the right (and no other pattern)", note: ""),
        Algorithm(name: "oppinheadright2", algorithm: "(No rotation) It’s Gd when there's an opposite color in the headlights on the right (and no other pattern)", note: ""),
        Algorithm(name: "oppinheadright3", algorithm: "(No rotation) It’s Gd when there's an opposite color in the headlights on the right (and no other pattern)", note: ""),
        Algorithm(name: "oppinheadright4", algorithm: "(No rotation) It’s Gd when there's an opposite color in the headlights on the right (and no other pattern)", note: ""),
        
        // Category 2: Adjacent Edge In Between Headlights
        Algorithm(name: "adjinheadleft1", algorithm: "(No rotation) It’s Rb when there's an adjacent color in the headlights on the left with an extended checker pattern", note: ""),
        Algorithm(name: "adjinheadleft2", algorithm: "(No rotation) It’s Rb when there's an adjacent color in the headlights on the left with an extended checker pattern", note: ""),
        Algorithm(name: "adjinheadleft3", algorithm: "(No rotation) It’s Rb when there's an adjacent color in the headlights on the left with an extended checker pattern", note: ""),
        Algorithm(name: "adjinheadleft4", algorithm: "(No rotation) It’s Rb when there's an adjacent color in the headlights on the left with an extended checker pattern", note: ""),
        
        Algorithm(name: "adjinheadright1", algorithm: "(U) It’s Ra when there's an adjacent color in the headlights on the right with an extended checker pattern", note: ""),
        Algorithm(name: "adjinheadright2", algorithm: "(U) It’s Ra when there's an adjacent color in the headlights on the right with an extended checker pattern", note: ""),
        Algorithm(name: "adjinheadright3", algorithm: "(U) It’s Ra when there's an adjacent color in the headlights on the right with an extended checker pattern", note: ""),
        Algorithm(name: "adjinheadright4", algorithm: "(U) It’s Ra when there's an adjacent color in the headlights on the right with an extended checker pattern", note: ""),
        
        Algorithm(name: "adjinheadrightchecker1", algorithm: "(U2) It’s Ga when there's an adjacent color in the headlights on the right and there is a checker pattern", note: ""),
        Algorithm(name: "adjinheadrightchecker2", algorithm: "(U2) It’s Ga when there's an adjacent color in the headlights on the right and there is a checker pattern", note: ""),
        Algorithm(name: "adjinheadrightchecker3", algorithm: "(U2) It’s Ga when there's an adjacent color in the headlights on the right and there is a checker pattern", note: ""),
        Algorithm(name: "adjinheadrightchecker4", algorithm: "(U2) It’s Ga when there's an adjacent color in the headlights on the right and there is a checker pattern", note: ""),
        
        Algorithm(name: "adjinheadleftchecker1", algorithm: "(U') It’s Gc when when there's an adjacent color in the headlights on the left and there is a checker pattern", note: ""),
        Algorithm(name: "adjinheadleftchecker2", algorithm: "(U') It’s Gc when when there's an adjacent color in the headlights on the left and there is a checker pattern", note: ""),
        Algorithm(name: "adjinheadleftchecker3", algorithm: "(U') It’s Gc when when there's an adjacent color in the headlights on the left and there is a checker pattern", note: ""),
        Algorithm(name: "adjinheadleftchecker4", algorithm: "(U') It’s Gc when when there's an adjacent color in the headlights on the left and there is a checker pattern", note: ""),
        
        Algorithm(name: "adjinheadrightnochecker1", algorithm: "(U') It’s Aa when when there's an adjacent color in the headlights on the right and there is no checker pattern", note: ""),
        Algorithm(name: "adjinheadrightnochecker2", algorithm: "(U') It’s Aa when when there's an adjacent color in the headlights on the right and there is no checker pattern", note: ""),
        Algorithm(name: "adjinheadrightnochecker3", algorithm: "(U') It’s Aa when when there's an adjacent color in the headlights on the right and there is no checker pattern", note: ""),
        Algorithm(name: "adjinheadrightnochecker4", algorithm: "(U') It’s Aa when when there's an adjacent color in the headlights on the right and there is no checker pattern", note: ""),
        
        Algorithm(name: "adjinheadleftnochecker1", algorithm: "(U') It’s Ab when when there's an adjacent color in the headlights on the left and there is no checker pattern", note: ""),
        Algorithm(name: "adjinheadleftnochecker2", algorithm: "(U') It’s Ab when when there's an adjacent color in the headlights on the left and there is no checker pattern", note: ""),
        Algorithm(name: "adjinheadleftnochecker3", algorithm: "(U') It’s Ab when when there's an adjacent color in the headlights on the left and there is no checker pattern", note: ""),
        Algorithm(name: "adjinheadleftnochecker4", algorithm: "(U') It’s Ab when when there's an adjacent color in the headlights on the left and there is no checker pattern", note: ""),
        
        // Adjacent Corner Permutation E
        Algorithm(name: "3colorcheckermiddle1", algorithm: "(U') It's F when it checkers in the middle and the corners are the same color (look for the opposite edge)", note: ""),
        Algorithm(name: "3colorcheckermiddle2", algorithm: "(U') It's F when it checkers in the middle and the corners are the same color (look for the opposite edge)", note: ""),
        Algorithm(name: "3colorcheckermiddle3", algorithm: "(U') It's F when it checkers in the middle and the corners are the same color (look for the opposite edge)", note: ""),
        Algorithm(name: "3colorcheckermiddle4", algorithm: "(U') It's F when it checkers in the middle and the corners are the same color (look for the opposite edge)", note: ""),
        Algorithm(name: "3colorcheckermiddle5", algorithm: "(No rotation) It's F when it checkers in the middle and the corners are the same color (look for the opposite edge)", note: ""),
        Algorithm(name: "3colorcheckermiddle6", algorithm: "(No rotation) It's F when it checkers in the middle and the corners are the same color (look for the opposite edge)", note: ""),
        Algorithm(name: "3colorcheckermiddle7", algorithm: "(No rotation) It's F when it checkers in the middle and the corners are the same color (look for the opposite edge)", note: ""),
        Algorithm(name: "3colorcheckermiddle8", algorithm: "(No rotation) It's F when it checkers in the middle and the corners are the same color (look for the opposite edge)", note: ""),
        
        Algorithm(name: "oppoutercornerright1", algorithm: "(U') It’s Ga when it's checker within checker and there are more opposite colors in the middle", note: ""),
        Algorithm(name: "oppoutercornerright2", algorithm: "(U') It’s Ga when it's checker within checker and there are more opposite colors in the middle", note: ""),
        Algorithm(name: "oppoutercornerright3", algorithm: "(U') It’s Ga when it's checker within checker and there are more opposite colors in the middle", note: ""),
        Algorithm(name: "oppoutercornerright4", algorithm: "(U') It’s Ga when it's checker within checker and there are more opposite colors in the middle", note: ""),
        
        Algorithm(name: "oppoutercornerleft1", algorithm: "(U2) It’s Gc when it's checker within checker and there are more opposite colors in the middle", note: ""),
        Algorithm(name: "oppoutercornerleft2", algorithm: "(U2) It’s Gc when it's checker within checker and there are more opposite colors in the middle", note: ""),
        Algorithm(name: "oppoutercornerleft3", algorithm: "(U2) It’s Gc when it's checker within checker and there are more opposite colors in the middle", note: ""),
        Algorithm(name: "oppoutercornerleft4", algorithm: "(U2) It’s Gc when it's checker within checker and there are more opposite colors in the middle", note: ""),
        
        Algorithm(name: "oppinnercornerright1", algorithm: "(U2) It’s Ra when it's checker within checker and there are more adj colors in the middle", note: ""),
        Algorithm(name: "oppinnercornerright2", algorithm: "(U2) It’s Ra when it's checker within checker and there are more adj colors in the middle", note: ""),
        Algorithm(name: "oppinnercornerright3", algorithm: "(U2) It’s Ra when it's checker within checker and there are more adj colors in the middle", note: ""),
        Algorithm(name: "oppinnercornerright4", algorithm: "(U2) It’s Ra when it's checker within checker and there are more adj colors in the middle", note: ""),
        
        Algorithm(name: "oppinnercornerleft1", algorithm: "(U') It’s Rb when it's checker within checker and there are more adj colors in the middle", note: ""),
        Algorithm(name: "oppinnercornerleft2", algorithm: "(U') It’s Rb when it's checker within checker and there are more adj colors in the middle", note: ""),
        Algorithm(name: "oppinnercornerleft3", algorithm: "(U') It’s Rb when it's checker within checker and there are more adj colors in the middle", note: ""),
        Algorithm(name: "oppinnercornerleft4", algorithm: "(U') It’s Rb when it's checker within checker and there are more adj colors in the middle", note: ""),
    ]
}

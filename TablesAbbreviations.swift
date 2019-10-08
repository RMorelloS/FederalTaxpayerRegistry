//
//  TablasAbreviaturas.swift
//  Practica_0_Ricardo_v1
//
//  Created by Morello Santos Ricardo on 9/20/19.
//  Copyright © 2019 Morello Santos Ricardo. All rights reserved.
//

import Foundation

class TablesAbbreviations{
    
    var tableCharValuesHomonymy =   [" ": "00",
                    "0": "00",
                    "1": "01",
                    "2": "02",
                    "3": "03",
                    "4": "04",
                    "5": "05",
                    "6": "06",
                    "7": "07",
                    "8": "08",
                    "9": "09",
                    "&": "10",
                    "Ñ": "10",
                    "A": "11",
                    "B": "12",
                    "C": "13",
                    "D": "14",
                    "E": "15",
                    "F": "16",
                    "G": "17",
                    "H": "18",
                    "I": "19",
                    "J": "21",
                    "K": "22",
                    "L": "23",
                    "M": "24",
                    "N": "25",
                    "O": "26",
                    "P": "27",
                    "Q": "28",
                    "R": "29",
                    "S": "32",
                    "T": "33",
                    "U": "34",
                    "V": "35",
                    "W": "36",
                    "X": "37",
                    "Y": "38",
                    "Z": "39"]

    var tableHomonymyDigits = [   0: "1",
                     1: "2",
                     2: "3",
                     3: "4",
                     4: "5",
                     5: "6",
                     6: "7",
                     7: "8",
                     8: "9",
                     9: "A",
                    10: "B",
                    11: "C",
                    12: "D",
                    13: "E",
                    14: "F",
                    15: "G",
                    16: "H",
                    17: "I",
                    18: "J",
                    19: "K",
                    20: "L",
                    21: "M",
                    22: "N",
                    23: "P",
                    24: "Q",
                    25: "R",
                    26: "S",
                    27: "T",
                    28: "U",
                    29: "V",
                    30: "W",
                    31: "X",
                    32: "Y",
                    33: "Z"]

    var tableVerifyingDigitValues
               =   ["0": "00",
                    "1": "01",
                    "2": "02",
                    "3": "03",
                    "4": "04",
                    "5": "05",
                    "6": "06",
                    "7": "07",
                    "8": "08",
                    "9": "09",
                    "A": "10",
                    "B": "11",
                    "C": "12",
                    "D": "13",
                    "E": "14",
                    "F": "15",
                    "G": "16",
                    "H": "17",
                    "I": "18",
                    "J": "19",
                    "K": "20",
                    "L": "21",
                    "M": "22",
                    "N": "23",
                    "&": "24",
                    "O": "25",
                    "P": "26",
                    "Q": "27",
                    "R": "28",
                    "S": "29",
                    "T": "30",
                    "U": "31",
                    "V": "32",
                    "W": "33",
                    "X": "34",
                    "Y": "35",
                    "Z": "36",
                    " ": "37"]

    var namesNaturalPerson : [String] = [
        "D",
        "DEL",
        "LA",
        "LOS",
        "LAS",
        "Y",
        "MC",
        "MAC",
        "VON",
        "VAN",
        "DE"
    ]
    var inappropriateWords : [String:String] = [
        "BUEI":"BUEX",
        "MAME":"MAMX",
        "CACA":"CACX",
        "MEAR":"MEAX",
        "CAGA":"CAGX",
        "MEON":"MEOX",
        "CAKA":"CAKX",
        "MOCO":"MOCX",
        "COGE":"COGX",
        "PEDA":"PEDX",
        "COJE":"COJX",
        "PENE":"PENX",
        "FETO":"FETX",
        "PUTO":"PUTX",
        "JOTO":"JOTX",
        "CACO":"CACX",
        "KACO":"KACX",
        "CAGO":"CAGX",
        "KAGO":"KAGX",
        "CAKO":"CAKX",
        "KOJO":"KOJX",
        "COJA":"COJX",
        "KULO":"KULX",
        "COJI":"COJX",
        "LOCO":"LOCX",
        "CULO":"CULX",
        "LOKO":"LOKX",
        "GUEY":"GUEX",
        "MAMO":"MAMX",
        "KACA":"KACX",
        "MEAS":"MEAX",
        "KAGA":"KAGX",
        "MION":"MIOX",
        "KOGE":"KOGX",
        "MULA":"MULX",
        "KAKA":"KAKX",
        "PEDO":"PEDX",
        "LOCA":"LOCX",
        "PUTA":"PUTX",
        "LOKA":"LOKX",
        "QULO":"QULX",
        "RATA":"RATX",
        "RUIN":"RUIX"
    ]
    var abbreviationsJuridicalPerson : [String] = [
        "EL",
        "LA",
        "S. DE",
        "S.A. DE",
        "R.L.",
        "C.V.",
        "DE",
        "LOS",
        "LAS",
        "Y",
        "DEL",
        "S.A.",
        "COMPAÑÍA",
        "CIA",
        "CÍA",
        "SOCIEDAD",
        "SOC",
        "COOPERATIVA",
        "COOP",
        "A.C.",
        "A. EN P.",
        "S. EN C. POR A.",
        "S. EN C.",
        "E. EN N.C.",
        "EN",
        "PARA",
        "CON",
        "POR",
        "SUS",
        "AL",
        "S.C.",
        "E",
        "S.C.S.",
        "S.C.L.",
        "THE",
        "I.A.P",
        "S.N.C.",
        "AND",
        "OF",
        "C.D.",
        "COMPANY",
        "MAC",
        "MC",
        "VAN",
        "VON",
    ]
    init(){
        sortJuridicalPersonAbbreviationsArray()
    }
    func before(value1: String, value2: String) -> Bool {
        // One string is alphabetically first.
        // ... True means value1 precedes value2.
        return value1.count > value2.count;
    }
    func sortJuridicalPersonAbbreviationsArray(){
        // Sort the array.
        abbreviationsJuridicalPerson.sort(by: before)
        // Display sorted array.
    }
}
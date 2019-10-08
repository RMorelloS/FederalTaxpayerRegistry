//
//  RFCMoral.swift
//  Practica_0_Ricardo_v1
//
//  Created by Morello Santos Ricardo on 9/19/19.
//  Copyright © 2019 Morello Santos Ricardo. All rights reserved.
//

import Foundation
//calculadora de rfc juridico
class RFCJuridical{
    //variables que almacenan el nombre de la empresa, la clave y fecha de creacion
    //variables para almacenar tambien el nombre original, ya que este se va a cambiar
    //remover abreviaturas, acentos, etc
    var juridicalPersonKey : String = ""
    var juridicalPersonName : String = ""
    var juridicalPersonDateOfCreation : String = ""
    var originalJuridicalPersonName : String = ""
    var juridicalPersonYearOfCreation : Int = 0
    var juridicalPersonMonthOfCreation : Int = 0
    var juridicalPersonDayOfCreation : Int = 0
    var homonymyValues : [String] = []
    var sumHomonymyValues : Int = 0
    //constructor
    init(juridicalName : String, creationDate : String){
        juridicalPersonName = juridicalName
        juridicalPersonDateOfCreation = creationDate
        originalJuridicalPersonName = juridicalName
    }
    //tornar la primer letra maiuscula
    func capitalizingFirstLetter(abbreviation: String) -> String {
        return abbreviation.prefix(1).uppercased() + abbreviation.lowercased().dropFirst()
    }
    //filtra las abreviaciones del nombre de la empresa
    //asi como para la persona fisica, se quita el nombre en el comienzo, medio y final
    func filterJuridicalPersonNameAbbreviations(){
        let juridicalAbbreviations = TablesAbbreviations()
        let juridicalNamesArraySeparatedByComma = juridicalPersonName.components(separatedBy: ",")
        juridicalPersonName = juridicalPersonName.replacingOccurrences(of: ",", with: "")
        juridicalPersonName = juridicalPersonName.replacingOccurrences(of: "  ", with: " ")
        if juridicalNamesArraySeparatedByComma.count > 1 && juridicalNamesArraySeparatedByComma.last != nil{
           juridicalPersonName = juridicalPersonName.replacingOccurrences(of: juridicalNamesArraySeparatedByComma.last!, with: "")
        }
        var juridicalNamesArray = juridicalPersonName.components(separatedBy: " ")
        
        for singleName in juridicalNamesArray{
            if juridicalAbbreviations.abbreviationsJuridicalPerson.contains(singleName.uppercased()){
                juridicalPersonName = juridicalPersonName.replacingOccurrences(of: " " + singleName + " ", with: " ")
                if singleName == juridicalNamesArray.first{
                    juridicalPersonName = juridicalPersonName.replacingOccurrences(of:  singleName + " ", with: "")
                    juridicalNamesArray = juridicalPersonName.components(separatedBy: " ")
                }else if singleName == juridicalNamesArray.last{
                    juridicalPersonName = juridicalPersonName.replacingOccurrences(of:  " " + singleName, with: "")
                    juridicalNamesArray = juridicalPersonName.components(separatedBy: " ")
                }
            }
        }
        
    }
    //verifica si hay numeros en el nombre moral
    //se si, traduz para el espanol los numeros
    func checkForNumbersInJuridicalName(){
        var isRomanNumeral = false
        let juridicalNamesArray = juridicalPersonName.components(separatedBy: " ")
        for singleName in juridicalNamesArray {
            isRomanNumeral = checkForRomanNumerals(item: singleName)
            var number = Int(singleName)
            if number != nil || isRomanNumeral {
                if isRomanNumeral{
                    number = romanToInt(romanNumeral: singleName)
                }
                let numberFormatter:NumberFormatter = NumberFormatter()
                numberFormatter.locale = Locale(identifier: "es_ES")
                numberFormatter.numberStyle = NumberFormatter.Style.spellOut
                let translatedNumber = numberFormatter.string(from: NSNumber(value: number!))!
                juridicalPersonName = juridicalPersonName.replacingOccurrences(of: singleName, with: translatedNumber)
            }
        }
    }
    //verifica si el numero es romano
    func checkForRomanNumerals(item: String) -> Bool{
        let numerals = ["M", "D", "C", "L", "X", "V", "I"]
        for letter in item {
            if !numerals.contains(String (letter)){
                return false
            }
        }
        return true
    }
    //converte numeros romanos para arabicos
    func romanToInt(romanNumeral: String) -> Int
    {
        var integerNumber : Int = 0
        for letter in romanNumeral{
            if letter == "M"{
                integerNumber += 1000
            }else if letter == "D"{
                integerNumber += 500
            }else if letter == "C"{
                integerNumber += 100
            }else if letter == "L"{
                integerNumber += 50
            }else if letter == "X"{
                integerNumber += 10
            }else if letter == "V"{
                integerNumber += 5
            }else if letter == "I"{
                integerNumber += 1
            }
        }
        return integerNumber
    }
    //filtra puntos del nombre
    func filterDots(name : String) -> String{
        var filteredName = name
        filteredName = filteredName.replacingOccurrences(of: ".", with: " ")
        filteredName = filteredName.replacingOccurrences(of: ". ", with: "")
        filteredName = filteredName.replacingOccurrences(of: "  ", with: " ")
        return filteredName
    }
    //regla para añadir cuando solo hay tres letras en el nombre de la empresa
    func rfcRuleOneElementThreeLetters(){
        juridicalPersonKey += juridicalPersonName.prefix(3).uppercased()
        
    }
    //regla para añadir cuando hay menos de tres letras en el nombre de la empresa
    func rfcRuleOneElementLessThanThreeLetters(){
        juridicalPersonKey += juridicalPersonName.uppercased()
        for _ in 0..<(3-juridicalPersonName.count){
            juridicalPersonKey += "X"
        }
    }
    //regla para añadir cuando solo hay dos nombres
    func rfcRuleTwoElements(){
        let juridicalNamesArray = juridicalPersonName.components(separatedBy: " ")
        juridicalPersonKey += juridicalNamesArray.first!.prefix(1).uppercased()
        juridicalPersonKey += juridicalNamesArray[1].prefix(2).uppercased()
    }
    //regla para añadir cuando hay tres nombres o mas
    func rfcRuleThreeElements(){
        let juridicalNamesArray = juridicalPersonName.components(separatedBy: " ")
        juridicalPersonKey += juridicalNamesArray.first!.prefix(1).uppercased()
        juridicalPersonKey += juridicalNamesArray[1].prefix(1).uppercased()
        juridicalPersonKey += juridicalNamesArray[2].prefix(1).uppercased()
    }
    //añadir la fecha
    func rfcRuleDate(){
        separateCreationDate()
        juridicalPersonKey += String(juridicalPersonYearOfCreation).suffix(2)
        if juridicalPersonMonthOfCreation < 10{
            juridicalPersonKey += "0"
        }
        juridicalPersonKey += String(juridicalPersonMonthOfCreation)
        if juridicalPersonDayOfCreation < 10{
            juridicalPersonKey += "0"
        }
        juridicalPersonKey += String(juridicalPersonDayOfCreation)
    }
    //separa la fecha
    func separateCreationDate(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd:MM:yyyy"
        let date = dateFormatter.date(from: juridicalPersonDateOfCreation)
        if date != nil {
            let calendar = Calendar.current
            let year = calendar.component(.year, from: date!)
            juridicalPersonYearOfCreation = year
            let month =  calendar.component(.month, from: date!)
            juridicalPersonMonthOfCreation = month
            let day = calendar.component(.day, from: date!)
            juridicalPersonDayOfCreation = day
        }
    }
    //filtra los acentos del nombre moral
    func filterAccentFromName(){
            originalJuridicalPersonName = originalJuridicalPersonName.uppercased()
            originalJuridicalPersonName = originalJuridicalPersonName.replacingOccurrences(of: "Á", with: "A")
            originalJuridicalPersonName = originalJuridicalPersonName.replacingOccurrences(of: "É", with: "E")
            originalJuridicalPersonName = originalJuridicalPersonName.replacingOccurrences(of: "Í", with: "I")
            originalJuridicalPersonName = originalJuridicalPersonName.replacingOccurrences(of: "Ó", with: "O")
            originalJuridicalPersonName = originalJuridicalPersonName.replacingOccurrences(of: "Ú", with: "U")
            originalJuridicalPersonName = originalJuridicalPersonName.replacingOccurrences(of: "Ñ", with: "&")
    
    }
    //funcion para calcular el digito homonimo
    //es lo mismo para la persona fisica, excepto que tiene un espacio antes del nombre de la persona moral
    func calculateHomonymyKey(){
         let tableCharValues = TablesAbbreviations()
        filterAccentFromName()
        var fullName = filterDots(name: originalJuridicalPersonName)
        fullName = fullName.replacingOccurrences(of: ",", with: "")
         for characterCount in 0..<fullName.count{
             let character = fullName.index(fullName.startIndex, offsetBy: characterCount)
             var valueForCharacter = tableCharValues.tableCharValuesHomonymy[String(fullName[character])]
             if valueForCharacter != nil{
                 //insertando el 0 en la primera posicion del arreglo de valores
                 if characterCount == 0{
                     valueForCharacter!.insert("0", at: character)
                 }
                 homonymyValues.append(valueForCharacter!)
             }
         }
         let homonymyIndividualValue = Int(homonymyValues[0])!
         if homonymyIndividualValue > 10{
             sumHomonymyValues += Int(homonymyIndividualValue/10) * Int(homonymyIndividualValue/10)
         }
         for (index, value) in homonymyValues.enumerated(){
             let integerValue = Int(value)!
             let multipliedValue = integerValue * (integerValue%10)
             sumHomonymyValues += multipliedValue
             if index != homonymyValues.endIndex-1 {
                 let nextValue = Int(homonymyValues[index+1])!
                 if (nextValue > 10){
                     let intermediateIntegerValue = ((integerValue%10)*10) + (nextValue/10)
                     sumHomonymyValues+=((intermediateIntegerValue)*(intermediateIntegerValue%10))
                 }
             }
         }
         let lastThreeDigitsOfSum = sumHomonymyValues%1000
         let firstHomonymyDigit = tableCharValues.tableHomonymyDigits[lastThreeDigitsOfSum/34]!
         let secondHomonymyDigit = tableCharValues.tableHomonymyDigits[lastThreeDigitsOfSum%34]!
         juridicalPersonKey += firstHomonymyDigit
         juridicalPersonKey += secondHomonymyDigit

     }
    //funcion para calcular el digito verificador (igual para persona fisica)
    func calculateVerifyingDigit(){
        let tableVerifyingDigitValues = TablesAbbreviations()
        var sumVerifyingDigit = 0
        var countN = 1
        juridicalPersonKey.insert(" ", at: juridicalPersonKey.startIndex)
        for character in 0..<juridicalPersonKey.count{
            let character = juridicalPersonKey.index(juridicalPersonKey.startIndex, offsetBy: character)
            let valueForCharacter = tableVerifyingDigitValues.tableVerifyingDigitValues[String(juridicalPersonKey[character])]
            if valueForCharacter != nil{
                let valueForCharacterInteger = Int(valueForCharacter!)
                if valueForCharacterInteger != nil{
                    sumVerifyingDigit = sumVerifyingDigit+valueForCharacterInteger! * (14 - countN)
                }else{
                    print("Caracter invalido ingresado para el nombre!")
                }
            }
            countN = countN+1
        }
        
        if sumVerifyingDigit%11 == 0{
            juridicalPersonKey += "0"
        }else if sumVerifyingDigit%11 < 10 && sumVerifyingDigit%11 > 0{
            let digit = 11 - (sumVerifyingDigit%11)
            juridicalPersonKey += String(digit)
        }else{
            juridicalPersonKey+="A"
        }
    }
}


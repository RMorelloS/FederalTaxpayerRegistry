//
//  RFCFisical.swift
//  Practica_0_Ricardo_v1
//
//  Created by Morello Santos Ricardo on 9/23/19.
//  Copyright © 2019 Morello Santos Ricardo. All rights reserved.
//

import Foundation
//clase para calcular el rfc de personas fisicas
class RFCNatural{
    //variables que almacenan el nombre, fecha de nacimiento y clave RFC de la persona
    var naturalPersonName : String = ""
    var naturalPersonMothersName : String = ""
    var naturalPersonFathersName : String = ""
    var naturalPersonDateOfBirth : String = ""
    var naturalPersonKey : String = ""
    //variables que almacenam los nombres originales, ya que los de arriba se van a cambiar
    //como quitar las abreviaturas, acentos, etc
    var originalNaturalPersonName : String = ""
    var originalNaturalPersonMothersName : String = ""
    var originalNaturalPersonFathersName : String = ""
    //fecha de nacimiento separada en enteros
    var naturalPersonBirthMonth : Int = 0
    var naturalPersonBirthYear : Int = 0
    var naturalPersonBirthDay : Int = 0
    //arreglo de valores para calcular los digitos homonimos
    var homonymyValues : [String] = []
    //soma de los valores del arreglo homonimo
    var sumHomonymyValues : Int = 0
    //constructor
    init(naturalName : String, naturalMothersName : String, naturalFathersName : String, naturalBirthDate : String){
        naturalPersonName = naturalName
        naturalPersonMothersName = naturalMothersName
        naturalPersonFathersName = naturalFathersName
        naturalPersonDateOfBirth = naturalBirthDate
        originalNaturalPersonName = naturalName
        originalNaturalPersonFathersName = naturalFathersName
        originalNaturalPersonMothersName = naturalMothersName
    }
    //filtra acentos del nombre y apellido de la persona fisica
    func filterAccentFromName(){
        var arrayNames : [String] = [originalNaturalPersonName, originalNaturalPersonFathersName, originalNaturalPersonMothersName]
        for (index, var name) in arrayNames.enumerated(){
            name = name.uppercased()
            name = name.replacingOccurrences(of: "Á", with: "A")
            name = name.replacingOccurrences(of: "É", with: "E")
            name = name.replacingOccurrences(of: "Í", with: "I")
            name = name.replacingOccurrences(of: "Ó", with: "O")
            name = name.replacingOccurrences(of: "Ú", with: "U")
            name = name.replacingOccurrences(of: "Ñ", with: "&")
            arrayNames[index] = name
        }
        originalNaturalPersonName = arrayNames[0]
        originalNaturalPersonFathersName = arrayNames[1]
        originalNaturalPersonMothersName = arrayNames[2]
        
    }
    //filtra abreviaturas, puntos y coma del nombre de la persona fisica
    func filterNaturalPersonName(){
        var arrayNaturalPersonNames : [String] = [naturalPersonName, naturalPersonMothersName, naturalPersonFathersName]
        let naturalAbbreviations = TablesAbbreviations()
        var countNames=0
        for var name in arrayNaturalPersonNames{
            var separatedNameArray = name.components(separatedBy: " ")
            for individualName in separatedNameArray{
                if naturalAbbreviations.namesNaturalPerson.contains(individualName.uppercased()){
                    //quita las abreviaturas que estan en el medio de la palabra
                    name = name.replacingOccurrences(of: " " + individualName + " ", with: " ")
                    if individualName == separatedNameArray.first {
                        //quita las abreviaturas que estan en el comienzo de la palabra
                        name = name.replacingOccurrences(of:  individualName + " ", with: "")
                        separatedNameArray = name.components(separatedBy: " ")
                    }else if individualName == separatedNameArray.last{
                        //quita las abrevituras que estan en el final de la palabra
                        name = name.replacingOccurrences(of:  " " + individualName, with: "")
                        separatedNameArray = name.components(separatedBy: " ")
                    }
                }
            }
            arrayNaturalPersonNames[countNames] = name
            countNames+=1
        }
        //atribue los nuevos nombres filtrados as variables
        naturalPersonName = arrayNaturalPersonNames[0]
        naturalPersonMothersName = arrayNaturalPersonNames[1]
        naturalPersonFathersName = arrayNaturalPersonNames[2]
    }
    //adicionar las cuatro letras del nombre para a clave RFC
    func addNaturalNameToKey(amountOfLettersToAdd : Int){
        //separa el primer nombre
        let individualNames = naturalPersonName.components(separatedBy: " ")
        //si tiene mas de una palabra - nombre compuesto
        if individualNames.count > 1{
            for (index,name) in individualNames.enumerated(){
                //si el primer nombre es jose o maria
                if (index == 0){
                    if(name != "José") && (name != "María"){
                            naturalPersonKey = naturalPersonKey + name.prefix(amountOfLettersToAdd)
                            break
                    }
                }else{
                    naturalPersonKey = naturalPersonKey + name.prefix(amountOfLettersToAdd)
                }
            }
        }else{
            naturalPersonKey = naturalPersonKey + naturalPersonName.prefix(amountOfLettersToAdd)
        }
    }
    //filtra palabras inapropriadas de la clave, como CULO = CULX
    func filterInappropriateWords(){
        let tables = TablesAbbreviations()
        if tables.inappropriateWords[naturalPersonKey] != nil{
            naturalPersonKey = tables.inappropriateWords[naturalPersonKey]!
        }
    }
    //separa la fecha y añade a clave
    func rfcRuleDate(){
        separateCreationDate()
        naturalPersonKey += String(naturalPersonDateOfBirth).suffix(2)
        if naturalPersonBirthMonth < 10{
            naturalPersonKey += "0"
        }
        naturalPersonKey += String(naturalPersonBirthMonth)
        if naturalPersonBirthDay < 10{
            naturalPersonKey += "0"
        }
        naturalPersonKey += String(naturalPersonBirthDay)
    }
    //funcion para separar la fecha
    func separateCreationDate(){
         let dateFormatter = DateFormatter()
         dateFormatter.dateFormat = "dd:MM:yyyy"
         let date = dateFormatter.date(from: naturalPersonDateOfBirth)
         if date != nil {
             let calendar = Calendar.current
             let year = calendar.component(.year, from: date!)
             naturalPersonBirthYear = year
             let month =  calendar.component(.month, from: date!)
             naturalPersonBirthMonth = month
             let day = calendar.component(.day, from: date!)
             naturalPersonBirthDay = day
         }
     }
    //quita los acentos de la clave rfc
    func removeAccentFromNaturalKey(){
        naturalPersonKey = naturalPersonKey.replacingOccurrences(of: "Á", with: "A")
        naturalPersonKey = naturalPersonKey.replacingOccurrences(of: "É", with: "E")
        naturalPersonKey = naturalPersonKey.replacingOccurrences(of: "Í", with: "I")
        naturalPersonKey = naturalPersonKey.replacingOccurrences(of: "Ó", with: "O")
        naturalPersonKey = naturalPersonKey.replacingOccurrences(of: "Ú", with: "U")
        
    }
    //verificar en cual de las reglas se cae el nombre insertado
    func addFullNameToKey(){
        //si el apellido paterno solo tiene una o dos letras
        if naturalPersonFathersName.count == 1 || naturalPersonFathersName.count == 2 {
            fathersNameOneLetter()
            addNaturalNameToKey(amountOfLettersToAdd: 2)
        }//si no hay apellido materno o paterno
        else if naturalPersonFathersName.count == 0 || naturalPersonMothersName.count == 0{
            emptyFatherOrMothersName()
            addNaturalNameToKey(amountOfLettersToAdd : 2)
        }//sigue la regla 1 - estandar para añadir los nombres a la clave
        else{
            defaultForAddingNamesToKey()
            addNaturalNameToKey(amountOfLettersToAdd: 1)
        }
        naturalPersonKey = naturalPersonKey.uppercased()
    }
    //funcion para verificar si una letra es un vocal
    func isVowel(letter: String) -> Bool{
        switch letter {
            case "a", "á", "é", "e", "í","i","o","ó","u","ú","A","E","I","O","U","Á","É","Í","Ó","Ú":
                return true
            default:
                return false
        }
    }
    //funcion para añadir las letras del primer nombre y apellidos en la clave
    func defaultForAddingNamesToKey(){
        //primera letra del apellido paterno
        naturalPersonKey = naturalPersonKey + naturalPersonFathersName.prefix(1)
        //primera vocal del apellido paterno
        for i in 1..<naturalPersonFathersName.count {
            let index = naturalPersonFathersName.index(naturalPersonFathersName.startIndex, offsetBy: i)
            if isVowel(letter: String(naturalPersonFathersName[index])){
                naturalPersonKey = naturalPersonKey + String(naturalPersonFathersName[index])
                break
            }
        }
        //primera letra del apellido materno
        naturalPersonKey = naturalPersonKey + naturalPersonMothersName.prefix(1)
    }
    //funcion para añadir caso uno de los apellidos estea vacio
    func emptyFatherOrMothersName(){
        if naturalPersonFathersName.count == 0{
            naturalPersonKey = naturalPersonKey + naturalPersonMothersName.prefix(2)
        }else{
            naturalPersonKey = naturalPersonKey + naturalPersonFathersName.prefix(2)
        }
    }
    //funcion para añadir caso el apellido paterno solo tenga una letra
    func fathersNameOneLetter(){
        naturalPersonKey = naturalPersonKey+naturalPersonFathersName.prefix(1)
        naturalPersonKey = naturalPersonKey+naturalPersonMothersName.prefix(1)
    }
    //funcion para filtrar solo el primer apellido
    func filterOnlyFirstSurname(){
        var countSurnames = 0
        var arrayNaturalPersonSurname : [String] = [naturalPersonFathersName, naturalPersonMothersName]
        for var name in arrayNaturalPersonSurname{
            let separatedNameArray = name.components(separatedBy: " ")
            if separatedNameArray.count > 1 {
                name = separatedNameArray.first!
                arrayNaturalPersonSurname[countSurnames] = name
            }
            countSurnames += 1
        }
        naturalPersonFathersName = arrayNaturalPersonSurname[0]
        naturalPersonMothersName = arrayNaturalPersonSurname[1]
        
    }
    //funcion para calcular los digitos homonimos
    func calculateHomonymyKey(){
        //tabla que contiene los caracteres y sus valores
        let tableCharValues = TablesAbbreviations()
        //nombre completo
        let fullName = originalNaturalPersonFathersName + " " + originalNaturalPersonMothersName + " " + originalNaturalPersonName
        //para cada caracter del nombre, verifica su valor en la tabla y añade el valor a un arreglo de enteros
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
        //primer digito del arreglo homonimo
        //ejemplo: 015 = 1 * 1
        let homonymyIndividualValue = Int(homonymyValues[0])!
        if homonymyIndividualValue > 10{
            sumHomonymyValues += Int(homonymyIndividualValue/10) * Int(homonymyIndividualValue/10)
        }
        //a los demas digitos, primer multiplica el numero por su secundo digito
        //integerValue * integerValue%10
        //015 = 15 * 5
        //despues verifica si hay un proximo numero e, caso si, multiplica el numero formado por el segundo digito del numero anterior y
        //el primer digito del posterior por el segundo digito del posterior
        //015 72 - numero = 57, multiplica 57 * 7
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
        //capturando los ultimos tres digitos de la soma
        let lastThreeDigitsOfSum = sumHomonymyValues%1000
        //residuo y numero despues de la division
        let firstHomonymyDigit = tableCharValues.tableHomonymyDigits[lastThreeDigitsOfSum/34]!
        let secondHomonymyDigit = tableCharValues.tableHomonymyDigits[lastThreeDigitsOfSum%34]!
        //añadir los digitos
        naturalPersonKey += firstHomonymyDigit
        naturalPersonKey += secondHomonymyDigit
    }
    //funcion para calcular el digito verificador
    func calculateVerifyingDigit(){
        //tabla de digitos con sus respectivos valores
        let tableVerifyingDigitValues = TablesAbbreviations()
        //soma total de los valores
        var sumVerifyingDigit = 0
        //contador del valor de n en la formula
        var countN = 1
        //formula del somatorio rfc para el digito verificador
        for character in 0..<naturalPersonKey.count{
            let character = naturalPersonKey.index(naturalPersonKey.startIndex, offsetBy: character)
            let valueForCharacter = tableVerifyingDigitValues.tableVerifyingDigitValues[String(naturalPersonKey[character])]
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
        //las tres condiciones del digito verificador
        if sumVerifyingDigit%11 == 0{
            naturalPersonKey += "0"
        }else if sumVerifyingDigit%11 < 10 && sumVerifyingDigit%11 > 0{
            let digit = 11 - (sumVerifyingDigit%11)
            naturalPersonKey += String(digit)
        }else{
            naturalPersonKey+="A"
        }
    }
}

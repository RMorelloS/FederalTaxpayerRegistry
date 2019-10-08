//
//  controllerRFC.swift
//  Practica_0_Ricardo_v1
//
//  Created by Morello Santos Ricardo on 9/19/19.
//  Copyright © 2019 Morello Santos Ricardo. All rights reserved.
//

import Foundation
//classe controladora
class ControllerRFC{
    var userInputData = UserInput()
    //inicia
    func begin(){
        //presenta informaciones del programa y captura tipo del usuario
        userInputData.presentInformationAboutProgram()
        userInputData.getUserType()
        
        //caso sea moral
        if userInputData.juridicalOrNaturalPerson == "m" {
            //captura el nombre y fecha de creacion
            userInputData.getNameFromJuridicalUser()
            userInputData.getCreationOrBirthDate(0)
            //crea una calculadora de rfc moral para este usuario
            let rfcJuridicalCalculator = RFCJuridical(juridicalName: userInputData.juridicalPersonName, creationDate: userInputData.juridicalOrNaturalPersonDateOfCreation)
            //atribue el nombre de la persona moral a calculadora
            rfcJuridicalCalculator.juridicalPersonName = rfcJuridicalCalculator.filterDots(name: rfcJuridicalCalculator.juridicalPersonName)
            //filtra abreviaturas del nombre
            rfcJuridicalCalculator.filterJuridicalPersonNameAbbreviations()
            //verifica se tiene numeros y, caso tenga, traduz estes numeros para linguage escrita
            //505 = quinientos cinco, por ejemplo
            rfcJuridicalCalculator.checkForNumbersInJuridicalName()
            //conta numero de palabras del nombre de la persona moral
            let countWordsForRFCRules = rfcJuridicalCalculator.juridicalPersonName.components(separatedBy: " ").count
            //si tiene una palabra
            if countWordsForRFCRules == 1{
                //si la palabra tiene mas de 3 caracteres
                if rfcJuridicalCalculator.juridicalPersonName.count >= 3{
                    rfcJuridicalCalculator.rfcRuleOneElementThreeLetters()
                }//caso no
                else{
                    rfcJuridicalCalculator.rfcRuleOneElementLessThanThreeLetters()
                }
                
            }//si tiene 2 palabras
            else if countWordsForRFCRules == 2{
                rfcJuridicalCalculator.rfcRuleTwoElements()
            }//si tiene mas de tres palabras
            else if countWordsForRFCRules >= 3{
                rfcJuridicalCalculator.rfcRuleThreeElements()
            }
            //añadir la fecha de creacion de la empresa
            rfcJuridicalCalculator.rfcRuleDate()
            //calcula los digitos homonimos
            rfcJuridicalCalculator.calculateHomonymyKey()
            //calcula el digito verificador
            rfcJuridicalCalculator.calculateVerifyingDigit()
            //presenta la salida al usuario
            var index = rfcJuridicalCalculator.juridicalPersonKey.index(rfcJuridicalCalculator.juridicalPersonKey.startIndex, offsetBy: 4)
            rfcJuridicalCalculator.juridicalPersonKey.insert("-",at:index)
            index = rfcJuridicalCalculator.juridicalPersonKey.index(rfcJuridicalCalculator.juridicalPersonKey.startIndex, offsetBy: 11)
            rfcJuridicalCalculator.juridicalPersonKey.insert("-",at:index)
            index = rfcJuridicalCalculator.juridicalPersonKey.index(rfcJuridicalCalculator.juridicalPersonKey.startIndex, offsetBy: 14)
            rfcJuridicalCalculator.juridicalPersonKey.insert("-",at:index)
            print(rfcJuridicalCalculator.originalJuridicalPersonName)
            print("")
            print("--------------------------------------------------------------------------")
            print("RFC Asignado:")
            print(rfcJuridicalCalculator.juridicalPersonKey)
            print("--------------------------------------------------------------------------")
        }//caso sea persona fisica
        else if userInputData.juridicalOrNaturalPerson == "f"{
            //entrada de datos
            userInputData.getNameAndSurnameFromNaturalUser()
            userInputData.getCreationOrBirthDate(1)
            //creacion de la calculadora para persona fisica
            let rfcNaturalCalculator = RFCNatural(naturalName : userInputData.naturalPersonName, naturalMothersName : userInputData.naturalPersonMothersName, naturalFathersName : userInputData.naturalPersonFathersName, naturalBirthDate : userInputData.juridicalOrNaturalPersonDateOfCreation)
            //filtra caracteres y abreviaturas
            rfcNaturalCalculator.filterNaturalPersonName()
            //filtra solo las primeiras palabras del apellido materno y paterno
            rfcNaturalCalculator.filterOnlyFirstSurname()
            //adiciona el nombre
            rfcNaturalCalculator.addFullNameToKey()
            //remove acentos de la clave rfc
            rfcNaturalCalculator.removeAccentFromNaturalKey()
            //filtra palabras inapropriadas de la clave hasta ahora, como CULO = CULX
            rfcNaturalCalculator.filterInappropriateWords()
            //añadir la fecha de nacimiento
            rfcNaturalCalculator.rfcRuleDate()
            //filtrar acentos del nombre para calcular los digitos homonimos y verificador
            rfcNaturalCalculator.filterAccentFromName()
            //calcular digito homonimo
            rfcNaturalCalculator.calculateHomonymyKey()
            //calcular digito verificador
            rfcNaturalCalculator.calculateVerifyingDigit()
            //añadir los - para formatar
            var index = rfcNaturalCalculator.naturalPersonKey.index(rfcNaturalCalculator.naturalPersonKey.startIndex, offsetBy: 4)
            rfcNaturalCalculator.naturalPersonKey.insert("-",at:index)
            index = rfcNaturalCalculator.naturalPersonKey.index(rfcNaturalCalculator.naturalPersonKey.startIndex, offsetBy: 11)
            rfcNaturalCalculator.naturalPersonKey.insert("-",at:index)
            index = rfcNaturalCalculator.naturalPersonKey.index(rfcNaturalCalculator.naturalPersonKey.startIndex, offsetBy: 14)
            rfcNaturalCalculator.naturalPersonKey.insert("-",at:index)
            //presentar la salida al usuario
            print("")
            print("--------------------------------------------------------------------------")
            print(rfcNaturalCalculator.originalNaturalPersonName + " " + rfcNaturalCalculator.originalNaturalPersonFathersName + " " + rfcNaturalCalculator.originalNaturalPersonMothersName)
            print("RFC Asignado:")
            print(rfcNaturalCalculator.naturalPersonKey)
            print("--------------------------------------------------------------------------")
        }
    }
}

//
//  RFC.swift
//  Practica_0_Ricardo_v1
//
//  Created by Morello Santos Ricardo on 9/19/19.
//  Copyright © 2019 Morello Santos Ricardo. All rights reserved.
//


//clase para manipular la entrada y salida de los datos del usuario
import Foundation
class UserInput{
    //variables para almacenar el nombre y fecha de nacimiento del usuario caso sea fisico
    var naturalPersonName : String = ""
    var naturalPersonMothersName : String = ""
    var naturalPersonFathersName : String = ""
    var naturalPersonDateOfBirth : String = ""
    //variables para almacenar el nombre y fecha de creacion de la empresa caso sea moral
    var juridicalPersonName : String = ""
    var juridicalOrNaturalPersonDateOfCreation : String = ""
    //arreglo de caracteres especiales que no pueden constar en el nombre de la persona fisica o moral
    var characteresEspeciales = ["!","$","%","&","/","(",")","=","+","[","]","{","}",">","<","*","–","^","º","ª","\\","·","´","`"]
    //variable para almacenar m caso sea moral y f caso sea fisica
    var juridicalOrNaturalPerson : String = ""
    //funcion para recibir entrada del usuario
    func getInputFromUser() -> String{
        let keyboard = FileHandle.standardInput
        let inputData = keyboard.availableData
        let inputDataToString = String(data: inputData, encoding: String.Encoding.utf8)!
        return inputDataToString.trimmingCharacters(in: CharacterSet.newlines)
    }
    //presenta forma de uso del programa
    func presentInformationAboutProgram(){
        print("Este programa genera el Registro Federal de Contribuyentes para personas físicas y morales.")
        print("Caso sea una persona fisica, será solicitado su nombre, apellido paterno y materno y fecha de nacimiento. Caso sea una persona moral, será solicitado el nombre de la persona moral y fecha de creación.")
    }
    //verificar se usuario es moral o fisico
    //opciones ademas de m y f no son aceitas
    func getUserType(){
        var validateInput = false
        repeat{
            print("¿Eres una persona moral o física?")
            print("m = persona moral")
            print("f = persona física")
            juridicalOrNaturalPerson = getInputFromUser()
            validateInput = (juridicalOrNaturalPerson == "m" || juridicalOrNaturalPerson == "f")
        }while !validateInput
    }
    //funcion para almacenar el nombre y apellido del usuario
    func getNameAndSurnameFromNaturalUser(){
        //variables para verificar si el nombre es valido o no
        var blankName = false
        var invalidFathersName = false
        var invalidMothersName = false
        //va a capturar el nombre del usuario mientras no estea vacio y tenga caracteres especiales
        repeat{
            print("Entre con tu nombre: ")
            naturalPersonName = getInputFromUser()
            blankName = (naturalPersonName == "")
            for character in naturalPersonName{
                if characteresEspeciales.contains(String(character)){
                    print("No se puede tener el caracter \(character) en el nombre.")
                    blankName = true
                }
            }
            
        }while blankName
        //va a capturar el appelido mientras tenga caracteres especiales caso no estea vacio
        repeat{
            print("Entre con tu apellido paterno (presione enter si no tienes uno): ")
            naturalPersonFathersName = getInputFromUser()
            if !naturalPersonFathersName.isEmpty{
                for character in naturalPersonFathersName{
                    if characteresEspeciales.contains(String(character)){
                        print("No se puede tener el caracter \(character) en el nombre.")
                        invalidFathersName = true
                        naturalPersonFathersName = ""
                    }else{
                        invalidFathersName = false
                    }
                }
            }else{
                invalidFathersName = false
            }
        }while invalidFathersName
        
        repeat{
            print("Entre con tu apellido materno (presione enter si no tienes uno):")
            naturalPersonMothersName = getInputFromUser()
            if !naturalPersonMothersName.isEmpty{
                for character in naturalPersonMothersName{
                    if characteresEspeciales.contains(String(character)){
                        print("No se puede tener el caracter \(character) en el nombre.")
                        naturalPersonMothersName = ""
                        invalidMothersName = true
                    }else{
                        invalidMothersName = false
                    }
                }
            }else{
                invalidMothersName = false
            }
        }while invalidMothersName
    
    }
    //va a capturar el nombre de la persona moral mientras no estea vacia y tenga caracteres especiales
    func getNameFromJuridicalUser(){
        var blankName = false
        repeat{
            print("Entre con tu nombre moral: ")
            juridicalPersonName = getInputFromUser()
            blankName = (juridicalPersonName == "")
            for character in juridicalPersonName{
                if characteresEspeciales.contains(String(character)){
                    print("No se puede tener el caracter \(character) en el nombre.")
                    blankName = true
                }
            }
        }while blankName
    }
    //captura la fecha de creacion y nacimiento de la persona
    func getCreationOrBirthDate(_ option : Int){
        var blankDate = false
        repeat{
            if option == 0{
                print("Entre con la fecha de creación de la empresa (formato DD:MM:YYYY): ")
            }else if option == 1{
                print("Entre con la fecha de nacimiento de la persona fisica (formato DD:MM:YYYY): ")
            }
            juridicalOrNaturalPersonDateOfCreation = getInputFromUser()
            blankDate = (juridicalOrNaturalPersonDateOfCreation == "")
        }while blankDate || !validateCreationDate()
        
    }
    //valida la fecha de creacion o nacimiento
    //caso sea persona fisica, valida si tiene mas de 18 años
    //tambien, valida si la fecha insertada es maior que hoy
    func validateCreationDate() -> Bool{
        var validDate = false
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd:MM:yyyy"
        let date = dateFormatter.date(from: juridicalOrNaturalPersonDateOfCreation)
        if date != nil {
            validDate = true
        } else {
            validDate = false
            print("Fecha invalida!")
            return validDate
        }
        if date! > Date(){
            validDate = false
            print("La fecha no puede ser superior al dia de hoy!")
        }
        if juridicalOrNaturalPerson == "f"{
            let calendar = Calendar.current
            let today = Date()
            let components = calendar.dateComponents([.year, .month, .day], from: date!, to: today)
            let ageYears = components.year!
            if ageYears < 18{
                print("La persona física debe tener más de 18 años!")
                validDate = false
            }
        }
        return validDate
    }
}

//
//  FormViewModel.swift
//  MuseumApp
//
//  Created by Antonio Hernández Barbadilla on 3/6/25.
//

import SwiftUI
import SwiftData

@Observable
final class CardsViewModel {
    var kindMemershipSelected = "Adult"
    var username = ""
    var email = ""
    
    let context = CIContext()  // Contexto necesario para convertir el filtro QR en imagen
    
    var isFormValid: Bool {
        !username.isEmpty && !email.isEmpty && isValidEmail(email)
    }
    
    let kindMemership = MembershipType.allCases.map(\.rawValue)
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        return email.range(of: emailRegex, options: .regularExpression) != nil
    }
    
    private func resetForm() {
        username = ""
        email = ""
    }
    
    // MARK: Generar contenido QR
    
    private func generateQRContent() -> String {// Convierte los datos del formulario en un JSON String para codificar en el QR
        
        let data = [
            "username": username,
            "email": email,
            "membership": kindMemershipSelected
        ]
        
        // Convertimos el diccionario a JSON
        if let jsonData = try? JSONSerialization.data(withJSONObject: data),
           let jsonString = String(data: jsonData, encoding: .utf8) {
            return jsonString
        }
        return "Ivalid QR"
    }
}

extension CardsViewModel {
    func saveToDatabase(context: ModelContext) {
        let type = MembershipType(rawValue: kindMemershipSelected) ?? .adult
        let qrData = generateQRData()

        let newCard = MembershipCardDB(
            name: username,
            email: email,
            membership: type,
            qrCode: qrData
        )
        context.insert(newCard)
        resetForm()
    }

    private func generateQRData() -> Data {
        let string = generateQRContent()
        guard let data = string.data(using: .utf8) else {
            print("Error al convertir el string a Data")
            return Data()
        }
        let filter = CIFilter.qrCodeGenerator()
        filter.setValue(data, forKey: "inputMessage")
        filter.setValue("H", forKey: "inputCorrectionLevel")

        let context = CIContext()
        if let outputImage = filter.outputImage,
           let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
            let uiImage = UIImage(cgImage: cgImage)
            return uiImage.pngData() ?? Data()
        }
        return Data()
    }
}

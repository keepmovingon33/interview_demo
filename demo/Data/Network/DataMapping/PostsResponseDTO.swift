//
//  PostsResponseDTO.swift
//  demo
//
//  Created by Sky on 09/12/2021.
//

import Foundation

// MARK: - Demo Transfer Object
struct DemoResponseDTO: Decodable {
    let listings: [PostsResponseDTO]
}

struct PostsResponseDTO: Decodable {
    let listingStatus: String?
    
    let images: Images
    
    let year: Int
    let make: String
    let model: String
    let trim: String
    
    let currentPrice: Double
    let mileage: Double
    let dealer: Dealer
    
    let badge: String?
    let accidentHistory: AccidentHistory?
    let personalUse: Bool
    let ownerHistory: OwnerHistory
    let serviceHistory: ServiceHistory
    
    struct Images: Decodable {
        let firstPhoto: Photo
        
        struct Photo: Decodable {
            let large: String
        }
    }
    
    struct Dealer: Decodable {
        let city: String
        let state: String
        let phone: String
    }
    
    struct AccidentHistory: Decodable {
        let text: String
    }
    
    struct OwnerHistory: Decodable {
        var history: [History] = []
        
        struct History: Decodable {
            let ownerNumber: Int
        }
    }
    
    struct ServiceHistory: Decodable {
        let text: String
        let number: Int
    }
}

// MARK: - Mappings to Domain

extension DemoResponseDTO {
    func toDomain() -> CarList {
        return .init(listings: listings.map { $0.toDomain() })
    }
}

extension PostsResponseDTO {
    func toDomain() -> Car {
        return .init(status: listingStatus,
                     photo: images.firstPhoto.large,
                     title: title,
                     subTitle: subTitle,
                     badge: badge ?? "N/A",
                     accidentStatus: accidentHistory?.text ?? "N/A",
                     personalUse: personalUse,
                     ownerNumberText: ownerNumberText,
                     serviceHistoryText: serviceHistoryText,
                     dealerPhone: getDealerPhone())
    }
    
    var title: String {
        return "\(year) \(make) \(model) \(trim)"
    }
    
    var subTitle: String {
        return "$\(currentPrice) | \(milageValue) | \(dealer.city), \(dealer.state)"
    }
    
    var milageValue: String {
        if mileage < 1000 {
            return "\(mileage) mil"
        }
        return "\(mileage/1000.rounded())K mil"
    }
    
    var ownerNumberText: String {
        return "\(ownerHistory.history.count)-Owner"
    }
    
    var serviceHistoryText: String {
        return "\(serviceHistory.number) \(serviceHistory.text)"
    }
    
    func getDealerPhone() -> String {
        if let formatted = format(phoneNumber: dealer.phone) {
            return formatted
        } else {
            return dealer.phone
        }
    }
}

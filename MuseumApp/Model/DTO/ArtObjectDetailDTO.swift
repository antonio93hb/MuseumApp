//
//  ArtObjectDTO.swift
//  MuseumApp
//
//  Created by Antonio Hernández Barbadilla on 27/5/25.
//

import Foundation

struct ArtObjectDetailDTO: Codable {
    let objectID: Int
    let isHighlight: Bool
    let accessionNumber: String
    let accessionYear: String
    let isPublicDomain: Bool
    let primaryImage: String
    let primaryImageSmall: String
    let additionalImages: [String]
    // constituents: [Constituent]?
    let department: String
    let objectName: String
    let title: String
    let culture: String
    let period: String
    let dynasty: String
    let reign: String
    let portfolio: String
    let artistRole: String
    let artistPrefix: String
    let artistDisplayName: String
    let artistDisplayBio: String
    let artistSuffix: String
    let artistAlphaSort: String
    let artistNationality: String
    let artistBeginDate: String
    let artistEndDate: String
    let artistGender: String
    let artistWikidataURL: String
    let artistULANURL: String
    let objectDate: String
    let objectBeginDate: Int
    let objectEndDate: Int
    let medium: String
    let dimensions: String
    //let measurements: [Measurement]?
    let creditLine: String
    let geographyType: String
    let city: String
    let state: String
    let county: String
    let country: String
    let region: String
    let subregion: String
    let locale: String
    let locus: String
    let excavation: String
    let river: String
    let classification: String
    let rightsAndReproduction: String
    let linkResource: String
    let metadataDate: String
    let repository: String
    let objectURL: String
    let tags: [Tag]?
    let objectWikidataURL: String
    let isTimelineWork: Bool
    let galleryNumber: String
    
    enum CodingKeys: String, CodingKey {
        case objectID, isHighlight, accessionNumber, accessionYear,
            isPublicDomain
        case primaryImage, primaryImageSmall, additionalImages,
            department
        case objectName, title, culture, period, dynasty, reign, portfolio
        case artistRole, artistPrefix, artistDisplayName, artistDisplayBio,
            artistSuffix
        case artistAlphaSort, artistNationality, artistBeginDate, artistEndDate,
            artistGender
        case artistWikidataURL = "artistWikidata_URL"
        case artistULANURL = "artistULAN_URL"
        case objectDate, objectBeginDate, objectEndDate, medium, dimensions
        case creditLine, geographyType, city, state, county, country, region,
            subregion
        case locale, locus, excavation, river, classification,
            rightsAndReproduction
        case linkResource, metadataDate, repository
        case objectURL = "objectURL"
        case tags
        case objectWikidataURL = "objectWikidata_URL"
        case isTimelineWork
        case galleryNumber = "GalleryNumber"
    }
}

extension ArtObjectDetailDTO {
    var toArtObjectModel: ArtObjectModel {
        ArtObjectModel(
            id: objectID,
            title: title,
            artist: artistDisplayName,
            date: objectDate ,
            imageUrl: primaryImageSmall,
            department: department,
            culture: culture,
            medium: medium,
            dimensions: dimensions,
            objectUrl: objectURL
        )
    }
}

// MARK: - Constituent
struct Constituent: Codable {
    let constituentID: Int
    let role: String
    let name: String
    let constituentULANURL: URL
    let constituentWikidataURL: URL
    let gender: String

    enum CodingKeys: String, CodingKey {
        case constituentID, role, name, gender
        case constituentULANURL = "constituentULAN_URL"
        case constituentWikidataURL = "constituentWikidata_URL"
    }
}

// MARK: - Measurement
struct Measurement: Codable {
    let elementName: String
    let elementDescription: String?
    let elementMeasurements: ElementMeasurements?
}

// MARK: - ElementMeasurements
struct ElementMeasurements: Codable {
    let height: Double
    let width: Double

    enum CodingKeys: String, CodingKey {
        case height = "Height"
        case width = "Width"
    }
}

// MARK: - Tag
struct Tag: Codable {
    let term: String
    let aatURL: URL
    let wikidataURL: URL

    enum CodingKeys: String, CodingKey {
        case term
        case aatURL = "AAT_URL"
        case wikidataURL = "Wikidata_URL"
    }
}

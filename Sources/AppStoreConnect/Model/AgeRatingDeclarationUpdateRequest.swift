//
//  AgeRatingDeclarationUpdateRequest.swift
//  AppStoreConnect
//
//  Created by Waqar Malik on 1/26/22.
//

import Foundation

public struct AgeRatingDeclarationUpdateRequest: Codable {
    public var alcoholTobaccoOrDrugUseOrReferences: String
    public var contests: String
    public var gambling: Bool
    public var gamblingSimulated: String
    public var kidsAgeBand: KidsAgeBand
    public var medicalOrTreatmentInformation: String
    public var profanityOrCrudeHumor: String
    public var sexualContentGraphicAndNudity: String
    public var sexualContentOrNudity: String
    public var seventeenPlus: Bool
    public var horrorOrFearThemes: String
    public var matureOrSuggestiveThemes: String
    public var unrestrictedWebAccess: Bool
    public var violenceCartoonOrFantasy: String
    public var violenceRealisticProlongedGraphicOrSadistic: String
    public var violenceRealistic: String
}

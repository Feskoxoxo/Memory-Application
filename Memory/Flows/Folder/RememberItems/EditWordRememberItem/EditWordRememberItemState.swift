//
//  EditWordRememberItemState.swift
//  Memory
//

import Foundation
import PhotosUI
import SwiftUI

struct EditWordRememberItemState {
    struct RememberItemRequest {
        let id: Int
    }

    var categoriesIds: [Int]
    var word: String = ""
    var translation: String = ""
    var transcription: String = ""
    var images: [ImageType] = []
    var isLearning: Bool = true
    var examples: [WordExampleModel] = []

    var rememberItem: RememberCardItemModel?

    var fetchRequest: FeedbackRequest<RememberItemRequest>?

    var updateRequest: FeedbackRequest<UpdateRememberItemModel>?
    var createRequest: FeedbackRequest<NewRememberItemModel>?

    var routingRequest: RoutingFeedbackRequest<EditWordRememberItemRouterProtocol, EditWordRememberItemEvent>?
}

extension EditWordRememberItemState: RoutingStateProtocol {}

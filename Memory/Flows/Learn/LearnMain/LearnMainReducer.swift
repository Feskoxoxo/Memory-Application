//
//  LearnMainReducer.swift
//  Memory
//

struct LearnMainReducer {
    func reduce(state: inout LearnMainState, event: LearnMainEvent) {
        switch event {
        case let .folderSelected(id):
            onFolderSelected(id: id, state: &state)
        case .showAllFolders:
            onShowAllFolders(state: &state)
        case let .favoriteFoldersFetched(result):
            onFavoriteFoldersFetched(result: result, state: &state)
        case .refresh:
            onRefresh(state: &state)
        case .onAppear:
            onAppear(state: &state)
        case let .foldersExist(result):
            onFoldersExist(result: result, state: &state)
        case let .learnNewItems(folderId):
            onLearnNewCardsTapped(folderId: folderId, state: &state)
        case let .reviewItems(folderId):
            onReviewCardsTapped(folderId: folderId, state: &state)
        }
    }
}

// MARK: - Event handlers

private extension LearnMainReducer {
    func onAppear(state: inout LearnMainState) {
        state.foldersExistsRequest = FeedbackRequest()
        state.fetchFavoriteFoldersRequest = FeedbackRequest()
    }

    func onLearnNewCardsTapped(folderId: Int, state: inout LearnMainState) {
        state.requestRoute {
            $0.learnFolder(id: folderId)
        }
    }

    func onReviewCardsTapped(folderId: Int, state: inout LearnMainState) {
        state.requestRoute {
            $0.reviewFolder(id: folderId)
        }
    }

    func onFolderSelected(id: Int, state: inout LearnMainState) {
        state.requestRoute {
            $0.selectLearnMode(for: id)
        }
    }

    func onShowAllFolders(state: inout LearnMainState) {
        state.requestRoute {
            $0.allFolders()
        }
    }

    func onRefresh(state: inout LearnMainState) {
        state.fetchFavoriteFoldersRequest = FeedbackRequest()
        state.foldersExistsRequest = FeedbackRequest()
    }

    func onFavoriteFoldersFetched(result: Result<[LearnMainState.FavoriteFolderModel], Error>, state: inout LearnMainState) {
        state.fetchFavoriteFoldersRequest = nil

        switch result {
        case let .success(folders):
            state.favoriteFolders = folders
        case .failure:
            state.favoriteFolders = []
        }
    }

    func onFoldersExist(result: Result<Bool, Error>, state: inout LearnMainState) {
        state.foldersExistsRequest = nil

        switch result {
        case let .success(value):
            state.foldersExists = value
        case .failure:
            state.foldersExists = false
        }
    }
}

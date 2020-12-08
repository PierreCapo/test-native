import Resolver

class MatchStatsPresenter {
    @Injected var interactor: MatchStatsInteractor
    
    lazy var sections = interactor.getMatchStatSections()
    
}

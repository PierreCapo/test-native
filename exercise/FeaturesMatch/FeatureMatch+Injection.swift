import Resolver

extension Resolver {
    public static func registerFeatureMatch() {
        registerMatchStats()
    }
    
    public static func registerMatchStats() {
        register { MatchStatsViewController() }.scope(shared)
        register { MatchStatsPresenter() }.scope(shared)
        register { MatchStatsInteractor() }.scope(shared)
        register { MatchStatsRouter() }.scope(shared)
    }
}

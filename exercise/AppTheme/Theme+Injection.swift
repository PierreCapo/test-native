import Resolver

extension Resolver {
    public static func registerTheme() {
        register { ChampionsLeagueTheme() as CompetitionTheme }.scope(shared)
    }
}

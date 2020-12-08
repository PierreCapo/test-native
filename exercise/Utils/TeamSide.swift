import Resolver

enum TeamSide {
    case homeTeam
    case awayTeam
    
    var teamColor: UIColor {
        let appTheme = Resolver.resolve(CompetitionTheme.self)
        switch self {
        case .homeTeam:
            return appTheme.homeTeamColor
        case .awayTeam:
            return appTheme.awayTeamColor
        }
    }
}

import UIKit

struct Team: Equatable {
    var name: String
    var badgeName: String
}

enum StageKind {
    case group
    case round
}

struct Stage {
    var kind: StageKind
    var group: String?
    var round: String?
    
    var displayName: String {
        switch self.kind {
        case .group:
            guard let group = group else { return "Group stage"}
            return "Group \(group)"
        case .round:
            guard let round = round else { return "Round stage"}
            return "Round \(round)"
        }
    }
}

enum MatchEventKind {
    case goal
}

struct MatchEvent {
    var team: Team
    var kind: MatchEventKind
    var time: String
}

struct Match {
    var homeTeam: Team
    var awayTeam: Team
    var events: [MatchEvent]
    var stage: Stage
    var stats: [MatchStat]
    
    var homeTeamScore: Int {
        events
            .filter { event in event.kind == .goal }
            .filter { event in event.team == homeTeam }
            .count
    }
    
    var awayTeamScore: Int {
        events
            .filter { event in event.kind == .goal }
            .filter { event in event.team == awayTeam }
            .count
    }
}

protocol MatchStat {
    var category: String { get }
    var title: String { get }
    var homeTeamValue: Float { get }
    var awayTeamValue: Float { get }
}

struct LinearMatchStat: MatchStat {
    var category: String
    var title: String
    var homeTeamValue: Float
    var awayTeamValue: Float
}

struct SharedPercentageMatchStat: MatchStat {
    var category: String
    var title: String
    var homeTeamValue: Float
    var awayTeamValue: Float
}

struct DistinctPercentageMatchStat: MatchStat {
    var category: String
    var title: String
    var homeTeamValue: Float
    var awayTeamValue: Float
}


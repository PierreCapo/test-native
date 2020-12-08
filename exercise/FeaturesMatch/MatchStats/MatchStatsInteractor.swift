import UIKit

struct MatchStatScreenSection {
    var name: String
    var isCollapsed: Bool = false
    var matchStats: [MatchStat]
}

class MatchStatsInteractor {
    private func getMatch() -> Match {
        // hardcoding the Match here
        // TODO: Plug it to a real remote API:
        let homeTeam = Team(name: "Juventus", badgeName: "JuventusBadge")
        let awayTeam = Team(name: "Barcelona", badgeName: "BarcelonaBadge")
        
        let events = [
            MatchEvent(team: homeTeam, kind: .goal, time: "14"),
            MatchEvent(team: homeTeam, kind: .goal, time: "36")
        ]
        
        let stage = Stage(kind: .group, group: "C", round: nil)
        let stats: [MatchStat] = [
            SharedPercentageMatchStat(category: "Key Stats", title: "Possession", homeTeamValue: 40, awayTeamValue: 60),
            LinearMatchStat(category: "Key Stats", title: "Attempts", homeTeamValue: 14, awayTeamValue: 8),
            LinearMatchStat(category: "Key Stats", title: "Corners", homeTeamValue: 4, awayTeamValue: 1),
            LinearMatchStat(category: "Key Stats", title: "Offsides", homeTeamValue: 0, awayTeamValue: 3),
            DistinctPercentageMatchStat(category: "Key Stats", title: "Passing Accuracy", homeTeamValue: 80, awayTeamValue: 83),
            LinearMatchStat(category: "Key Stats", title: "Passes completed", homeTeamValue: 619, awayTeamValue: 439),
            LinearMatchStat(category: "Key Stats", title: "Recovered balls", homeTeamValue: 29, awayTeamValue: 35),
            LinearMatchStat(category: "Key Stats", title: "Attempts blocked", homeTeamValue: 4, awayTeamValue: 3),
            LinearMatchStat(category: "Key Stats", title: "Saves", homeTeamValue: 0, awayTeamValue: 3),
            LinearMatchStat(category: "Key Stats", title: "Yellow cards", homeTeamValue: 1, awayTeamValue: 4),
            LinearMatchStat(category: "Key Stats", title: "Red cards", homeTeamValue: 0, awayTeamValue: 3),
            
            LinearMatchStat(category: "Attacking", title: "Penalties Scored", homeTeamValue: 1, awayTeamValue: 0),
            LinearMatchStat(category: "Attacking", title: "Big Chances", homeTeamValue: 2, awayTeamValue: 0),
            SharedPercentageMatchStat(category: "Attacking", title: "Attempts", homeTeamValue: 40, awayTeamValue: 60),
            DistinctPercentageMatchStat(category: "Distribution", title: "Passing accuracy", homeTeamValue: 80, awayTeamValue: 83),
            LinearMatchStat(category: "Distribution", title: "Short passes completed", homeTeamValue: 228, awayTeamValue: 133),
            LinearMatchStat(category: "Distribution", title: "Medium-length passes completed", homeTeamValue: 401, awayTeamValue: 309),
            LinearMatchStat(category: "Distribution", title: "Long passes completed", homeTeamValue: 32, awayTeamValue: 35),
            
        ]
        
        return Match(homeTeam: homeTeam, awayTeam: awayTeam, events: events, stage: stage, stats: stats)
    }
    
    func getMatchStatSections() -> [MatchStatScreenSection] {
        let sectionOrder = ["Key stats", "Attacking", "Distribution"]
        return self.getMatch().stats
            .groupBy { $0.category }
            .sorted { sectionOrder.firstIndex(of: $0.key) ?? 0 < sectionOrder.firstIndex(of: $1.key) ?? 0}
            .map { group in
                MatchStatScreenSection(name: group.key, isCollapsed: false, matchStats: group.elements)
            }
    }
}

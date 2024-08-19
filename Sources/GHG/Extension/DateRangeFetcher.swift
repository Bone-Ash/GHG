//
//  DateRangeFetcher.swift
//  GHG
//
//  Created by GH on 8/19/24.
//

import Foundation

public struct DateRangeFetcher {
    public private(set) var startTime: TimeInterval
    public private(set) var endTime: TimeInterval
    private let intervalType: TimeIntervalType
    
    public enum TimeIntervalType {
        case day
        case week
        case month
        
        public var timeInterval: TimeInterval {
            switch self {
            case .day:
                return 24 * 60 * 60
            case .week:
                return 7 * 24 * 60 * 60
            case .month:
                return 30 * 24 * 60 * 60
            }
        }
    }
    
    public init(intervalType: TimeIntervalType) {
        self.intervalType = intervalType
        let currentTime = Date().timeIntervalSince1970
        let calendar = Calendar.current
        
        // 计算当前时间的开始时间和结束时间
        let startOfPeriod = calendar.date(from: calendar.dateComponents([.year, .month, .day], from: Date()))?.timeIntervalSince1970 ?? currentTime
        self.startTime = currentTime
        self.endTime = startOfPeriod
    }
    
    public mutating func fetchNextPeriod() {
        let onePeriod: TimeInterval = intervalType.timeInterval
        
        endTime = Date(timeIntervalSince1970: endTime).addingTimeInterval(-onePeriod).timeIntervalSince1970
        startTime = endTime - intervalType.timeInterval
        
        print("Calculated Start Time: \(formatDate(from: startTime))")
        print("Calculated End Time: \(formatDate(from: endTime))")
    }
    
    private func formatDate(from timeInterval: TimeInterval) -> String {
        let date = Date(timeIntervalSince1970: timeInterval)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter.string(from: date)
    }
}

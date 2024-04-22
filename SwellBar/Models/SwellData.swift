import Foundation

struct SwellData: Codable {
    var waveHeight: Double?
    var wavePeriod: Int?
    var waveDirection: Int?
    var waterTemp: Double?

    enum CodingKeys: String, CodingKey {
        case waveHeight = "waveHeight"
        case wavePeriod = "wavePeriod"
        case waveDirection = "waveDirection"
        case waterTemp = "waterTemp"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        waveHeight = Self.decodeDouble(from: container, forKey: .waveHeight)
        wavePeriod = Self.decodeInt(from: container, forKey: .wavePeriod)
        waveDirection = Self.decodeInt(from: container, forKey: .waveDirection)
        waterTemp = Self.decodeDouble(from: container, forKey: .waterTemp)
    }

    private static func decodeDouble(from container: KeyedDecodingContainer<CodingKeys>, forKey key: CodingKeys) -> Double? {
        if let stringValue = try? container.decode(String.self, forKey: key), stringValue != "MM" {
            return Double(stringValue)
        }
        return nil
    }

    private static func decodeInt(from container: KeyedDecodingContainer<CodingKeys>, forKey key: CodingKeys) -> Int? {
        if let stringValue = try? container.decode(String.self, forKey: key), stringValue != "MM" {
            return Int(stringValue)
        }
        return nil
    }
}

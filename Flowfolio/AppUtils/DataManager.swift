//
//  DataManager.swift
//  Flowfolio
//
//  Created by Yasir on 26/02/23.
//

import Foundation

public class DataManager {
    static let shared: DataManager = DataManager()
    
    var editionsData: [EditionData]?
    var seriesData: [SeriesData]?
    var playsData: [PlayData]? {
        didSet {
            getAllPlayDatas()
        }
    }
    var playDataIds: [Int: [String:String]?] = [:]
    var setsData: [String]?
    var setNames: [String]? {
        didSet {
            setNames?.forEach({self.getSetDataByName($0)})
        }
    }
    var playerData: [PlayerData]?
    
    func getLaLigaGolazosData(){
        getData()
        getAllEditionsData()
        getAllSeriesData()
        getAllPlaysData()
        getAllSetsData()
        getAllSetNames()
    }
    
    func getAllEditionsData() {
        Task {
            do {
                editionsData = try await FlowManager.shared.fetchAllEditions()
            } catch {
                print("*** Debug Error: fetchAllEditions ***")
                //print(error)
            }
        }
    }
    
    func getAllSeriesData() {
        Task {
            do {
                seriesData = try await FlowManager.shared.fetchAllSeries()
            } catch {
                print("*** Debug Error: fetchAllSeries ***")
                //print(error)
            }
        }
    }
    
    func getAllPlaysData() {
        Task {
            do {
                playsData = try await FlowManager.shared.fetchAllPlays()
            } catch {
                print("*** Debug Error: fetchAllPlays ***")
                //print(error)
            }
        }
    }
    
    func getAllSetsData() {
        Task {
            do {
                setsData = try await FlowManager.shared.fetchAllSets()
            } catch {
                print("*** Debug Error: fetchAllSets ***")
                //print(error)
            }
        }
    }
    
    func invoke() {
        
    }
    
    func getAllSetNames() {
        Task {
            do {
                setNames = try await FlowManager.shared.fetchAllSetNames()
            } catch {
                print("*** Debug Error: fetchAllSetNames ***")
                //print(error)
            }
        }
    }
    
    func getSetDataByName(_ name: String) {
        Task {
            do {
                let setData = try await FlowManager.shared.fetchSetDataByName(name)
                setsData?.append(setData)
            } catch {
                print("*** Debug Error: fetchSetData ***")
                //print(error)
            }
        }
    }
    
    func getAllPlayDatas() {
        if let playsData = playsData {
            for playData in playsData {
                getPlayDataBy(id: playData.id)
            }
        }
    }
    
    func getPlayDataBy(id: Int) {
        Task {
            do {
                let playDataId = try await FlowManager.shared.fetchPlayDataById(id)
                print(playDataId!.keys)
                playDataIds[id] =  playDataId
            } catch {
                print("*** Debug Error: fetchPlayDataById ***")
                //print(error)
            }
        }
    }
    
    func getData() {
        if let url = URL(string: "https://retoolapi.dev/RQX3sK/players") {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    do {
                        let result = try JSONDecoder().decode([PlayerData].self, from: data)
                        self.playerData = result
                    } catch let error {
                        print(error)
                    }
                }
            }.resume()
        }
    }
    
    func getEditions() -> [EditionData]? {
        var result: [EditionData] = []
        if let editionsData = editionsData, let playerData = playerData {
            let editionsIds: [Int] = playerData.reduce([Int](), { res, item in
                var arr = res
                if let i = item.Link.lastIndex(of: "/") {
                    var substr = item.Link.suffix(from: i)
                    substr.remove(at: substr.startIndex)
                    arr.append(Int(substr)!)
                }
                return arr
            })
            for id in editionsIds {
                result.append(editionsData.filter({$0.id == id})[0])
            }
        }
        return result
    }
}

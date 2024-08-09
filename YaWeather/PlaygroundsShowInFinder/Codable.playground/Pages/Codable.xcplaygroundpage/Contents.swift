import Foundation

// Протокол Codable в Swift представляет собой объединение двух других протоколов: Encodable и Decodable. Codable позволяет типу данных быть кодируемым (Encodable) и декодируемым (Decodable), что обеспечивает простой способ сериализации и десериализации данных в формат JSON, Plist и другие форматы.
//Когда вы объявляете структуру или класс в Swift и хотите, чтобы они могли быть преобразованы в JSON (или другой формат) и обратно, вы можете применить протокол Codable. Для этого необходимо, чтобы все свойства вашей структуры или класса также были Codable.


struct Planet: Codable {
    let name: String
    let rotation_period: String
    let climate: String
    let terrain: String
    let population: String
}

let urls = [
    URL(string: "https://swapi.dev/api/planets/3/?format=json")!,
    URL(string: "https://swapi.dev/api/planets/34/?format=json")!,
    URL(string: "https://swapi.dev/api/planets/1/?format=json")!,
    URL(string: "https://swapi.dev/api/planets/2/?format=json")!,
    URL(string: "https://swapi.dev/api/planets/4/?format=json")!,
    URL(string: "https://swapi.dev/api/planets/5/?format=json")!,
    URL(string: "https://swapi.dev/api/planets/7/?format=json")!,
    URL(string: "https://swapi.dev/api/planets/17/?format=json")!,
    URL(string: "https://swapi.dev/api/planets/27/?format=json")!,
    URL(string: "https://swapi.dev/api/planets/37/?format=json")!,
    URL(string: "https://swapi.dev/api/planets/12/?format=json")!,
    URL(string: "https://swapi.dev/api/planets/11/?format=json")!,
    URL(string: "https://swapi.dev/api/planets/10/?format=json")!,
    URL(string: "https://swapi.dev/api/planets/13/?format=json")!,
    URL(string: "https://swapi.dev/api/planets/16/?format=json")!,
]


func fetchData() {
    for url in urls {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let planet = try JSONDecoder().decode(Planet.self, from: data)
                    print("")
                    print("Planet: \(planet.name)")
                    print("Rotation period is \(planet.rotation_period) hours")
                    print("Climate is \(planet.climate)")
                    print("Population: \(planet.population) residents")
                    print("Planet surface is \(planet.terrain)")
                    print("")
                    print("------------------==================------------------")
                } catch {
                    print("Ошибка при декодировании JSON для URL \(url.absoluteString): \(error)")
                }
            }
        }.resume()
    }
}

fetchData()



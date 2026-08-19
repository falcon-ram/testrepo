// Concurrency

//func fetchUsername() async -> String {
//    // await tells swift: pause here but don't
//    // block the thread
//    // Other code can run while we wait for this to finish
//    try? await Task.sleep(for: .seconds(1)) // simulate network delay
//    return "Bobby van Ram"
//}

// To call an async function you must use await
// This only works inside another async context
//func loadProfile() async {
//    let name = await fetchUsername() // pause here until fetchUsername finishes
//    print("Welcome, \(name)") // then continue from here
//}

// updated fetchUsername using throw as well as async
enum NetworkError: Error {
    case serverDown
    case badData
}

func fetchUsername() async throws -> String {
    // await tells swift: pause here but don't
    // block the thread
    // Other code can run while we wait for this to finish
    try await Task.sleep(for: .seconds(1)) // simulate network delay, try the potential faliure
    return "Bobby van Ram"
}
// Calling async throws function: try and await - both keywords together
func loadData() async {
    do {
        let data = try await fetchUsername()
        print(data)
    } catch {
        print("Something went wrong \(error)")
    }
}
Task {
    await loadData()
}

func saveData() async {
    try? await Task.sleep(for: .milliseconds(500))
    print("Data Saved")
}
Task {
    await saveData()
    print("Hello World")
}

enum WeatherError: Error {
    case unknown
}

func fetchWaeather(for city: String) async throws -> String {
    guard city == "Singapore" else { throw WeatherError.unknown }
    try? await Task.sleep(for: .milliseconds(500))
    return "Raining 22°C"
}

Task {
    do
    {
        let weather = try await fetchWaeather(for: "Bangkok")
        print(weather)
    } catch {
        print("Something went wrong \(error)")
    }
}

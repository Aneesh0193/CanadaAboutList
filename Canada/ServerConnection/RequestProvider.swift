
import Foundation

struct ResponseError: Codable {
    var message: String
    var responseCode: String?
    
    private enum CodingKeys: String, CodingKey {
        case message
        case responseCode
    }
}

struct requestProvider {

    static func getURLRequestWithoutToken(requestUrl: URL,forRequest method: HTTPRequestMethod,requestBody: Data) -> URLRequest?{
        var urlRequest = URLRequest.init(url: requestUrl, timeoutInterval: appTimeoutInterval)
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpMethod = HTTPRequestMethod.POST.rawValue
        urlRequest.httpBody = requestBody
        
        return urlRequest
    }
}

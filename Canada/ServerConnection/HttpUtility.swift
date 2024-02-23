 
import Foundation
 


protocol APIServiceProtocol {
    func getAPIData<T:Decodable>(requestUrl: URL, resultType: T.Type, completionHandler:@escaping(ServiceCallback))
}
 
struct HttpUtility: APIServiceProtocol {
    
    func getAPIData<T:Decodable>(requestUrl: URL, resultType: T.Type, completionHandler: @escaping(ServiceCallback)) {
        
        var urlRequest = URLRequest.init(url: requestUrl, timeoutInterval: appTimeoutInterval)
        urlRequest.httpMethod = HTTPRequestMethod.GET.rawValue
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        
        session.dataTask(with: urlRequest) { (data, response, error) in
            guard let resp = response as? HTTPURLResponse else{
                return completionHandler (false,nil,.InvalidResponse(invalidResponse: error?.localizedDescription ?? "Empty response"))
            } 
            guard let data = data else {
                return completionHandler (false,nil,.InvalidResponse(invalidResponse: error?.localizedDescription ?? "Empty response data"))
            }
            
            let decoder = JSONDecoder()
            if resp.statusCode == ResponseStatus.success.rawValue {
                do {
                    let repositoryResponse = try decoder.decode(T.self, from: data)
                    completionHandler (true,repositoryResponse,nil)
                }
                catch {
                    return completionHandler (false,response,.DecodeError (decodeError: error.localizedDescription))
                }
            }else{
                do {
                    let apiError = try decoder.decode(ResponseError.self, from: data)
                    //Option 2: OR in all such cases we can use error message which is directly received in server response and provide an option value if "message" value is also null in server response
                    //TestCase 2: Invalid Username and PAssword -> receives responseCode from server -> so at this case app can map message to response code -> currently shown message received as it is.
                    return completionHandler (false,response,.InvalidResponse(invalidResponse: apiError.message))
                    
                }catch {
                    return completionHandler (false,response,.DecodeError (decodeError: error.localizedDescription))
                }
            }
        }.resume()
    }
}
    

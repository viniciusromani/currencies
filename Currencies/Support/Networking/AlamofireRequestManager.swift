import Alamofire

typealias RequestManagerCompletion<T> = (T?, Error?, HTTPURLResponse?) -> Void

class AlamofireRequestManager {
    
    private struct CustomURLEncoding: ParameterEncoding {
        func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
            var request = try URLEncoding().encode(urlRequest, with: parameters)
            if let absoluteString = request.url?.absoluteString {
                let replaced = absoluteString.replacingOccurrences(of: "%5B%5D", with: "=")
                request.url = URL(string: replaced)
            }
            return request
        }
    }
    
    func request(_ method: HTTPMethod,
                 from url: URL,
                 parameters: [String: Any]? = nil,
                 headers: [String: String]? = nil,
                 completion: @escaping RequestManagerCompletion<Any>) {
        
        let encoding: ParameterEncoding = method == .get ? CustomURLEncoding(): JSONEncoding.default
        
        let request = Alamofire.SessionManager.default.request(url,
                                                               method: method,
                                                               parameters: parameters,
                                                               encoding: encoding,
                                                               headers: headers)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    completion(value, nil, response.response)
                case .failure(let error):
                    completion(nil, error, response.response)
                }
        }
        
        request.resume()
    }
}

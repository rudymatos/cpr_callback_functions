import Vapor

public func routes(_ router: Router) throws {
    
    router.get("cpr-callback-functions/callback/twitter"){ request -> Response in
        print("Entering to twitter callback with params: \(request.query)")
        guard let oauthToken = try? request.query.get(String.self, at: "oauth_token"), let oauthVerifier = try? request.query.get(String.self, at: "oauth_verifier") else {
            print("redirecting to CPRMobileApp://oauth-swift/twitter")
            return request.redirect(to: "CPRMobileApp://oauth-swift/twitter")
        }
        let queryString = "oauth_token=\(oauthToken)&oauth_verifier=\(oauthVerifier)"
        print("redirecting to CPRMobileApp://oauth-swift/twitter?\(queryString)")
        return request.redirect(to: "CPRMobileApp://oauth-swift/twitter?\(queryString)")
    }
    
    router.get("cpr-callback-functions/callback/pinterest"){ request -> Response in
        print("Entering to pinterest callback with params: \(request.http.url.query)")
        guard let queryString = request.http.url.query?.replacingOccurrences(of: "state,", with: "state=").replacingOccurrences(of: "code,", with: "code="),
            queryString.split(separator:"&").count >= 2 else {
                print("redirecting to CPRMobileApp://oauth-swift/pinterest")
            return request.redirect(to: "CPRMobileApp://oauth-swift/pinterest")
        }
        print("redirecting to CPRMobileApp://oauth-swift/pinterest?\(queryString)")
        return request.redirect(to: "CPRMobileApp://oauth-swift/pinterest?\(queryString)")
    }
    
}

import Vapor

public func routes(_ router: Router) throws {
    
    router.get("cpr-callback-functions/callback/twitter"){ request -> Response in
        print(request.query)
        guard let oauthToken = try? request.query.get(String.self, at: "oauth_token"), let oauthVerifier = try? request.query.get(String.self, at: "oauth_verifier") else {
            return request.redirect(to: "OAuthTesting://oauth-swift/twitter")
        }
        let queryString = "oauth_token=\(oauthToken)&oauth_verifier=\(oauthVerifier)"
        return request.redirect(to: "OAuthTesting://oauth-swift/twitter?\(queryString)")
    }
    
    router.get("cpr-callback-functions/callback/pinterest"){ request -> Response in
        guard let queryString = request.http.url.query?.replacingOccurrences(of: "state,", with: "state=").replacingOccurrences(of: "code,", with: "code="),
            queryString.split(separator:"&").count >= 2 else {
            return request.redirect(to: "OAuthTesting://oauth-swift/pinterest")
        }
        return request.redirect(to: "OAuthTesting://oauth-swift/pinterest?\(queryString)")
    }
    
}

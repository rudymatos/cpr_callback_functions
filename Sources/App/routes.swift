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
        print(request.query)
        guard let state = try? request.query.get(String.self, at: "state"), let code = try? request.query.get(String.self, at: "code") else {
            return request.redirect(to: "OAuthTesting://oauth-swift/pinterest")
        }
        print(state)
        print(code)
        let queryString = "state=\(state)&code=\(code)"
        return request.redirect(to: "OAuthTesting://oauth-swift/pinterest?\(queryString)")
    }
    
}

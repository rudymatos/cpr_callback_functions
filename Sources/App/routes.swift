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
}

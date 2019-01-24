import Vapor

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    router.get("cpr-callback-functions/callback/twitter"){ request -> Response in
        print(request.query)
        guard let oauthToken = try? request.query.get(String.self, at: "oauth_token"), let oauthTokenSecret = try? request.query.get(String.self, at: "oauth_token_secret"), let oauthCallbackConfirmed = try? request.query.get(String.self, at: "oauth_callback_confirmed") else {
            return request.redirect(to: "OAuthTesting://oauth-swift/twitter")
        }
        let queryString = "oauth_token=\(oauthToken)&oauth_token_secret=\(oauthTokenSecret)&oauth_callback_confirmed=\(oauthCallbackConfirmed)"
        return request.redirect(to: "OAuthTesting://oauth-swift/twitter?\(queryString)")
    }
}

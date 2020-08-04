//
//  BNetHeaderKeys.swift
//  BNetworking
//
//  Created by Berkay Vurkan on 15.10.2019.
//
// swiftlint:disable identifier_name

import Foundation

// MARK: - HTTP Header Keys
/// HTTP Header Fields
///
/// - See also: https://en.wikipedia.org/wiki/List_of_HTTP_header_fields
/// - See also: https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers
public enum HTTPHeaderKeys {

    // MARK: - Authentication
    /// Authentication category
    ///
    /// - www_authenticate: Defines the authentication method that should be used to gain access to a resource.
    /// - authorization: Contains the credentials to authenticate a user agent with a server.
    /// - proxy_authenticate: Defines the authentication method that should be used to gain access to a resource behind a Proxy server.
    /// - proxy_authorization: Contains the credentials to authenticate a user agent with a proxy server.
    public enum Authentication: String {
      case www_authenticate     = "WWW-Authenticate"
      case authorization        = "Authorization"
      case proxy_authenticate   = "Proxy_Authenticate"
      case proxy_authorization  = "Proxy_Authorization"
    }

    // MARK: - Caching
    /// Caching category
    ///
    /// - age: The time in seconds the object has been in a proxy cache.
    /// - cache_control: Specifies directives for caching mechanisms in both requests and responses.
    /// - expires: The date/time after which the response is considered stale.
    /// - pragma: Implementation-specific header that may have various effects anywhere along the request-response chain.
    ///
    ///   Used for backwards compatibility with HTTP/1.0 caches where the Cache-Control header is not yet present.
    /// - 'warning: A general warning field containing information about possible problems.
    public enum Caching: String {
        case age            = "Age"
        case cache_control  = "Cache-Control"
        case expires        = "Expires"
        case pragma         = "Pragma"
        case warning        = "Warning"
    }

    // MARK: - Client Hints
    /// Client Hints category
    ///
    /// - accept_ch: Response header field or the equivalent HTML meta element with http-equiv attribute indicate server support for particular hints indicated in its value.
    /// - content_dpr: A response header servers must send whenever DPR and Width hints are used to select a resource
    ///
    ///     Content-DPR = [Selected image resource size] / ([Width] / [DPR])
    /// - dpr: Device Pixel Ratio, which means the ratio of physical screen pixels to CSS pixels.
    /// - downlink: Which represents the user’s maximum download speed.
    /// - save_data: It isn’t so much a hint describing network conditions as it is a user preference stating that pages should send less data.
    /// - viewport_width: Which is quantified in CSS pixels.
    /// - width:  The width of an image in physical pixels
    ///
    /// - See also: https://developers.google.com/web/fundamentals/performance/optimizing-content-efficiency/client-hints
    public enum ClientHints: String {
        case accept_ch      = "Accept-CH"
        case content_dpr    = "Content-DPR"
        case dpr            = "DPR"
        case downlink       = "Downlink"
        case save_data      = "Save-Data"
        case viewport_width = "Viewport-Width"
        case width          = "Width"
    }

    // MARK: - Conditionals
    /// Conditionals category
    ///
    /// - last_modified: It is a validator, the last modification date of the resource, used to compare several versions of the same resource.
    ///
    ///     It is less accurate than ETag, but easier to calculate in some environments. Conditional requests using If-Modified-Since and If-Unmodified-Since use this value to change the behavior of the request.
    /// - eTag: It is a validator, a unique string identifying the version of the resource.
    ///
    ///     Conditional requests using If-Match and If-None-Match use this value to change the behavior of the request.
    /// - if_match: Makes the request conditional and applies the method only if the stored resource matches one of the given ETags.
    /// - if_none_match: Makes the request conditional and applies the method only if the stored resource doesn't match any of the given ETags.
    ///
    ///     This is used to update caches (for safe requests), or to prevent to upload a new resource when one is already existing.
    /// - if_modified_since: Makes the request conditional and expects the entity to be transmitted only if it has been modified after the given date.
    ///
    ///     This is used to transmit data only when the cache is out of date.
    /// - if_unmodified_since: Makes the request conditional and expects the entity to be transmitted only if it has not been modified after the given date.
    ///
    ///     This is used to ensure the coherence of a new fragment of a specific range with previous ones, or to implement an optimistic concurrency control system when modifying existing documents.
    public enum Conditionals: String {
        case last_modified          = "Last-Modified"
        case eTag                   = "ETag"
        case if_match               = "If-Match"
        case if_none_match          = "If-None-Match"
        case if_modified_since      = "If_Modified_Since"
        case if_unmodified_since    = "If-Unmodified-Since"
    }

    // MARK: - Connection Management
    /// Connection Management category
    ///
    /// - connection: Controls whether the network connection stays open after the current transaction finishes.
    /// - keep_alive: Controls how long a persistent connection should stay open.
    public enum ConnectionManagement: String {
        case connection     = "Connection"
        case keep_alive     = "Keep-Alive"
    }

    // MARK: - Content Negotiation
    /// Content Negotiation category
    ///
    /// - accept: Informs the server about the types of data that can be sent back. It is MIME-type.
    /// - accept_charset: Informs the server about which character set the client is able to understand.
    /// - accept_encoding: Informs the server about the encoding algorithm, usually a compression algorithm, that can be used on the resource sent back.
    /// - accept_language: Informs the server about the language the server is expected to send back.
    ///
    ///     This is a hint and is not necessarily under the full control of the user: the server should always pay attention not to override an explicit user choice (like selecting a language in a drop down list).
    public enum ContentNegotiation: String {
        case accept             = "Accept"
        case accept_charset     = "Accept-Charset"
        case accept_encoding    = "Accept-Encoding"
        case accept_language    = "Accept-Language"
    }

    // MARK: - Controls
    /// Controls category
    ///
    /// - expect: Indicates expectations that need to be fulfilled by the server in order to properly handle the request.
    /// - max_forwards: Limit the number of times the message can be forwarded through proxies or gateways.
    public enum Controls: String {
        case expect         = "Expect"
        case max_forwards   = "Max-Forwards"
    }

    // MARK: - Cookies
    /// Cookies category
    ///
    /// - cookie: Contains stored HTTP cookies previously sent by the server with the Set-Cookie header.
    /// - set_cookie: Send cookies from the server to the user agent.
    public enum Cookies: String {
        case cookie         = "Cookie"
        case set_cookie     = "Set-Cookie"
    }

    // MARK: - CORS
    /// CORS category
    ///
    /// - access_control_allow_origin: Indicates whether the response can be shared.
    /// - access_control_allow_credentials: Indicates whether the response to the request can be exposed when the credentials flag is true.
    /// - access_control_allow_headers: Used in response to a preflight request to indicate which HTTP headers can be used when making the actual request.
    /// - access_control_allow_methods: Specifies the method or methods allowed when accessing the resource in response to a preflight request.
    /// - access_control_expose_headers: Indicates which headers can be exposed as part of the response by listing their names.
    /// - access_control_max_age: Indicates how long the results of a preflight request can be cached.
    /// - access_control_request_headers: Used when issuing a preflight request to let the server know which HTTP headers will be used when the actual request is made.
    /// - access_control_request_methods: Used when issuing a preflight request to let the server know which HTTP method will be used when the actual request is made.
    /// - origin: Indicates where a fetch originates from.
    /// - timing_allow_origin: Specifies origins that are allowed to see values of attributes retrieved via features of the Resource Timing API,
    ///
    ///     which would otherwise be reported as zero due to cross-origin restrictions.
    ///
    /// - See also: https://w3c.github.io/resource-timing/
    public enum Cors: String {
        case access_control_allow_origin        = "Access-Control-Allow-Origin"
        case access_control_allow_credentials   = "Access-Control-Allow-Credentials"
        case access_control_allow_headers       = "Access-Control-Allow-Headers"
        case access_control_allow_methods       = "Access-Control-Allow-Methods"
        case access_control_expose_headers      = "Access-Control-Expose-Headers"
        case access_control_max_age             = "Access-Control-Max-Age"
        case access_control_request_headers     = "Access-Control-Request-Headers"
        case access_control_request_methods     = "Access-Control-Request-Method"
        case origin                             = "Origin"
        case timing_allow_origin                = "Timing-Allow-Origin"
    }

    // MARK: - Do Not Track
    /// Do not track category
    ///
    /// - dnt: Used for expressing the user's tracking preference.
    /// - tk: Indicates the tracking status that applied to the corresponding request.
    public enum DoNotTrack: String {
        case dnt    = "DNT"
        case tk     = "Tk"
    }

    // MARK: - Downloads
    /// Downloads category
    ///
    /// - content_disposition: It is a response header if the resource transmitted should be displayed inline (default behavior when the header is not present),
    ///
    ///     or it should be handled like a download and the browser should present a 'Save As' window.
    public enum Downloads: String {
        case content_disposition    = "Content-Disposition"
    }

    // MARK: - Message Body
    /// Body Information
    ///
    /// - content_length: Indicates the size of the entity-body, in decimal number of octets, sent to the recipient.
    /// - content_type: Indicates the media type of the resource.
    /// - content_encoding: Used to specify the compression algorithm.
    /// - content_language: Describes the language(s) intended for the audience, so that it allows a user to differentiate according to the users' own preferred language.
    /// - content_location: Indicates an alternate location for the returned data.
    public enum MessageBodyInformation: String {
        case content_length     = "Content-Length"
        case content_type       = "Content-Type"
        case content_encoding   = "Content-Encoding"
        case content_language   = "Content-Language"
        case content_location   = "Content-Location"
    }

    // MARK: - Proxies
    /// Proxies category
    ///
    /// - forwarded: Contains information from the client-facing side of proxy servers that is altered or lost when a proxy is involved in the path of the request.
    /// - x_forwarded_for: Identifies the originating IP addresses of a client connecting to a web server through an HTTP proxy or a load balancer.
    /// - x_forwarded_host: Identifies the original host requested that a client used to connect to your proxy or load balancer.
    /// - x_forwarded_proto: identifies the protocol (HTTP or HTTPS) that a client used to connect to your proxy or load balancer.
    /// - via: Added by proxies, both forward and reverse proxies, and can appear in the request headers and the response headers.
    public enum Proxies: String {
        case forwarded          = "Forwarded"
        case x_forwarded_for    = "X-Forwarded-For"
        case x_forwarded_host   = "X-Forwarded-Host"
        case x_forwarded_proto  = "X-Forwarded-Proto"
        case via                = "Via"
    }

    // MARK: - Redirects
    /// Redirects category
    ///
    /// - location: Indicates the URL to redirect a page to.
    public enum Redirects: String {
        case location   = "Location"
    }

    // MARK: - Request Context
    /// Request Context category
    ///
    /// - from: Contains an Internet email address for a human user who controls the requesting user agent.
    /// - host: Specifies the domain name of the server (for virtual hosting), and (optionally) the TCP port number on which the server is listening.
    /// - referer: The address of the previous web page from which a link to the currently requested page was followed.
    /// - referrer_policy: Governs which referrer information sent in the Referer header should be included with requests made.
    /// - user_agent: Contains a characteristic string that allows the network protocol peers to identify the application type, operating system, software vendor or software version of the requesting software user agent.
    ///
    /// - See also: https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/User-Agent/Firefox
    public enum RequestContext: String {
        case from           = "From"
        case host           = "Host"
        case referer        = "Referer"
        case referer_policy = "Referrer-Policy"
        case user_agent     = "User-Agent"
    }

    // MARK: - Response Context
    /// Response Context category
    ///
    /// - allow: Lists the set of HTTP request methods support by a resource.
    /// - server: Contains information about the software used by the origin server to handle the request.
    public enum ResponseContext: String {
        case allow      = "Allow"
        case server     = "Server"
    }

    // MARK: - Range Requests
    /// Range Requests category
    ///
    /// - accept_ranges: Indicates if the server supports range requests and if so, in which unit the range can be expressed.
    /// - range: Indicates the part of a document that the server should return.
    /// - if_range: Creates a conditional range request that is only fulfilled if the given etag or date matches the remote resource.
    ///
    ///     Used to prevent downloading two ranges from incompatible version of the resource.
    /// - content_range: Indicates where in a full body message a partial message belongs.
    public enum RangeRequests: String {
        case accept_ranges  = "Accept-Ranges"
        case range          = "Range"
        case if_range       = "If-Range"
        case content_range  = "Content-Range"
    }

    // MARK: - Security
    /// Security category
    ///
    /// - content_security_policy: Controls resources the user agent is allowed to load for a given page.
    /// - content_security_policy_report_only: Allows web developers to experiment with policies by monitoring (but not enforcing) their effects.
    ///
    ///     These violation reports consist of JSON documents sent via an HTTP POST request to the specified URI.
    /// - public_key_pins: Associates a specific cryptographic public key with a certain web server to decrease the risk of MITM attacks with forged certificates.
    /// - public_key_pins_report_only: Sends reports to the report-uri specified in the header and does still allow clients to connect to the server even if the pinning is violated.
    /// - strict_transport_security: Force communication using HTTPS instead of HTTP.
    /// - upgrade_insecure_requests: Sends a signal to the server expressing the client’s preference for an encrypted and authenticated response, and that it can successfully handle the upgrade-insecure-requests directive.
    /// - x_content_type_options: Disables MIME sniffing and forces browser to use the type given in Content-Type.
    /// - x_frame_options: Indicates whether a browser should be allowed to render a page in a <frame>, <iframe> or <object>
    /// - x_xss_protection: Enables cross-site scripting filtering
    ///
    /// - See also: https://developer.mozilla.org/tr/docs/Web/HTTP/Headers/Content-Security-Policy
    public enum Security: String {
        case content_security_policy                = "Content-Security-Policy"
        case content_security_policy_report_only    = "Content-Security-Policy-Report-Only"
        case public_key_pins                        = "Public-Key-Pins"
        case public_key_pins_report_only            = "Public-Key-Pins-Report-Only"
        case strict_transport_security              = "Strict-Transport-Security"
        case upgrade_insecure_requests              = "Upgrade-Insecure-Requests"
        case x_content_type_options                 = "X-Content-Type-Options"
        case x_frame_options                        = "X-Frame-Options"
        case x_xss_protection                       = "X-XSS-Protection"
    }

    // MARK: - Server Sent Events
    /// Server Sent Events category
    ///
    /// - ping_from:
    /// - ping_to:
    /// - last_event_id:
    public enum ServerSentEvents: String {
        case ping_from      = "Ping-From"
        case ping_to        = "Ping-To"
        case last_event_id  = "Last-Event-ID"
    }

    // MARK: - Tansfer Coding
    /// Transfer Coding category
    ///
    /// - transfer_encoding: Specifies the the form of encoding used to safely transfer the entity to the user.
    /// - te: Specifies the transfer encodings the user agent is willing to accept.
    /// - trailer: Allows the sender to include additional fields at the end of chunked message.
    public enum TransferCoding: String {
        case transfer_encoding  = "Transfer-Encoding"
        case te                 = "TE"
        case trailer            = "Trailer"
    }

    // MARK: - Web Socket
    /// Web Sockets category
    ///
    /// - sec_webSocket_key:
    /// - sec_webSocket_extensions:
    /// - sec_webSocket_accept:
    /// - sec_webSocket_protocol:
    /// - sec_webSocket_version:
    public enum WebSockets: String {
        case sec_webSocket_key          = "Sec-WebSocket-Key"
        case sec_webSocket_extensions   = "Sec-WebSocket-Extensions"
        case sec_webSocket_accept       = "Sec-WebSocket-Accept"
        case sec_webSocket_protocol     = "Sec-WebSocket-Protocol"
        case sec_webSocket_version      = "Sec-WebSocket-Version"
    }

    // MARK: - Other
    /// Other category
    ///
    /// - 'date: Contains the date and time at which the message was originated.
    /// - large_allocation: Tells the browser that the page being loaded is going to want to perform a large allocation.
    /// - link:
    /// - retry_after: Indicates how long the user agent should wait before making a follow-up request.
    /// - sourceMap: Links generated code to a source map.
    /// - upgrade: The standard establishes rules for upgrading or changing to a different protocol on the current client, server, transport protocol connection.
    ///
    ///     For example, this header standard allows a client to change from HTTP 1.1 to HTTP 2.0, assuming the server decides to acknowledge and implement the Upgrade header field.  Niether party is required to accept the terms specified in the Upgrade header field.
    ///
    ///     It can be used in both client and server headers.  If the Upgrade header field is specified, then the sender MUST also send the Connection header field with the upgrade option specified.
    /// - vary: Determines how to match future request headers to decide whether a cached response can be used rather than requesting a fresh one from the origin server.
    /// - x_dns_prefetch_control: Controls DNS prefetching, a feature by which browsers proactively perform domain name resolution on both links that the user may choose to follow as well as URLs for items referenced by the document, including images, CSS, JavaScript, and so forth.
    /// - x_firefox_spdy:
    /// - x_requested_width:
    /// - x_ua_compatiable:
    ///
    /// - See also: https://developer.mozilla.org/en-US/docs/Tools/Debugger/How_to/Use_a_source_map
    /// - See also: https://tools.ietf.org/html/rfc7230#section-6.1
    public enum Other: String {
        case date                   = "Date"
        case large_allocation       = "Large-Allocation"
        case link                   = "Link"
        case retry_after            = "Retry-After"
        case sourceMap              = "SourceMap"
        case upgrade                = "Upgrade"
        case vary                   = "Vary"
        case x_dns_prefetch_control = "X-DNS-Prefetch-Control"
        case x_firefox_spdy         = "X-Firefox-Spdy"
        case x_requested_width      = "X-Requested-With"
        case x_ua_compatiable       = "X-UA-Compatible"
    }
}

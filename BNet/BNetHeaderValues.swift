//
//  BNetHeaderValues.swift
//  BNetworking
//
//  Created by Berkay Vurkan on 15.10.2019.
//

import Foundation


//MARK:- Header Values
public enum HTTPHeaderValues {
    
    
    /// Values for Content Type key
    ///
    /// - application:  typically either uninterpreted binary data or information to be processed by a mail-based application. The primary subtype, "octet-stream", is to be used in the case of uninterpreted binary data, in which case the simplest recommended action is to offer to write the information into a file for the user.
    ///
    ///     Two additional subtypes, "ODA" and "PostScript", are defined for transporting ODA and PostScript documents in bodies. Other expected uses for "application" include spreadsheets, data for mail-based scheduling systems, and languages for "active" (computational) email.
    /// - text: The primary subtype, *plain*, indicates plain (unformatted) text. No special software is required to get the full meaning of the text, aside from support for the indicated character set.
    ///
    ///     Subtypes are to be used for enriched text in forms where application software may enhance the appearance of the text, but such software must not be required in order to get the general idea of the content.
    ///
    ///     Possible subtypes thus include any readable word processor format. A very simple and portable subtype, richtext, is defined in this document.
    /// - video: Requires the capability to display moving images, typically including specialized hardware and software. The initial subtype is "mpeg".
    /// - audio: With initial subtype "basic". Audio requires an audio output device (such as a speaker or a telephone) to "display" the contents.
    /// - image: Image requires a display device (such as a graphical display, a printer, or a FAX machine) to view the information. Initial subtypes are defined for two widely-used image formats, jpeg and gif.
    /// - multipart: Data consisting of multiple parts of independent data types. Four initial subtypes are defined, including the primary "mixed" subtype, "alternative" for representing the same data in multiple formats, "parallel" for parts intended to be viewed simultaneously, and "digest" for multipart entities in which each part is of type "message".
    ///
    /// - Note: A subtype specification is MANDATORY.   There are no default subtypes.
    /// - Note: Active email entails several securityconsiderations, which are discussed later in this memo, particularly in the context of application/PostScript.
    ///
    /// - See also:
    ///   [Definitions](https://www.w3.org/Protocols/rfc1341/4_Content-Type.html)
    public enum ContentType {
        
        case application(subtype: String)
        case text(subtype: String)
        case video(subtype: String)
        case audio(subtype: String)
        case image(subtype: String)
        case multipart(subtype: String)
    }
}

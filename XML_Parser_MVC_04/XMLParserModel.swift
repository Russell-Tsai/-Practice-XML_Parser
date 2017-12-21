//
//  XMLParserModel.swift
//  XML_Parser_MVC_04
//
//  Created by 蔡松樺 on 30/11/2017.
//  Copyright © 2017 蔡松樺. All rights reserved.
//

import UIKit

struct RSSItem {
    var Title : String
    var PubDate : String
}

class XMLParserModel: NSObject, XMLParserDelegate {
    
//    private var parser = XMLParser()
    private var posts = [RSSItem]()
    private var currentElement  = ""
    private var currentTitle = ""
    private var currentDate = ""
    
    func beginParer(completion: (([RSSItem])-> Void)) {
        
        if let path = Bundle.main.path(forResource: "Info", ofType: "xml") {
            let url = URL(fileURLWithPath: path)
            if let parser = XMLParser(contentsOf: url) {
                parser.delegate = self
                parser.parse()
                
                completion(self.posts)
            }
        }
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        currentElement = elementName
        if elementName == "book" {
            currentTitle = ""
            currentDate = ""
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        switch currentElement {
        case "title":
            currentTitle += string
        case "author":
            currentDate += string
        default:
            break
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "book"{
            let rssItem = RSSItem(Title: currentTitle, PubDate: currentDate)
            self.posts.append(rssItem)
        }
    }

}

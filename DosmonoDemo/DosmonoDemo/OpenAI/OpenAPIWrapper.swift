//
//  OpenAPIWrapper.swift
//  DosmonoDemo
//
//  Created by Imran Ishaq on 21/09/2023.
//

import Foundation

@objc class AppController:NSObject {
    
   @objc static func translateAUdioFile() {
       //    // Create an instance of OpenAIAPIConfig and set its properties
       let openAI = OpenAIAPI(OpenAIAPIConfig())
       
       let config = OpenAIAPIAudioParms(prompt: nil, response_format:OpenAIAPIResponseFormat.json.name, language: Iso639_1.en.code)

       guard let fileUrl = Bundle.main.url(forResource: "poor-audio", withExtension: "mp3") else {
           return
       }
       guard let data = try? Data(contentsOf:fileUrl) else { return }
       
       openAI.createTranscription(filedata:data, filename: "transcript.mp3", config:config) { (result:Result<OpenAIAPIAudioResponse, WebServiceError>) in
           switch result {
              case .success(let success):
                 dump(success)
              case .failure(let failure):
                 print("\(failure.localizedDescription)")
           }
       }

       openAI.createTranslation(filedata:data, filename: "transcript.mp3", config:config) { (result:Result<OpenAIAPIAudioResponse, WebServiceError>) in
           switch result {
              case .success(let success):
                 dump(success)
              case .failure(let failure):
                 print("\(failure.localizedDescription)")
           }
       }
       
    }
    
    

    

}

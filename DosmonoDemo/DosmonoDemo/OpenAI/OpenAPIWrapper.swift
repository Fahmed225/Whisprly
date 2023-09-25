//
//  OpenAPIWrapper.swift
//  DosmonoDemo
//
//  Created by Imran Ishaq on 21/09/2023.
//

import Foundation

@objc class AppController:NSObject {
    
    @objc static func translateAUdioFile(fileName:String) {
       //    // Create an instance of OpenAIAPIConfig and set its properties
        ///[SVProgressHUD dismiss];
        let openAI = OpenAIAPI(OpenAIAPIConfig(secret: "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"));
       
       let config = OpenAIAPIAudioParms(prompt: nil, response_format:OpenAIAPIResponseFormat.json.name, language: Iso639_1.en.code)

       guard let fileUrl = Bundle.main.url(forResource: "01_20230511231113", withExtension: "wav") else {
           return
       }
        let changeFileName = fileName.replacingOccurrences(of: ".dat", with: ".wav")
        let filePath = URL(fileURLWithPath: changeFileName)
 
       guard let data = try? Data(contentsOf:fileUrl) else { return }
       
       openAI.createTranscription(filedata:data, filename: "01_20230511231113.wav", config:config) { (result:Result<OpenAIAPIAudioResponse, WebServiceError>) in
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

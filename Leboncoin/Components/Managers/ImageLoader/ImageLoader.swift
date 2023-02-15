//
//  ImageLoader.swift
//  Leboncoin
//
//  Created by Renxiao Mo on 14/02/2023.
//

import Foundation

struct DataLoader {
    private func download(url: URL, toFile file: URL, completion: @escaping (Error?) -> Void) {
        let task = URLSession.shared.downloadTask(with: url) { tempURL, response, error in
            guard let tempURL = tempURL else {
                completion(error)
                return
            }

            do {
                if FileManager.default.fileExists(atPath: file.path) {
                    try FileManager.default.removeItem(at: file)
                }

                try FileManager.default.copyItem(
                    at: tempURL,
                    to: file
                )

                completion(nil)
            }

            catch {
                completion(error)
            }
        }

        task.resume()
    }
    
    func loadData(url: URL, completion: @escaping (Data?, Error?) -> Void) {
        // Compute a path to the URL in the cache
        let fileCachePath = FileManager.default.temporaryDirectory
            .appendingPathComponent(
                url.lastPathComponent,
                isDirectory: false
            )
        
        // If the image exists in the cache, load it and exit
        if let data = try? Data(contentsOf: fileCachePath) {
            completion(data, nil)
            return
        }
        
        // If the image does not exist in the cache, download the image and cache it
        download(url: url, toFile: fileCachePath) { error in
            guard let data = try? Data(contentsOf: fileCachePath) else {
                completion(nil, error)
                return
            }
            completion(data, error)
        }
    }
}

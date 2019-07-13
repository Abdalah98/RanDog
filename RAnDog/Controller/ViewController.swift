//
//  ViewController.swift
//  RAnDog
//
//  Created by Abdalah on 10/28/1440 AH.
//  Copyright © 1440 AH Abdalah. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var breeds:[String] = []
    @IBOutlet weak var PickerView: UIPickerView!
    @IBOutlet weak var imageview: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        PickerView.dataSource = self
        PickerView.delegate = self
        DOGAPI.requestBreedsList(completionHander: handleBreedsListResponse(breeds:error:))
    }
    
    func handleBreedsListResponse(breeds: [String], error: Error?) {
        self.breeds = breeds
        DispatchQueue.main.async {
            self.PickerView.reloadAllComponents()
        }
    }
    func handelRandomImagePesponse(imagedata :DogImage? ,
                                   error:Error?){
        guard let imageurl = URL(string:imagedata?.message ?? "") else
        {
            return
        }
        DOGAPI.requestImageFile(url: imageurl, completionHander:self.handelImageFileResponse(image:error:) )
    }

    func handelImageFileResponse(image :UIImage?,error:Error?){
        DispatchQueue.main.async {
            self.imageview.image = image
        }
        
    }
}

extension ViewController:UIPickerViewDelegate,UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return breeds.count
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return breeds[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        DOGAPI.requestRandomImage(breed:breeds[row],completionHander: handelRandomImagePesponse(imagedata:error:))
    }
}

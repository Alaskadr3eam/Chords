//
//  ViewController.swift
//  Chords
//
//  Created by Clément Martin on 05/03/2020.
//  Copyright © 2020 Clément Martin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //MARK: - Properties custom
    let customWidth:CGFloat = 100
    let customHeight:CGFloat = 100
    //MARK: - Properties Outlet
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var pickerKeysNames: UIPickerView!
    @IBOutlet weak var pickerChords: UIPickerView!
    //MARK: - Propertie model
    var chords = ChordsMod(chordsServiceSession: ChordsService.shared)

    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        customPicker()
        
        chords.requestChords { (bool) in
            guard bool == true else { return }
            DispatchQueue.main.async {
                self.initView()
            }
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
    }
    ///func for add rotation on PickerView
    private func customPicker() {
        pickerKeysNames.transform = CGAffineTransform(rotationAngle: Constant.rotation)
        pickerKeysNames.backgroundColor = .black
        
        pickerChords.transform = CGAffineTransform(rotationAngle: Constant.rotation)
        pickerChords.backgroundColor = .black
    }
    ///verify if dataSource pickerKey is ok
    private func initPickerView() -> Bool {
        if chords.dataSourceKeysName.count != 0 {
            pickerKeysNames.dataSource = self
            pickerKeysNames.delegate = self
  
            pickerChords.delegate = self
            pickerChords.dataSource = self
            return true
        }
        return false
    }
    ///func for init pickerView when dataSource is ok
    private func initView() {
        if !initPickerView() {
            return
        }
        pickerKeysNames.selectRow(0, inComponent: 0, animated: true)
        prepareDataSourcePickerChords(row: 0)
        pickerChords.selectRow(0, inComponent: 0, animated: true)
        initLabel(row: 0)
    }
    
    func initLabel(row: Int) {
        labelDescription.text = ("fingers: \(chords.dataourceChordsId[row].fingers)")
        labelDescription.text! += ("\n midi: \(chords.dataourceChordsId[row].midi)")
    }

}

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    //MARK: - UIPickerViewDelegate - Datasource
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == pickerKeysNames {
            return chords.dataSourceKeysName.count
        } else {
            return chords.dataourceChordsId.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == pickerKeysNames {
            return chords.dataSourceKeysName[row].name
        } else {
            initLabel(row: row)
             return chords.dataourceChordsId[row].suffix
        }
    }
    
    private func prepareDataSourcePickerChords(row: Int) {
        chords.dataourceChordsId.removeAll()
        let dataSource2 = chords.dataSourceKeysName[row].keychordids
        for id in (chords.chordsStock?.allchords)! {
            for id2 in dataSource2 {
                    if id.chordid == id2 {
                        chords.dataourceChordsId.append(id)
                        continue
                }
            }
        }
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == pickerKeysNames {
            prepareDataSourcePickerChords(row: row)
            pickerChords.selectRow(0, inComponent: 0, animated: true)
            initLabel(row: row)
        } else {
            initLabel(row: row)
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 100
    }
    
    func createNewView(title: String, pickerView: UIPickerView) -> UIView {
        //new view for picker
        let view = UIView(frame: CGRect(x: 0, y: 0, width: customWidth, height: customHeight))
        //label
        let middleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: customWidth, height: customHeight))
        middleLabel.text = title
        middleLabel.textColor = .white
        middleLabel.textAlignment = .center
        middleLabel.font = UIFont.systemFont(ofSize: 42, weight: .bold)
        view.addSubview(middleLabel)
        view.transform =  CGAffineTransform(rotationAngle: 90 * (.pi/180))
        return view
    }

    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        if pickerView == pickerKeysNames {
            return createNewView(title: chords.dataSourceKeysName[row].name, pickerView: pickerKeysNames)
        } else {
            return createNewView(title: chords.dataourceChordsId[row].suffix, pickerView: pickerChords)
        }
    }
}

//
//  ViewController.swift
//  Kalkulator
//
//  Created by Tomek on 09/09/2020.
//  Copyright © 2020 Tomek. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var holder: UIView!
    
    var pierwszaLiczba = 0
    var aktualnaOperacja: Operation?
    let brightGreen = UIColor(displayP3Red: 0.0, green: 1.0, blue: 0.0, alpha: 0.5)
    
    enum Operation {
        case dodaj, odejmij, pomnoz, podziel
    }

    private var resultLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textColor = .black
        label.textAlignment = .right
        label.font = UIFont(name: "Helvetica", size: 100)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        setupNumberPad()
    }
    
    private func setupNumberPad() {
        let buttonSize: CGFloat = view.frame.size.width / 4
        
        //przycisk zero
        let button0 = UIButton(frame: CGRect(x: 0, y: holder.frame.size.height-buttonSize, width: buttonSize*3, height: buttonSize))
        button0.setTitleColor(.black, for: .normal)
        button0.backgroundColor = brightGreen
        button0.setTitle("0", for: .normal)
        button0.layer.borderWidth = 7
        button0.layer.borderColor = UIColor.white.cgColor
        holder.addSubview(button0)
        button0.tag = 1
        button0.addTarget(self, action: #selector(zeroTapped), for: .touchUpInside)
        
        //przyciski 1, 2, 3
        for x in 0..<3 {
            let button1 = UIButton(frame: CGRect(x: buttonSize * CGFloat(x), y: holder.frame.size.height-(buttonSize*2), width: buttonSize, height: buttonSize))
            button1.setTitleColor(.black, for: .normal)
            button1.backgroundColor = brightGreen
            button1.setTitle("\(x+1)", for: .normal)
            button1.layer.borderWidth = 7
            button1.layer.borderColor = UIColor.white.cgColor
            holder.addSubview(button1)
            button1.tag = x + 2
            button1.addTarget(self, action: #selector(wyborCyfry(_:)), for: .touchUpInside)
        }
        
        //przyciski 4, 5, 6
        for x in 0..<3 {
            let button2 = UIButton(frame: CGRect(x: buttonSize * CGFloat(x), y: holder.frame.size.height-(buttonSize*3), width: buttonSize, height: buttonSize))
            button2.setTitleColor(.black, for: .normal)
            button2.backgroundColor = brightGreen
            button2.layer.borderWidth = 7
            button2.layer.borderColor = UIColor.white.cgColor
            button2.setTitle("\(x+4)", for: .normal)
            holder.addSubview(button2)
            button2.tag = x + 5
            button2.addTarget(self, action: #selector(wyborCyfry(_:)), for: .touchUpInside)
        }
        
        //przyciski 7, 8, 9
        for x in 0..<3 {
            let button3 = UIButton(frame: CGRect(x: buttonSize * CGFloat(x), y: holder.frame.size.height-(buttonSize*4), width: buttonSize, height: buttonSize))
            button3.setTitleColor(.black, for: .normal)
            button3.backgroundColor = brightGreen
            button3.layer.borderWidth = 7
            button3.layer.borderColor = UIColor.white.cgColor
            button3.setTitle("\(x+7)", for: .normal)
            holder.addSubview(button3)
            button3.tag = x + 8
            button3.addTarget(self, action: #selector(wyborCyfry(_:)), for: .touchUpInside)
        }
        
        //przycisk czyszczenia: C
        let clearButton = UIButton(frame: CGRect(x: 0, y: holder.frame.size.height-(buttonSize*5), width: view.frame.size.width - buttonSize, height: buttonSize))
        clearButton.setTitleColor(.black, for: .normal)
        clearButton.backgroundColor = .yellow
        clearButton.layer.borderWidth = 7
        clearButton.layer.borderColor = UIColor.white.cgColor
        clearButton.setTitle("Wyczyść", for: .normal)
        holder.addSubview(clearButton)
        
        //przyciski operacji
        let operacje_all = ["=", "+", "-", "*", "÷"]
        for x in 0..<5 {
            let button4 = UIButton(frame: CGRect(x: buttonSize * 3, y: holder.frame.size.height-(buttonSize * CGFloat(x + 1)), width: buttonSize, height: buttonSize))
            button4.setTitleColor(.black, for: .normal)
            button4.backgroundColor = .green
            button4.layer.borderWidth = 7
            button4.layer.borderColor = UIColor.white.cgColor
            button4.titleLabel?.font = UIFont(name: "Helvetica", size: 35)
            button4.setTitle(operacje_all[x], for: .normal)
            holder.addSubview(button4)
            button4.tag = x + 1
            button4.addTarget(self, action: #selector(wyborOperacji(_:)), for: .touchUpInside)
        }
        
        resultLabel.frame = CGRect(x: 20, y: clearButton.frame.origin.y - 110.0, width: view.frame.size.width - 40, height: 100)
        holder.addSubview(resultLabel)
        
        // Akcje
        clearButton.addTarget(self, action: #selector(wyczyscWyniki), for: .touchUpInside)
        
    }
    
    @objc func wyczyscWyniki() {
        resultLabel.text = "0"
        aktualnaOperacja = nil
        pierwszaLiczba = 0
    }
    
    @objc func zeroTapped() {
        if resultLabel.text != "0" {
            if let text = resultLabel.text {
                resultLabel.text = "\(text)\(0)"
            }
        }
    }
    
    @objc func wyborCyfry(_ sender: UIButton) {
        let tag = sender.tag - 1
        
        if resultLabel.text == "0" {
            resultLabel.text = "\(tag)"
        }
        else if let text = resultLabel.text {
            resultLabel.text = "\(text)\(tag)"
        }
    }
    
    @objc func wyborOperacji(_ sender: UIButton) {
        let tag = sender.tag
        
        if let text = resultLabel.text, let value = Int(text), pierwszaLiczba == 0 {
            pierwszaLiczba = value
            resultLabel.text = "0"
        }
        
        if tag == 1 {
            if let operation = aktualnaOperacja {
                var drugaLiczba = 0
                if let text = resultLabel.text, let value = Int(text) {
                    drugaLiczba = value
                }
                switch operation {
                    case .dodaj:
                        let result = pierwszaLiczba + drugaLiczba
                        resultLabel.text = "\(result)"
                        break
                    
                    case .odejmij:
                        let result = pierwszaLiczba - drugaLiczba
                        resultLabel.text = "\(result)"
                        break
                    
                    case .pomnoz:
                        let result = pierwszaLiczba * drugaLiczba
                        resultLabel.text = "\(result)"
                        break
                    
                    case .podziel:
                        let result = pierwszaLiczba / drugaLiczba
                        resultLabel.text = "\(result)"
                        break
                }
            }
        }
        else if tag == 2 {
            aktualnaOperacja = .dodaj
        }
        else if tag == 3 {
            aktualnaOperacja = .odejmij
        }
        else if tag == 4 {
            aktualnaOperacja = .pomnoz
        }
        else if tag == 5 {
            aktualnaOperacja = .podziel
        }
    }

}


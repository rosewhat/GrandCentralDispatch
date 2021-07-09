//
//  SecondViewController.swift
//  GCD
//
//  Created by rose on 07.07.2021.
//

import UIKit


class SecondViewController: UIViewController {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var imageView: UIImageView!
    // адрес для изображения
    fileprivate var imageURL: URL?
    fileprivate var image: UIImage? {
        get { // значение image
            return imageView.image
            
        }
        set {
            activityIndicator.startAnimating()
            activityIndicator.isHidden = true // прячем
            imageView.image = newValue
            imageView.sizeToFit() // режим полностью
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchImage()
        delay(3) {
            self.loginAlert()
        }
        
        // Do any additional setup after loading the view.
    }
    fileprivate func delay(_ delay: Int, closure: @escaping () ->()) {// задержка времени
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(delay)) {
            closure()
        }
    }
    fileprivate func loginAlert() {
        let ac = UIAlertController(title: "demo", message: "demo", preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "ok", style: .default, handler: nil)
        let cansel = UIAlertAction(title: "done", style: .default, handler: nil)
        
        ac.addAction(ok)
        ac.addAction(cansel)
        
        ac.addTextField { (username) in
            username.placeholder = "Введите логин"
            
        }
        ac.addTextField { (usernamePassword) in
            usernamePassword.placeholder = "Введите пароль"
            usernamePassword.isSecureTextEntry = true // скрыть символы
            
        }
        
        self.present(ac, animated: true, completion: nil)
    }
    fileprivate func fetchImage() {
        imageURL = URL(string: "https://upload.wikimedia.org/wikipedia/commons/0/07/Huge_ball_at_Vilnius_center.jpg")
        activityIndicator.isHidden = false
        activityIndicator.startAnimating() // начинает индикатор работать
        
        let queue = DispatchQueue.global(qos: .utility)
        queue.async { // не ждать
            guard  let url = self.imageURL,// существует?
                   
                   let imageData = try? Data(contentsOf: url) else { return } // данные в виде даты
            DispatchQueue.main.async {
                self.image = UIImage(data: imageData)
                
            }
            
        }
        
        
    }
}

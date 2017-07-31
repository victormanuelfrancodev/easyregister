//
//  TextFieldFormEasy.swift
//  TextFieldFormEasy
//
//  Created by Victor on 7/17/17.
//  Copyright © 2017 Azcatl. All rights reserved.
//

import UIKit


@objc protocol TextFieldFormEasyDelegate: class{
    @objc optional func validateCodigoPostal(_field: TextFieldFormEasy, codigoPostalValidate result: Bool, mensajeError: String?)
    @objc optional func TextFieldValidate (_field: TextFieldFormEasy, errorMessage errorMensaje: String? )
    @objc optional func TextFieldCustom(_field: TextFieldFormEasy, didValidateWithResult resultado: Bool, andErrorMessage errorMessage: String?)
    
}

enum TextFieldFormEasyType :Int{
    case name = 0
    case email = 1
    case phone = 2
    case password = 3
    case cp = 4
    case  number = 5
    case  emailCheck = 6
    case  passwordCheck = 7
    case  addres = 8
    
    func validate(_ text: String, emailCheck: String?, passwordCheck: String? ) -> Bool?{
        
        if text == ""{
            return nil
        }
        
        switch self {
        case .name:
            return true
        case .email:
            return isValidEmail(email: text)
        case .phone:
            return true
        case .password:
            return isPassword(password: text)
        case .cp:
            return isValidCP(cp: text)
        case .number:
            return true
        case .emailCheck:
            return emailCheck != nil && emailCheck == text
        case .passwordCheck:
            return passwordCheck != nil && passwordCheck == text
        case .addres:
            return true
        }
    }
    
    func isPassword(password:String)->Bool{
        let regex = "(^(?=\\w*\\d)(?=\\w*[A-Z])(?=\\w*[a-z])\\S{8,16}$)"
        let predicate = NSPredicate(format:"SELF MATCHES %@", regex)
        return predicate.evaluate(with: password)
    }
    func isNumber(number:String)->Bool{
        let regex = "\\b\\d{1,}\\b"
        let predicate = NSPredicate(format:"SELF MATCHES %@", regex)
        return predicate.evaluate(with: number)
    }
    
    func isValidEmail(email: String) -> Bool{
        let regex = "[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?"
        let predicate = NSPredicate(format:"SELF MATCHES %@", regex)
        return predicate.evaluate(with: email)
    }
    
    func isValidPhone(phone: String) ->Bool{
        let regex = "\\b\\d{2}[-.]?\\d{4}[-.]?\\d{2}[-.]?\\d{2}\\b"
        let predicate = NSPredicate(format:"SELF MATCHES %@", regex)
        return predicate.evaluate(with : phone)
    }
    
    func  isValidCP(cp: String) -> Bool{
        let regex = "\\b\\d{5}\\b"
        let predicate = NSPredicate(format:"SELF MATCHES %@", regex)
        return predicate.evaluate(with : cp)
    }
}

@IBDesignable
class TextFieldFormEasy: UIView, UITextFieldDelegate{

    /*Holder designable*/
    var textHolder: String = "Text Easy"
    var textColorHolder: UIColor = UIColor.black
    
    /*TextField designable */
    var backgroundColorTextFieldEasy: UIColor = UIColor.blue
    var textColorTextFieldEasy: UIColor = UIColor.black
    
    /*Boder, style etc TextField*/
    var borderWidthTextFieldEasy: CGFloat = 1.0
    var borderColorTextFieldEasy: UIColor = UIColor.cyan
    var cornerRadiousTextFieldEasy: CGFloat = 5.0
    var disableWriteEasy: Bool = false
   
    /*Tipo*/
    private var _mode: Int = 0
    
    /*Error*/
    var textError: String = "Error"
    var txtAlertError : UILabel?
    
    @IBOutlet weak var txtField: UITextField!
    
    /*Correcto*/
    var imagenViewCorrect: UIImageView? 
    
    /*Validación*/
    private var _isValid: Bool?
    
    /*Delegado*/
    weak var delegate: TextFieldFormEasyDelegate?
    
    /*Validación*/
    var imagenValidacion :UIImage! = UIImage(named: "ok-xxl")
    
    /*Vista*/
    var vista: UIViewController? = nil
    
    /* Texto de error */
    @IBInspectable var errorText: String = "Error" {
        didSet{
            textError = errorText
        }
    }
    /* Imagen de validación */
    @IBInspectable var imgValidacion :String = "ok-xxl" {
        didSet{
            imagenValidacion = UIImage(named: imgValidacion)
        }
    }
    
    /*  Text Color*/
    @IBInspectable var textFColor: UIColor = UIColor.black {
        didSet{
            textColorTextFieldEasy = textFColor
        }
    }
    
    /*Imagen View*/
    @IBInspectable var imagenValid: UIImage? = UIImage(named: "ok-xxl")
    
    @IBInspectable var errorMessage: String = "Error Message" {
        didSet {
            textError = errorMessage
        }
    }
    
    @IBInspectable var backgroundColorText: UIColor = UIColor.black {
        didSet {
            backgroundColorTextFieldEasy = backgroundColorText
        }
    }
    
    @IBInspectable var borderWidthText: CGFloat = 1.0{
        didSet {
            borderWidthTextFieldEasy = borderWidthText
        }
    }
    
    @IBInspectable var borderTextFieldColor: UIColor = UIColor.brown {
        didSet {
            borderColorTextFieldEasy = borderTextFieldColor
        }
    }
    
    @IBInspectable var placeHolderText: String = "" {
        didSet {
            self.textHolder = placeHolderText
        }
    }
    
    @IBInspectable var placeHolderColor: UIColor = UIColor.black {
        didSet {
            textColorHolder = placeHolderColor
        }
    }
    
    @IBInspectable var cornerRadiusText: CGFloat = 5.0 {
        didSet {
            cornerRadiousTextFieldEasy = cornerRadiusText
        }
    }
    
    @IBInspectable var disableWriteText: Bool = false {
        didSet {
          disableWriteEasy = disableWriteText
        }
    }
    
    
    weak var otherPasswordField: TextFieldFormEasy? {
        didSet {
            if otherPasswordField?.otherPasswordField == nil{
                otherPasswordField?.otherPasswordField = self
            }
        }
    }
    
    
    weak var otherEmailField: TextFieldFormEasy? {
        didSet {
            if otherEmailField?.otherEmailField == nil{
                otherEmailField?.otherEmailField = self
            }
        }
    }

    public var text: String?{
        get {
            return self.txtField.text
        }
        set{
            self.txtField.text = text
        }
    }
    
    var texto : String = ""{
        didSet{
            self.txtField.text = texto
        }
    }
    
    public var getValidationMode : Int?{
        get{
            return validationMode.rawValue
        }
    }

    
    var isValid: Bool? {
        get {
            return _isValid ?? false
        }
        set {
            _isValid = newValue
            switch newValue {
            case true?:
                imagenViewCorrect?.isHidden = false
                self.txtAlertError?.isHidden = false
                self.txtAlertError?.text = textError
                if delegate != nil {
                    delegate!.TextFieldCustom?(_field: self, didValidateWithResult: true, andErrorMessage: nil)
                }
            
            case false?:
                imagenViewCorrect?.isHidden = true
                self.txtAlertError?.isHidden = false
                //self.txtAlertError?.text = textError
            
                if delegate != nil {
                    delegate!.TextFieldCustom?(_field: self, didValidateWithResult: false, andErrorMessage: self.errorMessage)
                }
            case nil:
                
                imagenViewCorrect?.isHidden = true
                self.txtAlertError?.isHidden = true
                
                if delegate != nil {
                    delegate!.TextFieldCustom?(_field: self, didValidateWithResult: false, andErrorMessage: self.errorMessage)
                }
            }
        }
    }
    
    var mode: Int = 0 {
        didSet {
            _mode = mode
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
 
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func draw(_ rect: CGRect) {
        
        paintComponent()
        paintImagenValidate()
        paintAlertText()
        
        validationMode = TextFieldFormEasyType(rawValue: mode)!
    }
    
    /*Dibuja componente */
    func paintComponent(){
        self.txtField = UITextField(frame: CGRect(x: 0, y: 0, width: self.bounds.maxX, height: self.bounds.height-10))
        self.txtField.addTarget(self, action: #selector(textFieldDidEdit(_:)), for: .editingChanged)
        self.txtField.delegate = self
        self.txtField.returnKeyType = .done
        self.txtField.autocapitalizationType = .none
       
        self.txtField.layer.borderColor = UIColor.white.cgColor
        self.txtField.layer.borderWidth = 0.5
        self.txtField.textColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        if #available(iOS 8.2, *) {
            self.txtField.font = UIFont.systemFont(ofSize: 18, weight: UIFontWeightRegular)
        } else {
            // Fallback on earlier versions
        }
        self.txtField.backgroundColor = backgroundColorTextFieldEasy
        self.txtField.layer.borderWidth = borderWidthTextFieldEasy
        self.txtField.layer.borderColor = borderColorTextFieldEasy.cgColor
        self.txtField.layer.cornerRadius = cornerRadiousTextFieldEasy
        self.txtField.isUserInteractionEnabled = disableWriteEasy
        self.txtField.layer.masksToBounds = true
        self.txtField.borderStyle = .roundedRect
        if #available(iOS 8.2, *) {
            self.txtField.attributedPlaceholder = NSAttributedString(string: self.textHolder,
                                                                         attributes:
                [NSFontAttributeName:UIFont.systemFont(ofSize: 18, weight: UIFontWeightRegular), NSForegroundColorAttributeName:UIColor(red: 162.0/255.0, green: 174.0/255.0, blue: 182.0/255.0, alpha: 1.0)]
            )
        } else {
            // Fallback on earlier versions
        }
        self.txtField.backgroundColor = UIColor(red: 68.0/255.0, green: 92.0/255.0, blue: 108.0/255.0, alpha: 1.0)
        self.txtField.placeholder = self.textHolder
        addSubview(self.txtField)
    }
    
    /*Paint Imagen Validación*/
    func paintImagenValidate(){
        imagenViewCorrect = UIImageView(frame: CGRect(x: txtField.bounds.width - 20, y:  txtField.bounds.height / 2 - 5, width: 10, height: 10))
        let imagenSimbolo : UIImage = UIImage(named: "ok-xxl")!
        
        imagenViewCorrect?.image = imagenSimbolo
        imagenViewCorrect?.isHidden = true
        
        addSubview(imagenViewCorrect!)
    }
    
    /*Paint Alert Text*/
    func paintAlertText(){
        /*Font*/
        txtAlertError = UILabel(frame: CGRect(x: 10, y: self.txtField.bounds.height+5 , width: self.bounds.width, height: 10))
        txtAlertError?.text = self.textError
        txtAlertError?.font = UIFont(name: "System", size: 12.0)
        txtAlertError?.font = UIFont.italicSystemFont(ofSize: 12.0)
        txtAlertError?.textColor = UIColor(red: 208.0/255.0, green: 1.0/255.0, blue: 27.0/255.0, alpha: 1.0)
        txtAlertError?.isHidden = true
        addSubview(txtAlertError!)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if validationMode == .cp {
            
            guard let text = textField.text else { return true }
            let newLength = text.characters.count + string.characters.count - range.length
            return newLength <= 5 // Bool
        }
        else if validationMode == .phone {
            guard let text = textField.text else { return true }
            let newLength = text.characters.count + string.characters.count - range.length
            return newLength <= 10
        }
        else{
            guard let text = textField.text else { return true }
            let newLength = text.characters.count + string.characters.count - range.length
            return newLength <= 50
        }
    }
    
    var validationMode: TextFieldFormEasyType = .name {
        didSet {
            _mode = validationMode.rawValue
            
            switch validationMode {
                
            case .name:
                self.txtField.isSecureTextEntry = false
                self.txtField.autocorrectionType = .no
                self.txtField.autocapitalizationType = .sentences
                self.txtField.keyboardType = .asciiCapable
            // print("nombre")
            case .email:
                self.txtField.autocorrectionType = .no
                self.txtField.isSecureTextEntry = false
                self.txtField.keyboardType = .emailAddress
            // print("email")
            case .phone:
                self.txtField.isSecureTextEntry = false
                self.txtField.keyboardType = .numberPad
            // print("numeroTelefonico")
            case .password:
                self.txtField.isSecureTextEntry = true
                self.txtField.autocorrectionType = .no
                self.txtField.keyboardType = .default
            // print("password")
            case .cp:
                self.txtField.isSecureTextEntry = false
                self.txtField.keyboardType = .numberPad
            // print("cp")
            case .number:
                self.txtField.isSecureTextEntry = false
                self.txtField.keyboardType = .numberPad
            // print("cp")
            case .addres:
                self.txtField.keyboardType = .default
                self.txtField.autocorrectionType = .no
                self.txtField.isSecureTextEntry = false
                self.txtField.autocapitalizationType = .sentences
            //print("addres")
            case .passwordCheck:
                self.txtField.isSecureTextEntry = true
                self.txtField.autocorrectionType = .no
                self.txtField.keyboardType = .default
            case .emailCheck:
                self.txtField.isSecureTextEntry = false
                self.txtField.autocorrectionType = .no
                self.txtField.keyboardType = .emailAddress
            }
        }
    }

    func textFieldDidEndEditing(_ textField: UITextField){
        
        isValid = validationMode.validate(textField.text!,emailCheck: otherEmailField?.text,passwordCheck: otherPasswordField?.text)
        
        
        if validationMode == .passwordCheck{
            if validationMode.validate(textField.text!, emailCheck: nil, passwordCheck: otherPasswordField?.text) == true{
                _ = textFieldShouldReturn(textField)
                // isValid = validationMode.validate(textField.text!,emailCheck: nil,passwordCheck: otherPasswordField?.text)
            }else{
                
                self.isValid = nil
            }
        }
        
        if validationMode == .emailCheck{
            if validationMode.validate(textField.text!, emailCheck: otherEmailField?.text, passwordCheck: nil) == true{
                
                _ = textFieldShouldReturn(textField)
                // isValid = validationMode.validate(textField.text!,emailCheck: otherEmailCheck?.text,passwordCheck: nil)
            }else{
                
                self.isValid = nil
            }
        }
        
    }
    
    func textFieldDidEdit(_  textField: UITextField){
        
        isValid = validationMode.validate(textField.text!,emailCheck: otherEmailField?.text,passwordCheck: otherPasswordField?.text)
        
        if validationMode == .cp && textField.text?.characters.count == 5{
            
            self.delegate!.validateCodigoPostal?(_field: self, codigoPostalValidate: true, mensajeError: "Algo extraño sucedio? 0_o")
        }
        
        if validationMode == .passwordCheck{
            if validationMode.validate(textField.text!, emailCheck: nil, passwordCheck: otherPasswordField?.text) == true{
                _ = textFieldShouldReturn(textField)
            }else{
                
                self.isValid = nil
            }
        }
        
        if validationMode == .emailCheck{
            if validationMode.validate(textField.text!, emailCheck: otherEmailField?.text, passwordCheck: nil) == true{
                
                _ = textFieldShouldReturn(textField)
            }else{
                self.isValid = nil
            }
        }
        
        self.delegate!.TextFieldValidate!(_field: self, errorMessage: "Algo extraño sucedio al validar los campos o_0")
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
   
}





# Easy Register

Create easy your Text Fields!

You can validate this form 
* Name
* Email 
* Phone
* Password 
* C.P.
* Number 
* EmailCheck 
* PasswordCheck 
* Addres 


  ![](https://image.ibb.co/bN2zfQ/Text_Field_Easy_Images3.png)

# Step 1
    Use a view and use custom class : TextFieldFormEasy
![](https://image.ibb.co/hXduEk/Text_Field_Easy_Images.png)
# Step 2
    Write Error Text, image valid, background color, Text Color etc..
![](https://image.ibb.co/iu0Vn5/Text_Field_Easy_Images2.png)

# Delegate
You need Delegate TextFieldFormEasyDelegate 
```sh
TextFieldFormEasyDelegate
```
- Validate postal code 
```sh
func validateCodigoPostal(_field: TextFieldFormEasy, codigoPostalValidate result: Bool, mensajeError: String?)
```
- textFieldDidEndEditing 
```sh
func TextFieldValidate (_field: TextFieldFormEasy, errorMessage errorMensaje: String? )
```
# Example 

```sh
    @IBOutlet weak var nombre: TextFieldFormEasy!
    override func viewDidLoad() {
        super.viewDidLoad()
        nombre.delegate = self
        nombre.mode = TextFieldFormEasyType.name.rawValue
        // Do any additional setup after loading the view.
    }
```


**Free Software, Hell Yeah!**

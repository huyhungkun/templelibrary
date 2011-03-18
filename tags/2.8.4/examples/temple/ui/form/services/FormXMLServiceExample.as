/**
 * @exampleText
 * 
 * <a name="FormXMLService"></a>
 * <h1>FormXMLService</h1>
 * 
 * <p>This is an example of the FormXMLService. In this case we send the submitted data to an XML file, which acts as the result of a possible backend server.
 * By setting the Flash var "success" to true, we fake a successful submit, otherwise we fake an error.</p>
 * 
 * <p>View this example online at: 
 * 	<ul>
 * 		<li>Error result: <a href="http://templelibrary.googlecode.com/svn/trunk/examples/temple/ui/form/services/FormXMLServiceExample.swf?success=false" target="_blank">http://templelibrary.googlecode.com/svn/trunk/examples/temple/ui/form/services/FormXMLServiceExample.swf?success=false</a></li>
 * 		<li>Success result: <a href="http://templelibrary.googlecode.com/svn/trunk/examples/temple/ui/form/services/FormXMLServiceExample.swf?success=true" target="_blank">http://templelibrary.googlecode.com/svn/trunk/examples/temple/ui/form/services/FormXMLServiceExample.swf?success=true</a></li>
 * 	</ul>	
 * 	</p>
 * 
 * <p><a href="http://templelibrary.googlecode.com/svn/trunk/examples/temple/ui/form/services/FormXMLServiceExample.as" target="_blank">Download source</a></p>   
 */
package
{
	import temple.data.flashvars.FlashVars;
	import temple.ui.form.Form;
	import temple.ui.form.FormEvent;
	import temple.ui.form.services.FormXMLService;
	import temple.ui.form.validation.rules.EmailValidationRule;
	import temple.ui.form.validation.rules.EmptyStringValidationRule;
	import temple.utils.color.Colors;

	import flash.net.URLRequestMethod;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;

	public class FormXMLServiceExample extends DocumentClassExample
	{
		private var _label:TextField;
		
		public function FormXMLServiceExample()
		{
			super("Temple - FormXMLServiceExample");
			
			// By setting the flash var "success" to true, we fake a successful submit.
			FlashVars.initialize(this.loaderInfo.parameters);
			FlashVars.configureVar("success",  false, Boolean);
			
			// Create a FormXMLService which handles our form.
			// For this case we just submit the data to an XML file, normally you would send it to a backend server.
			// The XML file acts as the result of the backend server.
			// If the Flash var "success" is set to true, we use an XML file without errors, otherwise we use an XML with an error.
			var service:FormXMLService = new FormXMLService(FlashVars.getValue("success") ? "submit_success.xml" : "submit_error.xml"); 
			
			// we set method to GET, since Google Code doesn't allow us to send POST data to an XML file.
			service.method = URLRequestMethod.GET;

			// XML when the submit was successful
			//var service:FormXMLService = new FormXMLService('submit_success.xml'); 
			
			// Create a form
			var form:Form = new Form(service);
			
			// we enable debugging, so we can see debug info in Yalala: http://yalala.tyz.nl/
			form.debug = true;
			
			var label:TextField = new TextField();
			label.autoSize = TextFieldAutoSize.LEFT;
			label.text = "This is an example of a login form";
			label.x = 20;
			this.addChild(label);
			
			// Create a field for the email
			var emailInput:Input = new Input();
			emailInput.hintText = "email address";
			emailInput.x = 20;
			emailInput.y = 30;
			this.addChild(emailInput);
			
			// Add field to the form
			form.addElement(emailInput, "email", EmailValidationRule, "This is not a valid email address");

			// Create a field for the password
			var passwordInput:Input = new Input();
			passwordInput.displayAsPassword = true;
			passwordInput.hintText = "password";
			passwordInput.x = 20;
			passwordInput.y = 60;
			this.addChild(passwordInput);

			// Add field to the form
			form.addElement(passwordInput, "password", EmptyStringValidationRule, "Please fill in your password");
			
			// Create a submit button
			var button:Button = new Button();
			button.x = 20;
			button.y = 104;
			this.addChild(button);
			
			form.addSubmitButton(button);
			
			// Create a label for displaying error or success messages
			this._label = new TextField();
			this._label.autoSize = TextFieldAutoSize.LEFT;
			this._label.x = 20;
			this._label.y = 82;
			this.addChild(this._label);
			
			form.addEventListener(FormEvent.RESET, this.handleFormEvent);
			form.addEventListener(FormEvent.VALIDATE_SUCCESS, this.handleFormEvent);
			form.addEventListener(FormEvent.VALIDATE_ERROR, this.handleFormEvent);
			form.addEventListener(FormEvent.SUBMIT_SUCCESS, this.handleFormEvent);
			form.addEventListener(FormEvent.SUBMIT_ERROR, this.handleFormEvent);
			
			form.reset();
		}

		private function handleFormEvent(event:FormEvent):void
		{
			switch (event.type)
			{
				case FormEvent.RESET:
				{
					this._label.text = "";
					this._label.textColor = Colors.BLACK;
					break;
				}
				case FormEvent.VALIDATE_SUCCESS:
				{
					this._label.text = "";
					this._label.textColor = Colors.BLACK;
					break;
				}
				case FormEvent.VALIDATE_ERROR:
				{
					this._label.text = event.result.message;
					this._label.textColor = Colors.RED;
					break;
				}
				case FormEvent.SUBMIT_SUCCESS:
				{
					this._label.text = event.result.message;
					this._label.textColor = Colors.BLACK;
					break;
				}
				case FormEvent.SUBMIT_ERROR:
				{
					this._label.text = event.result.message;
					this._label.textColor = Colors.RED;
					break;
				}
			}
		}
	}
}
import temple.ui.buttons.MultiStateButton;
import temple.ui.form.components.InputField;
import temple.ui.states.error.ErrorFadeState;
import temple.ui.states.over.OverFadeState;
import temple.utils.color.Colors;

import flash.filters.BevelFilter;
import flash.filters.DropShadowFilter;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFieldType;
import flash.text.TextFormat;
import flash.text.TextFormatAlign;

class Input extends InputField
{
	public function Input()
	{
		super(this.addChild(new TextField()) as TextField);
		
		textField.border = true;
		textField.background = true;
		textField.width = 200;
		textField.height = 20;
		textField.type = TextFieldType.INPUT;
		textField.filters = [new DropShadowFilter(2, 45, 0, 1, 4, 4, .5, 1, true)];
		this.addChild(textField);

		this.hintTextColor = Colors.GRAY;
		this.errorTextColor = Colors.RED;
		
		// create an error state
		var errorText:TextField = new TextField();
		var error:ErrorFadeState = new ErrorFadeState(.5, .5, errorText);
		error.graphics.lineStyle(2, Colors.RED);
		error.graphics.drawRect(0, 0, textField.width, textField.height);
		errorText.x = textField.width + 4;
		errorText.textColor = Colors.RED;
		errorText.autoSize = TextFieldAutoSize.LEFT;
		error.addChild(errorText);
		this.addChild(error);
		
	}
}

class Button extends MultiStateButton
{
	public function Button()
	{
		this.graphics.beginFill(Colors.LIGHT_GREY);
		this.graphics.drawRect(0, 0, 100, 30);
		this.graphics.endFill();
		
		this.filters = [new BevelFilter(2, 45, Colors.WHITE, 1, Colors.BLACK, 1, 2, 2)];
		
		// Create an IOverState in the button to highlight the button when the mouse hovers the button.
		// We use a 'FadeState' for this one, the the highlighting is animated.
		var overState:OverFadeState = new OverFadeState(.1);
		overState.graphics.beginFill(Colors.GRAY);
		overState.graphics.drawRect(0, 0, 100, 30);
		overState.graphics.endFill();
		this.addChild(overState);
		
		var label:TextField = new TextField();
		label.width = 100;
		label.text = "log in";
		label.y = 2;
		
		var format:TextFormat = new TextFormat();
		format.align = TextFormatAlign.CENTER;
		format.size = 16;
		
		label.setTextFormat(format);
		
		this.addChild(label);
	}

}

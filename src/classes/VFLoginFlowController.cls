public class VFLoginFlowController {
    public String code {get;set;}
    public Boolean coderend{get;set;}
    String startUrl;
    
    String userId = UserInfo.getUserId(); 
    public String email {get; set;}
    public String inputCodeValue{get; set;}
    
    
    public VFLoginFlowController (){
          
          coderend = true;
          email = getEmail();
          code = codeGenerator();
         // SendEmail();
          /*Auth.SessionManagement.FinishLoginFlow();
       return new PageReference(startURL);*/
    
    }
    public String getEmail()
    {
        User u = [select email from User where id=:userId LIMIT 1];
        
        return u.email;    
    }
    
    public String codeGenerator(){
        Integer rand = Math.round(Math.random()*100000);
        return string.valueOf(rand);
    
    }
    
    
    public void SendEmail(){
    
        
        Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
        // Set recipients to two contact IDs.
        // Replace IDs with valid record IDs in your org.
        message.toAddresses = new String[] {email ,'sshiv120@in.ibm.com'};
        message.subject = 'Verification Code';
        message.plainTextBody = 'This is your code:- '+code;
        Messaging.SingleEmailMessage[] messages = 
            new List<Messaging.SingleEmailMessage> {message};
                 Messaging.SendEmailResult[] results = Messaging.sendEmail(messages);
        if (results[0].success) {
            System.debug('The email was sent successfully.');
        } else {
            System.debug('The email failed to send: '
                  + results[0].errors[0].message);
        }
    }

    public PageReference FinishLoginFlowStartUrl() {
        //do stuff
        if(code == inputCodeValue){
          startURL = System.currentPageReference().getParameters().get('startURL');
         //finish the login flow and send you to the startUrl (account page in this case)
           return Auth.SessionManagement.finishLoginFlow(startURL);
        }
        else{
         ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM,'Please enter correct code'));
         return null;
        }
    }


    public PageReference FinishLoginFlowHome() {
        //do stuff
        
        //finish the login flow and send you the default homepage
        return Auth.SessionManagement.finishLoginFlow();
    }
}
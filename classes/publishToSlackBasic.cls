public class publishToSlackBasic{
     
    public class slackRequest { 
        @InvocableVariable(label='Slack Message' required=true) 
        public String slackMessage; 
        @InvocableVariable(label='Channel/User to post to' required=true) 
        public String channel; 
    } 
    
    @InvocableMethod(label='Publish to Slack')
    public static void publishToSlack(List<slackRequest> requests) {
        String webhookURL='https://hooks.slack.com/ENTER_YOUR_OWN_WEBHOOK_URL'; 
        for(slackRequest r:requests){
            JSONGenerator gen = JSON.createGenerator(true);
            gen.writeStartObject(); //Inserts {
            gen.writeStringField('text', r.slackMessage);
            gen.writeStringField('channel', r.channel);
            gen.writeStringField('username', 'Salesforce Bot');
            gen.writeStringField('icon_emoji', ':robot_face:');
            gen.writeEndObject(); //Inserts }
 
            String body = gen.getAsString(); //Translates JSONGenerator to string to be passed to callout
            System.debug(body);
            System.enqueueJob(new qCallOut(webhookURL, 'POST', body));
        } 
    }
   
    public class qCallOut implements System.Queueable, Database.AllowsCallouts {
         
        //private final String url;
        private final String method;
        private final String body;
         
        public qCallOut(String url, String method, String body) {
            //this.url = url;
            this.method = method;
            this.body = body;
        }
         
        public void execute(System.QueueableContext ctx) {
            HttpRequest req = new HttpRequest();
            req.setEndpoint('callout:SlackPush');
            req.setMethod(method);
            req.setBody(body);
            Http http = new Http();
            HttpResponse res = http.send(req);
        }
    }
}
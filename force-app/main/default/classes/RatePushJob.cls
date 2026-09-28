public class RatePushJob implements Queueable {
    
    private List<Id> remaining; 
    private Integer link;


    public RatePushJob (List<Id> remaining,Integer link){
            this.remaining = remaining; 
            this.link = link;

    }


        public void execute(QueueableContext ctx) {
        System.debug('link ' + link + ' | received ' + remaining.size());
    }

    }
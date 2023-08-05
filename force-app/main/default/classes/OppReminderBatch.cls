public class OppReminderBatch implements Database.Batchable<sObject>, Schedulable {
    public Database.QueryLocator start(Database.BatchableContext BC) {
        Date due = Date.today().addDays(3);
        return Database.getQueryLocator([
            SELECT Id, Name, CloseDate, OwnerId, Owner.name
            FROM Opportunity
            WHERE CloseDate = :due AND IsClosed = FALSE
        ]);
    }

    public void execute(Database.BatchableContext BC, List<Opportunity> oppList) {
        List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
        for (Opportunity opp : oppList) {
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            mail.setSubject('Opportunity Required Action!');
            mail.setTargetObjectId(opp.OwnerId);
            mail.setSaveAsActivity(false);
            mail.setPlainTextBody(
                'Hello ' + opp.owner.name + ',\n' +
                'Opportunity ' + opp.Name + ' has to be closed. Please finalize your sales process.' + '\n' +
                'Opportunity Details' + '\n' +
                'Name: ' + opp.Name + '\n' +
                'Close Date: ' + opp.CloseDate + '\n'
            );
            mails.add(mail);
        }
        Messaging.sendEmail(mails);
    }

    public void finish(Database.BatchableContext BC) {}

    public void execute(SchedulableContext sc) {
        OppReminderBatch batch = new OppReminderBatch();
        Database.executeBatch(batch);

        // Reschedule the job to run daily at midnight
        Datetime nextRun = Datetime.now().addDays(1).date();
        String jobId = System.schedule('Opp Reminder Batch - Daily', '0 0 0 * * ?', new OppReminderBatch());
    }
}

public with sharing class ContactBirthdayEmailBatch implements Database.Batchable<SObject>, Schedulable {
  public Database.QueryLocator start(Database.BatchableContext bc) {
    return Database.getQueryLocator(
      [
        SELECT Id, Birthdate, Email, FirstName, LastName
        FROM Contact
        WHERE
          Email != NULL
          AND CALENDAR_MONTH(Birthdate) = :System.today().month()
          AND DAY_IN_MONTH(Birthdate) = :System.today().day()
      ]
    );
  }

  public void execute(Database.BatchableContext bc, List<Contact> conList) {
    //email list created
    List<Messaging.SingleEmailMessage> mailList = new List<Messaging.SingleEmailMessage>();
    //for loop used to send email to all contacts that available
    for (Contact con : conList) {
      //a mail template cretaed to send to all contacts
      Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
      mail.setToAddresses(new List<String>{ con.Email });
      mail.setSubject(
        'Happy Birthday ' +
          (con.FirstName != null ? con.FirstName + ' ' : '') +
          con.LastName + '!'
      );
      mail.setPlainTextBody(
        'As Silverline family, we wish you a very happy birthday and send you best wishes for much happiness in your life!'
      );
      mailList.add(mail);
    }
    List<Messaging.SendEmailResult> result = Messaging.sendEmail(mailList);
    for (Messaging.SendEmailResult emailResult : result) {
      System.debug(
        emailResult.success
          ? 'The mail was successfully sent by Batch Apex'
          : 'The mail failed to send: ' + emailResult.getErrors()
      );
    }
  }

  public void finish(Database.BatchableContext bc) {}

  public void execute(SchedulableContext sc) {
    Database.executeBatch(new ContactBirthdayEmailBatch());
  }
  // Schedule the batch job to run daily at a specific time
  public static void scheduleJob() {
    String cronExp = '0 0 0 * * ?';
    System.schedule(
      'ContactBirthdayEmailBatchJob',
      cronExp,
      new ContactBirthdayEmailBatch()
    );
  }
}

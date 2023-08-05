@IsTest
private class TestContactBirthdayEmailBatch {
  @IsTest
  static void testContactBirthdayEmailBatch() {
    // Create test contacts with birthdays for the current day
    List<Contact> testContacts = new List<Contact>();
    Date today = Date.today();

    Contact testContact1 = new Contact(
      FirstName = 'Ridvan',
      LastName = 'Saman',
      Birthdate = today,
      Email = 'ridvan@test.com'
    );
    testContacts.add(testContact1);

    Contact testContact2 = new Contact(
      FirstName = 'Ezgi',
      LastName = 'Saman',
      Birthdate = today,
      Email = 'ezgi@test.com'
    );

    testContacts.add(testContact2);

    insert testContacts;

    // Start the batch job manually
    Test.startTest();
    ContactBirthdayEmailBatch batch = new ContactBirthdayEmailBatch();
    Database.executeBatch(batch);
    Test.stopTest();

    // Verify that emails were sent
    List<EmailMessage> sentEmails = [
      SELECT Id, Subject
      FROM EmailMessage
      WHERE Subject LIKE 'Happy Birthday%'
    ];
    System.assertEquals(2, sentEmails.size(), 'Expected 2 emails to be sent');
  }
}

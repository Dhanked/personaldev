/**
 * Created by shivani on 24/05/20.
 */
@IsTest
public class UnitOfWorkTest {

    @IsTest
    public static void challengeComplete(){

        fflib_SObjectUnitOfWork uow = new fflib_SObjectUnitOfWork(
                new Schema.SObjectType[] {
                        Account.SObjectType,
                        Contact.SObjectType,
                        Note.SObjectType }
        );
        for(Integer o=0; o<100; o++) {
            Account aAccount = new Account();
            aAccount.Name = 'UoW Test Account Name ' + o;
            uow.registerNew(aAccount);
            for(Integer i=0; i<5; i++) {
                Contact aContact = new Contact();
                aContact.LastName = aAccount.Name + ' : Contact : ' + i;
                aContact.CompanyEmail__c ='test'+i + 'x'+o+'@test.com';
                uow.registerNew(aContact,Contact.AccountId,aAccount);
                Note aNote = new Note();
                aNote.Title = 'Notetitle';
                aNote.Body = 'NoteBody';

                uow.registerNew(aNote, Note.ParentId, aContact);

            }
        }
        test.startTest();
        uow.commitWork();
        test.stopTest();
        System.assertEquals(100, [Select Id from Account].size());
        System.assertEquals(500, [Select Id from Contact].size());
        System.assertEquals(500, [Select Id from Note].size());
    }
}
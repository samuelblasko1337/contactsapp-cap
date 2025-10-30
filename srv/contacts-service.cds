using contactsapp from '../db/schema';
service ContactsService {
  entity Contacts as projection on contactsapp.Contacts;
}

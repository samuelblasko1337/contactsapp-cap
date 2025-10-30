namespace contactsapp;

entity Contacts {
  key ID        : UUID;
  firstName     : String(80);
  lastName      : String(80);
  company       : String(120);
  jobTitle      : String(120);      // Position
  email         : String(255);
  phoneWork     : String(40);       // Telefon geschäftlich
  phonePrivate  : String(40);       // Telefon privat
  favorite      : Boolean;          // Favorit (ja/nein)
  notes         : String(2000);     // Notizen
  avatarUrl     : String(500);      // Profilbild-URL
  owner         : String(255);      // User/Owner ID
  createdAt     : Timestamp;
  updatedAt     : Timestamp;
}

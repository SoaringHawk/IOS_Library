# iOS Library Book Rental App

This app is a SwiftUI-based book rental platform integrated with Firebase Firestore. It provides book browsing, rental functionality, user registration/login, and admin-level book management.

---

## Features

### Book Management
- View a real-time list of books
- Random featured book display
- Rent and return books
- See who rented a book (if any)

### User Management
- Register/login using email & password
- User roles defined by an `isAdmin` flag in Firestore
- Store user info in `Users` Firestore collection

### Admin Features
- Add new books
- Delete books from the list
- Admin logic triggered by the `isAdmin` field
- Admin UI is conditionally rendered in views

---

## Architecture

- **UI:** SwiftUI-based views
- **ViewModel:** `BooksViewModel` centralizes all logic for book handling and Firestore interaction
- **Persistence:** Firebase Firestore (manual integration; no Firebase Auth SDK yet)
- **Auth:** Custom email/password logic via Firestore queries (Firebase Auth integration planned)

---

## Firestore Structure

### `Books` Collection

Each book document includes:
- `title`: String  
- `author`: String  
- `category`: String  
- `description`: String  
- `imgUrl`: String (cover image URL)  
- `pdfLink`: String (link to PDF of book)  
- `isRented`: Bool  
- `renter`: Array of Strings (emails of users who rented the book)  

### `Users` Collection

Each user document includes:
- `email`: String  
- `password`: String  
- `isAdmin`: Bool   

---

## Developers

- Christian Denis Marcelin
- Yunxian Xu
- Sarah Leventon

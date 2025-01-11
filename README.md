# 🔍 ScanScript 📄
ScanScript is a mobile application developed with Dart and Flutter that functions as an OCR regular expression scanner. This application was developed as my final project in compliance with our Automata and Finite Languages subject. 

## How To Use 🔍
**Step 1:** After opening ScanScript, you should land in the Home Screen.
<br>
<img height="250" src="https://github.com/user-attachments/assets/73ebdcd1-f29d-457a-a5b7-43e0a744f881">
<br>
**Step 2:** Add Regular Expressions by clicking the **Add** button in the bottom navigation bar.
<br>
<img height="250" src="https://github.com/user-attachments/assets/c32b3c5a-6b14-4530-920c-0d2039e3931b"> <img height="250" src="https://github.com/user-attachments/assets/8f79a6f4-eb4c-4c24-bf5c-1081de3509ec">
<br>
**Step 3:** Next, select an image to scan either by snapping an image with the **Camera** or choosing from the **Gallery**. 
<br>
<img height="250" src="https://github.com/user-attachments/assets/d25efdb0-b22b-4ac5-9c73-160fbb631a63">
<br>
**Step 4:** After the image is processed, the app redirects you to a findings screen where all instances of the RegExp patterns are highlighted.
<br>
<img height="250" src="https://github.com/user-attachments/assets/66cd6959-419c-4c6e-ad60-f193907f0116">
<br>

## Technologies Used 🛠️
As mentioned above, the mobile application was constructed with **Dart** and **Flutter**. External Flutter packages that involved image selection, image cropping, and text recognition were employed to implement the OCR scanning features.

Flutter Packages from [**pub.dev**](https://pub.dev/):
- [image_picker](https://pub.dev/packages/image_picker)
- [image_cropper](https://pub.dev/packages/image_cropper)
- [google_mlkit_text_recognition](https://pub.dev/packages/google_mlkit_text_recognition)

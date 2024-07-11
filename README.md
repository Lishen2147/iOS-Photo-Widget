#  Photo Widget

This is custom iOS app that let you select a photo from your Photo Library and display it on widget.

## Prepare
After git clone this, you need to create an app group for data between the app and widget
1. Double click on the project name in the File Explorer pane
2. In the right side of the project setting, Choose the **TARGETS** of the main app (**PhotoWidget**)
3. Clink on **Signing & Capabilities** tab
4. Click on the second-to-the-right button located at the top-right corner of the Xcode, which looks like an "add sign within a rounded-rectangle frame"
5. Add a **App Group**
6. Check on the added group which should be named as "group.\*\*\*.\*\*\*"
7. Look back to right side of the project setting, Select the widget under **TARGETS**
8. Check on the same app group.
9. Copy the app group name and paste into the suite names in `PhotoWidget/ContentView.swift` and `ImageShowCaseWidget/ImageShowCaseWidget.swift`

## Then you should be ready to run the code
select a simulator or your iPhone.
hit `command + r` to build & run.

## Screenshots of Product
![iVBORw0KGgoAAAANSUhEUgAAA9IAAAdrCAYAAABeGYRwAAAACXBIWXMAAAsTAAALEwEAmpwYAAAJ](https://github.com/Lishen2147/iOS-Photo-Widget/assets/65699767/479223cf-8e88-4765-b36b-464b0f6d4f15)
![iVBORw0KGgoAAAANSUhEUgAAA9IAAAdrCAYAAABeGYRwAAAACXBIWXMAAAsTAAALEwEAmpwYAAAJ 2](https://github.com/Lishen2147/iOS-Photo-Widget/assets/65699767/bfbb3c33-b6d0-40ab-8576-44ef52305f4a)
![iVBORw0KGgoAAAANSUhEUgAAA9IAAAdrCAYAAABeGYRwAAAACXBIWXMAAAsTAAALEwEAmpwYAAAJ 3](https://github.com/Lishen2147/iOS-Photo-Widget/assets/65699767/d0e28a35-d9da-43d4-8739-3cb885eec8d4)

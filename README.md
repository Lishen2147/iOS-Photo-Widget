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

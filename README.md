# lite_harvest

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Wireless debugging
Go to phone settings
Select on version
Click Build number until developer options are enabled
Go to developer options 
On wireless debugging
Run the following code in terminal in this folder cd C:\Users\Admin\AppData\Local\Android\Sdk\platform-tools 
>./adb tcpip 5555
>./adb connect [IP address]
or
>.\adb pair [IP address]:[Paring code]
Go back to the project file and run the code
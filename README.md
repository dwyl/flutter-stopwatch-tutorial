<div align="center">

    # Flutter Stopwatch ⏱

    A tutorial for building a basic stopwatch from scratch using flutter. 

</div>

# What? 🤷‍♀️
This is a quick tutorial that will get you up-and-running
in less than **20 minutes** with a simple app 
that functions as a stopwatch that also *persists*
in-between sessions. 

# Why? 💡
We wanted to build the simple Flutter app 
with a stopwatch to test how complex it would be
before adding this to our [`app`](https://github.com/dwyl/app).

# Giving it a whirl 📲
You can try the finished app before trying to build it.
Simply clone this project, fetch the dependencies
and get it running!

```sh
git clone https://github.com/dwyl/flutter-stopwatch-tutorial.git

cd flutter-stopwatch-tutorial

flutter pub get
```

If this is your time running a Flutter app,
either be it on a real device or an emulator,
please check the [`learn-flutter`](https://github.com/dwyl/learn-flutter/tree/update-info#installing-flutter-%EF%B8%8F)
repository to setup everything you need to get started on your Flutter journey!

After all of this, you can simply run the app
and give it a try!

## Running on a real device
If you are interested in running the app on your
Android or iOS device, you should follow these instructions.

### Android
Running the app on an Android device is quite easy.
You first need to [enable developer options](https://developer.android.com/studio/debug/dev-options) and USB debugging on your device.
You can tap your `device build number` several times
and the "Developer Options" option will come up.
Now it's just a matter of enabling `USB debugging` as well 
and you should be sorted.

After this, it's just a matter of plugging your phone
to your computer with a USB cable. 
You can check if the device is properly connected by running

```sh
flutter devices
```

And you should be able to see the connected phone.

![connected_device](https://user-images.githubusercontent.com/17494745/201946732-a45299e6-66b4-4ef2-9499-f62a2190ec2c.png)

If you are using visual studio, you can choose the device
in the bottom bar and pick your phone. 
To run, simply press `F5` or `Run > Start debugging`
and the build process will commence and the app will be running on your phone!

> If this is your first time running on an Android device/emulator, 
> it might take some time so Gradle downloads all the needed dependencies,
> binaries and respective SDKs to build the app to be run on the app. 
> Just make sure you have a solid internet connection. 

> **Do not** interrupt the the building process on the first setup.
> This will result in a corrupted `.gradle` file and you need to 
> clean up to get the app working again. If this happens to you, 
> check the [`learn-flutter`](https://github.com/dwyl/flutter-counter-example/tree/update-info#running-on-a-real-device-)
> repo, in the `Running on a real device` section to fix this issue.

### iOS
The process is a wee more complicated because you need an
**Apple ID** or to sign up for a [`Developer Account`](https://developer.apple.com/programs/enroll/).

After this, open `XCode` and sign in with your ID 
(inside `Preferences > Accounts`).

![preferences](https://user-images.githubusercontent.com/17494745/202515691-d4d3832b-8b6e-4e3b-953f-9c01b4a87228.png)

Inside `Manager Certificates`, click on the "+" sign and
select `iOS Development`.

![certificates](https://user-images.githubusercontent.com/17494745/202516745-ba05bfac-20db-492f-9580-3aa7cc09803a.png)


After this, plug the device to your computer.
Find the device in the dropdown (`Window > Organizer`).
Below the team pop-up menu, click on `Fix Issue`
and then on `XCode` click the `Run` button.

In subsequent runs, you can deploy with VSCode
or any other IDE. 
This certificate setup is only needed on the first time with XCode.

## Demo
Here's a quick demo of what the app will look like,
running on an OnePlus 6T.

We're going to have a **stopwatch** that persists
each `timer` that is created everytime it's paused.
This way, we are saving not only the amount of times
the stopwatch was stopped and restarted but also when.

![demo](https://user-images.githubusercontent.com/17494745/202527641-95b5b33c-1824-47e0-ac75-4286497a3d1b.gif)


# How? 💻


---


The database class from this guide is ready to be used with your app. For Flutter apps, a Drift database class is typically instantiated at the top of your widget tree and then passed down with provider or riverpod. See using the database for ideas on how to integrate Drift into your app's state management.
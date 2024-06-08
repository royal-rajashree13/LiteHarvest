# lite_harvest

LITE HARVEST: Wick-Based Hydroponics System With Mobile  Application
This project focuses on the development of a wick-based hydroponics system integrated with sensors and a mobile application for remote monitoring and control. The objectives were to design a hardware setup capable of monitoring temperature, TDS, and EC levels in water, automate water flow control, and provide real-time data visualization and notifications through a mobile app.  The hardware comprises temperature, and TDS sensors placed in water bucket which is connected to a water motor controlling water flow to cups of plant in the hydroponic setup. A water level sensor ensures optimal water levels. Data from the sensors are transmitted to a cloud database via Wi-Fi. The mobile application enables users to access setup instructions, view real-time temperature, TDS, and EC values, and receive notifications if thresholds are exceeded. Admins have additional privileges to manage user accounts. In the findings, the hardware successfully measures and controls environmental parameters, ensuring optimal growing conditions for the plants. The mobile application provides intuitive user interface and effective data visualization, enhancing user experience and facilitating remote monitoring. Threshold notifications enable timely intervention, contributing to improved plant health and yield.

<img src="https://github.com/gkylsk/LiteHarvest/assets/130023461/94905b24-14b5-470d-8f45-29396e7a03ec" alt="Hardware-1" width="250" height="300">
<img src="https://github.com/gkylsk/LiteHarvest/assets/130023461/f2b92e69-9ad6-4aae-b4fb-b68705f4867b" alt="Hardware-2" width="250" height="250">
<img src="https://github.com/gkylsk/LiteHarvest/assets/130023461/d6598135-e821-46d2-b7b3-170e344f0e7a" alt="Wick setup" width="300" height="200">
<img src="https://github.com/gkylsk/LiteHarvest/assets/130023461/7794b849-d8fb-4fae-881d-eed1be7f26b6" alt="Home Page" width="500" height="300">
<img src="https://github.com/gkylsk/LiteHarvest/assets/130023461/f4561513-b722-4fab-bc08-41035290015e" alt="Admin Dashboard" width="500" height="300">
<img src="https://github.com/gkylsk/LiteHarvest/assets/130023461/0dc1566d-555a-4d8b-a470-dc59110bd9c2" alt="Management Login" width="500" height="300">
<img src="https://github.com/gkylsk/LiteHarvest/assets/130023461/dff9105d-8158-4f39-9de9-6fa148f03758" alt="image" width="500" height="300">
<img src="https://github.com/gkylsk/LiteHarvest/assets/130023461/10d1f36f-683b-4457-ad9a-c0fa32213203" alt="Notification" width="500" height="300">

## Download App in Phone 
The system and mobile should be connected to the same network
## Wireless debugging 
Go to phone settings
Select on version
Click Build number until developer options are enabled
Go to developer options 
On wireless debugging
Run the following code in the terminal using path cd C:\Users\Admin\AppData\Local\Android\Sdk\platform-tools 
>./adb tcpip 5555
>./adb connect [IP address]
or
>.\adb pair [IP address]:[Paring code]
Go back to the project file and run the code

## Database
Used Firebase for real-time database
To be able to obtain real-time data the Firebase project fingerprint needs to be uploaded to FirebaseHttpClient.h file

## Notifiction
Download simple push app
Upload code to ESP8266 by providing the key

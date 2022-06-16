# Pitstop

PitStop is an iOS App to track your car's expenses. This project is currently being developed in team with [Ivan Voloshchuk](https://github.com/IV0000), [Francesco Puzone](https://github.com/morbuen) and [Anna Antonova](https://github.com/Oneanya21).

## Overview
The first time you download the app, you are invited through the on-boarding to insert your car's data such as brand, model and fuel type.
Everytime you make a purchase related to your car you can report it by inserting data through a modal sheet, where you can choose between a variety of categories and options, as well as changing the date of the expense. This will allow the system to create statistics in real time, to increase your awareness of your spendings throughout the year. Additionally, we have built a **Document** section to let you save your car documents all in one place and an **Important Numbers** section for saving numbers to reach straight away, in case any unpredictable event occurs. 

Do you find annoying have to remember when you need to overhaul the car? Or if you need to change the tires? I believe so, same as for most of us, that's why we implemented a notification feature!

## Features
- Add your car details
- Add an expense, odometer count, notification reminder
- Add document 
- Add numbers
- Expense view
- Statistics about odometer, vehicle efficiency, and costs
- Modify and change your car details as well as you expenses details


## Frameworks & Technologies
We used **SwiftUI** to create the user interface, **Swift** as main programming language and **CoreData** to save our user's persistent data.
The design pattern we adopted is **MVVM** with different view models for handling CoreData access, the statistics, categories and fuel type...

## Screenshots

<img src="https://user-images.githubusercontent.com/94223094/169893103-be24dbd0-4efd-4f70-8f96-eb3e595ff5ec.gif" width="280" height="570"/>   <img src="https://user-images.githubusercontent.com/94223094/169893079-7e227b06-69ef-42ff-8b46-56c2ecdda6ec.gif" width="280" height="570"/>


## Appstore
Try Pitstop on [Appstore](https://apps.apple.com/it/app/pitstop-vehicle-manager/id1626259038?l=en)!

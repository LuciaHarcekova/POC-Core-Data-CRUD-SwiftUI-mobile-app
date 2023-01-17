# Core Data (CRUD) with SwiftUI

![Swift](https://img.shields.io/badge/swift-F54A2A?style=for-the-badge&logo=swift&logoColor=white)

Core Data is a graphical and persistence framework, which is used in Apple devices with operating systems macOS and iOS. Core Data was first introduced in Mac OS X 10.4 Tiger and iOS with iPhone SDK 3.0. It allows data to be organized in a relational entity–attribute model manner, so that it can be serialized into XML, binary, or SQLite stores.
You can utilize Core Data to save your application’s permanent data for offline use, to cache temporary data, and to add undo functionality to your app on a single device.
Core Data automatically reflects your schema to a CloudKit container to sync data across multiple devices in a single iCloud account.
You can specify your data’s types and relationships and develop respective class definitions. Core Data can manage object instances at runtime through Core Data’s Data Model editor.
Core Data has certain disadvantages as it can only store data once entered, which is not like a typical SQL database. 
In other words, Core Data keeps an object graph in the memory hence it can only work with records in the memory. You can understand this like, suppose you want to delete or update 100 records, so first you need to load all the records in the memory.

## Building the solution

### Creating project
You have two option
1. Create a new project with the Core Data by selecting “Use Core Data”.
2. After creating the project add files for Core Data (e.g. Data Model).
Once the Data Model is created, you will see a file like "CoreDataTest.xcdatamodeld".

### Creating the data model 
Go to the Core Data Model file, you will see a tool. This tool allows you to configure entities, these entities represent data models.
Here you can define some of the things for each and every entity but remember that Attributes and Relationships will be most important.

Press the plus button to create a new Entity, and give it the name Note. Inside an Entity, there are Attributes (like columns in SQL). Add the following attributes:
- noteText as a type String: The text of the note we write.
- priorityColor as a type Transformable: The UIColor of the selected priority.
- dateAdded as a type Date: The date the note was added.


### Saving records
The procedure of adding the records to Core Data includes the following tasks:
- Create the context
```
let container = NSPersistentContainer(name: "NotesModel")
```
- Create an entity
```
let newNote = Note(context: moc)
```
- Add data to the new record
```
newNote.id = UUID()
newNote.title = title
newNote.text = text
newNote.creationDate = Date()
newNote.priority = Int16(priority)
newNote.color = UIColor(color)
```
- For each key, you need to set values for the records.
```
try? moc.save()
```

### Fetching data
The procedure of the fetching data contains of the following tasks:
- Craft and organize the request of type NSFetchRequest for the entity.
- Use predicate for filter data (if required).
- Fetch the result from the context in the form of an array of [NSManagedObject].
- You need to iterate through an array to obtain value with the specific key.


### Saving colors

I found out multiple approaches how to deal with savings colors. 
- create a new entity and save r, g, b parts separately as attributes 
- save color in its HEX code <- picked approach

1. We add a new attribute to our Model, I named it **colorAsHex** of type String.
2. Then, we create an extension for the UIcolor class. In the extension, we define a convenience initializer for creating a UIColor instance from a hex value. `convenience init?(hex: String)`
3. We also implement a computed property for converting a UIColor instance to its corresponding hex value. `var toHex: String?`
4. We create an extension for the **Note** and define a computed property **color**, of type UIColor?
```
import UIKit
import Foundation

extension Note {

    var color: UIColor? {
        get {
            guard let hex = colorAsHex else { return nil }
            return UIColor(hex: hex)
        }
        set(newColor) {
            if let newColor = newColor {
                colorAsHex = newColor.toHex
            }
        }
    }
}
```

5. We don't directly access the **colorAsHex** property of the **Note**. Instead, we use the color computed property as a proxy. The color computed property is in charge of value conversion.
```
// Getting a Color
let color = note.color

// Setting a Color
note.color = UIColor(hex: "FF5F5B")
```

Source: https://cocoacasts.com/how-to-store-uicolor-in-core-data-persistent-store

### Future improvements 
This is the primitive implementation of small POC only for the sake of learning. For the larger projects I highly recommend follow the right architecture principles and structure for your project.


**Wish you good luck with your developing!**


## Resources 
- https://serialcoder.dev/text-tutorials/swiftui/presenting-colorpicker-in-swiftui/
- https://tiannahenrylewis.medium.com/a-simple-approach-to-saving-color-in-coredata-with-swiftui-55ab4de1f828
- https://cocoacasts.com/how-to-store-uicolor-in-core-data-persistent-store
- https://developer.apple.com/documentation/coredata?fbclid=IwAR3nwboqEGuKmrJEPIBFUSrx0UCx7EsbAHFZkrPzXnpXhL5K76XBYWXGvnA
- https://johncodeos.com/how-to-use-core-data-in-ios-using-swift/
- https://developer.apple.com/videos/play/wwdc2019/230/?fbclid=IwAR1HIneHoMODlVsnxF_2S2_U6oNwEKV__qNL7x_3wfAhaVYjtAcowedcRbo

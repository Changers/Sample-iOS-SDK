## 1. App Settings
+ Activate Capabilities -> Background Modes -> Location Updates
+ Add to Info.plist: 
	+ "Privacy - Motion Usage Description" string // e.g: For the automatic measurement of distances we need the option "Always Allow"
	+ "Privacy - Location Always & When in Use Description" string // e.g: For the automatic measurement of distances we need the option "Always Allow"
	+ "Privacy - When in Use Description" string // e.g: For the automatic measurement of distances we need the option "Allow While Using App".
+ minimum deployment target 11.0

## Authorizations
The SDK requires two authorizations:  

1. Location (Always)
2. Motion

Both authorizations are requested by the Changers SDK when needed.

### Automatic Tracking
To function properly the SDK requires the **'Always'** location permission. 


## 1. Installation

```
  Manually drag and drop `ChangersSDK.framework` from [here!](https://github.com/Changers/Sample-iOS-SDK/tree/master/ChangersSDK.framework) to `Build Phases` >`Embed Frameworks` in your project
```

```
  pod 'MotionTagSDK', git: "https://gitlab.com/motiontag-dist/tracker-library-ios.git"
```


  
## 2. Interface 

```
func initSDK(with config: ChangersConfig, uuid: UUID?)
func setDelegate(_ delegate: ChangersDelegate?)
func setup()
```

```
public protocol ChangersDelegate: class {
    func setupDidFinish(with uiid: String)
    func setupDidFail(with error: ChangersSDKError?)
}

```


```
static func loadWebApp(on viewController: UIViewController, completion: (() -> Void)? = nil)
static var isReady: Bool { get }

```

```
enum ChangersSDKError: Error {
    case unknownError
    case connectionError
    case credentialsError
}
```



## 3. Setup

Initialize the library using ```func initSDK(with config: ChangersConfig, uuid: UUID?)```:


```
    lazy var changers = Changers()
    changers.initSDK(with: changersConfig with: changersUUID)
```

This needs to be done somewhere near the top of ```didFinishLaunchingWithOptions```. The reason is that the app may be started from the background by the system. By initializing the tracking library early, you guarantee that all location managers are set up to retreive new incoming locations.
Since the SDK may need additional time to finalize its initialization (e.g. necessary data migrations that have to be run on startup) the `initSDK` call is asynchronous. The `setupDidFinish` or `setupDidFail` from the delegate `ChangersDelegate` will be called by the SDK once it is done with everything. Best usage will be to wait for `setupDidFinish` and change the state of the button which opens the webapp.
`uuid` is optional on first init, we will register the device and provide you with one in the callback `setupDidFinish`

To receive callbacks, therefore the user uuid, set the appropriate delegate ```ChangersDelegate```:

```
	changers.delegate = self
```
 

To open the webapp, make sure the ChangersSDK is `Changers.isReady`, if yes then just call the ```static func loadWebApp(on viewController: UIViewController, completion: (() -> Void)? = nil)``` method:

```
         Changers.loadWebApp(on: self)
```

if `Changers.isReady == false` we will need to call `changers.setup()` and wait for the callback from `ChangersDelegate`.

The reason is that the app may need additional time to finalize its initial (e.g. necessary data migrations, or API calls in order to init the user with the Changers Back end, if it's not ready it's mostly due to API request timeout, the init happens once to register the user with the Changers Backend or to log the user in )

## 5. Callbacks

### Optional

```setupDidFinish(with uiid: String)```

- if the SDK is initialized properly and ready, the method `setupDidFinish` will be triggered and you will receive the `uiid` which belong to this user. You need to save it along with the user profil and provide it to the SDK:

```setupDidFail(with error: ChangersSDKError?)```

- if the SDK fails to initialized, `setupDidFail()` will be triggered with one of the following errors: 

```
enum ChangersSDKError: Error {
    case unknownError
    case connectionError
    case credentialsError
}
```


## 6. Example

Checkout the "Sample Changers iOS SDK" folder [here](https://github.com/Changers/Sample-iOS-SDK/tree/master/Sample%20Changers%20iOS%20SDK%20)  for an example application.


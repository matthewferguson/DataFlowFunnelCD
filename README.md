# DataFlowFunnelCD

Built For : Xcode 12.x and newer, Swift 5.x and newer, iOS 13.X SDK, 14.X SDK, M1 (Apple Silicon) macOS 11 and greater ( target 'x86_64-apple-ios-macabi') . Testing for iOS 12 and 11 has not occurred, but might be added in the future. Testing for macOS 10 and Intel based devices has not occurred, but might be added in the future.  


DataFlowFunnelCD is a Swift Package used for two main Architecture purposes.  1) Manage Core Data contention (multi-threaded) issues when saving two separate NSManagedObjects ( CRUD operations). 2) Solves the problem of referencing the NSPersistentContainer from anywhere in the bundle. Anywhere includes frameworks, other swift packages, and traditional bundle access. 

Note: iOS 15 SDK is introducing contention protection within the Core Data Framework. Will these Core Data features be available for iOS 12, 13, and 14 SDK is unknown.  Therefore, in the meantime DataFlowFunnelCD is here during the 3 to 4 year transition. 

Be sure to run the test app PondFishing ( https://github.com/matthewferguson/PondFishing ) and learn more on how CRUD "Operations" should be used with the DataFlowFunnelCD Swift Package.  PondFishing tests this DataFlowFunnelCD Package and can guide you in how to use that package properly. 


Installation Instructions:

1) Xcode 12.X.X Swift Package Manager - https://developer.apple.com/documentation/swift_packages/adding_package_dependencies_to_your_app
2) Add https://github.com/matthewferguson/DataFlowFunnelCD.git to your Swift App  
3) Create a Core Data model file, fill with your relational tables(your custom data flow or persistence), and place it next to common resources at the bundle level.  For Example: CoreDataFunnelModel.xcdatamodeld and later you will setModelName(to: "CoreDataFunnelModel") as decribed in future steps. 
4) import DataFlowFunnelCD needs to be added. 
5) Suggested AppDelegate singleton instantiation:
    @main
    class AppDelegate: UIResponder, UIApplicationDelegate 
    {
      
      // 1
      var refDataFlowFunnel:DataFlowFunnel = DataFlowFunnel.shared
    
      
      func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
      
          // 2
          // name your Core Data momd 
          self.refDataFlowFunnel.setModelName(to: "CoreDataFunnelModel" )
          
          // 3
          // id the bundle of the app sharing all the packages
          self.refDataFlowFunnel.setTargetBundleIdentifier(bundleId: "com.matthewferguson.PondFishing")
          
          // 4
          // use your custom CRUD operations. For example I use a debug Swift Operation to print the entire relational database. 
          DataFlowFunnel.shared.addOperation(FetchAndDescribeDataOperation())
          
          return true
     }

This package was create July 2021. At some point a github bug and suggestions tracker will be setup. 

if you find this package useful please press the star button above. The github search engine will share this package with those that might benefit. 

 




//
//  file : DataFlowFunnelCD.swift
//  class : DataFlowFunnel
//
//  Created by Matthew Ferguson on 7/25/21.
//

import Foundation
import CoreData

@objcMembers
public class DataFlowFunnel: OperationQueue {
    
    //MARK:- properties
    
        /// Framework bundle ID target
    private var targetBundleIdentifier: String!
        /// sqlite model name
    private var modelName: String!

    //MARK:- Shared Instance
    
    public static let shared: DataFlowFunnel = {
        let instance = DataFlowFunnel()
        return instance
    }()
    
    //MARK:- init()
    
    override init() {
            /// super required for OperationQueue configuration
        super.init()
            /// Make the Operation Queue a single operation FIFO
        self.maxConcurrentOperationCount = 1
            /// Queue QualityOfService set to highest
        self.qualityOfService = .userInteractive
    }
    
    public init(bundleId:String , modelName:String) {
            /// Super required for OperationQueue configuration
        super.init()
            /// Set the Operation Queue a single operation FIFO
        self.maxConcurrentOperationCount = 1
            /// Queue QualityOfService set to highest
        self.qualityOfService = .userInteractive
            /// Core Data model name
        self.setModelName(to: modelName)
            /// Framework bundle ID target
        self.targetBundleIdentifier = bundleId
    }
    
    
    // buz Error
    public func setModelName(to modelName:String) {
        if self.modelName == nil {
            self.modelName = modelName
        }
    }
    
    // buz Error
    public func setTargetBundleIdentifier(bundleId:String) {
        if self.targetBundleIdentifier == nil {
            self.targetBundleIdentifier = bundleId
        }
    }
    
    
    /// Set this operation queue quality of service
    /// parameters: queueQualityOfService
    ///               .userInteractive - highest quality of service, highest demand on resources
    ///               .userInitiated
    ///               .utility
    ///               .background - lowest quality of service, lowest demand on resources
    ///
    func operationQueueQoS(changeTo queueQualityOfService:QualityOfService) {
        self.qualityOfService = queueQualityOfService
    }

    
    lazy var persistentContainer: NSPersistentContainer = {
        
        let frameworkBundle = Bundle(identifier: self.targetBundleIdentifier )
        let modelURL = frameworkBundle!.url(forResource: self.modelName, withExtension: "momd")!
        let managedObjectModel =  NSManagedObjectModel(contentsOf: modelURL)
        let container = NSPersistentContainer(name: self.modelName, managedObjectModel: managedObjectModel!)
        container.loadPersistentStores { (storeDescription, error) in
            if let err = error{
                fatalError("Loading of store failed:\(err)")
            }
        }
        return container
    }()

    
    public func getManagedObjectContextRef()->NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    public func getBackgroundManagedObjectContextRef()->NSManagedObjectContext {
        return persistentContainer.newBackgroundContext()
    }
    
    public func getPersistentContainerRef()->NSPersistentContainer {
        return persistentContainer
    }

}

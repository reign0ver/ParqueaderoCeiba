//
//  SceneDelegate.swift
//  Parqueadero
//
//  Created by Andrés Enrique Carrillo Miranda - Ceiba Software on 28/01/20.
//  Copyright © 2020 Andrés Enrique Carrillo Miranda - Ceiba Software. All rights reserved.
//

import UIKit
import Swinject
import SwinjectStoryboard

#if Parqueadero
let debug = true
#else
let debug = false
#endif

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    let container: Container = {
        let container = Container()
        //DAO
//        container.register(ParkingDAOImpl.self) { _ in
//            ParkingDAOImpl()
//        }
        container.register(ParkingDAOProtocol.self) { _ in
            if debug {
                return ParkingDAOImpl()
            } else {
                return ParkingDAOImplTest()
            }
        }.inObjectScope(.container)
        //Services
        container.register(GetInVehicleService.self) { r in
            GetInVehicleService(parkingDAO: r.resolve(ParkingDAOProtocol.self)!)
        }
        container.register(GetOutVehicleService.self) { r in
            GetOutVehicleService(parkingDAO: r.resolve(ParkingDAOProtocol.self)!)
        }
        container.register(ListVehiclesService.self) { r in
            ListVehiclesService(parkingDAO: r.resolve(ParkingDAOProtocol.self)!)
        }
        //Model
        container.register(ParkingModel.self) { r in
            ParkingModel(getInService: r.resolve(GetInVehicleService.self)!,
                         getOutService: r.resolve(GetOutVehicleService.self)!,
                         listVehiclesService: r.resolve(ListVehiclesService.self)!)
        }
        //ViewModel
        container.register(ParkingViewModel.self) { r in
             ParkingViewModel(parkingModel: r.resolve(ParkingModel.self)!)
        }
        container.register(AddVehicleViewModel.self) { r in
             AddVehicleViewModel(parkingModel: r.resolve(ParkingModel.self)!)
        }
        //Views
        container.storyboardInitCompleted(VehiclesViewController.self) { (r, c) in
            c.viewModel = r.resolve(ParkingViewModel.self)!
        }
        container.storyboardInitCompleted(AddVehicleViewController.self) { (r, c) in
            c.viewModel = r.resolve(AddVehicleViewModel.self)!
        }
        return container
    }()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let winScene = (scene as? UIWindowScene) else { return }
        let win = UIWindow(windowScene: winScene)
//        let story = UIStoryboard(name: "Vehicles", bundle: nil)
//        let viewController = story.instantiateViewController(withIdentifier: "VehiclesViewController") as! VehiclesViewController
//        win.rootViewController = UINavigationController(rootViewController: viewController)
        
//        self.window = win
        let storyboard = SwinjectStoryboard.create(name: "Vehicles", bundle: nil, container: container)
        let vController = storyboard.instantiateViewController(withIdentifier: "VehiclesViewController") as! VehiclesViewController
        win.rootViewController = UINavigationController(rootViewController: vController)
        
        win.makeKeyAndVisible()
        window = win
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}


//
//  SceneDelegate.swift
//  YaWeather
//
//  Created by Vic on 23.04.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    // setup initial VC in willConnectTo session - sequence
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // windowScene is responsible for screen
        guard let windowScene = (scene as? UIWindowScene) else { return } // creating screen on scene

        // initialize var window with class UIWindow
        window = UIWindow(windowScene: windowScene)
        window?.windowScene = windowScene
        // UIWindow class that responsible for windows in which might be located VCs
        // this window has to be crutial and visible
        window?.makeKeyAndVisible() // now window is main
        
        // setup VC that will be shown in this window
        // according to task VC has to have TVCell and sections, NavController is needed, because TVContoller should be integrated into NavCont(Apple guidlines)
        window?.rootViewController = UINavigationController(rootViewController: MainViewController()) // TV integrated into NavC, assigned and initialized
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
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


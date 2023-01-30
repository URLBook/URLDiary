import ProjectDescription
import ProjectDescriptionHelpers
import MyPlugin

/*
                +-------------+
                |             |
                |     App     | Contains URLDiary App target and URLDiary unit-test target
                |             |
         +------+-------------+-------+
         |         depends on         |
         |                            |
 +----v-----+                   +-----v-----+
 |          |                   |           |
 |   Kit    |                   |     UI    |   Two independent frameworks to share code and start modularising your app
 |          |                   |           |
 +----------+                   +-----------+

 */

// MARK: - Project Factory
protocol ProjectFactory {
    var projectName: String { get }
    var dependencies: [TargetDependency] { get }
    
    func generateTarget() -> [Target]
    func generateConfigurations() -> Settings
}


// MARK: - Base Project Factory
class BaseProjectFactory: ProjectFactory {
    let projectName: String = "URLDiary"
    
    let deploymentTarget: ProjectDescription.DeploymentTarget = .iOS(targetVersion: "16.0", devices: [.iphone])
    
    let dependencies: [TargetDependency] = [
        .external(name: "RxSwift"),
        .external(name: "RxCocoa"),
        .external(name: "RxKeyboard"),
        .external(name: "SnapKit"),
        .external(name: "Then"),
        .external(name: "FirebaseAuth"),
        .external(name: "FirebaseDatabase"),
        .external(name: "FirebaseFirestore"),
        .external(name: "FirebaseStorage"),
        .external(name: "FirebaseMessaging"),
        .external(name: "Swinject")
    ]
    
    let infoPlist: [String: InfoPlist.Value] = [
        "CFBundleShortVersionString": "1.0.1",
        "CFBundleVersion": "1",
        "UILaunchStoryboardName": "LaunchScreen",
        "UIApplicationSceneManifest": [
            "UIApplicationSupportsMultipleScenes": false,
            "UISceneConfigurations": [
                "UIWindowSceneSessionRoleApplication": [
                    [
                        "UISceneConfigurationName": "Default Configuration",
                        "UISceneDelegateClassName": "$(PRODUCT_MODULE_NAME).SceneDelegate"
                    ],
                ]
            ]
        ],
    ]
    
    let baseSettings: [String: SettingValue] = [
      "OTHER_LDFLAGS": "-ObjC",
    ]
    
    let releaseSetting: [String: SettingValue] = [:]
    
    let debugSetting: [String: SettingValue] = [:]
    
    func generateConfigurations() -> Settings {
        return Settings.settings(
            base: baseSettings,
            configurations: [
              .release(
                name: "Release",
                settings: releaseSetting
              ),
              .debug(
                name: "Debug",
                settings: debugSetting
              )
            ],
            defaultSettings: .recommended
          )
    }
    
    func generateTarget() -> [Target] {
        [
            Target(
                name: projectName,
                platform: .iOS,
                product: .app,
                bundleId: "so.notion.\(projectName)",
                deploymentTarget: deploymentTarget,
                infoPlist: .extendingDefault(with: infoPlist),
                sources: ["\(projectName)/Sources/**"],
                resources: "\(projectName)/Resources/**",
                entitlements: "\(projectName).entitlements",
                scripts: [.pre(path: "Scripts/SwiftLintRunScript.sh", arguments: [], name: "SwiftLint")],
                dependencies: dependencies
            )
        ]
    }
}

// MARK: - Project

// Local plugin loaded
let factory = BaseProjectFactory()

// Creates our project using a helper function defined in ProjectDescriptionHelpers
let project: Project = .init(
    name: factory.projectName,
    organizationName: factory.projectName,
    settings: factory.generateConfigurations(),
    targets: factory.generateTarget()
)
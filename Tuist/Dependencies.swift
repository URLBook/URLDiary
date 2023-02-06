//
//  Dependencies.swift
//  Config
//
//  Created by 오국원 on 2023/01/30.
//
import ProjectDescription

let spm = SwiftPackageManagerDependencies([
    .remote(url: "https://github.com/ReSwift/ReSwift.git", requirement: .upToNextMajor(from: "6.0.0")),
    .remote(url: "https://github.com/ReactiveX/RxSwift", requirement: .upToNextMajor(from: "6.5.0")),
    .remote(url: "https://github.com/RxSwiftCommunity/RxKeyboard", requirement: .upToNextMajor(from: "2.0.0")),
    .remote(url: "https://github.com/firebase/firebase-ios-sdk", requirement: .upToNextMajor(from: "8.10.0")),
    .remote(url: "https://github.com/devxoul/Then", requirement: .upToNextMajor(from: "3.0.0")),
    .remote(url: "https://github.com/Alamofire/Alamofire", requirement: .upToNextMajor(from: "5.6.2")),
    .remote(url: "https://github.com/SnapKit/SnapKit", requirement: .upToNextMajor(from: "5.6.0")),
    .remote(url: "https://github.com/Swinject/Swinject", requirement: .upToNextMajor(from: "2.8.3"))
])

let dependencies = Dependencies(
    swiftPackageManager: spm,
    platforms: [.iOS]
)


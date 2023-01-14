//
//  Dependencies.swift
//  Config
//
//  Created by 이건우 on 2023/01/15.
//

import ProjectDescription
import ProjectDescriptionHelpers

let dependencies = Dependencies(
    carthage: [],
    swiftPackageManager: [
        .remote(url: "https://github.com/CSolanaM/SkeletonUI.git", requirement: .branch("master"))
    ],
    platforms: [.iOS]
)

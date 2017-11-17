//
//  Model.swift
//  SwiftSignDemo
//
//  Created by 高鑫 on 2017/11/17.
//  Copyright © 2017年 高鑫. All rights reserved.
//

import Foundation
import UIKit

struct UserInfo {
    var user = String()
    var password = String()
}

class UserInfos {
    static var userInfos : [UserInfo] = []
    static var infos : [String] = ["个人资料","个人简介","关注","粉丝","收藏","赞","文章","图片","视频","注销"]
}

//
//  CanvasAPI.swift
//  Courses
//
//  Created by Nate Armstrong on 1/9/16.
//  Copyright © 2016 Nate Armstrong. All rights reserved.
//

import Foundation
import Moya

let AccessToken = "<ACCESS_TOKEN_HERE>"

public enum Canvas {
    case Courses
}

extension Canvas: TargetType {

    public var baseURL: NSURL { return NSURL(string: "https://canvas.instructure.com/api/v1")! }
    public var path: String {
        switch self {
        case .Courses:
            return "/courses"
        }
    }
    public var method: Moya.Method {
        return .GET
    }
    public var parameters: [String: AnyObject]? {
        switch self {
        case .Courses:
            return ["access_token": AccessToken]
        }
    }
    public var sampleData: NSData {
        switch self {
        case .Courses:
            return "[{\"id\":20000000169013,\"name\":\"CS-1410-02 FA12\",\"account_id\":20000000002422,\"start_at\":\"2012-08-20T00:00:00Z\",\"grading_standard_id\":null,\"is_public\":null,\"course_code\":\"CS-1410-02 FA12\",\"default_view\":\"feed\",\"enrollment_term_id\":20000000000157,\"end_at\":\"2012-12-28T00:00:00Z\",\"public_syllabus\":false,\"storage_quota_mb\":15000,\"is_public_to_auth_users\":false,\"apply_assignment_group_weights\":true,\"calendar\":{\"ics\":\"https://canvas.instructure.com/feeds/calendars/course_NHXrkHog9MbyjYBLSYm9CcUCXQpprOu0Q55ack1u.ics\"},\"enrollments\":[{\"type\":\"student\",\"role\":\"StudentEnrollment\",\"role_id\":821,\"user_id\":20000000349018,\"enrollment_state\":\"active\"}],\"hide_final_grades\":false,\"workflow_state\":\"available\",\"restrict_enrollments_to_course_dates\":true}]".dataUsingEncoding(NSUTF8StringEncoding)!
        }
    }

}

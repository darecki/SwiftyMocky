//
//  ProtocolWithGenericMethodsMock.swift
//  Mocky_Example
//
//  Created by przemyslaw.wosko on 04/11/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Mocky
import XCTest
@testable import Mocky_Example

// sourcery: mock = "ProtocolWithGenericMethods"
class ProtocolWithGenericMethodsMock: ProtocolWithGenericMethods, Mock {


// sourcery:inline:auto:ProtocolWithGenericMethodsMock.autoMocked
//swiftlint:disable force_cast
//swiftlint:disable function_body_length
//swiftlint:disable line_length
//swiftlint:disable vertical_whitespace

    fileprivate var invocations: [MethodType] = []
    var methodReturnValues: [MethodProxy] = []
    var methodPerformValues: [PerformProxy] = []
    var matcher: Matcher = Matcher.default
        
    //MARK : ProtocolWithGenericMethods
        

    func exampleMethod<T: Equatable>(elements: [T]) -> [T] {
        addInvocation(.exampleMethod__elements_elements(.value(elements)))
        	let perform = methodPerformValue(.exampleMethod__elements_elements(.value(elements))) as? ([T]) -> Void
			perform?(elements)
        guard let value = methodReturnValue(.exampleMethod__elements_elements(.value(elements))) as? [T] else {
			print("[FATAL] stub return value not specified for exampleMethod<T: Equatable>(elements: [T]). Use given.")
			fatalError("[FATAL] stub return value not specified for exampleMethod<T: Equatable>(elements: [T]). Use given.")
		}
		return value
    }
    
    fileprivate enum MethodType {

        case exampleMethod__elements_elements(Parameter<[T]>)    
        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Bool {
            switch (lhs, rhs) {

                case (.exampleMethod__elements_elements(let lhsElements), .exampleMethod__elements_elements(let rhsElements)): 
                    guard Parameter.compare(lhs: lhsElements, rhs: rhsElements, with: matcher) else { return false } 
                    return true 
                default: return false
            }
        }

        func intValue() -> Int {
            switch self {
                case let .exampleMethod__elements_elements(p0): return p0.intValue
            }
        }
    }

    struct MethodProxy {
        fileprivate var method: MethodType
        var returns: Any?

        static func exampleMethod<T: Equatable>(elements: Parameter<[T]>, willReturn: [T]) -> MethodProxy {
            return MethodProxy(method: .exampleMethod__elements_elements(elements), returns: willReturn)
        }
    }

    struct VerificationProxy {
        fileprivate var method: MethodType


        static func exampleMethod<T: Equatable>(elements: Parameter<[T]>) -> VerificationProxy {
            return VerificationProxy(method: .exampleMethod__elements_elements(elements))
        }
    }

    struct PerformProxy {
        fileprivate var method: MethodType
        var performs: Any

        static func exampleMethod<T: Equatable>(elements: Parameter<[T]>, perform: ([T]) -> Void) -> PerformProxy {
            return PerformProxy(method: .exampleMethod__elements_elements(elements), performs: perform)
        }
    }

    public func matchingCalls(_ method: VerificationProxy) -> Int {
        return matchingCalls(method.method).count
    }

    public func given(_ method: MethodProxy) {
        methodReturnValues.append(method)
        methodReturnValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func perform(_ method: PerformProxy) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: VerificationProxy, count: UInt = 1, file: StaticString = #file, line: UInt = #line) {
        let method = method.method
        let invocations = matchingCalls(method)
        XCTAssert(invocations.count == Int(count), "Expeced: \(count) invocations of `\(method)`, but was: \(invocations.count)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        invocations.append(call)
    }

    private func methodReturnValue(_ method: MethodType) -> Any? {
        let matched = methodReturnValues.reversed().first(where: { proxy -> Bool in
            return MethodType.compareParameters(lhs: proxy.method, rhs: method, matcher: matcher)
        })

        return matched?.returns
    }

    private func methodPerformValue(_ method: MethodType) -> Any? {
        let matched = methodPerformValues.reversed().first(where: { proxy -> Bool in
            return MethodType.compareParameters(lhs: proxy.method, rhs: method, matcher: matcher)
        })

        return matched?.performs
    }

    private func matchingCalls(_ method: MethodType) -> [MethodType] {
        let matchingInvocations = invocations.filter({ (call) -> Bool in
            return MethodType.compareParameters(lhs: call, rhs: method, matcher: matcher)
        })
        return matchingInvocations
    }
// sourcery:end
}

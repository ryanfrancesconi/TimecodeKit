//
//  Component.swift
//  TimecodeKit • https://github.com/orchetect/TimecodeKit
//  © 2020-2023 Steffan Andrews • Licensed under MIT License
//

extension Timecode {
    /// Individual timecode component.
    public enum Component: Equatable, Hashable, CaseIterable {
        case days
        case hours
        case minutes
        case seconds
        case frames
        case subFrames
    }
}

@available(macOS 10.15, macCatalyst 13, iOS 11, tvOS 11, watchOS 6, *)
extension Timecode.Component: Identifiable {
    public var id: Self { self }
}

extension Timecode.Component: Sendable { }

// MARK: - Sequence Traversal

extension Timecode.Component {
    /// Returns the next timecode component in sequence.
    /// If the component is the last in the sequence, the sequence wraps around and returns the first component.
    public func next(excluding: [Self] = []) -> Self {
        let components = Self.allCases.filter { !excluding.contains($0) }
        
        precondition(!components.isEmpty)
        
        guard let index = components.firstIndex(of: self) else {
            return components.first!
        }
        
        let offsetIndex = index.advanced(by: 1)
        
        if components.indices.contains(offsetIndex) {
            return components[offsetIndex]
        } else {
            return components.first!
        }
    }
    
    /// Returns the previous timecode component in sequence.
    /// If the component is the first in the sequence, the sequence wraps around and returns the last component.
    public func previous(excluding: [Self] = []) -> Self {
        let components = Self.allCases.filter { !excluding.contains($0) }
        
        precondition(!components.isEmpty)
        
        guard let index = components.firstIndex(of: self) else {
            return components.last!
        }
        
        let offsetIndex = index.advanced(by: -1)
        
        if components.indices.contains(offsetIndex) {
            return components[offsetIndex]
        } else {
            return components.last!
        }
    }
}

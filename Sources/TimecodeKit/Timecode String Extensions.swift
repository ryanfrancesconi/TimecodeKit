//
//  Timecode String Extensions.swift
//  TimecodeKit • https://github.com/orchetect/TimecodeKit
//

// MARK: - to Timecode

extension String {
    
    /// Returns an instance of `Timecode(exactly:)`.
    /// If the string is not a valid timecode string, it returns nil.
    @inlinable public func toTimecode(
        at frameRate: Timecode.FrameRate,
        limit: Timecode.UpperLimit = ._24hours,
        subFramesDivisor: Int? = nil,
        displaySubFrames: Bool = false
    ) -> Timecode? {
        
        if let sfd = subFramesDivisor {
            
            return Timecode(self,
                            at: frameRate,
                            limit: limit,
                            subFramesDivisor: sfd,
                            displaySubFrames: displaySubFrames)
            
        } else {
            
            return Timecode(self,
                            at: frameRate,
                            limit: limit,
                            displaySubFrames: displaySubFrames)
            
        }
        
    }
    
    /// Returns an instance of `Timecode(rawValues:)`.
    /// If the string is not a valid timecode string, it returns nil.
    @inlinable public func toTimecode(
        rawValuesAt frameRate: Timecode.FrameRate,
        limit: Timecode.UpperLimit = ._24hours,
        subFramesDivisor: Int? = nil,
        displaySubFrames: Bool = false
    ) -> Timecode? {
        
        if let sfd = subFramesDivisor {
            
            return Timecode(rawValues: self,
                            at: frameRate,
                            limit: limit,
                            subFramesDivisor: sfd,
                            displaySubFrames: displaySubFrames)
            
        } else {
            
            return Timecode(rawValues: self,
                            at: frameRate,
                            limit: limit,
                            displaySubFrames: displaySubFrames)
            
        }
        
    }
    
}

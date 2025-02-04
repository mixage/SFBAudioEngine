//
// Copyright (c) 2020 - 2022 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/SFBAudioEngine
// MIT license
//

import Foundation
import CoreAudio

/// A HAL audio slider control object
/// - remark: This class correponds to objects with base class `kAudioSliderControlClassID`
public class SliderControl: AudioControl {
	// A textual representation of this instance, suitable for debugging.
	public override var debugDescription: String {
		do {
			return "<\(type(of: self)): 0x\(String(objectID, radix: 16, uppercase: false)), (\(try scope()), \(try element())), \(try value())>"
		}
		catch {
			return super.debugDescription
		}
	}
}

extension SliderControl {
	/// Returns the control's value
	/// - remark: This corresponds to the property `kAudioSliderControlPropertyValue`
	public func value() throws -> UInt32 {
		return try getProperty(PropertyAddress(kAudioSliderControlPropertyValue), type: UInt32.self)
	}
	/// Sets the control's value
	/// - remark: This corresponds to the property `kAudioSliderControlPropertyValue`
	public func setValue(_ value: UInt32) throws {
		try setProperty(PropertyAddress(kAudioSliderControlPropertyValue), to: value)
	}

	/// Returns the available control values
	/// - remark: This corresponds to the property `kAudioSliderControlPropertyRange`
	public func range() throws -> [UInt32] {
		return try getProperty(PropertyAddress(kAudioSliderControlPropertyRange), elementType: UInt32.self)
	}
}

extension SliderControl {
	/// Returns `true` if `self` has `selector`
	/// - parameter selector: The selector of the desired property
	public func hasSelector(_ selector: AudioObjectSelector<SliderControl>) -> Bool {
		return hasProperty(PropertyAddress(PropertySelector(selector.rawValue)))
	}

	/// Returns `true` if `selector` is settable
	/// - parameter selector: The selector of the desired property
	/// - throws: An error if `self` does not have the requested property
	public func isSelectorSettable(_ selector: AudioObjectSelector<SliderControl>) throws -> Bool {
		return try isPropertySettable(PropertyAddress(PropertySelector(selector.rawValue)))
	}

	/// Registers `block` to be performed when `selector` changes
	/// - parameter selector: The selector of the desired property
	/// - parameter block: A closure to invoke when the property changes or `nil` to remove the previous value
	/// - throws: An error if the property listener could not be registered
	public func whenSelectorChanges(_ selector: AudioObjectSelector<SliderControl>, perform block: PropertyChangeNotificationBlock?) throws {
		try whenPropertyChanges(PropertyAddress(PropertySelector(selector.rawValue)), perform: block)
	}
}

extension AudioObjectSelector where T == SliderControl {
	/// The property selector `kAudioSliderControlPropertyValue`
	public static let value = AudioObjectSelector(kAudioSliderControlPropertyValue)
	/// The property selector `kAudioSliderControlPropertyRange`
	public static let range = AudioObjectSelector(kAudioSliderControlPropertyRange)
}

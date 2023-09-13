//
//  FontViewModifier.swift
//  Giro
//
//  Created by Samuel NEVEU on 31/07/2023.
//

import SwiftUI

extension View {
    func lgcTextNormal16() -> some View {
        modifier(FontModifier(style: .lgcTextNormal16))
    }
    
    func lgcTextBold16() -> some View {
        modifier(FontModifier(style: .lgcTextBold16))
    }
    func lgcTextBoldItalic16() -> some View {
        modifier(FontModifier(style: .lgcTextBoldItalic16))
    }
    func lgcTextLight16() -> some View {
        modifier(FontModifier(style: .lgcTextLight16))
    }
    func lgcTextLightItalic16() -> some View {
        modifier(FontModifier(style: .lgcTextLightItalic16))
    }
    func lgcTextItalic16() -> some View {
        modifier(FontModifier(style: .lgcTextItalic16))
    }

    func lgcTextNormal14() -> some View {
        modifier(FontModifier(style: .lgcTextNormal14))
    }
    
    func lgcTextBold14() -> some View {
        modifier(FontModifier(style: .lgcTextBold14))
    }
    func lgcTextBoldItalic14() -> some View {
        modifier(FontModifier(style: .lgcTextBoldItalic14))
    }
    func lgcTextLight14() -> some View {
        modifier(FontModifier(style: .lgcTextLight14))
    }
    func lgcTextLightItalic14() -> some View {
        modifier(FontModifier(style: .lgcTextLightItalic14))
    }
    func lgcTextItalic14() -> some View {
        modifier(FontModifier(style: .lgcTextItalic14))
    }
    
    func lgcTextNormal12() -> some View {
        modifier(FontModifier(style: .lgcTextNormal12))
    }
    
    func lgcTextBold12() -> some View {
        modifier(FontModifier(style: .lgcTextBold12))
    }
    func lgcTextBoldItalic12() -> some View {
        modifier(FontModifier(style: .lgcTextBoldItalic12))
    }
    func lgcTextLight12() -> some View {
        modifier(FontModifier(style: .lgcTextLight12))
    }
    func lgcTextLightItalic12() -> some View {
        modifier(FontModifier(style: .lgcTextLightItalic12))
    }
    func lgcTextItalic12() -> some View {
        modifier(FontModifier(style: .lgcTextItalic12))
    }
    
    func lgcTextNormal24() -> some View {
        modifier(FontModifier(style: .lgcTextNormal24))
    }
    
    func lgcTextBold24() -> some View {
        modifier(FontModifier(style: .lgcTextBold24))
    }
    func lgcTextBoldItalic24() -> some View {
        modifier(FontModifier(style: .lgcTextBoldItalic24))
    }
    func lgcTextLight24() -> some View {
        modifier(FontModifier(style: .lgcTextLight24))
    }
    func lgcTextLightItalic24() -> some View {
        modifier(FontModifier(style: .lgcTextLightItalic24))
    }
    func lgcTextItalic24() -> some View {
        modifier(FontModifier(style: .lgcTextItalic24))
    }
    
    func lgcTextNormal32() -> some View {
        modifier(FontModifier(style: .lgcTextNormal32))
    }
    
    func lgcTextBold32() -> some View {
        modifier(FontModifier(style: .lgcTextBold32))
    }
    func lgcTextBoldItalic32() -> some View {
        modifier(FontModifier(style: .lgcTextBoldItalic32))
    }
    func lgcTextLight32() -> some View {
        modifier(FontModifier(style: .lgcTextLight32))
    }
    func lgcTextLightItalic32() -> some View {
        modifier(FontModifier(style: .lgcTextLightItalic32))
    }
    func lgcTextItalic32() -> some View {
        modifier(FontModifier(style: .lgcTextItalic32))
    }
    
//    func lgcTextNormal38() -> some View {
//        modifier(FontModifier(style: .lgcTextNormal38))
//    }
//
//    func lgcTextBold38() -> some View {
//        modifier(FontModifier(style: .lgcTextBold38))
//    }
//    func lgcTextBoldItalic38() -> some View {
//        modifier(FontModifier(style: .lgcTextBoldItalic38))
//    }
//    func lgcTextLight38() -> some View {
//        modifier(FontModifier(style: .lgcTextLight38))
//    }
//    func lgcTextLightItalic38() -> some View {
//        modifier(FontModifier(style: .lgcTextLightItalic38))
//    }
//    func lgcTextItalic38() -> some View {
//        modifier(FontModifier(style: .lgcTextItalic38))
//    }
}

struct FontModifier: ViewModifier {
    let style: FontStyle
    
    func body(content: Content) -> some View {
        content
            .font(style.font)
            .lineSpacing(style.lineHeight - style.fontSize)
    }
}

enum FontStyle {
    case lgcTextNormal16
    case lgcTextBold16
    case lgcTextBoldItalic16
    case lgcTextLight16
    case lgcTextLightItalic16
    case lgcTextItalic16
    
    case lgcTextNormal14
    case lgcTextBold14
    case lgcTextBoldItalic14
    case lgcTextLight14
    case lgcTextLightItalic14
    case lgcTextItalic14
    
    case lgcTextNormal12
    case lgcTextBold12
    case lgcTextBoldItalic12
    case lgcTextLight12
    case lgcTextLightItalic12
    case lgcTextItalic12
    
    case lgcTextNormal24
    case lgcTextBold24
    case lgcTextBoldItalic24
    case lgcTextLight24
    case lgcTextLightItalic24
    case lgcTextItalic24
    
    case lgcTextNormal32
    case lgcTextBold32
    case lgcTextBoldItalic32
    case lgcTextLight32
    case lgcTextLightItalic32
    case lgcTextItalic32
    
    var fontSize: CGFloat {
        switch self {
        case .lgcTextNormal16,
                .lgcTextBold16,
                .lgcTextBoldItalic16,
                .lgcTextLight16,
                .lgcTextLightItalic16,
                .lgcTextItalic16:
            return 16
        case .lgcTextNormal14,
                .lgcTextBold14,
                .lgcTextBoldItalic14,
                .lgcTextLight14,
                .lgcTextLightItalic14,
                .lgcTextItalic14:
            return 14
        case .lgcTextNormal12,
                .lgcTextBold12,
                .lgcTextBoldItalic12,
                .lgcTextLight12,
                .lgcTextLightItalic12,
                .lgcTextItalic12:
            return 12
        case .lgcTextNormal24,
                .lgcTextBold24,
                .lgcTextBoldItalic24,
                .lgcTextLight24,
                .lgcTextLightItalic24,
                .lgcTextItalic24:
            return 24
        case .lgcTextNormal32,
                .lgcTextBold32,
                .lgcTextBoldItalic32,
                .lgcTextLight32,
                .lgcTextLightItalic32,
                .lgcTextItalic32:
            return 32
        }
    }
    
    var font: Font {
        switch self {
        case .lgcTextNormal32, .lgcTextNormal24, .lgcTextNormal16, .lgcTextNormal14, .lgcTextNormal12: return Font.custom("Louis_George_Cafe", size: fontSize)
        case .lgcTextBoldItalic32, .lgcTextBoldItalic24, .lgcTextBoldItalic16, .lgcTextBoldItalic14, .lgcTextBoldItalic12: return Font.custom("Louis_George_Cafe_Bold_Italic", size: fontSize)
        case .lgcTextBold32, .lgcTextBold24, .lgcTextBold16, .lgcTextBold14, .lgcTextBold12: return Font.custom("Louis_George_Cafe_Bold", size: fontSize)
        case .lgcTextLightItalic32, .lgcTextLightItalic24, .lgcTextLightItalic16, .lgcTextLightItalic14, .lgcTextLightItalic12: return Font.custom("Louis_George_Cafe_Light_Italic", size: fontSize)
        case .lgcTextLight32, .lgcTextLight24, .lgcTextLight16, .lgcTextLight14, .lgcTextLight12: return Font.custom("Louis_George_Cafe_Light", size: fontSize)
        case .lgcTextItalic32, .lgcTextItalic24, .lgcTextItalic16, .lgcTextItalic14, .lgcTextItalic12: return Font.custom("Louis_George_Cafe_Italic", size: fontSize)
        }
    }
    
    var lineHeight: CGFloat {
        switch self {
        case .lgcTextNormal16,
                .lgcTextBold16,
                .lgcTextBoldItalic16,
                .lgcTextLight16,
                .lgcTextLightItalic16,
                .lgcTextItalic16:
            return 24
        case .lgcTextNormal14,
                .lgcTextBold14,
                .lgcTextBoldItalic14,
                .lgcTextLight14,
                .lgcTextLightItalic14,
                .lgcTextItalic14:
            return 22
        case .lgcTextNormal12,
                .lgcTextBold12,
                .lgcTextBoldItalic12,
                .lgcTextLight12,
                .lgcTextLightItalic12,
                .lgcTextItalic12:
            return 20
        case .lgcTextNormal24,
                .lgcTextBold24,
                .lgcTextBoldItalic24,
                .lgcTextLight24,
                .lgcTextLightItalic24,
                .lgcTextItalic24:
            return 32
        case .lgcTextNormal32,
                .lgcTextBold32,
                .lgcTextBoldItalic32,
                .lgcTextLight32,
                .lgcTextLightItalic32,
                .lgcTextItalic32:
            return 40
        }
    }
}

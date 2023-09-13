//
//  ViewHelper.swift
//  Giro
//
//  Created by Samuel NEVEU on 25/07/2023.
//

import SwiftUI

/// Custom View modifier extension
extension View {
    @ViewBuilder
    func imageFullScreenCover<Content: View>(show: Binding<Bool>, @ViewBuilder content: @escaping () -> Content) -> some View {
        self
            .modifier(HelperImageFullScreen(show: show, overlay: content()))
    }
}

/// Helper
fileprivate struct HelperImageFullScreen<Overlay: View>: ViewModifier {
    @Binding var show: Bool
    var overlay: Overlay
    
    @State private var hostView: CustomHostingView<Overlay>?
    @State private var parentController: UIViewController?
    
    func body(content: Content) -> some View {
        content
            .background(content: {
                ExtractSwiftUIParentController(content: overlay, hostView: $hostView) { viewController in
                    parentController = viewController
                }
            })
            .onAppear {
                hostView = CustomHostingView(show: $show,rootView: overlay)
            }
            .onChange(of: show) { newValue in
                if newValue {
                    /// Present View
                    if let hostView {
                        /// Changin Presentation Style and Transistion Style
                        hostView.modalPresentationStyle = .overCurrentContext
                        hostView.modalTransitionStyle = .crossDissolve
                        hostView.view.backgroundColor = .clear
                        
                        parentController?.present(hostView, animated: false)
                    }
                } else {
                    /// Dismiss View
                    hostView?.dismiss(animated: false)
                }
            }
    }
}



fileprivate struct ExtractSwiftUIParentController<Content: View>: UIViewRepresentable {
    var content: Content
    @Binding var hostView: CustomHostingView<Content>?
    var parentController: (UIViewController?) -> ()
    
    func makeUIView(context: Context) -> UIView {
        return UIView()
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        /// Update HostViews Root View
        hostView?.rootView = content
        DispatchQueue.main.async {
            /// Retrieve it's parent view controller
            parentController(uiView.superview?.superview?.parentController)
        }
    }
}

class CustomHostingView<Content: View>: UIHostingController<Content> {
    @Binding var show: Bool
    
    init(show: Binding<Bool>, rootView: Content) {
        self._show = show
        super.init(rootView: rootView)
    }
    
    required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        // Disable default animation while dismissing
        super.viewWillDisappear(false)
        show = false
    }
}

public extension UIView {
    var parentController: UIViewController? {
        var responder = self.next
        while responder != nil {
            if let viewController = responder as? UIViewController {
                return viewController
            }
            responder = responder?.next
        }
        return nil
    }
}

extension View {
    /// Applies the given transform if the given condition evaluates to `true`.
    /// - Parameters:
    ///   - condition: The condition to evaluate.
    ///   - transform: The transform to apply to the source `View`.
    /// - Returns: Either the original `View` or the modified `View` if the condition is `true`.
    @ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

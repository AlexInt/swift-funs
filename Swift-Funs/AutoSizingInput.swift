//
//  AutoSizingInput.swift
//  Swift-Funs
//
//  Created by jimmy on 2021/11/14.
//

import SwiftUI

struct AutoSizingInput: View {
    @State private var text = ""
    //auto update TextBox height
    @State private var containerHeight: CGFloat = 0
    
    private let maxHeight: CGFloat = 120.0;
    
    
    var body: some View {
        NavigationView {
            VStack {
                AutoSizingTF(hint: "input", text: $text, containerHeight: $containerHeight, onEnd:{
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                })
                    .padding(.horizontal)
                    .frame(height: containerHeight <= maxHeight ? containerHeight : maxHeight)
                    .background(Color.white)
                    .cornerRadius(10)
                    .padding()
            }
            .navigationTitle("Input Accessory View")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.primary.opacity(0.04).ignoresSafeArea())
        }
        
            
    }
}

struct AutoSizingInput_Previews: PreviewProvider {
    static var previews: some View {
        AutoSizingInput()
    }
}


struct AutoSizingTF: UIViewRepresentable {
    var hint: String
    @Binding var text: String
    @Binding var containerHeight: CGFloat
    var onEnd: ()->Void
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.text = hint
        textView.textColor = .gray
        textView.font = .systemFont(ofSize: 20)
        textView.delegate = context.coordinator
        textView.backgroundColor = .clear
        
        //Input Accessory view
        //your own custom size
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        toolBar.barStyle = .default
        
        //since we need done at right so using another item as spacer
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: context.coordinator, action: #selector(context.coordinator.closeKeyboard))
        toolBar.items = [spacer, doneButton]
        toolBar.sizeToFit()
        textView.inputAccessoryView = toolBar
        return textView
    }
    func updateUIView(_ uiView: UITextView, context: Context) {
        //starting text field height
        DispatchQueue.main.async {
            if containerHeight == 0 {
                containerHeight = uiView.contentSize.height
            }
        }
    }
    
    class Coordinator: NSObject, UITextViewDelegate {
        //to read all parent properties
        var parent: AutoSizingTF
        
        init(parent: AutoSizingTF) {
            self.parent = parent
        }
        
        @objc func closeKeyboard() {
            parent.onEnd()
        }
        
        func textViewDidBeginEditing(_ textView: UITextView) {
            /*
             checking if text box is empty...
             is so then clearing the hint
             */
            if textView.text == parent.hint {
                textView.text = ""
                textView.textColor = UIColor(Color.primary)
            }
        }
        
        //updating text in SwiftUI view
        func textViewDidChange(_ textView: UITextView) {
            parent.text = textView.text
            parent.containerHeight = textView.contentSize.height
        }
        
        //on end checking if textbox is empty
        //if so then put hint
        func textViewDidEndEditing(_ textView: UITextView) {
            if textView.text == "" {
                textView.text = parent.hint
                textView.textColor = .gray
            }
        }
    }
}

//
//  OnboardingInvitationViewController.swift
//
//  Created by Jameson Rader on 25.11.18.
//  Copyright © 2018 Rader Enterprises. All rights reserved.
//

import UIKit

class OnboardingInvitationViewController: UIViewController, UITextViewDelegate {
    static let onboardingFlowShownKey = "onboardingFlowShown"
    static let termsOfUseAcceptedKey = "termsOfUseAcceptedKey"
    static let trainingRobotAcceptedKey = "trainingRobotAccepted"
    static let eulaLink = "eula"
    static let privacyPolicyLink = "privacy"
    

    @IBOutlet weak var termsTextView: UITextView!
    @IBOutlet weak var appNameLabel: UILabel!
    @IBOutlet weak var acceptButton: UIButton!

    public init() {
        super.init(nibName: "OnboardingInvitationViewController", bundle: .main)
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override open func viewDidLoad() {
        super.viewDidLoad()
        acceptButton.setTitle("Accept & Continue", for: .normal)

        styleTermsText()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }

    @IBAction func onGetStartedTapped() {
        UserDefaults.standard.set(true, forKey: OnboardingInvitationViewController.termsOfUseAcceptedKey)
        UserDefaults.standard.synchronize()
    }
    
    private func styleTermsText() {
        styleTextView(termsTextView, fullText: "By using this application, you agree to the Terms & Conditions and Privacy Policy.",
                      links: [("Terms & Conditions", OnboardingInvitationViewController.eulaLink),
                              ("Privacy Policy", OnboardingInvitationViewController.privacyPolicyLink)])
        termsTextView.textAlignment = .center
    }

    private func styleTextView(_ textView: UITextView, fullText: String, links: [(String, String)]) {
        textView.delegate = self
        let attributedString = NSMutableAttributedString(string: fullText)
        attributedString.addAttribute(.font, value: UIFont.init(name: "OpenSans-Regular", size: 17)!, range: NSMakeRange(0, fullText.count))

        for (linkText, url) in links {
            let range = NSRange(fullText.range(of: linkText)!, in: fullText)

            attributedString.addAttribute(.link, value: NSURL(string: url)!, range: range)
            attributedString.addAttribute(.underlineStyle, value: NSNumber(value: 1), range: range)
            attributedString.addAttribute(.font, value: UIFont.init(name: "OpenSans-SemiBold", size: 15)!, range: range)
        }

        textView.attributedText = attributedString
        textView.linkTextAttributes = [.foregroundColor: UIColor.white]
        textView.textColor = .white
        textView.backgroundColor = UIColor.clear
    }
    
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {

        // **Perform sign in action here**
        print("ayy")
        if URL.absoluteString == OnboardingInvitationViewController.eulaLink {
            //Eula link
            let alertController = UIAlertController(title: "Terms & Conditions", message: "There are no terms and conditions. I love you unconditionally!", preferredStyle: .alert)
            let okAlert = UIAlertAction(title: "I agree", style: .default, handler: { (action : UIAlertAction!) -> Void in
                self.dismiss(animated: true, completion: nil)
            })
            alertController.addAction(okAlert)
            self.present(alertController, animated: true, completion: nil)
        } else {
            // Privacy link
            print("privacy")
            let alertController = UIAlertController(title: "Privacy Policy", message: "I'll keep all ur secrets to my grave <3", preferredStyle: .alert)
            let okAlert = UIAlertAction(title: "I agree", style: .default, handler: { (action : UIAlertAction!) -> Void in
                self.dismiss(animated: true, completion: nil)
            })
            alertController.addAction(okAlert)
            self.present(alertController, animated: true, completion: nil)
        }

        return false
    }

    @IBAction func acceptButtonPressed(_ sender: Any) {
        navigationController?.pushViewController(LoveListViewController(), animated: true)
    }
}

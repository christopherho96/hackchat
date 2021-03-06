//
//  AuthProvider.swift
//  chat
//
//  Created by Christopher Ho on 2017-05-27.
//  Copyright © 2017 Christopher Ho. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth

typealias LoginHandler = (_ msg:String?)-> Void;

struct LoginErrorCode {
    static let INVALID_EMAIL = "Invalid Email Address, Please Provide A Real Email Address";
    static let WRONG_PASSWORD = "Wrong PAssword, Please enter the correct Password";
    static let PROBLEM_CONNECTING = "Problem connecting to database";
    static let USER_NOT_FOUND = "User not found";
    static let EMAIL_ALREADY_IN_USE = "Email already in use."
    static let WEAK_PASSWORD = "Password should be at least 6 characters long";
}

class AuthProvider{
    
    private static let _instance = AuthProvider();
    
    static var Instance: AuthProvider {
        return _instance;
    }
    
    var userName = "";
    
    func login(withEmail:String, password: String, loginHandler: LoginHandler?){
        Auth.auth().signIn(withEmail: withEmail, password: password, completion: {
            (user, error) in
            
            if error != nil {
                self.handleErrors(err: error! as NSError, loginHandler: loginHandler);
                
            }else{
                loginHandler?(nil);
            }
        });
    }//login func
    
    func signUp(withEmail: String, password: String, loginHandler: LoginHandler?){
        Auth.auth().createUser(withEmail: withEmail, password: password, completion: {
            (user, error) in
            
            if error != nil {
                self.handleErrors(err: error! as NSError, loginHandler: loginHandler);
            }else{
                if user?.uid != nil{
                    //store the user to database
                    DBProvider.Instance.saveUser(withID: user!.uid, email: withEmail, password: password);
                    
                    self.login(withEmail: withEmail, password: password, loginHandler: loginHandler);
                }
            }
        })
    }
    
    func isLoggedIn() -> Bool{
        if Auth.auth().currentUser != nil {
            return true;
        }
        
        return false;
    }
    
    func logOut() -> Bool {
        if Auth.auth().currentUser != nil{
            do{
                try Auth.auth().signOut();
                return true;
            }catch{
                return false;
            }
        }
        return true;
    }
    
    func userID() -> String{
        return Auth.auth().currentUser!.uid;
    }
    
    private func handleErrors(err: NSError, loginHandler: LoginHandler?){
        
        
        if let errCode = AuthErrorCode(rawValue: err.code){
            
            switch errCode {
                
            case AuthErrorCode.invalidEmail:
                loginHandler?(LoginErrorCode.INVALID_EMAIL)
                break;
                
            case AuthErrorCode.emailAlreadyInUse:
                loginHandler?(LoginErrorCode.EMAIL_ALREADY_IN_USE);
                break;
            
            case AuthErrorCode.weakPassword:
                loginHandler?(LoginErrorCode.WEAK_PASSWORD);
                break;
                
                
            case AuthErrorCode.userNotFound:
                loginHandler?(LoginErrorCode.USER_NOT_FOUND);
                break;
                
            case AuthErrorCode.wrongPassword:
                loginHandler?(LoginErrorCode.WRONG_PASSWORD);
                break;

            default:
                break;
                
            }
        
        }
    }
    
}

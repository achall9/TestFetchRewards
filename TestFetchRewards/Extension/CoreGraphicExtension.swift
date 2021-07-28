//
//  CoreGraphicExtension.swift
//  TestFetchRewards
//
//  Created by Alex on 27/07/2021.
//


import UIKit

extension CGSize {
    func aspectFit(to size: CGSize) -> CGSize {
        let mW = size.width / self.width;
        let mH = size.height / self.height;
        
        var result = size
        if( mH < mW ) {
            result.width = size.height / self.height * self.width;
        }
        else if( mW < mH ) {
            result.height = size.width / self.width * self.height;
        }
        
        return result;
    }
    
    func aspectFill(to size: CGSize) -> CGSize {
        let mW = size.width / self.width;
        let mH = size.height / self.height;
        
        var result = size
        if( mH > mW ) {
            result.width = size.height / self.height * self.width;
        }
        else if( mW > mH ) {
            result.height = size.width / self.width * self.height;
        }
        return result;
    }
}

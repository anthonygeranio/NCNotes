//
//  NCNotesController.h
//  NCNotes
//
//  Created by Anthony Geranio on 2/15/14.
//  Copyright (c) 2014 ASG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "_SBUIWidgetViewController.h"

@interface NCNotesController : _SBUIWidgetViewController {
    UITextView *noteView;
    UIButton *shareButton;
    UIButton *saveButton;
    
    NSString *noteColor;
    NSString *fontColor;
    CGFloat fontSizes;
    
    NSArray *colorsArray;
    UIColor *selectedNoteColor;
    UIColor *selectedFontColor;
    
    NSString *settingsPath;
    NSString *folderPath;
    NSString *filePath;
}

@property (nonatomic, retain) UITextView *noteView;
@property (nonatomic, retain) UIButton *shareButton;
@property (nonatomic, retain) UIButton *saveButton;

@property (nonatomic, retain) NSString *noteColor;
@property (nonatomic, retain) NSString *fontColor;

@property (nonatomic, retain) NSArray *colorsArray;
@property (nonatomic, retain) UIColor *selectedNoteColor;
@property (nonatomic, retain) UIColor *selectedFontColor;

@property (nonatomic, retain) NSString *settingsPath;
@property (nonatomic, retain) NSString *folderPath;
@property (nonatomic, retain) NSString *filePath;

- (void)save;
- (void)share;

@end
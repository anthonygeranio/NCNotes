//
//  NCNotesController.m
//  NCNotes
//
//  Created by Anthony Geranio on 2/15/14.
//  Copyright (c) 2014 ASG. All rights reserved.
//

#import "NCNotesController.h"

@implementation NCNotesController
@synthesize noteView, shareButton, saveButton, fontColor, noteColor, selectedNoteColor, selectedFontColor, colorsArray, filePath, folderPath, settingsPath;

- (void)loadView {
    [super loadView];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:[self getFolderPath]]){
        [[NSFileManager defaultManager] createDirectoryAtPath:[self getFolderPath] withIntermediateDirectories:YES attributes:nil error:nil];
        [[NSFileManager defaultManager] createFileAtPath:[self getFilePath] contents:Nil attributes:nil];
    }
}

- (NSString *)getFolderPath {
    folderPath = [NSString stringWithFormat:@"%@/%s", NSHomeDirectory(), "Library/NCNotes"];
    return folderPath;
}

- (NSString *)getFilePath {
    filePath = [NSString stringWithFormat:@"%@/%s", NSHomeDirectory(), "Library/NCNotes/saved.txt"];
    return filePath;
}

- (NSString *)getSettingsPath {
    settingsPath = @"/var/mobile/Library/Preferences/NCNotes.plist";
    return settingsPath;
}

- (void)hostDidPresent {
    [super hostDidPresent];
    
    // Notification Center was opened
    NSLog(@"Notification Center was opened");
}

- (void)viewDidAppear:(BOOL)animated {
    
    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:[self getSettingsPath]];
    
    colorsArray = @[[UIColor blackColor], [UIColor blueColor], [UIColor brownColor], [UIColor grayColor], [UIColor greenColor], [UIColor orangeColor], [UIColor purpleColor], [UIColor redColor], [UIColor whiteColor], [UIColor yellowColor]];
    
    selectedNoteColor = colorsArray[[[dict objectForKey:@"noteColor"] intValue]];
    NSLog(@"Note Color selected: %@ ", selectedNoteColor);
    
    selectedFontColor = colorsArray[[[dict objectForKey:@"fontColor"] intValue]];
    NSLog(@"Font Color selected: %@ ", selectedFontColor);
    
    fontSizes = [[dict objectForKey:@"fontSize"] intValue];
    NSLog(@"Font Size selected: %f ", fontSizes);
    
    noteView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, 320, 100)];
    noteView.editable = YES;
    noteView.allowsEditingTextAttributes = YES;
    [noteView setBackgroundColor:selectedNoteColor];
    [noteView setTextColor:selectedFontColor];
    noteView.font = [UIFont fontWithName:@"Arial" size:fontSizes];
    [self.view addSubview:noteView];
    [noteView release];
    
    saveButton = [[UIButton alloc] initWithFrame:CGRectMake(-25, 90, 100, 50)];
    saveButton.backgroundColor = [UIColor clearColor];
    saveButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:10];
    saveButton.titleLabel.textColor = selectedFontColor;
    [saveButton setTitle:@"Save" forState:UIControlStateNormal];
    [saveButton addTarget:self action:@selector(save)
         forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:saveButton];
    [self.view bringSubviewToFront:saveButton];
    [saveButton release];
    
    shareButton = [[UIButton alloc] initWithFrame:CGRectMake(245, 90, 100, 50)];
    shareButton.backgroundColor = [UIColor clearColor];
    shareButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:10];
    shareButton.titleLabel.textColor = selectedFontColor;
    [shareButton setTitle:@"Share" forState:UIControlStateNormal];
    [shareButton addTarget:self action:@selector(share)
         forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:shareButton];
    [self.view bringSubviewToFront:shareButton];
    [shareButton release];
    
    self.view.backgroundColor = selectedNoteColor;
    
    noteView.text = [NSString stringWithContentsOfFile:[self getFilePath] encoding:NSUTF8StringEncoding error:nil];
    
}

- (void)save {
    [self.noteView resignFirstResponder];
    [noteView.text writeToFile:[self getFilePath] atomically:YES encoding: NSUTF8StringEncoding error:nil];
}

- (void)share {
    
    NSString *shareString = [NSString stringWithFormat:@"%@", noteView.text];
    
    NSArray *activityItems = [NSArray arrayWithObjects:shareString, nil];
    
    UIActivityViewController *activityController =
    [[UIActivityViewController alloc]
     initWithActivityItems:activityItems
     applicationActivities:nil];
    
    [self presentViewController:activityController
                       animated:YES completion:nil];
}

- (void)hostDidDismiss {
    [super hostDidDismiss];
    
    // Notification Center was closed
    NSLog(@"Notification Center was closed");
}

- (CGSize)preferredViewSize
{
	return CGSizeMake(320, 130);
}

@end
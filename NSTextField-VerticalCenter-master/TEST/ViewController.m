//
//  ViewController.m
//  TEST
//
//  Created by sycf_ios on 2017/4/18.
//  Copyright © 2017年 shibiao. All rights reserved.
//

#import "ViewController.h"
@interface ViewController ()<NSTextFieldDelegate>
@property (weak) IBOutlet NSTextField *text1;
@property (weak) IBOutlet NSTextField *text2;
@property (weak) IBOutlet NSTextField *text3;

@end
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.text3.hidden = YES;
    // Do any additional setup after loading the view.
    self.text2.delegate = self;
    self.text1.delegate = self;
    
    self.text1.tag = 100;
    self.text2.tag = 200;
    [self.text2 setFocusRingType:NSFocusRingTypeNone];
    [self.text1 setFocusRingType:NSFocusRingTypeNone];
}

- (BOOL)control:(NSControl *)control textView:(NSTextView *)textView doCommandBySelector:(SEL)commandSelector{
    BOOL result = NO;
    
    // 判断是哪个输入框  哪个按键
    NSLog(@"----%@", NSStringFromSelector(commandSelector));
    NSLog(@"----%ld", (long)control.tag);
    
    // 判断谁说第一相应者
    NSLog(@"%hhd", control.becomeFirstResponder);
    
    [self.text3 acceptsFirstResponder];
    [self.text3 becomeFirstResponder];
    
    
    if (control.tag == 100) {
        if (commandSelector == @selector(insertNewline:)) {
            NSLog(@"shift-enter detected");
            [textView insertNewlineIgnoringFieldEditor:self];
            if (self.text1.becomeFirstResponder) {
                NSLog(@"100 之前是第一相应者 200是成为了第一相应者");
                [self.text1 resignFirstResponder];
                [self.text2 becomeFirstResponder];
                [self.text2 acceptsFirstResponder];
                result = YES;
            } else {
                NSLog(@"100 不是第一相应着");
            }
            
    
        } else if (commandSelector == @selector(insertTab:)){
            NSLog(@"enter detected");
            [textView.window.contentView nextResponder];
            [textView insertNewlineIgnoringFieldEditor:self];
            if (self.text1.becomeFirstResponder) {
                NSLog(@"100 之前是第一相应者  200成为了第一相应者");
                [self.text1 resignFirstResponder];
                [self.text2 becomeFirstResponder];
                [self.text2 acceptsFirstResponder];

                result = YES;

            } else {
                NSLog(@"100 不是第一相应着");
            }
        }
        
    }
    
    if(control.tag == 200) {
        if (commandSelector == @selector(insertNewline:)) {
            NSLog(@"shift-enter detected");
            [textView insertNewlineIgnoringFieldEditor:self];
            if (self.text2.becomeFirstResponder) {
                NSLog(@"200 之前是第一相应者  100成为了第一相应者");
                [self.text2 resignFirstResponder];
//                [self.text1 becomeFirstResponder];
//                [self.text1 acceptsFirstResponder];
                [self buttonClick];
                result = YES;

            } else {
                NSLog(@"200 不是第一相应者");
            }
            
        } else if (commandSelector == @selector(insertTab:)){
            NSLog(@"tab detected");
            [textView.window.contentView nextResponder];
            [textView insertNewlineIgnoringFieldEditor:self];
            if (self.text2.becomeFirstResponder) {
                NSLog(@"200 是第一相应着");
                [self.text2 resignFirstResponder];
                [self.text1 becomeFirstResponder];
                [self.text1 acceptsFirstResponder];
                result = YES;
            } else {
                NSLog(@"200 不是第一相应着");
            }
        }

    }
    
    
    
    
//    if (commandSelector == @selector(insertNewline:)) {
//        NSLog(@"shift-enter detected");
//        [textView insertNewlineIgnoringFieldEditor:self];
//        result = YES;
//        
//    } else if (commandSelector == @selector(insertTab:)){
//        NSLog(@"enter detected");
//        [textView.window.contentView nextResponder];
//        [textView insertNewlineIgnoringFieldEditor:self];
//        result = YES;
//    }
   return result;
}


- (void)buttonClick{
    NSLog(@"-----%@-----%@", self.text1.stringValue, self.text2.stringValue);
    NSLog(@"点击enter 直接登录");
}




- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}


@end

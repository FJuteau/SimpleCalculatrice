//
//  ViewController.h
//  SimpleCalculatrice
//
//  Created by François Juteau on 23/07/2015.
//  Copyright (c) 2015 François Juteau. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (nonatomic) NSString *operand1;
@property (nonatomic) NSString *operand2;

@property (nonatomic) float result;

@property (weak, nonatomic) UIButton *nextOperation;

@property (weak, nonatomic) IBOutlet UITextField *label;


#pragma mark - Inits and Resets

-(id)initWithCoder:(NSCoder *)aDecoder;

#pragma mark - Buttons Properties

@property (weak, nonatomic) IBOutlet UIButton *buttonPlus;
@property (weak, nonatomic) IBOutlet UIButton *buttonMoins;
@property (weak, nonatomic) IBOutlet UIButton *buttonMulti;
@property (weak, nonatomic) IBOutlet UIButton *buttonDiv;
@property (weak, nonatomic) IBOutlet UIButton *buttonEqual;


#pragma mark - Memory properties

@property (strong, atomic) NSMutableArray *memoryArray;
@property (nonatomic) NSInteger nbCurrentMemory;

@property (weak, nonatomic) IBOutlet UIButton *memory1;
@property (weak, nonatomic) IBOutlet UIButton *memory2;
@property (weak, nonatomic) IBOutlet UIButton *memory3;
@property (weak, nonatomic) IBOutlet UIButton *memory4;
@property (weak, nonatomic) IBOutlet UIButton *memory5;
@property (weak, nonatomic) IBOutlet UIButton *memory6;


#pragma mark - Buttons Methodes

- (IBAction)pushNumericButton:(UIButton *)sender;
- (IBAction)pushOperationButton:(UIButton *)sender;
- (IBAction)pushEqualButton:(UIButton *)sender;
- (IBAction)pushCancelButton:(UIButton *)sender;


#pragma mark - Memory Methode

- (IBAction)AddMemory:(id)sender;
- (IBAction)memoryAcces:(id)sender;


@end


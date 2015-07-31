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

@property (nonatomic) double result;

// UIButton cache that will kepp the next operation that will be used
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

// An attay taht will stok all the memory buttons
@property (strong, atomic) NSMutableArray *memoryArray;
// The numer of memory currently displayed
@property (nonatomic) NSInteger nbCurrentMemory;

@property (weak, nonatomic) IBOutlet UIButton *memory1;
@property (weak, nonatomic) IBOutlet UIButton *memory2;
@property (weak, nonatomic) IBOutlet UIButton *memory3;
@property (weak, nonatomic) IBOutlet UIButton *memory4;
@property (weak, nonatomic) IBOutlet UIButton *memory5;


#pragma mark - Buttons Methodes

- (IBAction)pushNumericButton:(UIButton *)sender;
- (IBAction)pushOperationButton:(UIButton *)sender;
- (IBAction)pushCancelButton:(UIButton *)sender;
- (IBAction)pushCommaButton:(UIButton *)sender;
- (IBAction)pushNegativeButton:(UIButton *)sender;


#pragma mark - Memory Methode
/**
 *  @author François Juteau, 15-07-31 00:07:38
 *
 *  @brief  Shift memories down and sets the first one to the label text
 *  @param sender not used
 */
- (IBAction)AddMemory:(id)sender;

/**
 *  @author François Juteau, 15-07-31 00:07:33
 *
 *  @brief  Sets the label to the UIButton text if it's not empty
 *  @param sender a memory button that was pressed
 */
- (IBAction)memoryAcces:(id)sender;


@end


//
//  ViewController.m
//  SimpleCalculatrice
//
//  Created by François Juteau on 23/07/2015.
//  Copyright (c) 2015 François Juteau. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

#pragma mark - Behaviour

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self setNbCurrentMemory:0];
    
    // Assingning every memory buttons to the buttons array
    
    // Swipe gesture regognizer decalration to delete a character
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleLeftSwipeGesture)];
    [swipe setDirection:UISwipeGestureRecognizerDirectionLeft];
    [[self view] addGestureRecognizer:swipe];
    
    [self reset];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Inits & Resets

// It's init with coder that is call from the parent
-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self)
    {
        _memoryArray = [[NSMutableArray alloc] init];
    }
    return self;
}

/**
 *  @author François Juteau, 15-07-31 01:07:58
 *
 *  @brief  Resets all operation properties
 */
-(void)reset
{
    [_label setText:@""];
    [_nextOperation setSelected:NO];
    
    [self setNextOperation:nil];
    [self setOperand1:@""];
    [self setOperand2:@""];
    [self setResult:0];
}


#pragma mark - Actions on the view

/**
 *  @author François Juteau, 15-07-31 01:07:14
 *
 *  @brief  Hanfle the adding of digits on the label text
 *  @param sender UIButton that is pressed
 */
-(IBAction)pushNumericButton:(UIButton *)sender
{
    [self pushButtonWithInt:[[NSString alloc] initWithFormat:@"%ld", [sender tag]]];
}

/**
 *  @author François Juteau, 15-07-31 01:07:41
 *
 *  @brief  Applies the last operation to the operands and sets the next operation
 *  @param sender UIbutton of the last operation pressed
 */
-(IBAction)pushOperationButton:(UIButton *)sender
{
    [self testOperations:sender];
    
    [_nextOperation setSelected:YES];
}

/**
 *  @author François Juteau, 15-07-31 01:07:52
 *
 *  @brief  Resets operations properties
 *  @param sender not used
 */
- (IBAction)pushCancelButton:(UIButton *)sender
{
    [self reset];
}

/**
 *  @author François Juteau, 15-07-31 01:07:17
 *
 *  @brief  Adds a comma at the end of the label
 *  @param sender not used
 */
- (IBAction)pushCommaButton:(UIButton *)sender
{
    [self pushButtonWithInt:@"."];
}

/**
 *  @author François Juteau, 15-07-31 01:07:57
 *
 *  @brief  Changes the sign of the label
 *  @param sender not used
 */
- (IBAction)pushNegativeButton:(UIButton *)sender
{
    [_label setText:[[NSString alloc] initWithFormat:@"%G", ([[_label text] doubleValue] * -1)]];
}


#pragma mark - Memory Methods

/**
 *  @author François Juteau, 15-07-31 00:07:38
 *
 *  @brief  Shift memories down and sets the first one to the label text
 *  @param sender not used
 */
- (IBAction)AddMemory:(id)sender
{
    if (![[_label text] isEqual:@""])
    {
        NSString *tempMemory = [[NSString alloc] initWithString:[_label text]];
        [_memoryArray insertObject:tempMemory atIndex:0];
    }
    [_memoryTableView reloadData];

}


#pragma mark - UITableViewDataSource Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _memoryArray.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"memoryCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    [[cell textLabel] setText:[_memoryArray objectAtIndex:indexPath.row]];
    
    return cell;
}


#pragma UITableViewDelegate Methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *val = [_memoryArray objectAtIndex:indexPath.row];
    
    [_label setText:val];
    
    [_nextOperation setSelected:NO];
}


#pragma mark - Handling methods

/**
 *  @author François Juteau, 15-07-31 01:07:51
 *
 *  @brief  Hadle the left swuoe gesture by deleting the last character on the label
 */
-(void) handleLeftSwipeGesture
{
    if ([_nextOperation isSelected] || _nextOperation == _buttonEqual || [[_label text] isEqual:@""])
    {
        [self reset];
    }
    else
    {
        // On prend les caractères du text du label jusqu'à sa taille -1
        [_label setText:[[_label text] substringToIndex:[[_label text] length]-1]];
    }
}

/**
 *  @author François Juteau, 15-08-03 08:08:08
 *
 *  @brief Handle the displaying of an error message
 *  @param _message message to display
 */
-(void) handleErrorMessages:(NSString *)_message
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"ATTENTION" message:_message preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction* cancel = [UIAlertAction
                             actionWithTitle:@"Cancel"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [alert dismissViewControllerAnimated:YES completion:nil];
                             }];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:nil];
}


#pragma mark - Intern methods

/**
 *  @author François Juteau, 15-07-31 01:07:33
 *
 *  @brief  Adds or start a fresh digit depending on if an operation is selected or not
 *  @param _value digit to add
 */
-(void) pushButtonWithInt:(NSString *)_value
{
    if ([_nextOperation isSelected])
    {
        [_label setText:_value];
        [_nextOperation setSelected:NO];
    }
    else
    {
        [self addDigit:_value];
    }
}

/**
 *  @author François Juteau, 15-07-31 01:07:16
 *
 *  @brief  Adds a digit to existants digits in label
 *  @param _digit digit to add
 */
-(void)addDigit:(NSString *)_digit
{
    // On assign au text de _label l'ancien text + le paramètre
    [_label setText:[[_label text] stringByAppendingString:_digit]];
}


-(void)testOperations:(UIButton *)_op
{
    if ([_nextOperation isSelected] != YES || _nextOperation == _buttonEqual)
    {
        _operand2 = [_label text];
        
        if (_nextOperation == _buttonPlus)
        {
            // Si c'est une multiplication
            [self setResult:[_operand1 doubleValue] + [_operand2 doubleValue]];
        }
        else if (_nextOperation == _buttonMoins)
        {
            // Si c'est une division
            [self setResult:[_operand1 doubleValue] - [_operand2 doubleValue]];
        }
        else if (_nextOperation == _buttonMulti)
        {
            // Si c'est une multiplication
            [self setResult:[_operand1 doubleValue] * [_operand2 doubleValue]];
        }
        else if (_nextOperation == _buttonDiv)
        {
            // Si c'est une division
            if ([_operand2 floatValue] != 0) {
                [self setResult:[_operand1 doubleValue] / [_operand2 doubleValue]];
            }
            else
            {
                [self handleErrorMessages:@"Non divisible par 0"];
            }
        }
        else
        {
            // Si l'objet est nul donc si c'est la première opération
            [self setResult:[[_label text] doubleValue]];
        }
        // Set false only used for the buttonEqual case
        [_nextOperation setSelected:NO];
        
        [self setNextOperation:_op];
        
        [self setOperand1:[[NSString alloc] initWithFormat:@"%G", _result]];
        [_label setText:[self operand1]];
        
        [_nextOperation setSelected:YES];
    }
}


@end

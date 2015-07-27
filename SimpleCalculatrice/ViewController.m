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
    
    NSLog(@"viewDidLoad");
    [_memoryArray addObject:_memory1];
    [_memoryArray addObject:_memory2];
    [_memoryArray addObject:_memory3];
    [_memoryArray addObject:_memory4];
    [_memoryArray addObject:_memory5];
    
    [self reset];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Inits & Resets

// C'est initWithCoder qui est appelé par le storyboard
-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    NSLog(@"init");
    if (self)
    {
        _memoryArray = [[NSMutableArray alloc] init];
    }
    return self;
}

-(void)reset
{
    [_label setText:@""];
    [_nextOperation setSelected:NO];
    
    [self setNextOperation:nil];
    [self setOperand1:@""];
    [self setOperand2:@""];
    [self setResult:0];
}


#pragma mark - Buttons Methodes

/*!
 *  @author François Juteau
 *
 *  @brief  <#Description#>
 *
 *  @param sender <#sender description#>
 */
-(IBAction)pushNumericButton:(UIButton *)sender
{
    [self pushButtonWithInt:[[NSString alloc] initWithFormat:@"%ld", [sender tag]]];
}

/*!
 *  @brief  <#Description#>
 *
 *  @param sender <#sender description#>
 */
-(IBAction)pushOperationButton:(UIButton *)sender
{
    [self testOperations:sender];
    
    [_nextOperation setSelected:YES];
}

/**
 *  <#Description#>
 *
 *  @param sender <#sender description#>
 */
- (IBAction)pushEqualButton:(UIButton *)sender
{
    [self testOperations:sender];
}

- (IBAction)pushCancelButton:(UIButton *)sender
{
    if ([_nextOperation isSelected] || _nextOperation == _buttonEqual)
    {
        [self reset];
    }
    else
    {
        // On prend les caractères du text du label jusqu'à sa taille -1
        [_label setText:[[_label text] substringToIndex:[[_label text] length]-1]];
    }
}

- (IBAction)pushComaButton:(UIButton *)sender
{
    [self pushButtonWithInt:@"."];
}

- (IBAction)pushNegativeButton:(UIButton *)sender
{
    [_label setText:[@"-" stringByAppendingString:[_label text]]];
}


#pragma mark - Memory Methoes

- (IBAction)AddMemory:(id)sender {
    
    long i = _nbCurrentMemory;
    
    while ( i > 0 )
    {
        [(UIButton *)[_memoryArray objectAtIndex:i] setTitle:[[(UIButton *)[_memoryArray objectAtIndex:i-1] titleLabel] text] forState:UIControlStateNormal];
        [[_memoryArray objectAtIndex:i] setHidden:NO];
        i--;
    }
    
    [(UIButton *)[_memoryArray objectAtIndex:0] setTitle:[_label text] forState:UIControlStateNormal];
    [[_memoryArray objectAtIndex:0] setHidden:NO];
    
    // on ne dépasse pas le nombre d'objets dans le tableau
    if (_nbCurrentMemory < [_memoryArray count]-1) {
        _nbCurrentMemory++;
    }
}

- (IBAction)memoryAcces:(UIButton *)sender
{
    if (![[[sender titleLabel] text] isEqualToString:@""])
    {
        [_label setText:[[sender titleLabel] text]];
    }
}


#pragma mark - Methodes internes

-(void) pushButtonWithInt:(NSString *)_value
{
    if ([_nextOperation isSelected] || _nextOperation == _buttonEqual)
    {
        [_label setText:_value];
        [_nextOperation setSelected:NO];
    }
    else
    {
        [self addDigit:_value];
    }
}

-(void)addDigit:(NSString *)_digit
{
    // On assign au text de _label l'ancien text + le paramètre
    [_label setText:[[_label text] stringByAppendingString:_digit]];
}


-(void)testOperations:(UIButton *)_op
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
        NSLog(@"DIVISION : operand2 : %f", [_operand2 doubleValue]);
        // Si c'est une division
        if ([_operand2 floatValue] != 0) {
            NSLog(@"NON EGAL");
            [self setResult:[_operand1 doubleValue] / [_operand2 doubleValue]];
        }
        else
        {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"ATTENTION" message:@"Division par 0 impossible" preferredStyle:UIAlertControllerStyleActionSheet];
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
    }
    else
    {
        // Si l'objet est nul donc si c'est la première opération
        [self setResult:[[_label text] doubleValue]];
    }
    
    [_nextOperation setSelected:NO];
    [self setNextOperation:_op];
    
    [self setOperand1:[[NSString alloc] initWithFormat:@"%G", _result]];
    [_label setText:[self operand1]];
}


@end

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
    [_memoryArray addObject:_memory6];
    
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
        _memoryArray = [[NSMutableArray alloc] initWithObjects:_memory1, _memory2, _memory3, _memory4,_memory5, _memory6, nil];
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

-(IBAction)pushNumericButton:(UIButton *)sender
{
    [self pushButtonWithInt:[[NSString alloc] initWithFormat:@"%ld", [sender tag]]];
}

-(IBAction)pushOperationButton:(UIButton *)sender
{
    [self testOperations:sender];
    
    [_nextOperation setSelected:YES];
}

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


#pragma mark - Memory Methoes

- (IBAction)AddMemory:(id)sender {
    
    long i = _nbCurrentMemory;
    
//    assert(appdelegate._memoryArray);
    
    while ( i > 0 )
    {
        [(UITextField *)[_memoryArray objectAtIndex:i] setText:[(UITextField *)[_memoryArray objectAtIndex:i-1] text]];
        i--;
    }
    
    [(UITextField *)[_memoryArray objectAtIndex:0] setText:[_label text]];
}

- (IBAction)memoryAcces:(UITextField *)sender
{
    if ([[sender text] isEqualToString:@""])
    {
        [_label setText:[sender text]];
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
        [self setResult:[_operand1 floatValue] + [_operand2 floatValue]];
    }
    else if (_nextOperation == _buttonMoins)
    {
        // Si c'est une division
        [self setResult:[_operand1 floatValue] - [_operand2 floatValue]];
    }
    else if (_nextOperation == _buttonMulti)
    {
        // Si c'est une multiplication
        [self setResult:[_operand1 floatValue] * [_operand2 floatValue]];
    }
    else if (_nextOperation == _buttonDiv)
    {
        // Si c'est une division
        [self setResult:[_operand1 floatValue] / [_operand2 floatValue]];
    }
    else
    {
        // Si l'objet est nul donc si c'est la première opération
        [self setResult:[[_label text] floatValue]];
    }
    
    [_nextOperation setSelected:NO];
    [self setNextOperation:_op];
    
    [self setOperand1:[[NSString alloc] initWithFormat:@"%f", [self result]]];
    [_label setText:[self operand1]];
}


@end

//
//  Calculs.m
//  SimpleCalculatrice
//
//  Created by François Juteau on 01/08/2015.
//  Copyright (c) 2015 François Juteau. All rights reserved.
//

#import "Calculs.h"

@implementation Calculs

+(NSString *) doPlusOperation:(NSString *)_op1 withOperand2:(NSString *)_op2 andResult:(double)_result
{
    
    _result = [_op1 doubleValue] + [_op2 doubleValue];
    return @"";
}

+(NSString *) doMoinsOperation:(NSString *)_op1 withOperand2:(NSString *)_op2
{
    
    return @"";
}

+(NSString *) doMultiOperation:(NSString *)_op1 withOperand2:(NSString *)_op2
{
    
     return @"";
}

+(NSString *) doDivOperation:(NSString *)_op1 withOperand2:(NSString *)_op2
{
    
     return @"";
}

@end

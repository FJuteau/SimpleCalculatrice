//
//  Calculs.h
//  SimpleCalculatrice
//
//  Created by François Juteau on 01/08/2015.
//  Copyright (c) 2015 François Juteau. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Calculs : NSObject

+(NSString *) doPlusOperation:(NSString *)_op1 withOperand2:(NSString *)_op2 andResult:(double)_result;
+(NSString *) doMoinsOperation:(NSString *)_op1 withOperand2:(NSString *)_op2;
+(NSString *) doMultiOperation:(NSString *)_op1 withOperand2:(NSString *)_op2;
+(NSString *) doDivOperation:(NSString *)_op1 withOperand2:(NSString *)_op2;

@end

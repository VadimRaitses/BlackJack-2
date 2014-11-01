//
//  CardView.h
//  BlackJack
//
//  Created by Vadim raitses on 6/4/14.
//  Copyright (c) 2014 Vadim Raitses. All rights reserved.
//

#import<Foundation/Foundation.h>

@interface CardView : UIView
 @property (nonatomic) NSUInteger rank;
 @property (nonatomic, strong) NSString *suit;
 @property (nonatomic) BOOL faceUp;
 - (void)pinch:(UIPinchGestureRecognizer *)gesture;
@end

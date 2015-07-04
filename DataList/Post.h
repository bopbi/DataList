//
//  Post.h
//  DataList
//
//  Created by Bobby Adi Prabowo on 7/4/15.
//  Copyright (c) 2015 Bobby Adi Prabowo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Post : NSManagedObject

@property (nonatomic, retain) NSString * content;
@property (nonatomic, retain) NSString * title;

@end

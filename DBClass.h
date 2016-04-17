//
//  DBClass.h
//  RevealControllerProject3
//
//  Created by Nish Vishnu on 17/04/16.
//
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "DealsObj.h"

@interface DBClass : NSObject

@property (strong, nonatomic)NSArray *docPaths;
@property (strong, nonatomic)NSString *documentsDir;
@property (strong, nonatomic)NSString *dbPath;
@property (strong, nonatomic)FMDatabase *database;
@property (strong, nonatomic)NSString *KeyName;
@property (strong, nonatomic)NSString *KeyValue;
@property (strong, nonatomic)NSString *ExecuteString;
@property (strong, nonatomic)NSString *ExecuteSubString;
@property (nonatomic, retain)NSArray *argsValues;

@property (strong, nonatomic)DealsObj *dealsObj;

- (void) InsertNewDeal : (DealsObj *) currentDealDetails;
- (NSMutableArray *) GetDealsArray;

-(void) CreateDB;

@end

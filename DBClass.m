//
//  DBClass.m
//  RevealControllerProject3
//
//  Created by Nish Vishnu on 17/04/16.
//
//

#import "DBClass.h"

@implementation DBClass
@synthesize docPaths, documentsDir;
@synthesize dbPath, database;
@synthesize dealsObj;

- (void) SetUpDB
{
    docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    documentsDir = [docPaths objectAtIndex:0];
    dbPath = [documentsDir   stringByAppendingPathComponent:@"eFoodie.sqlite"];
    database = [FMDatabase databaseWithPath:dbPath];
}

NSMutableString *QueryString;

-(void) CreateDB;
{
    [self SetUpDB];
    [self CreateDealsTable];
}

- (void) CreateDealsTable
{
    [database open];
    
    NSMutableArray *columnsArray = [[NSMutableArray alloc] init];
    [columnsArray addObject:@"deal_alt1"];
    [columnsArray addObject:@"deal_alt2"];
    [columnsArray addObject:@"deal_alt3"];
    [columnsArray addObject:@"deal_brandId"];
    [columnsArray addObject:@"deal_brandName"];
    [columnsArray addObject:@"deal_couponTemplate"];
    [columnsArray addObject:@"deal_current_downloads"];
    [columnsArray addObject:@"deal_dealsPerSubscriber"];
    [columnsArray addObject:@"deal_description"];
    [columnsArray addObject:@"deal_disclaimer1"];
    [columnsArray addObject:@"deal_disclaimer2"];
    [columnsArray addObject:@"deal_draft"];
    [columnsArray addObject:@"deal_endDate"];
    [columnsArray addObject:@"deal_headline"];
    [columnsArray addObject:@"deal_id"];
    [columnsArray addObject:@"deal_img1"];
    [columnsArray addObject:@"deal_img1Id"];
    [columnsArray addObject:@"deal_img2"];
    [columnsArray addObject:@"deal_img2Id"];
    [columnsArray addObject:@"deal_img3Id"];
    [columnsArray addObject:@"deal_link"];
    [columnsArray addObject:@"deal_messageId"];
    [columnsArray addObject:@"deal_restaurants_address"];
    [columnsArray addObject:@"deal_restaurants_brandId"];
    [columnsArray addObject:@"deal_restaurants_city"];
    [columnsArray addObject:@"deal_restaurants_hours"];
    [columnsArray addObject:@"deal_restaurants_id"];
    [columnsArray addObject:@"deal_restaurants_phone"];
    [columnsArray addObject:@"deal_restaurants_state"];
    [columnsArray addObject:@"deal_restaurants_zipcode"];
    [columnsArray addObject:@"deal_startDate"];
    [columnsArray addObject:@"deal_subheadline"];
    [columnsArray addObject:@"deal_template"];
    [columnsArray addObject:@"deal_totalDownloadLimit"];
    
    NSString *query = [self CreateTable:@"deal" : columnsArray];
    
    [database executeUpdate: query];
    [database close];
}

- (NSString *) CreateTable : (NSString *) TABLE_NAME : (NSMutableArray *) COLUMNS
{
    QueryString = [[NSMutableString alloc] init];
    [QueryString appendString:@"CREATE TABLE "];
    [QueryString appendString: TABLE_NAME];
    [QueryString appendString:@" "];
    [QueryString appendString:@"( "];
    
    int arrayLength = COLUMNS.count;
    int indexInt = 1;
    
    for(id Column in COLUMNS)
    {
        [QueryString appendString: (NSString *) Column];
        
        if(indexInt == arrayLength)
        {
            [QueryString appendString: @" TEXT DEFAULT NULL ) "];
        }
        else
        {
            [QueryString appendString: @" TEXT DEFAULT NULL, "];
        }
        
        indexInt += 1;
    }
    
    return QueryString;
}

- (void) InsertNewDeal : (DealsObj *) currentDealDetails;
{
//    if([self CheckTicketExists : currentTicketDetails.TICKET_ID])
//    {
//        [self UpdateTicketDetails: currentTicketDetails];
//        return;
//    }
    
    NSMutableString *ExecuteString  = [[NSMutableString alloc] init];
    
    [ExecuteString appendString: @"INSERT INTO "];
    [ExecuteString appendString: @"deal "];
    [ExecuteString appendString: @"("];
    [ExecuteString appendString: @"deal_alt1,"];
    [ExecuteString appendString: @"deal_alt2,"];
    [ExecuteString appendString: @"deal_alt3,"];
    [ExecuteString appendString: @"deal_brandId,"];
    [ExecuteString appendString: @"deal_brandName,"];
    [ExecuteString appendString: @"deal_couponTemplate,"];
    [ExecuteString appendString: @"deal_current_downloads,"];
    [ExecuteString appendString: @"deal_dealsPerSubscriber,"];
    [ExecuteString appendString: @"deal_description,"];
    [ExecuteString appendString: @"deal_disclaimer1,"];
    [ExecuteString appendString: @"deal_disclaimer2,"];
    [ExecuteString appendString: @"deal_draft,"];
    [ExecuteString appendString: @"deal_endDate,"];
    [ExecuteString appendString: @"deal_headline,"];
    [ExecuteString appendString: @"deal_id,"];
    [ExecuteString appendString: @"deal_img1,"];
    [ExecuteString appendString: @"deal_img1Id,"];
    [ExecuteString appendString: @"deal_img2,"];
    [ExecuteString appendString: @"deal_img2Id,"];
    [ExecuteString appendString: @"deal_img3Id,"];
    [ExecuteString appendString: @"deal_link,"];
    [ExecuteString appendString: @"deal_messageId,"];
    
    [ExecuteString appendString: @"deal_restaurants_address,"];
    
    [ExecuteString appendString: @"deal_restaurants_brandId,"];
    [ExecuteString appendString: @"deal_restaurants_city,"];
    [ExecuteString appendString: @"deal_restaurants_hours,"];
    [ExecuteString appendString: @"deal_restaurants_id,"];
    
    [ExecuteString appendString: @"deal_restaurants_phone,"];
    [ExecuteString appendString: @"deal_restaurants_state,"];
    [ExecuteString appendString: @"deal_restaurants_zipcode,"];
    [ExecuteString appendString: @"deal_startDate,"];
    
    [ExecuteString appendString: @"deal_subheadline,"];
    [ExecuteString appendString: @"deal_template,"];
    [ExecuteString appendString: @"deal_totalDownloadLimit"];
    [ExecuteString appendString: @")"];
    [ExecuteString appendString: @" VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)"];
    
    [database open];
    
    [database executeUpdate: ExecuteString,
     currentDealDetails.deal_alt1,
     currentDealDetails.deal_alt2,
     currentDealDetails.deal_alt3,
     currentDealDetails.deal_brandId,
     currentDealDetails.deal_brandName,
     currentDealDetails.deal_couponTemplate,
     currentDealDetails.deal_current_downloads,
     currentDealDetails.deal_dealsPerSubscriber,
     currentDealDetails.deal_description,
     currentDealDetails.deal_disclaimer1,
     currentDealDetails.deal_disclaimer2,
     currentDealDetails.deal_draft,
     currentDealDetails.deal_endDate,
     currentDealDetails.deal_headline,
     currentDealDetails.deal_id,
     currentDealDetails.deal_img1,
     currentDealDetails.deal_img1Id,
     currentDealDetails.deal_img2,
     currentDealDetails.deal_img2Id,
     currentDealDetails.deal_img3Id,
     currentDealDetails.deal_link,
     currentDealDetails.deal_messageId,
     currentDealDetails.deal_restaurants_address,
     currentDealDetails.deal_restaurants_brandId,
     currentDealDetails.deal_restaurants_city,
     currentDealDetails.deal_restaurants_hours,
     currentDealDetails.deal_restaurants_id,
     currentDealDetails.deal_restaurants_phone,
     currentDealDetails.deal_restaurants_state,
     currentDealDetails.deal_restaurants_zipcode,
     currentDealDetails.deal_startDate,
     currentDealDetails.deal_subheadline,
     currentDealDetails.deal_template,
     currentDealDetails.deal_totalDownloadLimit,
     nil];
    
    [database close];
}

- (NSMutableArray *) GetDealsArray;
{
    [self SetUpDB];
    
    [database open];
    
    FMResultSet *rs = [database executeQuery:@"SELECT * FROM deal", nil];
    
    NSMutableArray *array = [NSMutableArray array];
    
    DealsObj *dealsObjItem;
    
    while ([rs next])
    {
        dealsObjItem = [[DealsObj alloc] init];
        dealsObjItem.deal_alt1 = [rs stringForColumn:@"deal_alt1"];
        dealsObjItem.deal_alt2 = [rs stringForColumn:@"deal_alt2"];
        dealsObjItem.deal_alt3 = [rs stringForColumn:@"deal_alt3"];
        dealsObjItem.deal_brandId = [rs stringForColumn:@"deal_brandId"];
        dealsObjItem.deal_brandName = [rs stringForColumn:@"deal_brandName"];
        dealsObjItem.deal_couponTemplate = [rs stringForColumn:@"deal_couponTemplate"];
        dealsObjItem.deal_current_downloads = [rs stringForColumn:@"deal_current_downloads"];
        dealsObjItem.deal_dealsPerSubscriber = [rs stringForColumn:@"deal_dealsPerSubscriber"];
        dealsObjItem.deal_description = [rs stringForColumn:@"deal_description"];
        dealsObjItem.deal_disclaimer1 = [rs stringForColumn:@"deal_disclaimer1"];
        dealsObjItem.deal_disclaimer2 = [rs stringForColumn:@"deal_disclaimer2"];
        dealsObjItem.deal_draft = [rs stringForColumn:@"deal_draft"];
        dealsObjItem.deal_endDate = [rs stringForColumn:@"deal_endDate"];
        dealsObjItem.deal_headline = [rs stringForColumn:@"deal_headline"];
        dealsObjItem.deal_id = [rs stringForColumn:@"deal_id"];
        dealsObjItem.deal_img1 = [rs stringForColumn:@"deal_img1"];
        dealsObjItem.deal_img1Id = [rs stringForColumn:@"deal_img1Id"];
        dealsObjItem.deal_img2 = [rs stringForColumn:@"deal_img2"];
        dealsObjItem.deal_img2Id = [rs stringForColumn:@"deal_img2Id"];
        dealsObjItem.deal_img3Id = [rs stringForColumn:@"deal_img3Id"];
        dealsObjItem.deal_link = [rs stringForColumn:@"deal_link"];
        dealsObjItem.deal_messageId = [rs stringForColumn:@"deal_messageId"];
        dealsObjItem.deal_restaurants_address = [rs stringForColumn:@"deal_restaurants_address"];
        dealsObjItem.deal_restaurants_brandId = [rs stringForColumn:@"deal_restaurants_brandId"];
        dealsObjItem.deal_restaurants_city = [rs stringForColumn:@"deal_restaurants_city"];
        dealsObjItem.deal_restaurants_hours = [rs stringForColumn:@"deal_restaurants_hours"];
        dealsObjItem.deal_restaurants_id = [rs stringForColumn:@"deal_restaurants_id"];
        dealsObjItem.deal_restaurants_phone = [rs stringForColumn:@"deal_restaurants_phone"];
        dealsObjItem.deal_restaurants_state = [rs stringForColumn:@"deal_restaurants_state"];
        dealsObjItem.deal_restaurants_zipcode = [rs stringForColumn:@"deal_restaurants_zipcode"];
        dealsObjItem.deal_startDate = [rs stringForColumn:@"deal_startDate"];
        dealsObjItem.deal_subheadline = [rs stringForColumn:@"deal_subheadline"];
        dealsObjItem.deal_template = [rs stringForColumn:@"deal_template"];
        dealsObjItem.deal_totalDownloadLimit = [rs stringForColumn:@"deal_totalDownloadLimit"];
        
        [array addObject:dealsObjItem];
    }
    
    [rs close];
    
    [database close];
    
    return array;
}

@end

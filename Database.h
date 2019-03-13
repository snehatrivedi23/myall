//
//  Database.h
//  BookReader
//
//  Copyright ©2012, Coho Software LLC. All rights reserved

#import <UIKit/UIKit.h>
#import <sqlite3.h>

@interface Database : NSObject {

	sqlite3 *databaseObj;

}
+(Database*) shareDatabase;

-(BOOL) createEditableCopyOfDatabaseIfNeeded;
-(NSString *) GetDatabasePath:(NSString *)dbName;

-(NSMutableArray *)SelectAllFromTable:(NSString *)query;
-(int)getCount:(NSString *)query;
-(BOOL)CheckForRecord:(NSString *)query;
- (void)Insert:(NSString *)query;
-(void)Delete:(NSString *)query;
-(void)Update:(NSString *)query;
- (int)InsertWithRowId:(NSString *)query;

-(BOOL)createTable:(NSString *)tableQuery;
@end

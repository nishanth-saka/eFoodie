//
//  DealViewCell.h
//  RevealControllerProject3
//
//  Created by Nish Vishnu on 13/04/16.
//
//

#import <UIKit/UIKit.h>
#import "DealsObj.h"

@interface DealViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *lblDealName;
@property (weak, nonatomic) IBOutlet UILabel *lblDealDescription;
@property (weak, nonatomic) IBOutlet UILabel *lblRestaurant;
@property (weak, nonatomic) IBOutlet UIView *viewTopSection;
@property (weak, nonatomic) IBOutlet UIView *viewTopSubSection;
@property (weak, nonatomic) IBOutlet UIView *viewImgBottomSection;

@property (strong, nonatomic) DealsObj *dealsObj;

- (void) setDealImage : (NSString *) ImageURL;
- (void) setDealDetails: (NSString *) dealTitle : (NSString *) dealRestaurant : (NSString *) dealLocation;

@end

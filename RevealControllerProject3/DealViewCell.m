//
//  DealViewCell.m
//  RevealControllerProject3
//
//  Created by Nish Vishnu on 13/04/16.
//
//

#import "DealViewCell.h"
#import "UIImageView+WebCache.h"

@implementation DealViewCell
@synthesize img, lblDealName, lblDealDescription, lblRestaurant;
@synthesize viewTopSection, viewTopSubSection, viewImgBottomSection;

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) setDealDetails: (NSString *) dealTitle : (NSString *) dealRestaurant : (NSString *) dealLocation;
{
    viewTopSection.backgroundColor = [UIColor clearColor];  //[UIColor colorWithRed:241/255.0f green:153/255.0f blue:6/255.0f alpha:1.0f];
    viewTopSubSection.backgroundColor = [UIColor clearColor];  //[UIColor colorWithRed:38/255.0f green:28/255.0f blue:22/255.0f alpha:1.0f];
    viewImgBottomSection.backgroundColor = [UIColor colorWithRed:241/255.0f green:153/255.0f blue:6/255.0f alpha: 0.95f];
    //[UIColor colorWithRed:38/255.0f green:28/255.0f blue:22/255.0f alpha:0.3f];
    
    lblDealName.text = dealTitle;
    [lblDealName setTextColor: [UIColor colorWithRed:241/255.0f green:153/255.0f blue:6/255.0f alpha:1.0f]];

    lblDealDescription.text = dealRestaurant;
    [lblDealDescription setTextColor: [UIColor colorWithRed:38/255.0f green:28/255.0f blue:22/255.0f alpha:1.0f]];
    
    lblRestaurant.text = dealLocation;
    [lblRestaurant setTextColor: [UIColor whiteColor]]; //[UIColor colorWithRed:38/255.0f green:28/255.0f blue:22/255.0f alpha:1.0f]];
}

- (void) setDealImage : (NSString *) ImageURL;
{
//    img.contentMode = UIViewContentModeScaleToFill;
    
    double width = img.frame.size.width;
    double height =  img.frame.size.height;
    double apect = width/height;
    
    double nHeight = 320.f/ apect;
    img.frame = CGRectMake(0, 0, 320, nHeight);
    img.center = self.contentView.center;
    
    [img sd_setImageWithURL:[NSURL URLWithString: ImageURL]
                   placeholderImage:[UIImage imageNamed:@"skull.png"]];
}

@end

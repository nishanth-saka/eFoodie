//
//  FrontViewControllerBlocksViewController.h
//  RevealControllerProject3
//
//  Created by Joan on 30/12/12.
//
//

#import <UIKit/UIKit.h>
#import "DealViewCell.h"
#import "JBKenBurnsView.h"
#import "DBClass.h"
#import "DealsObj.h"

@interface FrontViewControllerLabel : UIViewController <UITableViewDataSource, UITableViewDelegate, KenBurnsViewDelegate>

@property (nonatomic, strong) IBOutlet JBKenBurnsView *kenView;
@property (nonatomic) IBOutlet UILabel *label;
@property (nonatomic) IBOutlet UIButton *button;
@property (weak, nonatomic) IBOutlet UITableView *tblDeals;
@property (strong, nonatomic) IBOutlet UIView *viewDetailsPage;
@property (weak, nonatomic) IBOutlet UIImageView *btnCloseView;
@property (weak, nonatomic) IBOutlet UIImageView *imgDetailPage;
@property (weak, nonatomic) IBOutlet UIScrollView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *lblMainTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblBottomTitle;
@property (weak, nonatomic) IBOutlet UIView *viewImgCover;
@property (weak, nonatomic) IBOutlet UIImageView *imgRedeemNow;
@property (weak, nonatomic) IBOutlet UILabel *lblCouponNumber;
@property (weak, nonatomic) IBOutlet UILabel *lblValidThru;
@property (weak, nonatomic) IBOutlet UILabel *lblBrandName;
@property (weak, nonatomic) IBOutlet UILabel *lblAddress;
@property (weak, nonatomic) IBOutlet UIView *viewTopBar;
@property (weak, nonatomic) IBOutlet UIImageView *imgBranding;
@property (weak, nonatomic) IBOutlet UIView *viewBgTitle;
@property (weak, nonatomic) IBOutlet UIView *viewBgSubHeading;
@property (weak, nonatomic) IBOutlet UIView *viewBgBrandName;
@property (weak, nonatomic) IBOutlet UIView *viewBgAddress;
@property (weak, nonatomic) IBOutlet UIView *viewBgTnC;
@property (weak, nonatomic) IBOutlet UIImageView *imgShare;
@property (weak, nonatomic) IBOutlet UIImageView *imgFavorite;
@property (weak, nonatomic) IBOutlet UIImageView *imgViewDetails;
@property (weak, nonatomic) IBOutlet UIImageView *imgClose;

@property (weak, nonatomic) IBOutlet UIView *viewDisc1;
@property (weak, nonatomic) IBOutlet UILabel *lblDisc1;
@property (weak, nonatomic) IBOutlet UIView *viewDisc2;
@property (weak, nonatomic) IBOutlet UILabel *lblDisc2;

@property (strong, nonatomic) DBClass *dbClassObj;

@property (nonatomic) NSString *text;
@end

//
//  FrontViewControllerBlocksViewController.m
//  RevealControllerProject3
//
//  Created by Joan on 30/12/12.
//
//

#import "FrontViewControllerLabel.h"
#import "SWRevealViewController.h"
#import "UIImageView+WebCache.h"


@interface FrontViewControllerLabel ()
{
    UIView *topBarView;
    int topBarViewWidth;
    int topBarViewHeight;
    int topBarXLoc;
    int topBarYLoc;
    
    int menuButtonWidth;
    int menuButtonHeight;
    int menuButtonXLoc;
    int menuButtonYLoc;
    
    int tblDealsWidth;
    int tblDealsHeight;
    int tblDealsXLoc;
    int tblDealsYLoc;
    
    int viewDetailsPageWidth;
    int viewDetailsPageHeight;
    int viewDetailsPageXLoc;
    int viewDetailsPageYLoc;
    
    int btnCloseViewWidth;
    int btnCloseViewHeight;
    int btnCloseViewXLoc;
    int btnCloseViewYLoc;
    
    int imgDetailPageWidth;
    int imgDetailPageHeight;
    int imgDetailPageXLoc;
    int imgDetailPageYLoc;
    
    DealViewCell *dealViewCell;
    int numberOfDeals;
    NSArray *dealsArray;
    
    UIImage *currentSelectedImage;
    NSMutableDictionary *currentDeal;
    NSMutableDictionary *restaurantAddress;
    SWRevealViewController *revealController;
    
    int lblMainTitleWidth, lblMainTitleHeight, lblMainTitleXLoc, lblMainTitleYLoc;
}
@end

@implementation FrontViewControllerLabel
@synthesize tblDeals, viewDetailsPage;
@synthesize bgView, lblMainTitle, viewImgCover;
@synthesize imgRedeemNow, lblBottomTitle;
@synthesize lblCouponNumber, lblValidThru;
@synthesize lblBrandName, lblAddress;
@synthesize imgBranding, viewBgTitle;
@synthesize viewBgSubHeading, viewBgBrandName;
@synthesize viewBgAddress, viewBgTnC;
@synthesize viewTopBar, btnCloseView, imgDetailPage;
@synthesize imgClose, imgFavorite, imgShare, imgViewDetails;
@synthesize kenView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self addTopBar];
    [self manageTableView];
    [self getDeals];
    
    //NSLog(@"%@", result);
}

- (void) addTopBar
{
    topBarView = [[UIView alloc] init];
    
    topBarViewWidth = self.view.frame.size.width;
    topBarViewHeight = 50;
    topBarXLoc = 0;
    topBarYLoc = 0;
    
    topBarView.backgroundColor = [UIColor colorWithRed:241/255.0f green:153/255.0f blue:6/255.0f alpha:1.0f];
    
    topBarView.frame = CGRectMake(topBarXLoc, topBarYLoc, topBarViewWidth, topBarViewHeight);
    
    UIButton *menuButton = [[UIButton alloc] init];
    
    menuButtonWidth = 20;
    menuButtonHeight = 15;
    menuButtonXLoc = 10;
    menuButtonYLoc = (topBarViewHeight - menuButtonHeight)/2 + 5;
    
    menuButton.frame = CGRectMake(menuButtonXLoc, menuButtonYLoc, menuButtonWidth, menuButtonHeight);
    menuButton.backgroundColor = [UIColor clearColor];
    [menuButton setBackgroundImage:[UIImage imageNamed:@"reveal-icon.png"] forState:UIControlStateNormal];
    
    revealController = self.revealViewController;
    
    [self.view addGestureRecognizer:revealController.panGestureRecognizer];
    [menuButton addTarget:revealController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
    
    [topBarView addSubview: menuButton];
    
    [self.view addSubview: topBarView];
}

- (void) manageTableView
{
    tblDealsWidth = tblDeals.frame.size.width;
    tblDealsHeight = tblDeals.frame.size.height;
    tblDealsXLoc = tblDeals.frame.origin.x;
    tblDealsYLoc = topBarYLoc + topBarViewHeight + 0;
    
    tblDeals.frame = CGRectMake(tblDealsXLoc, tblDealsYLoc, tblDealsWidth, tblDealsHeight);
    tblDeals.backgroundColor = [UIColor whiteColor];
}

- (NSString *) getDeals
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:@"GET"];
    [request setURL:[NSURL URLWithString:@"http://e-foodie.com/mapi/api.php?rquest=listDeals"]];
    
    NSError *error = [[NSError alloc] init];
    NSHTTPURLResponse *responseCode = nil;
    
    NSData *oResponseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&responseCode error:&error];
    
    id response=[NSJSONSerialization JSONObjectWithData:oResponseData options:
                 NSJSONReadingMutableContainers error:&error];

    dealsArray = (NSArray *) response;
    numberOfDeals = [dealsArray count];
    
    
    if([responseCode statusCode] != 200)
    {
        return nil;
    }
    
    return [[NSString alloc] initWithData:oResponseData encoding:NSUTF8StringEncoding];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(numberOfDeals != nil && numberOfDeals > 0)
    {
        return numberOfDeals;
    }
    
    return  1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 305;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"DealViewCell";
    
    DealViewCell *cell = (DealViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"DealViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    NSString *dealHeadline = [dealsArray[indexPath.row] objectForKey:@"headline"];
    NSString *dealRestaurant = [dealsArray[indexPath.row] objectForKey:@"brandName"];
    NSString *dealLocation = [dealsArray[indexPath.row] objectForKey:@"brandName"];
    NSString *dealImage = [dealsArray[indexPath.row] objectForKey:@"img1"];

    NSMutableArray* res = (NSMutableArray *) [dealsArray[indexPath.row] objectForKey:@"restaurants"];
    
    if(res != nil && res.count > 0)
    {
        NSMutableArray* obj = (NSMutableArray*) res[0];
        
        if(obj != nil && obj.count > 0)
        {
            NSMutableDictionary* obj2 = (NSMutableDictionary*) obj[0];
            dealLocation = [obj2 objectForKey:@"address"];
        }
    }
    
    [cell setDealDetails:dealHeadline :dealRestaurant : dealLocation];
    [cell setDealImage: dealImage ];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor = tblDeals.backgroundColor;    
}

#pragma mark - Table view delegate

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    return indexPath;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DealViewCell *cell = (DealViewCell *) [tableView cellForRowAtIndexPath:indexPath];
    currentSelectedImage = cell.img.image;
    currentDeal = (NSMutableDictionary *) [dealsArray objectAtIndex: indexPath.row];
    
    NSMutableArray *addressDict = (NSMutableArray *)  [currentDeal objectForKey:@"restaurants"];
    if(addressDict.count > 0)
    {
        NSMutableArray *addDict = (NSMutableArray *) addressDict[0];
        restaurantAddress = (NSMutableDictionary *) addDict[0];
//        NSLog(@"%@", restaurantAddress);
    }
    NSLog(@"Current Log %@", currentDeal);
    
    [revealController rightRevealToggle:cell];
    
    [self showDetailsPage];
}

- (void) showDetailsPage
{
    [bgView setContentOffset:
     CGPointMake(0, -bgView.contentInset.top) animated:YES];
    
    //imgBranding.backgroundColor = [UIColor colorWithRed:38/255.0f green:28/255.0f blue:22/255.0f alpha:1.0f];
    //imgBranding.backgroundColor = [UIColor lightGrayColor];
     viewTopBar.backgroundColor =  [UIColor colorWithRed:38/255.0f green:28/255.0f blue:22/255.0f alpha:1.0f];
    
    //bgView.backgroundColor = [UIColor colorWithRed:38/255.0f green:28/255.0f blue:22/255.0f alpha:1.0f];
    bgView.backgroundColor = [UIColor whiteColor];

    
    viewBgTitle.backgroundColor = [UIColor colorWithRed:79/255.0f green:170/255.0f blue:178/255.0f alpha:1.0f];
    [lblMainTitle setTextColor:  [UIColor whiteColor]];
     //[UIColor colorWithRed:241/255.0f green:217/255.0f blue:193/255.0f alpha:1.0f]]
    
    viewBgSubHeading.backgroundColor = [UIColor colorWithRed:79/255.0f green:170/255.0f blue:178/255.0f alpha:0.90f];
    [lblValidThru setTextColor: [UIColor whiteColor]];
    //[UIColor colorWithRed:241/255.0f green:217/255.0f blue:193/255.0f alpha:1.0f]
    
    //[UIColor colorWithRed:167/255.0f green:127/255.0f blue:93/255.0f alpha:1.0f];
    viewBgBrandName.backgroundColor = [UIColor colorWithRed:241/255.0f green:153/255.0f blue:6/255.0f alpha:1.0f];
    //[UIColor colorWithRed:241/255.0f green:217/255.0f blue:193/255.0f alpha:1.0f];
    [lblBrandName setTextColor: [UIColor whiteColor]];
     //[UIColor colorWithRed:38/255.0f green:28/255.0f blue:22/255.0f alpha:1.0f]];

    viewBgAddress.backgroundColor = [UIColor colorWithRed:241/255.0f green:153/255.0f blue:6/255.0f alpha: 0.90f];
    [lblAddress setTextColor: [UIColor whiteColor]];
    //[UIColor colorWithRed:38/255.0f green:28/255.0f blue:22/255.0f alpha:1.0f]];
     
    
    //[UIColor colorWithRed:241/255.0f green:153/255.0f blue:6/255.0f alpha:1.0f];
    
    viewImgCover.backgroundColor = [UIColor colorWithRed:0/255.0f green:0/255.0f blue:0/255.0f alpha:0.45f];
    imgRedeemNow.backgroundColor = [UIColor clearColor];
    //[UIColor colorWithRed:241/255.0f green:153/255.0f blue:6/255.0f alpha:1.0f];

    [lblCouponNumber setTextColor: [UIColor whiteColor]];
    viewBgTnC.backgroundColor = [UIColor colorWithRed:79/255.0f green:170/255.0f blue:178/255.0f alpha:1.0f];
    //;
    
    //[imgDetailPage setHidden: YES];

    imgRedeemNow.image = [UIImage imageNamed:@"redeem.png"];
    imgClose.image = [UIImage imageNamed:@"close.png"];
    imgFavorite.image = [UIImage imageNamed:@"fav.png"];
    
    imgShare.contentMode = UIViewContentModeScaleAspectFill;
    imgShare.image = [UIImage imageNamed:@"share.png"];
    imgViewDetails.image = [UIImage imageNamed:@"list.png"];
    //imgClose, imgFavorite, imgShare, imgViewDetails
    
    UITapGestureRecognizer *shareTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showShareOptions)];
    shareTap.numberOfTapsRequired = 1;
    [imgShare setUserInteractionEnabled:YES];
    [imgShare addGestureRecognizer:shareTap];
    
    viewDetailsPageWidth = viewDetailsPage.frame.size.width;
    viewDetailsPageHeight = [UIScreen mainScreen].bounds.size.height - 10;
    viewDetailsPageXLoc = (topBarViewWidth - viewDetailsPageWidth)/2;
    viewDetailsPageYLoc = 20;
    
    viewDetailsPage.frame = CGRectMake(viewDetailsPageXLoc, viewDetailsPageYLoc, viewDetailsPageWidth, viewDetailsPageHeight);
    bgView.frame = CGRectMake(viewDetailsPageXLoc, 0, viewDetailsPageWidth, viewDetailsPageHeight);
    bgView.contentSize = CGSizeMake(viewDetailsPageWidth,  (viewBgTnC.frame.origin.y + viewBgTnC.frame.size.height + 20));
    
    //imgBranding.frame = CGRectMake(0, 0, viewDetailsPageWidth, 50);
    
    lblMainTitleWidth = (int) (viewDetailsPageWidth * 0.8);
    lblMainTitleHeight = lblMainTitle.frame.size.height;
    lblMainTitleXLoc = (viewDetailsPageWidth - lblMainTitleWidth)/2;
    lblMainTitleYLoc = lblMainTitle.frame.origin.y;
    
    lblMainTitle.frame = CGRectMake(lblMainTitleXLoc, lblMainTitleYLoc, lblMainTitleWidth, lblMainTitleHeight);
    lblMainTitle.text = [currentDeal objectForKey:@"headline"];
    
    //[lblMainTitle setBackgroundColor: [UIColor colorWithRed:241/255.0f green:153/255.0f blue:6/255.0f alpha:1.0f]];
    
    imgDetailPageWidth = imgDetailPage.frame.size.width;
    imgDetailPageHeight = imgDetailPage.frame.size.height;
    imgDetailPageXLoc = imgDetailPage.frame.origin.x;
    imgDetailPageYLoc = lblMainTitleYLoc +  lblMainTitleHeight + 5;
    
    //[imgDetailPage setImage: currentSelectedImage];
    
    NSArray *myImages = @[currentSelectedImage];
    
    [kenView animateWithImages:myImages
                 transitionDuration:6
                       initialDelay:0
                               loop:YES
                        isLandscape:YES];
    
    imgDetailPage.contentMode = UIViewContentModeScaleAspectFill;
    
    kenView.frame = viewImgCover.frame;
    kenView.center = viewImgCover.center;
    
    imgRedeemNow.center = viewImgCover.center;
    lblCouponNumber.center = viewImgCover.center;
    
    NSMutableString *couponNumber = [[NSMutableString alloc] init];
    [couponNumber appendString: @"Coupon\n#"];
    [couponNumber appendString: [NSString stringWithFormat:@"%@", [restaurantAddress objectForKey:@"id"]]];
    [lblCouponNumber setText: couponNumber];
    
    NSMutableString *address = [[NSMutableString alloc] init];
    [address appendString: [NSString stringWithFormat:@"%@", [restaurantAddress objectForKey:@"address"]]];
    [address appendString: [NSString stringWithFormat:@" %@", [restaurantAddress objectForKey:@"city"]]];
    [address appendString: [NSString stringWithFormat:@" %@", [restaurantAddress objectForKey:@"state"]]];
    [address appendString: [NSString stringWithFormat:@" %@", [restaurantAddress objectForKey:@"zipcode"]]];
    [address appendString: [NSString stringWithFormat:@" %@", [restaurantAddress objectForKey:@"phone"]]];
    
    lblValidThru.text =  [currentDeal objectForKey:@"subheadline"];
    
    
    lblBrandName.text = [currentDeal objectForKey:@"brandName"];
    
    
    lblAddress.text = address;
    
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideDetailsPage)];
    singleTap.numberOfTapsRequired = 1;
    [imgClose setUserInteractionEnabled:YES];
    [imgClose addGestureRecognizer:singleTap];
    
    btnCloseViewWidth = btnCloseView.frame.size.width;
    btnCloseViewHeight = btnCloseView.frame.size.height;
    btnCloseViewXLoc = (viewDetailsPageWidth - btnCloseViewWidth)/2;
    btnCloseViewYLoc = [UIScreen mainScreen].bounds.size.height - btnCloseViewHeight - 40;
    
    btnCloseView.frame = CGRectMake(btnCloseViewXLoc, btnCloseViewYLoc, btnCloseViewWidth, btnCloseViewHeight);
    
    [self.viewDetailsPage bringSubviewToFront:btnCloseView];
    
    viewDetailsPage.frame = CGRectMake(0, viewDetailsPageHeight, viewDetailsPageWidth, viewDetailsPageHeight);
    [self.view addSubview:viewDetailsPage];
    
    [UIView animateWithDuration:0.5
                          delay:0.0
                        options: UIViewAnimationCurveEaseOut
                     animations:^
     {
         CGRect frame = viewDetailsPage.frame;
         frame.origin.y = 20;
         frame.origin.x = 0;
         viewDetailsPage.frame = frame;
     }
                     completion:^(BOOL finished)
     {
         NSLog(@"Completed");
         
     }];
    
}


- (void) hideDetailsPage
{
    [UIView animateWithDuration:0.3
                          delay:0.0
                        options: UIViewAnimationCurveEaseOut
                     animations:^
     {
         CGRect frame = viewDetailsPage.frame;
         frame.origin.y = viewDetailsPageHeight + 20;
         frame.origin.x = 0;
         viewDetailsPage.frame = frame;
     }
                     completion:^(BOOL finished)
     {
         NSLog(@"Completed");
         [viewDetailsPage removeFromSuperview];
     }];
}

- (void) showShareOptions
{
    NSString * message = [NSString stringWithFormat:@"%@", [currentDeal objectForKey:@"headline"]];
    NSString * messageURL = [NSString stringWithFormat:@"%@", [currentDeal objectForKey:@"link"]];
    
    
    NSArray * shareItems = @[message, messageURL];
    
    UIActivityViewController * avc = [[UIActivityViewController alloc] initWithActivityItems:shareItems applicationActivities:nil];
    
    [self presentViewController:avc animated:YES completion:nil];
}

@end

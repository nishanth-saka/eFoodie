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
    
    int viewBgTnCWidth, viewBgTnCHeight, viewBgTnCXLoc, viewBgTnCYLoc;
    
    DealViewCell *dealViewCell;
    int numberOfDeals;
    NSArray *dealsArray;
    NSArray *responseArray;
    
    UIImage *currentSelectedImage;
    DealsObj *currentDeal;
    NSMutableDictionary *restaurantAddress;
    SWRevealViewController *revealController;
    
    int lblMainTitleWidth, lblMainTitleHeight, lblMainTitleXLoc, lblMainTitleYLoc;
    
    UIColor *brownColor, *brownColorSubtle;
    UIColor *orangeColor, *orangeColorSubtle;
    UIColor *greenColor, *greenColorSubtle;
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
@synthesize kenView, dbClassObj;
@synthesize viewDisc1, lblDisc1;
@synthesize viewDisc2, lblDisc2;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    brownColor = [UIColor colorWithRed:38/255.0f green:28/255.0f blue:22/255.0f alpha:1.0f];
    brownColorSubtle  = [UIColor colorWithRed:38/255.0f green:28/255.0f blue:22/255.0f alpha:0.9f];
    
    greenColor = [UIColor colorWithRed:241/255.0f green:217/255.0f blue:193/255.0f alpha:1.0f];
    greenColorSubtle = [UIColor colorWithRed:241/255.0f green:217/255.0f blue:193/255.0f alpha:0.9f];
    
    orangeColor = [UIColor colorWithRed:241/255.0f green:153/255.0f blue:6/255.0f alpha:1.0f];
    orangeColorSubtle  = [UIColor colorWithRed:241/255.0f green:153/255.0f blue:6/255.0f alpha:0.9f];
    
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
    
    DealsObj *currentDealObj;
    for(id dealItemDict in dealsArray)
    {
        NSMutableDictionary *dealItem = (NSMutableDictionary *) dealItemDict;
        currentDealObj = [[DealsObj alloc] init];
        
        currentDealObj.deal_alt1 = [NSString stringWithFormat:@"%@", [dealItem objectForKey:@"alt1"]];
        currentDealObj.deal_alt3 = [dealItem objectForKey:@"alt2"];
        currentDealObj.deal_alt3 = [dealItem objectForKey:@"alt3"];
        currentDealObj.deal_brandId = [dealItem objectForKey:@"brandId"];
        currentDealObj.deal_brandName = [dealItem objectForKey:@"brandName"];
        currentDealObj.deal_couponTemplate = [dealItem objectForKey:@"couponTemplate"];
        currentDealObj.deal_current_downloads = [dealItem objectForKey:@"current_downloads"];
        currentDealObj.deal_dealsPerSubscriber = [dealItem objectForKey:@"dealsPerSubscriber"];
        currentDealObj.deal_description = [dealItem objectForKey:@"description"];
        currentDealObj.deal_disclaimer1 = [dealItem objectForKey:@"disclaimer1"];
        currentDealObj.deal_disclaimer2 = [dealItem objectForKey:@"disclaimer2"];
        currentDealObj.deal_draft = [dealItem objectForKey:@"draft"];
        currentDealObj.deal_endDate = [dealItem objectForKey:@"deal_endDate"];
        currentDealObj.deal_headline = [dealItem objectForKey:@"headline"];
        currentDealObj.deal_id = [dealItem objectForKey:@"id"];
        currentDealObj.deal_img1 = [dealItem objectForKey:@"img1"];
        currentDealObj.deal_img1Id = [dealItem objectForKey:@"img1Id "];
        currentDealObj.deal_img2 = [dealItem objectForKey:@"img2 "];
        currentDealObj.deal_img2Id = [dealItem objectForKey:@"img2Id"];
        currentDealObj.deal_img3Id = [dealItem objectForKey:@"img3Id"];
        currentDealObj.deal_link = [dealItem objectForKey:@"link"];
        currentDealObj.deal_messageId = [dealItem objectForKey:@"messageId"];
        
        currentDealObj.deal_startDate = [dealItem objectForKey:@"startDate"];
        currentDealObj.deal_subheadline = [dealItem objectForKey:@"subheadline"];
        currentDealObj.deal_template = [dealItem objectForKey:@"template"];
        currentDealObj.deal_totalDownloadLimit = [dealItem objectForKey:@"totalDownloadLimit"];
        
        NSMutableArray *addressDict = (NSMutableArray *)  [dealItem objectForKey:@"restaurants"];
        if(addressDict.count > 0)
        {
            NSMutableArray *addDict = (NSMutableArray *) addressDict[0];
            NSMutableDictionary *address = (NSMutableDictionary *) addDict[0];
            
            currentDealObj.deal_restaurants_address = [address objectForKey:@"address"];
            currentDealObj.deal_restaurants_brandId = [address objectForKey:@"brandId"];
            currentDealObj.deal_restaurants_city = [address objectForKey:@"city"];
            currentDealObj.deal_restaurants_hours = [address objectForKey:@"hours"];
            currentDealObj.deal_restaurants_id = [address objectForKey:@"id"];
            currentDealObj.deal_restaurants_phone = [address objectForKey:@"phone"];
            currentDealObj.deal_restaurants_state = [address objectForKey:@"state"];
            currentDealObj.deal_restaurants_zipcode = [address objectForKey:@"zipcode"];
        }
        
        [dbClassObj InsertNewDeal: currentDealObj];
    }
    
    responseArray = [dbClassObj GetDealsArray];
    numberOfDeals = [responseArray count];
    
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
    
    DealsObj *currentDealObj = (DealsObj *) responseArray[indexPath.row];
    NSString *dealHeadline = currentDealObj.deal_headline;
    NSString *dealRestaurant = currentDealObj.deal_brandName;
    NSString *dealLocation = currentDealObj.deal_restaurants_address;
    NSString *dealImage = currentDealObj.deal_img1;
   
//    NSMutableArray* res = (NSMutableArray *) [dealsArray[indexPath.row] objectForKey:@"restaurants"];
//    
//    if(res != nil && res.count > 0)
//    {
//        NSMutableArray* obj = (NSMutableArray*) res[0];
//        
//        if(obj != nil && obj.count > 0)
//        {
//            NSMutableDictionary* obj2 = (NSMutableDictionary*) obj[0];
//            
//        }
//    }
    
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
    
    currentDeal = (DealsObj *) responseArray[indexPath.row];
    //restaurantAddress = currentDealObj.deal_restaurants_address;
    
//    NSMutableArray *addressDict = (NSMutableArray *)  [currentDeal objectForKey:@"restaurants"];
//    if(addressDict.count > 0)
//    {
//        NSMutableArray *addDict = (NSMutableArray *) addressDict[0];
//        restaurantAddress = (NSMutableDictionary *) addDict[0];
////        NSLog(@"%@", restaurantAddress);
//    }
//    NSLog(@"Current Log %@", currentDeal);
    
    [revealController rightRevealToggle:cell];
    
    [self showDetailsPage];
}

- (void) showDetailsPage
{
    [bgView setContentOffset: CGPointMake(0, -bgView.contentInset.top) animated:YES];
    
    viewTopBar.backgroundColor =  orangeColorSubtle;
    bgView.backgroundColor = greenColorSubtle;

    viewBgTitle.backgroundColor = brownColor;
    [lblMainTitle setTextColor:  [UIColor whiteColor]];
    
    viewBgSubHeading.backgroundColor = brownColorSubtle;
    [lblValidThru setTextColor: [UIColor whiteColor]];
    
    viewBgBrandName.backgroundColor = orangeColor;
    [lblBrandName setTextColor: [UIColor whiteColor]];

    viewBgAddress.backgroundColor = orangeColorSubtle;
    [lblAddress setTextColor: [UIColor whiteColor]];
    
    viewImgCover.backgroundColor = [UIColor colorWithRed:0/255.0f green:0/255.0f blue:0/255.0f alpha:0.45f];
    imgRedeemNow.backgroundColor = [UIColor clearColor];
    
    [lblCouponNumber setTextColor: [UIColor whiteColor]];
    
    viewDisc1.backgroundColor = orangeColorSubtle;
    viewDisc2.backgroundColor = orangeColorSubtle;
    
    imgRedeemNow.image = [UIImage imageNamed:@"redeem.png"];
    imgClose.image = [UIImage imageNamed:@"close.png"];
    imgFavorite.image = [UIImage imageNamed:@"fav.png"];
    
    imgShare.contentMode = UIViewContentModeScaleAspectFill;
    imgShare.image = [UIImage imageNamed:@"share.png"];
    imgViewDetails.image = [UIImage imageNamed:@"list.png"];
    
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
    bgView.contentSize = CGSizeMake(viewDetailsPageWidth,  (viewDisc2.frame.origin.y + viewDisc2.frame.size.height + 60));
    
    //imgBranding.frame = CGRectMake(0, 0, viewDetailsPageWidth, 50);
    
    lblMainTitleWidth = (int) (viewDetailsPageWidth * 0.8);
    lblMainTitleHeight = lblMainTitle.frame.size.height;
    lblMainTitleXLoc = (viewDetailsPageWidth - lblMainTitleWidth)/2;
    lblMainTitleYLoc = lblMainTitle.frame.origin.y;
    
    lblMainTitle.frame = CGRectMake(lblMainTitleXLoc, lblMainTitleYLoc, lblMainTitleWidth, lblMainTitleHeight);
    lblMainTitle.text = currentDeal.deal_headline;
    
    lblDisc1.text = currentDeal.deal_disclaimer1;
    [lblDisc1 setTextColor: [UIColor whiteColor]];
    lblDisc2.text = currentDeal.deal_disclaimer2;
    [lblDisc2 setTextColor: [UIColor whiteColor]];
    
    imgDetailPageWidth = imgDetailPage.frame.size.width;
    imgDetailPageHeight = imgDetailPage.frame.size.height;
    imgDetailPageXLoc = imgDetailPage.frame.origin.x;
    imgDetailPageYLoc = lblMainTitleYLoc +  lblMainTitleHeight + 5;
    
    viewBgTnCWidth = viewBgTnC.frame.size.width;
    viewBgTnCHeight = viewBgTnC.frame.size.height;
    viewBgTnCXLoc = ([UIScreen mainScreen].bounds.size.width - viewBgTnCWidth)/2;
    viewBgTnCYLoc = [UIScreen mainScreen].bounds.size.height - viewBgTnCHeight - 25;
    
    viewBgTnC.frame = CGRectMake(viewBgTnCXLoc, viewBgTnCYLoc, viewBgTnCWidth, viewBgTnCHeight);
    viewBgTnC.backgroundColor = [UIColor clearColor];
    
    UIImageView *optionsBgImage = [[UIImageView alloc] init];
    optionsBgImage.frame = CGRectMake(0, 0, viewBgTnCWidth, viewBgTnCHeight);
    [optionsBgImage setImage:[UIImage imageNamed:@"options_bgnd.png"]];
    [optionsBgImage setAlpha:0.8f];
    
    [viewBgTnC addSubview: optionsBgImage];
    [viewBgTnC sendSubviewToBack: optionsBgImage];
    
    //[imgDetailPage setImage: currentSelectedImage];
    
    NSArray *myImages = @[currentSelectedImage];
    
    [kenView reloadInputViews];
    [kenView animateWithImages:myImages
                 transitionDuration:6
                       initialDelay:0
                               loop:NO
                        isLandscape:YES];
    
    imgDetailPage.contentMode = UIViewContentModeScaleAspectFill;
    
    kenView.frame = viewImgCover.frame;
    kenView.center = viewImgCover.center;
    
    imgRedeemNow.center = viewImgCover.center;
    lblCouponNumber.center = viewImgCover.center;
    
    NSMutableString *couponNumber = [[NSMutableString alloc] init];
    [couponNumber appendString: @"Coupon\n#"];
    [couponNumber appendString: currentDeal.deal_id];
    [lblCouponNumber setText: couponNumber];
    
    NSMutableString *address = [[NSMutableString alloc] init];
    [address appendString: [NSString stringWithFormat:@"%@", currentDeal.deal_restaurants_address]];
    [address appendString: [NSString stringWithFormat:@" %@", currentDeal.deal_restaurants_city]];
    [address appendString: [NSString stringWithFormat:@" %@", currentDeal.deal_restaurants_state]];
    [address appendString: [NSString stringWithFormat:@" %@", currentDeal.deal_restaurants_zipcode]];
    [address appendString: [NSString stringWithFormat:@" %@", currentDeal.deal_restaurants_phone]];
    
    lblValidThru.text =  currentDeal.deal_subheadline;
    lblBrandName.text = currentDeal.deal_brandName;
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
    NSString * message = currentDeal.deal_headline;
    NSString * messageURL = currentDeal.deal_link;
    
    
    NSArray * shareItems = @[message, messageURL];
    
    UIActivityViewController * avc = [[UIActivityViewController alloc] initWithActivityItems:shareItems applicationActivities:nil];
    
    [self presentViewController:avc animated:YES completion:nil];
}

@end

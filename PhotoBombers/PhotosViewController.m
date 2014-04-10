//
//  PhotosViewController.m
//  PhotoBombers
//
//  Created by Matthew Voracek on 3/26/14.
//  Copyright (c) 2014 Matthew Voracek. All rights reserved.
//

#import "PhotosViewController.h"
#import "PhotoCell.h"
#import "DetailViewController.h"
#import "PresentDetailTransition.h"
#import "DismissDetailTransition.h"

#import <SimpleAuth/SimpleAuth.h>

@interface PhotosViewController () <UIViewControllerTransitioningDelegate>

@property (nonatomic) NSString *accessToken;
@property (nonatomic) NSArray *photos;

@end

@implementation PhotosViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Photo Bombers";
    
    [self.collectionView registerClass:[PhotoCell class] forCellWithReuseIdentifier:@"photo"];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    self.accessToken = [userDefaults objectForKey:@"accessToken"];
    
    if (self.accessToken == nil)
    {
        [SimpleAuth authorize:@"instagram" options:@{@"scope": @[@"likes"]} completion:^(NSDictionary *responseObject, NSError *error) {
            NSLog(@"%@",responseObject);
            
            self.accessToken = responseObject[@"credentials"][@"token"];
            [userDefaults setObject:self.accessToken forKey:@"accessToken"];
            [userDefaults synchronize];
            [self refresh];
        }];
    }
    else
    {
        [self refresh];
    }

    
    /*
    NSURLSession *session = [NSURLSession sharedSession];
    NSURL *url = [[NSURL alloc]initWithString:@"http://blog.teamtreehouse.com/api/get_recent_summary/"];
    NSURLRequest * request = [[NSURLRequest alloc]initWithURL:url];
    NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
        NSString *text = [[NSString alloc]initWithContentsOfURL:location encoding:NSUTF8StringEncoding error:nil];
        NSLog(@"%@",text);
    }];
    [task resume];
    */
}

-(void)refresh
{
    NSURLSession *session = [NSURLSession sharedSession];
    NSString *URLString = [[NSString alloc]initWithFormat:@"https://api.instagram.com/v1/tags/snow/media/recent?access_token=%@", self.accessToken];
    NSURL *url = [[NSURL alloc]initWithString:URLString];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error)
        {
            NSData *data = [[NSData alloc]initWithContentsOfURL:location];
            NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            self.photos = [responseDictionary valueForKeyPath:@"data"];
            
            dispatch_async(dispatch_get_main_queue(), ^
            {
                [self.collectionView reloadData];
            });
                                          
            //NSString *text = [[NSString alloc]initWithContentsOfURL:location encoding:NSUTF8StringEncoding error:nil];
            //NSLog(@"%@",photos);
        }];
    [task resume];
}

-(instancetype)init
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(106.0, 106.0);
    layout.minimumInteritemSpacing = 1.0;
    layout.minimumLineSpacing = 1.0;
    return (self = [super initWithCollectionViewLayout:layout]);
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.photos count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"photo" forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor lightGrayColor];
    cell.photo = self.photos[indexPath.row];
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *photo = self.photos[indexPath.row];
    DetailViewController *viewController = [DetailViewController new];
    viewController.modalPresentationStyle = UIModalPresentationCustom;
    viewController.transitioningDelegate = self;
    viewController.photo = photo;
    
    [self presentViewController:viewController animated:YES completion:nil];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    return [[PresentDetailTransition alloc] init];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return [[DismissDetailTransition alloc]init];
}

@end

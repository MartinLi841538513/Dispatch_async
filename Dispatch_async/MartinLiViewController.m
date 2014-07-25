//
//  MartinLiViewController.m
//  Dispatch_async
//
//  Created by dongway on 14-7-23.
//  Copyright (c) 2014年 dongway. All rights reserved.
//

#import "MartinLiViewController.h"
#import "InteractWithServerOnJSON.h"
#import "SVProgressHUD.h"

@interface MartinLiViewController ()

@end

@implementation MartinLiViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)dispatchLoadData:(id)sender {
    
    NSString *urlString = @"http://old.idongway.com/sohoweb/q?method=store.get&format=json&cat=1";
    [SVProgressHUD show];//loading 视图
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
    
        NSDictionary *result = [InteractWithServerOnJSON interactWithServerOnJSON:urlString];//加载网络数据
        
        //因为需要再回到主线程关闭loading
        dispatch_sync(dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];  //dismiss  loading视图
            NSArray *stores = [result objectForKey:@"stores"];  //获取网络数据，并可以在这个位置刷新主线程UI
            NSLog(@"%@",[[stores firstObject] valueForKey:@"storeName"]);
        });
        NSLog(@"dosometing1");

    });
    
    NSLog(@"dosometing2");
}
@end

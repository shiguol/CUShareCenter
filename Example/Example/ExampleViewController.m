//
//  ExampleViewController.m
//  Example
//
//  Created by curer on 13-10-25.
//  Copyright (c) 2013年 curer. All rights reserved.
//

#import "ExampleViewController.h"
#import "CUShareCenter.h"
#import "CUPlatFormUserModel.h"

@interface ExampleViewController ()

@property (nonatomic, strong) id<CUShareClientDataSource> sina;
@property (nonatomic, strong) id<CUShareClientDataSource> qq;

@end

@implementation ExampleViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [CUShareCenter connectSinaWeiboWithAppKey:@"1128481868"
                                    appSecret:@"024e9c1c0aca2d28c03f182e5924de67"
                                  redirectUri:@"http://112.124.12.104/network_analysis/index.php/sns/session?provider=weibo"];
    
    [CUShareCenter connectTencentQQWithAppID:@"100383099"
                                      appKey:@"4a9f17a08ed276a198de27ba58ff9b6d"
                                 redirectUri:@""];
    
    [CUShareCenter connectRenRenWithAppID:@"168802"
                                   AppKey:@"e884884ac90c4182a426444db12915bf"
                                appSecret:@"094de55dc157411e8a5435c6a7c134c5"
                              redirectUri:nil];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - action

- (IBAction)bindButtonClicked:(id)sender {
    self.sina = [CUShareCenter clientWithPlatForm:@"新浪微博"];
    [self.sina bindSuccess:^(NSString *message, id data) {
        NSLog(@"%@", message);
    } error:^(NSString *message, id data) {
        NSLog(@"%@", message);
    }];
}

- (IBAction)unBindButtonClicked:(id)sender {
    self.sina = [CUShareCenter clientWithPlatForm:@"新浪微博"];
    [self.sina unBind];
}

- (IBAction)userInfoButtonClicked:(id)sender {

    id <CUShareClientDataSource> client = [CUShareCenter clientWithPlatForm:@"新浪微博"];
    if ([client isBind]) {
        [client userInfoSuccess:^(CUPlatFormUserModel *model) {
            NSLog(@"%@", model.nickname);
        } error:^(id data) {
            NSLog(@"%@", data);
        }];
    }
    else
    {
        self.sina = [CUShareCenter clientWithPlatForm:@"新浪微博"];
        [self.sina bindSuccess:^(NSString *message, id data) {
            NSLog(@"%@", message);
        } error:^(NSString *message, id data) {
            NSLog(@"%@", message);
        }];
    }
}

- (IBAction)shareImageDataButtonClicked:(id)sender {
    id <CUShareClientDataSource> client = [CUShareCenter clientWithPlatForm:@"新浪微博"];
    if ([client isBind]) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"gif"];
        NSData *imageData = [NSData dataWithContentsOfFile:path];
        
        [client content:@"test"
              imageData:imageData
                success:^(id data) {
                    NSLog(@"%@", data);
                } error:^(id error) {
                    NSLog(@"%@", error);
                }];
    }
    else
    {
        self.sina = [CUShareCenter clientWithPlatForm:@"新浪微博"];
        [self.sina bindSuccess:^(NSString *message, id data) {
            NSLog(@"%@", message);
        } error:^(NSString *message, id data) {
            NSLog(@"%@", message);
        }];
    }
}

- (IBAction)qqLoginButtonClicked:(id)sender {
    self.qq = [CUShareCenter clientWithPlatForm:@"QQ"];
    if ([self.qq isBind]) {
        NSLog(@"bind already");
        return;
    }
    
    [self.qq bindSuccess:^(NSString *message, id data) {
        NSLog(@"%@", message);
    } error:^(NSString *message, id data) {
        NSLog(@"%@", message);
    }];
}

- (IBAction)logoutQQButtonClicked:(id)sender {
    [[CUShareCenter clientWithPlatForm:@"QQ"] unBind];
}

- (IBAction)QQUserInfoButtonClicked:(id)sender {
    [[CUShareCenter clientWithPlatForm:@"QQ"] userInfoSuccess:^(CUPlatFormUserModel *model) {
        NSLog(@"%@", model.nickname);
        NSLog(@"%@", model.avatar);
    } error:^(id data) {
        
    }];
}
- (IBAction)QQShareButtonClicked:(id)sender {
    
    id <CUShareClientDataSource> client = [CUShareCenter clientWithPlatForm:@"QQ"];
    if (![client isBind]) {
        
        [client bindSuccess:^(NSString *message, id data) {
            
        } error:^(NSString *message, id data) {
            
        }];
        
        return;
    }
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"gif"];
    NSData *imageData = [NSData dataWithContentsOfFile:path];
    
    [[CUShareCenter clientWithPlatForm:@"QQ"] content:@"test"
                                            imageData:imageData
                                              success:^(id data) {
                                                  NSLog(@"%@", data);
                                              } error:^(id error) {
                                                   NSLog(@"%@", error);
                                              }];
}
- (IBAction)loginRenrenButtonClicked:(id)sender {
    id <CUShareClientDataSource> client = [CUShareCenter clientWithPlatForm:@"renren"];
    if ([client isBind]) {
        NSLog(@"already login");
        
        return;
    }
    
    [client bindSuccess:^(NSString *message, id data) {
        NSLog(@"%@", message);
    } error:^(NSString *message, id data) {
        NSLog(@"%@", message);
    }];
}
- (IBAction)renrenUserInfoButtonClicked:(id)sender {
    id <CUShareClientDataSource> client = [CUShareCenter clientWithPlatForm:@"renren"];
    
    if ([client isBind]) {
        [client userInfoSuccess:^(CUPlatFormUserModel *model) {
            NSLog(@"%@", model.nickname);
        } error:^(id data) {
            
        }];
    }
}
- (IBAction)renrenShareButtonClicked:(id)sender {
    id <CUShareClientDataSource> client = [CUShareCenter clientWithPlatForm:@"renren"];
    
    if ([client isBind]) {
        
        [client content:@"test"
            description:@"description"
                  title:@"title"
                   link:@"http://www.baidu.com"
               imageURL:@"http://d.hiphotos.baidu.com/pic/w%3D230/sign=1847e71f63d9f2d3201123ec99ed8a53/d8f9d72a6059252db799c5fa359b033b5ab5b946.jpg"
                success:^(id data) {
                    
                } error:^(id error) {
                    
                }];
    }
}
@end

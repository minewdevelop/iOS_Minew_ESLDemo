//
//  ViewController.m
//  ESLSingleKitDemo
//
//  Created by Minewtech on 2020/11/24.
//

#import "ViewController.h"
#import "ReloadingDataVC.h"
#import <Masonry/Masonry.h>
#import <MinewESLSingleKit/MinewESLSingleKit.h>

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *deviceAry;
    MTCentralManager *manager;
    UITableView *table;
    NSTimer *timer;
    MTPeripheral *p;
    UITextField *texF;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    manager = [MTCentralManager sharedInstance];

    table = [[UITableView alloc] init];
    table.delegate = self;
    table.dataSource = self;
    [self.view addSubview:table];
    [table mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(@300);
    }];
    
    UIButton *scanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    scanBtn.backgroundColor = [UIColor redColor];
    scanBtn.layer.cornerRadius = 50;
    [scanBtn setTitle:@"Scan" forState:UIControlStateNormal];
    [scanBtn addTarget:self action:@selector(startScan) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:scanBtn];
    
    [scanBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(table.mas_bottom).offset(20);
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(100, 100));
    }];
    
    texF = [[UITextField alloc] init];
    texF = [[UITextField alloc]init];
    texF.placeholder = @"enter the mac";
    texF.font = [UIFont systemFontOfSize:14];
    texF.text = @"ac233fd004d0";
    texF.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:texF];
    
    [texF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(scanBtn.mas_bottom).offset(10);
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(300, 50));
    }];
    // Do any additional setup after loading the view.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return manager.scannedPeris.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    }
    cell.textLabel.text = ((MTPeripheral *)manager.scannedPeris[indexPath.row]).broadcast.mac;
    //[[((MTPeripheral *)manager.scannedPeris[indexPath.row]).broadcast.name stringByAppendingString:@"--"] stringByAppendingString:((MTPeripheral *)manager.scannedPeris[indexPath.row]).broadcast.mac]
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (manager.scannedPeris.count != 0) {
        [self connectDevice:manager.scannedPeris[indexPath.row]];
    }
}

- (void) startScan {
    [manager startScan:^(NSArray<MTPeripheral *> *devices) {

    }];
    
    if (timer == nil) {
        timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(reloadTable) userInfo:nil repeats:YES];
    }
    
    [manager didChangesBluetoothStatus:^(PowerState statues) {
        switch (statues) {
            case PowerStatePoweredOff:
                NSLog(@"bluetooth status change to poweron");
                break;
                
            case PowerStatePoweredOn:
                NSLog(@"bluetooth status change to poweroff");
                break;
                
            case PowerStateUnknown:
                NSLog(@"bluetooth status change to unknown");
                break;
        }
    }];
    
}

- (void)reloadTable {
    [table reloadData];
}

- (void)connectDevice:(MTPeripheral *)per {
    NSLog(@"connect to the device mac:%@",per.broadcast.mac);
    if (manager.scannedPeris && manager.scannedPeris.count > 0) {
        for (NSInteger j = 0; j<manager.scannedPeris.count; j++) {
            if ([((MTPeripheral *)manager.scannedPeris[j]).broadcast.mac isEqualToString:texF.text]) {
                p = manager.scannedPeris[j];
            }
        }
        [manager stopScan];
        if (!p) {
            NSLog(@"no device");
            return;
        }
        [manager connectToPeriperal:p];

        [p.connector didChangeConnection:^(Connection connection) {
            if (connection == Vaildated) {
                NSLog(@"vaildated");
                [self pushNextVC];
            }
            if (connection == Disconnected) {
                NSLog(@"device has disconnected.");
            }
        }];
    }
    else {
        NSLog(@"no device");
    }
}

- (void)pushNextVC {
    ReloadingDataVC *vc = [[ReloadingDataVC alloc] init];
    vc.per = p;
    [self presentViewController:vc animated:YES completion:nil];
//    [self.navigationController pushViewController:vc animated:YES];
}

@end

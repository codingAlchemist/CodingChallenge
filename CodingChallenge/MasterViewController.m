
#import "MasterViewController.h"
#import "ServiceProvider.h"
#import "MasterCell.h"

#import "CodingChallenge-Swift.h"

typedef enum{
    BY_NAME,
    BY_RATING,
    BY_REVIEWS
} SortOptions;

@interface MasterViewController ()
@property (nonatomic, strong) NSMutableArray *ServiceProviders;
@property (nonatomic, strong) NSArray *sortedArray;
@property (nonatomic, strong) UIBarButtonItem *sortButton;
@property (nonatomic, weak) IBOutlet UITableView *providerTableView;

@end

@implementation MasterViewController

- (UIBarButtonItem *)sortButton{
    if (!_sortButton) {
        _sortButton = [[UIBarButtonItem alloc]initWithTitle:@"Sort"
                                                      style:UIBarButtonItemStyleDone
                                                     target:self
                                                     action:@selector(showSortActionSheet)];
        
    }
    
    return _sortButton;
}

- (void)showSortActionSheet{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Sort By"
                                                                             message:NULL
                                                                      preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *sortByName = [UIAlertAction actionWithTitle:@"Name" style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction * _Nonnull action) {
                                                           [self SortList:BY_NAME];
                                                       }];
    
    UIAlertAction *sortByRating = [UIAlertAction actionWithTitle:@"Rating" style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction * _Nonnull action) {
                                                           [self SortList:BY_RATING];
                                        
                                                       }];

    UIAlertAction *sortByLocation = [UIAlertAction actionWithTitle:@"Reviews" style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction * _Nonnull action) {
                                                           [self SortList:BY_REVIEWS];
                                                       }];

    [alertController addAction:sortByName];
    [alertController addAction:sortByRating];
    [alertController addAction:sortByLocation];
    
    [self presentViewController:alertController animated:YES completion:^{
        
    }];
    
}
- (NSArray *)sortedArray{
    if (!_sortedArray) {
        _sortedArray = [NSArray new];
    }
    return _sortedArray;
}

- (void)SortList:(SortOptions)option{
    
    switch (option) {
        case BY_NAME:
            self.sortedArray = [self.ServiceProviders sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
                NSString *prov1 = [(ServiceProvider *)obj1 name];
                NSString *prov2 = [(ServiceProvider *)obj2 name];
                return [prov1 compare:prov2];
            }];
            
            break;
        case BY_RATING:
            self.sortedArray = [self.ServiceProviders sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
                NSString *prov1 = [(ServiceProvider *)obj1 overallRating];
                NSString *prov2 = [(ServiceProvider *)obj2 overallRating];
                return [prov1 compare:prov2];
            }];
            break;
        case BY_REVIEWS:
            self.sortedArray = [self.ServiceProviders sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
                NSInteger prov1 = [(ServiceProvider *)obj1 reviewCount];
                NSInteger prov2 = [(ServiceProvider *)obj2 reviewCount];
                return prov1 < prov2;
            }];

            break;
        default:
            break;
    }
    [self.ServiceProviders removeAllObjects];
    [self.ServiceProviders addObjectsFromArray:self.sortedArray];
    [self.providerTableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.providerTableView.delegate = self;
    self.providerTableView.dataSource = self;
    self.navigationItem.rightBarButtonItem = self.sortButton;
    self.navigationController.navigationBar.topItem.title = @"Providers";
    [self GetProviderList];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)GetProviderList{
    self.ServiceProviders = [NSMutableArray new];
    StaticDataDTO *singleton = [StaticDataDTO sharedInstance];
    
    __block NSMutableArray *providers = [NSMutableArray new];
    [singleton getProviders:^(NSMutableDictionary * _Nonnull data, BOOL finished) {
        providers = [data objectForKey:@"serviceproviders"];
        
        for (int i=0; i < providers.count; i++) {
            if (providers[i] != NULL) {
                ServiceProvider *provider = [[ServiceProvider alloc]init];
                NSDictionary *coordinateDict = [NSDictionary new];
                coordinateDict = providers[i][@"coordinates"];
                provider.latitude = coordinateDict[@"latitude"];
                provider.longitude = coordinateDict[@"longitude"];
                provider.city = providers[i][@"city"];
                provider.state = providers[i][@"state"];
                provider.postalCode = providers[i][@"postalCode"];
                provider.overallRating = providers[i][@"overallGrade"];
                provider.name = providers[i][@"name"];
                provider.reviewCount = [providers[i][@"reviewCount"] integerValue];
                [self.ServiceProviders addObject:provider];
                
            }
        }
        if (finished) {
            [self.providerTableView reloadData];
        }
    }];
}


#pragma mark - TableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.ServiceProviders.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MasterCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    ServiceProvider *provider = (ServiceProvider *)self.ServiceProviders[indexPath.row];
    [cell CreateProvider:provider];
    return cell;
}

#pragma mark - Navigation
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ServiceProvider *provider = (ServiceProvider *)[self.ServiceProviders objectAtIndex:indexPath.row];
    DetailViewController *detailVC = [DetailViewController new];
    [detailVC GetProvider:provider];
    [self showViewController:detailVC sender:NULL];
}

@end

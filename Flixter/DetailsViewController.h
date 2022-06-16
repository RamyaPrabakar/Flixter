//
//  DetailsViewController.h
//  Flixter
//
//  Created by Ramya Prabakar on 6/16/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DetailsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *bigPosterImage;
@property (weak, nonatomic) IBOutlet UIImageView *smallPosterImage;
@property (weak, nonatomic) IBOutlet UILabel *moveTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *movieDescriptionLabel;
@property (nonatomic, strong) NSDictionary *detailDict;

@end

NS_ASSUME_NONNULL_END

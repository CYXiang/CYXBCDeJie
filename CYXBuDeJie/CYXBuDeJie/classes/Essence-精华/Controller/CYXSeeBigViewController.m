//
//  CYXSeeBigViewController.m
//  CYXBuDeJie
//
//  Created by Macx on 15/10/22.
//  Copyright © 2015年 CYX. All rights reserved.
//

#import "CYXSeeBigViewController.h"
#import "CYXTopic.h"
#import <UIImageView+WebCache.h>
#import <SVProgressHUD.h>
#import <Photos/Photos.h> // iOS8开始可用

@interface CYXSeeBigViewController () <UIScrollViewDelegate>

/** <#注释#> */
@property (nonatomic,weak) UIImageView * imageView;

@end

@implementation CYXSeeBigViewController

static NSString * const CYXCollectionName = @"CYXBuDeJie";

- (void)viewDidLoad {
    [super viewDidLoad];

    UIScrollView * scrollView = [[UIScrollView alloc]init];
    scrollView.delegate = self;
    scrollView.frame = [UIScreen mainScreen].bounds;
    // 插入到最底层，避免遮住按钮
    [self.view insertSubview:scrollView atIndex:0];
    
    UIImageView *imageView = [[UIImageView alloc]init];
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.topic.large_image]];
    imageView.width = scrollView.width;
    imageView.heigth = self.topic.height * imageView.width / self.topic.width;
    imageView.x = 0;
    if (imageView.heigth >= scrollView.heigth) { // 图片高度超过整个屏幕
        imageView.y = 0;
    } else { // 居中显示
        imageView.centerY = scrollView.heigth * 0.5;
    }
    [scrollView addSubview:imageView];
    self.imageView = imageView;
    
    // 滚动范围
    scrollView.contentSize = CGSizeMake(0, imageView.heigth);
    
    // 缩放比例
    CGFloat maxScale = self.topic.height / imageView.heigth;
    if (maxScale > 1.0) {
        scrollView.maximumZoomScale = maxScale;
    }
    
    imageView.userInteractionEnabled = YES;
    [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backBtnClick)]];
    
    // imageView 370 x 400
    // 真实图片 300 x 340
}

- (IBAction)backBtnClick{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)saveBtnClick{
//    UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    
    // 0.判断状态
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if (status == PHAuthorizationStatusDenied) { // 用户拒绝当前应用访问相册
        CYXLog(@"用户拒绝当前应用访问相册");
    }else if (status == PHAuthorizationStatusRestricted){ // 家长控制 - 不允许访问相册
        CYXLog(@"家长控制 - 不允许访问相册");
    }else if (status == PHAuthorizationStatusNotDetermined){
        CYXLog(@"用户还没做出选择");
        [self saveImage];
    }else if (status == PHAuthorizationStatusAuthorized){
        // 用户允许访问相册
        [self saveImage];
    }
    
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error) {
        [SVProgressHUD showErrorWithStatus:@"保存失败"];
    } else {
        [SVProgressHUD showSuccessWithStatus:@"保存成功"];
    }
}

- (void)saveImage{
    
    __block NSString *assetId = nil;
    // 1.存储图片到“相机胶卷”
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        // 这个block里面存放一些“修改”性质的代码
        // 新建一个PHAssetCreationRequest对象，保存图到“相机胶卷”
        // 返回PHAsset（图片）的字符串标识
       assetId = [PHAssetChangeRequest creationRequestForAssetFromImage:self.imageView.image].placeholderForCreatedAsset.localIdentifier;
        
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
        if (error) {
            CYXLog(@"保存图片到相机胶卷中失败");
            return ;
        }
        CYXLog(@"成功保存图片到相机胶卷中");
        
        // 2.获得相机对象
        PHAssetCollection *collection = [self collection];
        
        // 3.将“相机胶卷”中的图片 添加到新的相册
        [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
            PHAssetCollectionChangeRequest *request = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:collection];
            // 根据唯一标识获得相片对象
            PHAsset *asset = [PHAsset fetchAssetsWithLocalIdentifiers:@[assetId] options:nil].firstObject;
            
            // 添加图片到相册中
            [request addAssets:@[asset]];
        } completionHandler:^(BOOL success, NSError * _Nullable error) {
            if (error) {
                CYXLog(@"添加图片到相册中失败");
                return ;
            }
            
            CYXLog(@"成功添加图片到相册中");
            [[NSOperationQueue mainQueue]addOperationWithBlock:^{
                [SVProgressHUD showSuccessWithStatus:@"保存成功"];
            }];
        }];
        
    }];
}

/**
 *  返回相册
 */
- (PHAssetCollection *)collection{
    // 先获得之前创建过的相册
    PHFetchResult<PHAssetCollection *> *collectionResult = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    for (PHAssetCollection *collection in collectionResult) {
        if ([collection.localizedTitle isEqualToString:CYXCollectionName]) {
            return collection;
        }
    }
    // 如果相册不存在，就创建新的相册（文件夹）
    __block NSString *collectionId = nil;
    // 这个方法会在相册创建完毕后才会返回
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        // 新建一个PHAssetCollectionChangeRequest对象，用来创建一个新的相册
        collectionId = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:CYXCollectionName].placeholderForCreatedAssetCollection.localIdentifier;
    } error:nil];
    return [PHAssetCollection fetchAssetCollectionsWithLocalIdentifiers:@[collectionId] options:nil].firstObject;
}

#pragma mark - <UIScrollViewDelegate>
/**
 *  返回一个scrollView内部的子控件进行缩放
 */
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}


@end

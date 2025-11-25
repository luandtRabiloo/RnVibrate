#import "VibrateManager.h"
#import <UIKit/UIKit.h>

@interface VibrateManager()
@property (nonatomic, strong) UISelectionFeedbackGenerator *selectionFeedback;
@property (nonatomic, strong) UIImpactFeedbackGenerator *impactFeedback;
@end

@implementation VibrateManager

RCT_EXPORT_MODULE();

// Rung nhẹ cho selection (tốt nhất cho reorder list)
RCT_EXPORT_METHOD(hapticSelection)
{
    dispatch_async(dispatch_get_main_queue(), ^{
        UISelectionFeedbackGenerator *generator = [[UISelectionFeedbackGenerator alloc] init];
        [generator selectionChanged];
    });
}

// Rung nhẹ (light impact)
RCT_EXPORT_METHOD(hapticLight)
{
    dispatch_async(dispatch_get_main_queue(), ^{
        UIImpactFeedbackGenerator *generator = [[UIImpactFeedbackGenerator alloc] initWithStyle:UIImpactFeedbackStyleLight];
        [generator impactOccurred];
    });
}

// Rung trung bình
RCT_EXPORT_METHOD(hapticMedium)
{
    dispatch_async(dispatch_get_main_queue(), ^{
        UIImpactFeedbackGenerator *generator = [[UIImpactFeedbackGenerator alloc] initWithStyle:UIImpactFeedbackStyleMedium];
        [generator impactOccurred];
    });
}

// Rung mạnh
RCT_EXPORT_METHOD(hapticHeavy)
{
    dispatch_async(dispatch_get_main_queue(), ^{
        UIImpactFeedbackGenerator *generator = [[UIImpactFeedbackGenerator alloc] initWithStyle:UIImpactFeedbackStyleHeavy];
        [generator impactOccurred];
    });
}

// Chuẩn bị haptic trước (giảm độ trễ)
RCT_EXPORT_METHOD(prepareHaptic)
{
    dispatch_async(dispatch_get_main_queue(), ^{
        self.selectionFeedback = [[UISelectionFeedbackGenerator alloc] init];
        [self.selectionFeedback prepare];
    });
}

// Rung đã được chuẩn bị (nhanh hơn)
RCT_EXPORT_METHOD(hapticSelectionPrepared)
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.selectionFeedback) {
            [self.selectionFeedback selectionChanged];
            [self.selectionFeedback prepare]; // Chuẩn bị cho lần sau
        } else {
            UISelectionFeedbackGenerator *generator = [[UISelectionFeedbackGenerator alloc] init];
            [generator selectionChanged];
        }
    });
}

+ (BOOL)requiresMainQueueSetup
{
    return YES;
}

@end

#import "UIView+GGExtension.h"

@implementation UIView (GGExtension)
- (void)setGg_x:(CGFloat)gg_x
{
    CGRect frame = self.frame;
    frame.origin.x = gg_x;
    self.frame = frame;
}

- (CGFloat)gg_x
{
    return self.frame.origin.x;
}

- (void)setGg_y:(CGFloat)gg_y
{
    CGRect frame = self.frame;
    frame.origin.y = gg_y;
    self.frame = frame;
}

- (CGFloat)gg_y
{
    return self.frame.origin.y;
}

- (void)setGg_w:(CGFloat)gg_w
{
    CGRect frame = self.frame;
    frame.size.width = gg_w;
    self.frame = frame;
}

- (CGFloat)gg_w
{
    return self.frame.size.width;
}

- (void)setGg_h:(CGFloat)gg_h
{
    CGRect frame = self.frame;
    frame.size.height = gg_h;
    self.frame = frame;
}

- (CGFloat)gg_h
{
    return self.frame.size.height;
}

- (void)setGg_size:(CGSize)gg_size
{
    CGRect frame = self.frame;
    frame.size = gg_size;
    self.frame = frame;
}

- (CGSize)gg_size
{
    return self.frame.size;
}

- (void)setGg_origin:(CGPoint)gg_origin
{
    CGRect frame = self.frame;
    frame.origin = gg_origin;
    self.frame = frame;
}

- (CGPoint)gg_origin
{
    return self.frame.origin;
}
@end

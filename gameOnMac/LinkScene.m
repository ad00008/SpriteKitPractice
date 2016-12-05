//
//  LinkScene.m
//  gameOnMac
//
//  Created by 胡杨林 on 16/11/28.
//  Copyright © 2016年 胡杨林. All rights reserved.
//

#import "LinkScene.h"

@interface LinkScene()<SKPhysicsContactDelegate>

@property SKSpriteNode *nodeA;
@property SKSpriteNode *nodeB;
@property SKSpriteNode *slide;

@end


@implementation LinkScene

-(instancetype)initWithSize:(CGSize)size{
    LinkScene *scene = [super initWithSize:size];
    scene.backgroundColor = [SKColor whiteColor];
    scene.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:CGRectMake(self.frame.origin.x, self.frame.origin.y, self.size.width + 500, self.size.height)];
    return scene;
}
-(void)didMoveToView:(SKView *)view{
    SKSpriteNode *nodeA = [[SKSpriteNode alloc]initWithImageNamed:@"rocket.png"];
    SKSpriteNode *nodeB = [[SKSpriteNode alloc]initWithImageNamed:@"rocket2.png"];
    nodeA.name = @"A";
    nodeB.name = @"B";
    [nodeA setPhysicsBody:[SKPhysicsBody bodyWithRectangleOfSize:nodeA.size]];
    [nodeB setPhysicsBody:[SKPhysicsBody bodyWithRectangleOfSize:nodeB.size]];
    _nodeA = nodeA;
    _nodeB = nodeB;
    _slide = [[SKSpriteNode alloc]initWithImageNamed:@"44165.png"];
    _slide.name = @"slide";
    [_slide setPhysicsBody:[SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(627, 20)]];
    
}
-(void)keyDown:(NSEvent *)event{
   NSLog(@"keyDown:'%@' keyCode: %02D", event.characters, event.keyCode);
    if ([self.scene childNodeWithName:@"A"]) {
        [_nodeA removeFromParent];
    }
    if ([self.scene childNodeWithName:@"B"]) {
        [_nodeB removeFromParent];
    }
    if ([self.scene childNodeWithName:@"slide"]) {
        [_slide removeFromParent];
    }
    self.physicsWorld.gravity = CGVectorMake(0.0, -8.0);

    switch (event.keyCode) {
        case 18:{ //大键盘数字1
            NSLog(@"现在是弹簧连接spring");
            _nodeA.position = CGPointMake(400, 700);
            _nodeA.physicsBody.dynamic = YES;
            [self.scene addChild:_nodeA];
            _nodeB.position = CGPointMake(400, 500);
            [self.scene addChild:_nodeB];
            SKPhysicsJointSpring *spring = [SKPhysicsJointSpring jointWithBodyA:_nodeA.physicsBody bodyB:_nodeB.physicsBody anchorA:_nodeA.position anchorB:_nodeB.position];
            spring.damping = 0.05;
            spring.frequency = 2.0;
            [self.physicsWorld addJoint:spring];
            
            break;
        }
        case 19:{ //大键盘数字2
            SKSpriteNode *point = [[SKSpriteNode alloc]initWithColor:[SKColor redColor] size:CGSizeMake(5, 5)];
            point.position = CGPointMake(500, 600);
            point.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:point.size];
            point.physicsBody.dynamic = NO;
            [self.scene addChild:point];
            _nodeA.position = CGPointMake(300, 650);
            _nodeB.position = CGPointMake(400, 730);
            [self.scene addChild:_nodeA];
            _nodeA.physicsBody.dynamic = NO;
            [self.scene addChild:_nodeB];
            SKPhysicsJointLimit *limit = [SKPhysicsJointLimit jointWithBodyA:_nodeA.physicsBody bodyB:_nodeB.physicsBody anchorA:CGPointMake(300, 700) anchorB:CGPointMake(300, 630)];
            limit.maxLength = 300;
            [self.scene.physicsWorld addJoint:limit];
            break;
            
            
        }
        case 20:{//大键盘数字3
            _nodeA.position = CGPointMake(500, 500);
            _nodeB.position = CGPointMake(564, 500);
            [self.scene addChild:_nodeB];
            [self.scene addChild:_nodeA];
            _nodeA.physicsBody.dynamic = NO;
            SKPhysicsJointPin *pin = [SKPhysicsJointPin jointWithBodyA:_nodeA.physicsBody bodyB:_nodeB.physicsBody anchor:CGPointMake(564, 436)];
            [self.scene.physicsWorld addJoint:pin];
            break;
            
        }
        case 21:{//大键盘数字4
            _nodeA.position = CGPointMake(600, 520);
            [self.scene addChild:_nodeA];
            _nodeA.anchorPoint = CGPointZero;
            _slide.anchorPoint = CGPointZero;
            _slide.position = CGPointMake(200, 500);
            _slide.physicsBody.dynamic = NO;
            [self.scene addChild:_slide];
            _nodeA.physicsBody.dynamic = YES;
            SKPhysicsJointSliding *sliding = [SKPhysicsJointSliding jointWithBodyA:_nodeA.physicsBody bodyB:_slide.physicsBody anchor:_nodeA.anchorPoint axis:CGVectorMake(5.0, 0.0)];
            [self.scene.physicsWorld addJoint:sliding];
            sliding.shouldEnableLimits = YES;
            sliding.lowerDistanceLimit = -100;
            sliding.upperDistanceLimit = 300;
            self.physicsWorld.gravity = CGVectorMake(-4.9, 0.0);
            break;
        }
        case 23:{//大键盘数字5
            _nodeA.position = CGPointMake(500, 500);
            _nodeB.position = CGPointMake(532, 532);
            _nodeA.anchorPoint = CGPointZero;
            _nodeB.anchorPoint = CGPointZero;
            [self.scene addChild:_nodeA];
            [self.scene addChild:_nodeB];
            SKPhysicsJointFixed *fixed = [SKPhysicsJointFixed jointWithBodyA:_nodeA.physicsBody bodyB:_nodeB.physicsBody anchor:_nodeB.anchorPoint];
            [self.scene.physicsWorld addJoint:fixed];
            break;
        }
        
        case 29:{//大键盘数字0
            if ([self.scene childNodeWithName:@"A"]) {
                [_nodeA removeFromParent];
                [_nodeB removeFromParent];
            }
        }
        default:
            break;
    }
}
-(void)action{
    NSLog(@"111111");
}

@end

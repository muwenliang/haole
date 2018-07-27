//
//  HL_SingleTon.h
//  HAOLE
//
//  Created by mwl on 2018/1/15.
//  Copyright © 2018年 TJYD_. All rights reserved.
//


//点H宏
#define SingleTonH(methodName) +(instancetype)share##methodName;

//点M宏
#if __has_feature(objc_arc)
#define SingleTonM(methodName)\
static id instence =nil;\
+(instancetype)share##methodName\
{\
instence=[[self alloc]init ];\
return instence;\
}\
+(instancetype)allocWithZone:(struct _NSZone *)zone\
{\
if (instence==nil) {\
static dispatch_once_t onceToken;\
dispatch_once(&onceToken, ^{\
instence=[super allocWithZone:zone];\
});\
}\
return instence;\
}\
-(instancetype)init\
{\
static dispatch_once_t onceToken;\
dispatch_once(&onceToken, ^{\
instence =[super init];\
});\
return instence;\
}

#else

#define SingleTonM(methodName)\
static id instence =nil;\
+(instancetype)share##methodName\
{\
instence=[[self alloc]init ];\
return instence;\
}\
+(instancetype)allocWithZone:(struct _NSZone *)zone\
{\
if (instence==nil) {\
static dispatch_once_t onceToken;\
dispatch_once(&onceToken, ^{\
instence=[super allocWithZone:zone];\
});\
}\
return instence;\
}\
-(instancetype)init\
{\
static dispatch_once_t onceToken;\
dispatch_once(&onceToken, ^{\
instence =[super init];\
});\
return instence;\
}\
-(oneway void)release\
{\
}\
-(instancetype)retain\
{\
return self;\
}\
-(NSUInteger)retainCount\
{\
return 1;\
}
#endif



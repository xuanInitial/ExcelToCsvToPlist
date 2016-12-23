//
//  main.m
//  csvToPlist
//
//  Created by bihu_Mac on 2016/12/23.
//  Copyright © 2016年 bihu_Mac. All rights reserved.
//

#import <Foundation/Foundation.h>


int main(int argc, const char * argv[]) {
    @autoreleasepool {

        
        // 先把.xls 文件保存成.csv
        /*
         苹果自带的numbers 文件-->导出到-->CSV
         documentsPath  填你导出来的文件路径（不知道 直接拖进来就可以了）
         */
        
        NSMutableArray *allArr = [[NSMutableArray alloc] init];
        NSString *documentsPath =@"/Users/sky/Desktop/new";
        NSString *iOSPath = [documentsPath stringByAppendingPathComponent:@"Sheet1.csv"];
        NSString *content = [NSString stringWithContentsOfFile:iOSPath encoding:NSUTF8StringEncoding error:nil];
        
          NSArray * allLinedStrings = [content componentsSeparatedByString:@"\r\n"];
    
        for (int i = 0; i < allLinedStrings.count; i++) {
            if (i == 0 || i == 1) {
                continue;
            }
            NSArray *rows =[allLinedStrings[i] componentsSeparatedByString:@"," ];
     // 这步是做了数据转换  取值一一对应  （可以根据自己的value  自定义key ）
            if (![rows[1]  isEqualToString:@""]) {
                NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
                [dic setObject:rows[1] forKey:@"CompanyName"];
                [dic setObject:rows[2] forKey:@"address"];
                [dic setObject:rows[3] forKey:@"name"];
                [dic setObject:rows[4] forKey:@"employees"];
                [dic setObject:rows[5] forKey:@"phone"];
                
                [allArr addObject:dic];
            }
           
    }
        
        //写入
        NSDictionary *allDic = [NSDictionary dictionaryWithObject:allArr forKey:@"root"];
        
        NSString *arrayPath = [NSHomeDirectory() stringByAppendingString:@"/Desktop/arrayToPList.plist"];
        NSData * data = [NSKeyedArchiver archivedDataWithRootObject:allDic];

        BOOL didWriteSuccessfull = [data writeToFile:arrayPath atomically:YES];
        
        if (!didWriteSuccessfull) {
            NSLog(@"写入失败");
        }

       
        //读数据（因为做了二进制转换  读取的时候也需要转换一下）
        NSData * datas = [NSData dataWithContentsOfFile:arrayPath];
       NSDictionary *dicitionaryFromeFile =  [NSKeyedUnarchiver unarchiveObjectWithData:datas];
         NSLog(@"%@",dicitionaryFromeFile );
        
        
        //把plist文件拖到工程里面 读取方式
//        - (NSArray *)allDataArray{
//            if (!_allDataArray) {
//                NSString* path = [[NSBundle mainBundle] pathForResource:@"arrayToPList" ofType:@"plist"];
//                NSData * datas = [NSData dataWithContentsOfFile:path];
//                NSDictionary *dicitionaryFromeFile =  [NSKeyedUnarchiver unarchiveObjectWithData:datas];
//                _allDataArray = [NSArray arrayWithArray:[dicitionaryFromeFile objectForKey:@"root"]];
//            }
//            return _allDataArray;
//        }
    return 0;
}
}


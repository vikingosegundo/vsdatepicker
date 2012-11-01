//
//  ViewController.m
//  VSDatePicker
//
//  Created by Manuel Meyer on 01.11.12.
//  Copyright (c) 2012 bit.fritze. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIPickerViewDataSource, UIPickerViewDelegate>
@property (strong) NSArray *monthNames;
@end

@implementation ViewController

- (void)viewDidLoad
{
    
    NSDateFormatter * df = [[NSDateFormatter alloc] init];
    [df setLocale:[[NSLocale alloc] initWithLocaleIdentifier:[[NSLocale preferredLanguages] objectAtIndex:0]]];
    self.monthNames = [df monthSymbols];
    
    
    [super viewDidLoad];
    
    UIPickerView *picker = [[UIPickerView alloc] init];
    [self.view addSubview:picker];
    
    picker.delegate = self;
    picker.dataSource = self;
    picker.showsSelectionIndicator = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}

-(NSInteger)pickerView:pickerView numberOfRowsInComponent:(NSInteger)component
{
    NSUInteger number = 0;
    if (component == 1) {
        number = 12;
    } else {

        NSDateComponents *comps = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:[NSDate date]];
        
        NSUInteger month = [pickerView selectedRowInComponent:1]+1 ;
        NSUInteger actualYear = [comps year];
        
        NSDateComponents *selectMothComps = [[NSDateComponents alloc] init];
        selectMothComps.year = actualYear;
        selectMothComps.month = month;
        selectMothComps.day = 1;
        
        NSDateComponents *nextMothComps = [[NSDateComponents alloc] init];
        nextMothComps.year = actualYear;
        nextMothComps.month = month+1;
        nextMothComps.day = 1;
        
        NSDate *thisMonthDate = [[NSCalendar currentCalendar] dateFromComponents:selectMothComps];
        NSDate *nextMonthDate = [[NSCalendar currentCalendar] dateFromComponents:nextMothComps];
        
        NSDateComponents *differnce = [[NSCalendar currentCalendar]  components:NSDayCalendarUnit
                                                   fromDate:thisMonthDate
                                                     toDate:nextMonthDate
                                                    options:0];
        
        number = [differnce day];
        
    }
    
    return number;
}

-(void)pickerView:pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == 1) {
        [pickerView reloadComponent:0];
    }
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *result;
    if (component == 0) {
        result = [NSString stringWithFormat:@"%d", row+1];
    } else {
        result = [self.monthNames objectAtIndex:row];
    }
    return result;
}

@end

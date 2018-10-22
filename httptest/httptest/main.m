//
//  main.m
//  httptest
//
//  Created by aoshika on 2013/12/31.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#define restrict 
#import <RegexKit/RegexKit.h>

int main (int argc, const char * argv[])
{

    @autoreleasepool {
        CFStringRef sesid = CFSTR("PHPSESSID=xxxxxxxxxxxxxxxxxxxxxxxxxx;");

        NSString* regexp_string = @"<div id=\"question\">(.+)</div>";
        NSString* regexp_h_string = @"<input type=\"hidden\" name=\"h_timestamp\" value=\"(.+)\" />";
        NSString* regexp_i_string = @"<input type=\"hidden\" name=\"i_timestamp\" value=\"(.+)\" />";

        NSDate* stdate = [NSDate date];
        CFURLRef url = CFURLCreateWithString(NULL, CFSTR("http://www.hackerschool.jp/hack/take32.php"),NULL);
        CFHTTPMessageRef httprequest = CFHTTPMessageCreateRequest(NULL, CFSTR("GET"), url, kCFHTTPVersion1_1);
        CFHTTPMessageSetHeaderFieldValue(httprequest, CFSTR("Content-Type"), CFSTR("application/x-www-form-urlencoded"));
        CFHTTPMessageSetHeaderFieldValue(httprequest, CFSTR("Cookie"), sesid);
        CFReadStreamRef readstream = CFReadStreamCreateForHTTPRequest(NULL, httprequest);
        CFReadStreamOpen(readstream);
        
        CFIndex bytes;
        int bufsize = 1024*128;
        UInt8 buf[bufsize];
        NSString* input_id_string = nil;
        NSString* h_timestamp_string = nil;
        NSString* i_timestamp_string = nil;
        do {
            bytes = CFReadStreamRead(readstream, buf, sizeof(buf));
            if( bytes > 0 ) {
                NSString* responsestring = [[NSString alloc] initWithBytes: buf length: bytes encoding:NSASCIIStringEncoding];
                NSLog(responsestring);
                if( input_id_string == nil ) {
                    [responsestring getCapturesWithRegexAndReferences:regexp_string, @"${1}", &input_id_string, nil];
                }
                if( h_timestamp_string == nil ) {
                    [responsestring getCapturesWithRegexAndReferences:regexp_h_string, @"${1}", &h_timestamp_string, nil];
                }
                if( i_timestamp_string == nil ) {
                    [responsestring getCapturesWithRegexAndReferences:regexp_i_string, @"${1}", &i_timestamp_string, nil];
                }
                if( input_id_string != nil && h_timestamp_string != nil && i_timestamp_string != nil ) {
                    break;
                }
            } else if(bytes < 0 ) {
                CFStreamError err = CFReadStreamGetError(readstream);
            }
        }while(bytes > 0 );
        CFReadStreamClose(readstream);
        
        CFHTTPMessageRef httpresponse = (CFHTTPMessageRef)CFReadStreamCopyProperty(readstream, kCFStreamPropertyHTTPResponseHeader);
        if(httpresponse) {
            CFStringRef responsestatus = CFHTTPMessageCopyResponseStatusLine(httpresponse);
            NSLog((NSString*)responsestatus);
        }
        if( input_id_string != nil ) {
            NSLog(input_id_string);
            NSArray* arrbuf = NULL;
            arrbuf = [input_id_string componentsSeparatedByString:@"x"];
            long input_id_buf = 1;
            for(NSString* strbuf in arrbuf) {
                int intbuf = [[strbuf stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] intValue];
                input_id_buf *= intbuf;
            }
            NSString* input_id = [NSString stringWithFormat:@"%ld",input_id_buf];
            NSString* requestbody = [NSString stringWithFormat:@"h_timestamp=%@&i_timestamp=%@&input_id=%@",h_timestamp_string, i_timestamp_string, input_id];
            NSLog(requestbody);

            CFHTTPMessageRef httprequest2 = CFHTTPMessageCreateRequest(NULL, CFSTR("POST"), url, kCFHTTPVersion1_1);
            CFHTTPMessageSetHeaderFieldValue(httprequest2, CFSTR("Content-Type"), CFSTR("application/x-www-form-urlencoded"));
            CFHTTPMessageSetHeaderFieldValue(httprequest2, CFSTR("Cookie"), sesid);
            NSData* requestbodydata = [requestbody dataUsingEncoding:NSUTF8StringEncoding];
            CFHTTPMessageSetBody(httprequest2, (CFDataRef)requestbodydata);
            NSDate* eddate = [NSDate date];
            CFReadStreamRef readstream = CFReadStreamCreateForHTTPRequest(NULL, httprequest2);
            CFReadStreamOpen(readstream);

            CFIndex bytes;
            int bufsize = 1024*128;
            UInt8 buf[bufsize];
            NSString* input_id_string = nil;
            NSString* h_timestamp_string = nil;
            NSString* i_timestamp_string = nil;
            do {
                bytes = CFReadStreamRead(readstream, buf, sizeof(buf));
                if( bytes > 0 ) {
                    NSString* responsestring = [[NSString alloc] initWithBytes: buf length: bytes encoding:NSUTF8StringEncoding];
                    NSLog(responsestring);
                } else if(bytes < 0 ) {
                    CFStreamError err = CFReadStreamGetError(readstream);
                }
            }while(bytes > 0 );
            CFReadStreamClose(readstream);
            
            CFHTTPMessageRef httpresponse = (CFHTTPMessageRef)CFReadStreamCopyProperty(readstream, kCFStreamPropertyHTTPResponseHeader);
            if(httpresponse) {
                CFStringRef responsestatus = CFHTTPMessageCopyResponseStatusLine(httpresponse);
                NSLog((NSString*)responsestatus);
            }
            NSLog(@"%f",[eddate timeIntervalSinceDate:stdate]);
       }
    }
    return 0;
}


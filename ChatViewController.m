//
//  ChatViewController.m
//  PeerToPeer
//
//  Created by Glenn Sayers on 05/11/2013.
//  Copyright (c) 2013 Glenn Sayers. All rights reserved.
//

#import "ChatViewController.h"

@interface ChatViewController ()
@property (nonatomic, retain) MCBrowserViewController *browserViewController;
@property (nonatomic, retain) MCAdvertiserAssistant *advertiserAssistant;
@property (nonatomic, retain) MCSession *session;
@property (nonatomic, retain) MCPeerID *peerID;
@property (nonatomic, retain) NSMutableArray *messages;

-(void) searchForPeers;

@end

@implementation ChatViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self setUpUi];
    [self setUpConnection];
}

-(void) setUpUi
{
    //Set the text on the navigation bar
    self.title = @"Chat";
    
    //Create a bar button item with Apples default search icon
    UIBarButtonItem *searchButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(searchForPeers)];
    
    //Add the search button to the nav bar.
    self.navigationItem.rightBarButtonItem = searchButton;
}

-(void) setUpConnection {
    //Set our display name to be the name of the device
    self.peerID = [[MCPeerID alloc] initWithDisplayName:@"Glenns iPhone"];
    
    //Create a new session with our peerID
    self.session = [[MCSession alloc] initWithPeer:self.peerID];
    
    //Create a browser view with our service type and session
    self.browserViewController = [[MCBrowserViewController alloc] initWithServiceType:@"chatApp" session:self.session];
    
    self.browserViewController.delegate = self;
    
    //Create an advertiser assistant to make our device discoverable
    self.advertiserAssistant = [[MCAdvertiserAssistant alloc] initWithServiceType:@"chatApp" discoveryInfo:Nil session:self.session];
    
    //Start advertising!
    [self.advertiserAssistant start];
}

-(void) searchForPeers
{
    [self presentViewController:self.browserViewController animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma Session Delegate Methods
- (void)session:(MCSession *)session peer:(MCPeerID *)peerID didChangeState:(MCSessionState)state{
    
}

// Received data from remote peer
- (void)session:(MCSession *)session didReceiveData:(NSData *)data fromPeer:(MCPeerID *)peerID{

}

// Received a byte stream from remote peer
- (void)session:(MCSession *)session didReceiveStream:(NSInputStream *)stream withName:(NSString *)streamName fromPeer:(MCPeerID *)peerID{
    
}

// Start receiving a resource from remote peer
- (void)session:(MCSession *)session didStartReceivingResourceWithName:(NSString *)resourceName fromPeer:(MCPeerID *)peerID withProgress:(NSProgress *)progress{
    
}

// Finished receiving a resource from remote peer and saved the content in a temporary location - the app is responsible for moving the file to a permanent location within its sandbox
- (void)session:(MCSession *)session didFinishReceivingResourceWithName:(NSString *)resourceName fromPeer:(MCPeerID *)peerID atURL:(NSURL *)localURL withError:(NSError *)error{
    
}

#pragma BrowserView Delegate Methods

- (void)browserViewControllerDidFinish:(MCBrowserViewController *)browserViewController{
    [self.browserViewController dismissViewControllerAnimated:YES completion:nil];
}

// Notifies delegate that the user taps the cancel button.
- (void)browserViewControllerWasCancelled:(MCBrowserViewController *)browserViewController{
    [self.browserViewController dismissViewControllerAnimated:YES completion:nil];
}

@end

From: steve.blightman@oracle.com (Steve Blightman)
Date: Fri, 14 Apr 2017 10:49:10 -0700
Subject: NVMe over fabrics - Caching controller Identity data
Message-ID: <603f53f6-1211-3b5f-31c8-dfa1e8700c26@oracle.com>

As I understand it, the linux initiator caches the controller Identity 
data and some other values.  These only get loaded when it first 
connects, or when the controller is reset.  Now If a target wishes to 
change any of these values, capsule size for instance, it might set the 
new values and restart itself, but when the initiator reconnects to an 
existing controller, it still has the old values. Is there a way for the 
target to force the initiator to reload these values somehow?

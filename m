From: willy@linux.intel.com (Matthew Wilcox)
Date: Fri, 31 May 2013 09:35:53 -0400
Subject: Proposal for handling async event requests
Message-ID: <20130531133553.GG8211@linux.intel.com>


One of the pieces currently missing from the Linux driver is any attempt
to send async event requests.  Part of the issue is that the driver isn't
really in a position to do anything with the asynchronous event results.

One previously proposed solution is to punt the entire thing to userspace.
Have a daemon open /dev/nvme{0,1...n} and submit admin commands through
the ioctl mechanism.  This should work, but if/when there are async
events that the driver does need to react to, the daemon then has to
tell the driver what happened.

My proposal is that the driver issues async event requests.  It handles
any that it understands how to handle and any remaining events can be
picked up by userspace calling read() on the /dev/nvmeN character devices.

We need to determine a format for the records returned by read().
My proposal is that it looks suspiciously similar to a completion
queue entry.  That is, a 16-byte record with Dword 0, Dword 1 and the
high 15 bits of Dword 3 copied from the CQE.  Dword 2 and the bottom 17
bits of Dword 3 would be available for our own purposes to communicate
with the daemon.

Any comments on this proposal before we start implementation?  One thing
I'm particularly interested in is thoughts on how to handle multiple
openers of /dev/nvmeN.  Option 1 is to permit only a single open() of
the device.  That means that once the daemon is up and running, nobody
else can use this path to issue ioctls, which is probably not great.
Option 2 is to allow any number of openers, and if they step on each
others toes when some of them get some completion events and others
get other completion events ... oh well, too bad.  Option 3 is to
duplicate all completion events to all openers.  Option 4 is to play
games with the open flags; maybe O_RDWR gets to read completion entries
while O_WRONLY only gets to send ioctls.

Other options? 

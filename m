From: ngalbo@micron.com (Neal Galbo (ngalbo))
Date: Fri, 31 May 2013 15:04:41 +0000
Subject: Proposal for handling async event requests
In-Reply-To: <20130531133553.GG8211@linux.intel.com>
References: <20130531133553.GG8211@linux.intel.com>
Message-ID: <5E6652408D93274292C8F06C9A4A26008454B480@NTXBOIMBX05.micron.com>

I think handling should be localized and associated through an existing, running NVMe driver, i.e. not a separate daemon.

1) User space (or supervisor) issues ioctl to "open" and enable AEN feature to a loaded, running driver in anticipation of receiving async events. Ioctl parameters contain pointer to callback routine and buffer space to receive AEN's.
2) When driver receives ioctl it saves incoming parameters, sets up to receive AEN's (otherwise it's "closed"/disabled). The driver can manage the AEN's within, directly or could launch an AEN handler worker thread that it owns or various other ways.
3) When AEN is received, driver or AEN manager calls back through pointer, deposits AEN info.
4) Provide a corresponding "close" ioctl to disable the AEN chatter when not needed.
5) ??? provide unique tags/id's in ioctl parameters to allow multiple openers. Unique tag generator should be located at a central point ... like the driver? (another ioctl to get a unique tag?)

Regards,
Neal


-----Original Message-----
From: Linux-nvme [mailto:linux-nvme-bounces@lists.infradead.org] On Behalf Of Matthew Wilcox
Sent: Friday, May 31, 2013 9:36 AM
To: linux-nvme at lists.infradead.org
Subject: Proposal for handling async event requests


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

_______________________________________________
Linux-nvme mailing list
Linux-nvme at lists.infradead.org
http://merlin.infradead.org/mailman/listinfo/linux-nvme

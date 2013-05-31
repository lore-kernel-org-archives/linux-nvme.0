From: ngalbo@micron.com (Neal Galbo (ngalbo))
Date: Fri, 31 May 2013 19:26:30 +0000
Subject: Proposal for handling async event requests
In-Reply-To: <20130531165301.GH8211@linux.intel.com>
References: <20130531133553.GG8211@linux.intel.com>
 <5E6652408D93274292C8F06C9A4A26008454B480@NTXBOIMBX05.micron.com>
 <20130531165301.GH8211@linux.intel.com>
Message-ID: <5E6652408D93274292C8F06C9A4A26008454B639@NTXBOIMBX05.micron.com>

Yes, we do agree.
Yes, I like the read() with blocking idea rather than the polling, you mentioned that. I didn't think about the blocking, I missed that on the first go.

Regards,
Neal


-----Original Message-----
From: Matthew Wilcox [mailto:willy@linux.intel.com] 
Sent: Friday, May 31, 2013 12:53 PM
To: Neal Galbo (ngalbo)
Cc: linux-nvme at lists.infradead.org
Subject: Re: Proposal for handling async event requests

On Fri, May 31, 2013@03:04:41PM +0000, Neal Galbo (ngalbo) wrote:
> I think handling should be localized and associated through an existing, running NVMe driver, i.e. not a separate daemon.

OK, so we're fundamentally in agreement, it's just a matter of negotiating
the API?  :-)

> 1) User space (or supervisor) issues ioctl to "open" and enable AEN feature to a loaded, running driver in anticipation of receiving async events. Ioctl parameters contain pointer to callback routine and buffer space to receive AEN's.
> 2) When driver receives ioctl it saves incoming parameters, sets up to receive AEN's (otherwise it's "closed"/disabled). The driver can manage the AEN's within, directly or could launch an AEN handler worker thread that it owns or various other ways.
> 3) When AEN is received, driver or AEN manager calls back through pointer, deposits AEN info.
> 4) Provide a corresponding "close" ioctl to disable the AEN chatter when not needed.
> 5) ??? provide unique tags/id's in ioctl parameters to allow multiple openers. Unique tag generator should be located at a central point ... like the driver? (another ioctl to get a unique tag?)

Yes, this approach definitely works.  Essentially, we're putting a
completion queue in userspace.  How do you envisage notifying userspace
that it has new entries?  The advantage of read() on the character device
is that it can block.  We can also use the poll() mechanism to wake up
tasks that are waiting for new entries.  I suppose we could also use
poll() with your scheme.

Another approach would be zero-copy; userspace could mmap the character
device and get a completion queue that way.  I'm not expecting this to
be sufficiently high performance to warrant such an approach :-)

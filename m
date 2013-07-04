From: willy@linux.intel.com (Matthew Wilcox)
Date: Thu, 4 Jul 2013 10:39:15 -0400
Subject: ioctls vs sysfs
In-Reply-To: <3F4C85E56084AD4ABA63AA9D6585D474032A28E3@psv1exm01.pmc_nt.nt.pmc-sierra.bc.ca>
References: <3F4C85E56084AD4ABA63AA9D6585D474032A28E3@psv1exm01.pmc_nt.nt.pmc-sierra.bc.ca>
Message-ID: <20130704143915.GE30142@linux.intel.com>

On Thu, Jul 04, 2013@11:06:51AM +0300, David Sariel wrote:
> Hi Matthew,
> I have several questions:
> 
> 1) Do you have plans to add nore SG_* ioctls to supports more commands
> from sg utils package?

I don't have any plans to do anything further with the nvme-scsi driver
myself.  I don't keep track of what is and isn't supported.  That said,
if someone wants to send patches to add support for something that's
missing, I don't have a problem with applying it.  For example, Keith
added support for UNMAP.

> 2) Do you have plans to add/move more stuff  to sysfs?

I'm open to exposing more stuff through sysfs.  Did you have any requests?

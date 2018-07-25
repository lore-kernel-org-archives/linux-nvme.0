From: keith.busch@linux.intel.com (Keith Busch)
Date: Wed, 25 Jul 2018 08:48:48 -0600
Subject: [PATCH 1/2] nvme-cli: add minimal ana-log page support
In-Reply-To: <20180725045352.GA10905@lst.de>
References: <20180725001316.2714-1-chaitanya.kulkarni@wdc.com>
 <20180725045352.GA10905@lst.de>
Message-ID: <20180725144848.GC14596@localhost.localdomain>

On Wed, Jul 25, 2018@06:53:52AM +0200, Christoph Hellwig wrote:
> On Tue, Jul 24, 2018@05:13:15PM -0700, Chaitanya Kulkarni wrote:
> > This patch adds a new command to retrieve the ANA Log page.
> > We update identify ctrl/ns data structure to support this command.
> > We also add ana based error codes and different identifiers to the
> > linux/nvme.h header file in order to support this command.
> 
> One thing I am a little concerned about here is that reading the
> ANA log page may clear the ANA AEN.  This actually is the same for
> other log pages that clear AENs, but for ANA the effects are much
> worse.
> 
> Keith, wat do you think of always setting the RAE bit for log pages
> associated with AENs?  The only real issue I can see is that the
> bit is only defined for NVMe 1.3+ so we'd need to figure out the
> version somehow.  Maybe with a new ioctl so that we don't have
> to send an identify every time.

Adding the RAE option for user space tooling is a good idea. Defaulting to
on should be safe too (will confirm on older drives), but does re-arming
the AEN really create a problem for ANA? I thought the log page problem
was when reading a page changes the result of the next read, but that
only applies to very few logs.

From: kbusch@kernel.org (Keith Busch)
Date: Fri, 24 May 2019 15:05:02 -0600
Subject: [RFC PATCH] nvme: Ignore timeouts while a PCIe reset is pending
In-Reply-To: <e01d7206-dc2c-b3cf-548a-4cb5ffc5bd19@grimberg.me>
References: <20190522003741.26755-1-kenneth.heitke@intel.com>
 <20190522192656.GB5486@localhost.localdomain>
 <20190522200918.GC5486@localhost.localdomain>
 <e01d7206-dc2c-b3cf-548a-4cb5ffc5bd19@grimberg.me>
Message-ID: <20190524210501.GA17343@localhost.localdomain>

On Thu, May 23, 2019@11:45:28PM -0700, Sagi Grimberg wrote:
> Keith,
> 
> > I think we should do the above anyway, but it isn't going to help if
> > commands dispatched outside disabling timeout. This should fix that.
> > Note, we never needed to have a sync'ed reset on reset_done(), but
> > this makes it necessary.
> 
> With async reset on reset_done() what guarantees that nvme_dev_disable
> does not run concurrently with another context of nvme_reset_work? both
> mangle with the same queues assuming that they are not running
> concurrently.
> 
> quick archive browse got me to:
> http://lists.infradead.org/pipermail/linux-nvme/2017-December/014599.html
> 
> discussion on my patch, but I think that it was a side effect from
> ming's tests..

Oh, you're right. I think Ming must have been writing to the pc reset
repeatedly, in which case this proposal will have a problem coordinating.

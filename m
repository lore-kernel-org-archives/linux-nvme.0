From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 23 May 2019 23:45:28 -0700
Subject: [RFC PATCH] nvme: Ignore timeouts while a PCIe reset is pending
In-Reply-To: <20190522200918.GC5486@localhost.localdomain>
References: <20190522003741.26755-1-kenneth.heitke@intel.com>
 <20190522192656.GB5486@localhost.localdomain>
 <20190522200918.GC5486@localhost.localdomain>
Message-ID: <e01d7206-dc2c-b3cf-548a-4cb5ffc5bd19@grimberg.me>

Keith,

> I think we should do the above anyway, but it isn't going to help if
> commands dispatched outside disabling timeout. This should fix that.
> Note, we never needed to have a sync'ed reset on reset_done(), but
> this makes it necessary.

With async reset on reset_done() what guarantees that nvme_dev_disable
does not run concurrently with another context of nvme_reset_work? both
mangle with the same queues assuming that they are not running
concurrently.

quick archive browse got me to:
http://lists.infradead.org/pipermail/linux-nvme/2017-December/014599.html

discussion on my patch, but I think that it was a side effect from
ming's tests..

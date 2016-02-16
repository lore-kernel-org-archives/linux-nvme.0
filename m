From: keith.busch@intel.com (Keith Busch)
Date: Tue, 16 Feb 2016 18:40:47 +0000
Subject: [PATCH 1/2] NVMe: Lock out shutdown during pci init
In-Reply-To: <20160213095851.GA15206@infradead.org>
References: <1455231626-7166-1-git-send-email-keith.busch@intel.com>
 <20160213095851.GA15206@infradead.org>
Message-ID: <20160216184046.GA8415@localhost.localdomain>

On Sat, Feb 13, 2016@01:58:51AM -0800, Christoph Hellwig wrote:
> Seems like we should be holding the lock over the call
> to nvme_dev_disable to get protection for the whole execution,
> e.g. by adding a __nvme_dev_disable variant that expects the lock
> to be held.
> 
> Maybe it's also worth renaming shutdown_lock to register_mutex
> or similar to better document what it protects.

Perhaps we shouldn't unmap the registers on a reset. That'd fix several
problems, including this one and writing queue doorbells.

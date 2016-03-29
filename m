From: hch@infradead.org (Christoph Hellwig)
Date: Tue, 29 Mar 2016 03:55:27 -0700
Subject: [PATCHv4-4.5 5/7] NVMe: Move error handling to failed reset
 handler
In-Reply-To: <1456330558-819-6-git-send-email-keith.busch@intel.com>
References: <1456330558-819-1-git-send-email-keith.busch@intel.com>
 <1456330558-819-6-git-send-email-keith.busch@intel.com>
Message-ID: <20160329105527.GA11312@infradead.org>

On Wed, Feb 24, 2016@09:15:56AM -0700, Keith Busch wrote:
> This moves failed queue handling out of the namespace removal path and
> into the reset failure path, fixing a hanging condition if the controller
> fails or link down during del_gendisk. Previously the driver had to see
> the controller as degraded prior to calling del_gendisk to setup the
> queues to fail. But, if the controller happened to fail after this,
> there was no task to end outstanding requests.
> 
> On failure, all namespace states are set to dead. This has capacity
> revalidate to 0, and ends all new requests with error status.

This removes the last call of nvme_io_incapable and thus the
io_incapable method as well as nvme_pci_io_incapable.  Do you have any
plans to bring back users of these, or can we remove this
infrastructure?

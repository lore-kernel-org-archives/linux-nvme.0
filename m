From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 8 Jun 2016 05:03:29 -0700
Subject: [PATCH v2] NVMe: Add controller state for scheduling resets
In-Reply-To: <575808AC.2030004@lightbits.io>
References: <1464729484-14424-1-git-send-email-keith.busch@intel.com>
 <575808AC.2030004@lightbits.io>
Message-ID: <20160608120329.GA20526@infradead.org>

On Wed, Jun 08, 2016@02:59:40PM +0300, Sagi Grimberg wrote:
> Is my understanding correct? Do you think that we should modify the
> loop and rdma drivers to do async reset as well?
> 
> This also makes the different transport behave differently at the moment
> which is something we should strive to avoid...

Don't worry, I have an almost ready patch series to pull this change
it in, it actually helps for fabrics as well.

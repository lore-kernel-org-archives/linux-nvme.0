From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 24 Feb 2016 05:05:20 -0800
Subject: [PATCH] NVMe: Use IDA for namespace disk naming
In-Reply-To: <20160223225635.GB20250@localhost.localdomain>
References: <1455819485-3730-1-git-send-email-keith.busch@intel.com>
 <20160221161249.GA21099@infradead.org>
 <20160223225635.GB20250@localhost.localdomain>
Message-ID: <20160224130520.GA17955@infradead.org>

On Tue, Feb 23, 2016@10:56:36PM +0000, Keith Busch wrote:
> > This looks sensible, but I fear we might be running into the same
> > issue with the backing_device embedded in the request_queue.
> 
> I don't think I follow. On rescanning, a new namespace with the same
> NSID as a previously deleted one will allocate a new request_queue.

But the bdi name embedds the major/minor of the device.  So if we
haven't fully torn down the device we might run into sysfs name
conflicts.

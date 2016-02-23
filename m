From: keith.busch@intel.com (Keith Busch)
Date: Tue, 23 Feb 2016 22:56:36 +0000
Subject: [PATCH] NVMe: Use IDA for namespace disk naming
In-Reply-To: <20160221161249.GA21099@infradead.org>
References: <1455819485-3730-1-git-send-email-keith.busch@intel.com>
 <20160221161249.GA21099@infradead.org>
Message-ID: <20160223225635.GB20250@localhost.localdomain>

On Sun, Feb 21, 2016@08:12:49AM -0800, Christoph Hellwig wrote:
> On Thu, Feb 18, 2016@11:18:05AM -0700, Keith Busch wrote:
> > A namespace may be detached from a controller, but a user may be holding
> > a reference to it. Attaching a new namespace with the same NSID will create
> > duplicate names when using the NSID to name the disk.
> 
> This looks sensible, but I fear we might be running into the same
> issue with the backing_device embedded in the request_queue.

I don't think I follow. On rescanning, a new namespace with the same
NSID as a previously deleted one will allocate a new request_queue.

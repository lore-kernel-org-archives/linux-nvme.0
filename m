From: hch@infradead.org (Christoph Hellwig)
Date: Sun, 21 Feb 2016 08:12:49 -0800
Subject: [PATCH] NVMe: Use IDA for namespace disk naming
In-Reply-To: <1455819485-3730-1-git-send-email-keith.busch@intel.com>
References: <1455819485-3730-1-git-send-email-keith.busch@intel.com>
Message-ID: <20160221161249.GA21099@infradead.org>

On Thu, Feb 18, 2016@11:18:05AM -0700, Keith Busch wrote:
> A namespace may be detached from a controller, but a user may be holding
> a reference to it. Attaching a new namespace with the same NSID will create
> duplicate names when using the NSID to name the disk.

This looks sensible, but I fear we might be running into the same
issue with the backing_device embedded in the request_queue.

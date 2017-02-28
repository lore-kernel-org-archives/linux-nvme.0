From: hch@lst.de (Christoph Hellwig)
Date: Tue, 28 Feb 2017 15:10:17 +0100
Subject: [PATCH] nvme/pci: Poll CQ on timeout
In-Reply-To: <1487977168-5347-1-git-send-email-keith.busch@intel.com>
References: <1487977168-5347-1-git-send-email-keith.busch@intel.com>
Message-ID: <20170228141017.GC20317@lst.de>

On Fri, Feb 24, 2017@05:59:28PM -0500, Keith Busch wrote:
> If an IO timeout occurs, it's helpful to know if the controller did not
> post a completion or the driver missed an interrupt. While we never expect
> the latter, this patch will make it possible to tell the difference so
> we don't have to guess.

Do you have any good real use case for it?  I mostly don't like it
becuase it ties us to polling for a specific tag, something I'd like
to change in the ->poll API.

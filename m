From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 24 Feb 2016 11:33:58 -0800
Subject: [PATCHv4-4.5 2/7] NVMe: Use IDA for namespace disk naming
In-Reply-To: <1456330558-819-3-git-send-email-keith.busch@intel.com>
References: <1456330558-819-1-git-send-email-keith.busch@intel.com>
 <1456330558-819-3-git-send-email-keith.busch@intel.com>
Message-ID: <20160224193358.GB25509@infradead.org>

On Wed, Feb 24, 2016@09:15:53AM -0700, Keith Busch wrote:
> A namespace may be detached from a controller, but a user may be holding
> a reference to it. Attaching a new namespace with the same NSID will create
> duplicate names when using the NSID to name the disk.
> 
> This patch uses an IDA that is released only when the last reference is
> released instead of using the namespace ID.
> 
> Signed-off-by: Keith Busch <keith.busch at intel.com>

Reviewed-by: Christoph Hellwig <hch at lst.de>

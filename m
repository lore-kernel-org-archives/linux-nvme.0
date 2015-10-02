From: hch@infradead.org (Christoph Hellwig)
Date: Fri, 2 Oct 2015 09:57:26 -0700
Subject: [PATCHv2 2/2] NVMe: Simplify device resume on io queue failure
In-Reply-To: <1443803849-7268-2-git-send-email-keith.busch@intel.com>
References: <1443803849-7268-1-git-send-email-keith.busch@intel.com>
 <1443803849-7268-2-git-send-email-keith.busch@intel.com>
Message-ID: <20151002165726.GB2405@infradead.org>

On Fri, Oct 02, 2015@10:37:29AM -0600, Keith Busch wrote:
> Releasing IO queues and disks was done in a work queue outside the
> controller resume context to delete namespaces if the controller failed
> after a resume from suspend. This is unnecessary since we can resume
> a device asynchronously.
> 
> This patch makes resume use probe_work so it can directly remove
> namespaces if the device is manageable but not IO capable. Since the
> deleting disks was the only reason we had the convoluted "reset_workfn",
> this patch removes that unnecessary indirection.
> 
> Signed-off-by: Keith Busch <keith.busch at intel.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch at lst.de>

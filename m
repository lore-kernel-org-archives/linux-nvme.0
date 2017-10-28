From: hch@lst.de (Christoph Hellwig)
Date: Sat, 28 Oct 2017 07:52:58 +0200
Subject: [PATCH urgent-4.14] nvme: Fix setting logical block format
 when revalidating
In-Reply-To: <20171027195122.1810-1-keith.busch@intel.com>
References: <20171027195122.1810-1-keith.busch@intel.com>
Message-ID: <20171028055258.GA13348@lst.de>

On Fri, Oct 27, 2017@01:51:22PM -0600, Keith Busch wrote:
> Revalidating the disk needs to set the logical block format and capacity,
> otherwise it can't figure out if the users modified anything about
> the namespace.
> 
> Fixes: cdbff4f26bd9 ("nvme: remove nvme_revalidate_ns")
> 
> Signed-off-by: Keith Busch <keith.busch at intel.com>

Looks fine to me:

Reviewed-by: Christoph Hellwig <hch at lst.de>

Jens: can you pick this up directly before sending a block PR today?

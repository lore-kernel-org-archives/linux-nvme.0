From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 10 Aug 2017 02:23:33 -0700
Subject: [PATCH] nvmet_fc: Simplify sg list handling
In-Reply-To: <20170731202114.18202-1-jsmart2021@gmail.com>
References: <20170731202114.18202-1-jsmart2021@gmail.com>
Message-ID: <20170810092333.GA1442@infradead.org>

On Mon, Jul 31, 2017@01:21:14PM -0700, James Smart wrote:
> The existing nvmet_fc sg list handling has 2 faults:
> a) the request between LLDD and transport has too large of an sg
>    list (256 elements), which is normally 256k (64 elements).
> b) sglist handling doesn't optimize on the fact that each element
>    is a page.
> 
> This patch removes the static sg list in the request and uses the
> dynamic list already present in the nvmet_fc transport. It also
> simplies the handling of the sg list on multiple sequences to
> take advantage of the per-page divisions.

This looks good:

Reviewed-by: Christoph Hellwig <hch at lst.de>

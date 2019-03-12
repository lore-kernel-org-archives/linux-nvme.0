From: hch@infradead.org (Christoph Hellwig)
Date: Tue, 12 Mar 2019 07:48:06 -0700
Subject: [PATCH] nvme: fix write zeroes offset and count
In-Reply-To: <20190311151153.10516-1-keith.busch@intel.com>
References: <20190311151153.10516-1-keith.busch@intel.com>
Message-ID: <20190312144806.GA10240@infradead.org>

On Mon, Mar 11, 2019@09:11:53AM -0600, Keith Busch wrote:
> The implementation used blocks units rather than the expected bytes.

Thank,

looks good:

Reviewed-by: Christoph Hellwig <hch at lst.de>

And sorry for causing this mess.

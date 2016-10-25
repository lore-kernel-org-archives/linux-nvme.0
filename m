From: hch@infradead.org (Christoph Hellwig)
Date: Tue, 25 Oct 2016 05:39:23 -0700
Subject: [PATCH] rdma: force queue size to respect controller capability
In-Reply-To: <444159155.19898733.1477380154029.JavaMail.zimbra@kalray.eu>
References: <444159155.19898733.1477380154029.JavaMail.zimbra@kalray.eu>
Message-ID: <20161025123923.GA27453@infradead.org>

On Tue, Oct 25, 2016@09:22:34AM +0200, Samuel Jones wrote:
> Queue size needs to respect the Maximum Queue Entries Supported advertised by
> the controller in its Capability register.
> 
> Signed-off-by: Samuel Jones <sjones at kalray.eu>

Thanks Samuel,

this looks good:

Reviewed-by: Christoph Hellwig <hch at lst.de>

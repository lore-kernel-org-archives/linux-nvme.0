From: hch@infradead.org (Christoph Hellwig)
Date: Fri, 9 Dec 2016 10:32:25 -0800
Subject: [PATCH] nvme/scsi: Remove START STOP emulation
In-Reply-To: <1a075417a8c929924316bb5f9d93370c485c9d0e.1481048041.git.luto@kernel.org>
References: <1a075417a8c929924316bb5f9d93370c485c9d0e.1481048041.git.luto@kernel.org>
Message-ID: <20161209183225.GB8964@infradead.org>

On Tue, Dec 06, 2016@10:14:35AM -0800, Andy Lutomirski wrote:
> Now that the broken power state control is gone, it appears to serve
> no purpose.  Just delete it.  NVME devices don't have a concept of
> started vs stopped anyway.
> 
> Signed-off-by: Andy Lutomirski <luto at kernel.org>

Looks fine,

Reviewed-by: Christoph Hellwig <hch at lst.de>

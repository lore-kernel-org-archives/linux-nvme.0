From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 5 Nov 2015 11:58:39 -0800
Subject: [PATCH 1/1 v4] drivers/nvme: default to 4k device page size
In-Reply-To: <20151105170145.GB16308@linux.vnet.ibm.com>
References: <20151027223643.GA25332@localhost.localdomain>
 <20151027.175443.140992924519172506.davem@davemloft.net>
 <20151028135922.GA27909@localhost.localdomain>
 <20151029115536.GA28090@infradead.org>
 <20151029155701.GJ7716@linux.vnet.ibm.com>
 <20151029172043.GA8343@localhost.localdomain>
 <20151030213511.GK7716@linux.vnet.ibm.com>
 <20151103131824.GA12232@infradead.org>
 <20151103134624.GG13904@localhost.localdomain>
 <20151105170145.GB16308@linux.vnet.ibm.com>
Message-ID: <20151105195839.GB3194@infradead.org>

Looks fine,

Reviewed-by: Christoph Hellwig <hch at lst.de>

... but I doubt we'll ever bother updating it.  Most architectures
with arger page sizes also have iommus and would need different settings
for different iommus vs direct mapping for very little gain.  There's a
reason why we never bothered for RDMA either.

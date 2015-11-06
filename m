From: nacc@linux.vnet.ibm.com (Nishanth Aravamudan)
Date: Fri, 6 Nov 2015 08:13:45 -0800
Subject: [PATCH 1/1 v4] drivers/nvme: default to 4k device page size
In-Reply-To: <20151105195839.GB3194@infradead.org>
References: <20151027.175443.140992924519172506.davem@davemloft.net>
 <20151028135922.GA27909@localhost.localdomain>
 <20151029115536.GA28090@infradead.org>
 <20151029155701.GJ7716@linux.vnet.ibm.com>
 <20151029172043.GA8343@localhost.localdomain>
 <20151030213511.GK7716@linux.vnet.ibm.com>
 <20151103131824.GA12232@infradead.org>
 <20151103134624.GG13904@localhost.localdomain>
 <20151105170145.GB16308@linux.vnet.ibm.com>
 <20151105195839.GB3194@infradead.org>
Message-ID: <20151106161345.GB18259@linux.vnet.ibm.com>

On 05.11.2015 [11:58:39 -0800], Christoph Hellwig wrote:
> Looks fine,
> 
> Reviewed-by: Christoph Hellwig <hch at lst.de>
> 
> ... but I doubt we'll ever bother updating it.  Most architectures
> with arger page sizes also have iommus and would need different settings
> for different iommus vs direct mapping for very little gain.  There's a
> reason why we never bothered for RDMA either.

FWIW, whose tree should this go through? The bug only appears on Power,
afaik, but the patch is now just an NVMe change.

Thanks,
Nish

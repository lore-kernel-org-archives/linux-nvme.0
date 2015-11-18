From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 18 Nov 2015 06:42:03 -0800
Subject: [PATCH 1/1 v4] drivers/nvme: default to 4k device page size
In-Reply-To: <20151113150811.GA27275@localhost.localdomain>
References: <20151029115536.GA28090@infradead.org>
 <20151029155701.GJ7716@linux.vnet.ibm.com>
 <20151029172043.GA8343@localhost.localdomain>
 <20151030213511.GK7716@linux.vnet.ibm.com>
 <20151103131824.GA12232@infradead.org>
 <20151103134624.GG13904@localhost.localdomain>
 <20151105170145.GB16308@linux.vnet.ibm.com>
 <20151105195839.GB3194@infradead.org>
 <20151113073754.GA19688@infradead.org>
 <20151113150811.GA27275@localhost.localdomain>
Message-ID: <20151118144203.GA1819@infradead.org>

On Fri, Nov 13, 2015@03:08:11PM +0000, Keith Busch wrote:
> On Thu, Nov 12, 2015@11:37:54PM -0800, Christoph Hellwig wrote:
> > Jens, Keith: any chance to get this to Linux for 4.4 (and -stable)?
> 
> I agreed, looks good to me.
> 
> Acked-by: Keith Busch <keith.busch at intel.com>

Jens, can you pick this one for -rc2?

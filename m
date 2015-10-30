From: nacc@linux.vnet.ibm.com (Nishanth Aravamudan)
Date: Fri, 30 Oct 2015 14:35:46 -0700
Subject: [PATCH 0/5 v3] Fix NVMe driver support on Power with 32-bit DMA
In-Reply-To: <20151029.184955.728736673434401711.davem@davemloft.net>
References: <20151028135922.GA27909@localhost.localdomain>
 <20151029115536.GA28090@infradead.org>
 <20151029155701.GJ7716@linux.vnet.ibm.com>
 <20151029.184955.728736673434401711.davem@davemloft.net>
Message-ID: <20151030213546.GL7716@linux.vnet.ibm.com>

On 29.10.2015 [18:49:55 -0700], David Miller wrote:
> From: Nishanth Aravamudan <nacc at linux.vnet.ibm.com>
> Date: Thu, 29 Oct 2015 08:57:01 -0700
> 
> > So, would that imply changing just the NVMe driver code rather than
> > adding the dma_page_shift API at all? What about
> > architectures that can support the larger page sizes? There is an
> > implied performance impact, at least, of shifting the IO size down.
> > 
> > Sorry for the continuing questions -- I got lots of conflicting feedback
> > on the last series and want to make sure v4 is more acceptable.
> 
> In the long term I would be very happy to see us having a real interface
> for this stuff, just my opinion...

Yep, I think I'll try and balance the two -- fix NVMe for now with a 4K
page size as suggested by Christoph, and then work on the more complete
API for the next merge.

Thanks,
Nish

From: davem@davemloft.net (David Miller)
Date: Mon, 26 Oct 2015 18:27:46 -0700 (PDT)
Subject: [PATCH 0/5 v3] Fix NVMe driver support on Power with 32-bit DMA
In-Reply-To: <20151023205420.GA10197@linux.vnet.ibm.com>
References: <20151023205420.GA10197@linux.vnet.ibm.com>
Message-ID: <20151026.182746.1323901353520152838.davem@davemloft.net>

From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
Date: Fri, 23 Oct 2015 13:54:20 -0700

> 1) add a generic dma_get_page_shift implementation that just returns
> PAGE_SHIFT

I won't object to this patch series, but if I had implemented this I
would have required the architectures to implement this explicitly,
one-by-one.  I think it is less error prone and more likely to end
up with all the architectures setting this correctly.

From: nacc@linux.vnet.ibm.com (Nishanth Aravamudan)
Date: Tue, 27 Oct 2015 18:52:55 -0700
Subject: [PATCH 0/5 v3] Fix NVMe driver support on Power with 32-bit DMA
In-Reply-To: <20151027.175322.247163553940004154.davem@davemloft.net>
References: <20151023205420.GA10197@linux.vnet.ibm.com>
 <20151026.182746.1323901353520152838.davem@davemloft.net>
 <20151027222010.GD7716@linux.vnet.ibm.com>
 <20151027.175322.247163553940004154.davem@davemloft.net>
Message-ID: <20151028015255.GG7716@linux.vnet.ibm.com>

On 27.10.2015 [17:53:22 -0700], David Miller wrote:
> From: Nishanth Aravamudan <nacc at linux.vnet.ibm.com>
> Date: Tue, 27 Oct 2015 15:20:10 -0700
> 
> > Well, looks like I should spin up a v4 anyways for the powerpc changes.
> > So, to make sure I understand your point, should I make the generic
> > dma_get_page_shift a compile-error kind of thing? It will only fail on
> > architectures that actually build the NVME driver (as the only caller).
> > But I'm not sure how exactly to achieve that, if you could give a bit
> > more detail I'd appreciate it!
> 
> Yes, I am basically suggesting to simply not provide a default at all.

For my own edification -- what is the way that gets resolved? I guess I
mean it seems like linux-next would cease to compile because of my new
series. Would my patches just get kicked out of -next for introducing
that (or even via the 0-day notifications), or should I put something
into the commit message indicating it is an API introduction?

Sorry for the tentativeness, I have not introduce a cross-architecture
API like this before.

Thanks,
Nish

> 

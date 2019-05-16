From: ichavero@chavero.com.mx (=?ISO-8859-1?Q?Iv=E1n?= Chavero)
Date: Thu, 16 May 2019 00:50:58 -0500
Subject: nvme drive kernel 5.0 problem
In-Reply-To: <CACVXFVPXGKQ9UD6P5RsF5j8yry+1LuLrUeb4F6o74=uGK4Ak4Q@mail.gmail.com>
References: <4a0dda5365f24e7223d1672233d7f1ac64640d31.camel@chavero.com.mx>
 <CACVXFVPXGKQ9UD6P5RsF5j8yry+1LuLrUeb4F6o74=uGK4Ak4Q@mail.gmail.com>
Message-ID: <ac0020310720baaf802b66d9c218c59d9211a65d.camel@chavero.com.mx>

Thanks!

I'll test the patches or update to 5.1 to see if gets fixed

> Not see this issue with 5.1 kernel, may be addressed by the following
> patches:
> 
> 4e6b26d23dc1 PCI/MSI: Remove obsolete sanity checks for multiple
> interrupt sets
> a6a309edba13 genirq/affinity: Remove the leftovers of the original
> set support
> 612b72862b4d nvme-pci: Simplify interrupt allocation
> c66d4bd110a1 genirq/affinity: Add new callback for (re)calculating
> interrupt sets
> 9cfef55bb57e genirq/affinity: Store interrupt sets size in struct
> irq_affinity
> 0145c30e896d genirq/affinity: Code consolidation
> 
> 
> 
> Thanks,
> Ming Lei

Cheers,
Iv?n

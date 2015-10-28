From: davem@davemloft.net (David Miller)
Date: Tue, 27 Oct 2015 17:54:43 -0700 (PDT)
Subject: [PATCH 0/5 v3] Fix NVMe driver support on Power with 32-bit DMA
In-Reply-To: <20151027223643.GA25332@localhost.localdomain>
References: <20151026.182746.1323901353520152838.davem@davemloft.net>
 <20151027222010.GD7716@linux.vnet.ibm.com>
 <20151027223643.GA25332@localhost.localdomain>
Message-ID: <20151027.175443.140992924519172506.davem@davemloft.net>

From: "Busch, Keith" <keith.busch@intel.com>
Date: Tue, 27 Oct 2015 22:36:43 +0000

> If you're suggesting to compile-time break architectures that currently
> work just fine with NVMe, let me stop you right there.

Silently "working" without the architecture maintainer having to explicity
look at the new interface and make sure his platform is implementing it
properly is an extremely bad practice.

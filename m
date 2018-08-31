From: christian.koenig@amd.com (=?UTF-8?Q?Christian_K=c3=b6nig?=)
Date: Fri, 31 Aug 2018 10:08:11 +0200
Subject: [PATCH v5 06/13] PCI/P2PDMA: Add P2P DMA driver writer's
 documentation
In-Reply-To: <20180830185352.3369-7-logang@deltatee.com>
References: <20180830185352.3369-1-logang@deltatee.com>
 <20180830185352.3369-7-logang@deltatee.com>
Message-ID: <98bff500-4e4c-3a34-6762-16ef4b076d90@amd.com>

Am 30.08.2018 um 20:53 schrieb Logan Gunthorpe:
> [SNIP]
> +============================
> +PCI Peer-to-Peer DMA Support
> +============================
> +
> +The PCI bus has pretty decent support for performing DMA transfers
> +between two devices on the bus. This type of transaction is henceforth
> +called Peer-to-Peer (or P2P). However, there are a number of issues that
> +make P2P transactions tricky to do in a perfectly safe way.
> +
> +One of the biggest issues is that PCI doesn't require forwarding
> +transactions between hierarchy domains, and in PCIe, each Root Port
> +defines a separate hierarchy domain. To make things worse, there is no
> +simple way to determine if a given Root Complex supports this or not.
> +(See PCIe r4.0, sec 1.3.1). Therefore, as of this writing, the kernel
> +only supports doing P2P when the endpoints involved are all behind the
> +same PCI bridge, as such devices are all in the same PCI hierarchy
> +domain, and the spec guarantees that all transacations within the
> +hierarchy will be routable, but it does not require routing
> +between hierarchies.

Can we add a kernel command line switch and a whitelist to enable P2P 
between separate hierarchies?

At least all newer AMD chipsets supports this and I'm pretty sure that 
Intel has a list with PCI-IDs of the root hubs for this as well.

Regards,
Christian.

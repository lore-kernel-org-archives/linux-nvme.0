From: keith.busch@intel.com (Keith Busch)
Date: Mon, 19 Dec 2016 12:02:02 -0500
Subject: [RFC 1/1] MicroSemi Switchtec management interface driver
In-Reply-To: <1481994562-9283-2-git-send-email-logang@deltatee.com>
References: <1481994562-9283-1-git-send-email-logang@deltatee.com>
 <1481994562-9283-2-git-send-email-logang@deltatee.com>
Message-ID: <20161219170201.GA1043@localhost.localdomain>

On Sat, Dec 17, 2016@10:09:22AM -0700, Logan Gunthorpe wrote:
> Microsemi's "Switchtec" line of PCI switch devices is already
> supported by the kernel with standard PCI switch drivers. However, the
> Switchtec device advertises a special management endpoint which
> enables some additional functionality. This includes:
> 
>  * Packet and Byte Counters
>  * Firmware Upgrades
>  * Event and Error logs
>  * Querying port link status
>  * Custom user firmware commands
> 
> This patch introduces the switchtec kernel module which provides
> pci driver that exposes a char device. The char device provides
> userspace access to this interface through read, write and (optionally)
> poll calls. Currently no ioctls have been implemented but a couple
> may be added in a later revision.
> 
> A short text file is provided which documents the switchtec driver
> and outlines the semantics of using the char device.

Some of this would be simplified if you use the managed device API's:
devm_request_irq, pcim_enable_device, pcim_iomap, etc...

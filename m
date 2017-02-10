From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Fri, 10 Feb 2017 15:54:38 +0100
Subject: [PATCH v2 1/4] MicroSemi Switchtec management interface driver
In-Reply-To: <1486058763-7730-2-git-send-email-logang@deltatee.com>
References: <1486058763-7730-1-git-send-email-logang@deltatee.com>
 <1486058763-7730-2-git-send-email-logang@deltatee.com>
Message-ID: <20170210145438.GC24594@kroah.com>

On Thu, Feb 02, 2017@11:06:00AM -0700, Logan Gunthorpe wrote:
> Microsemi's "Switchtec" line of PCI switch devices is already well
> supported by the kernel with standard PCI switch drivers. However, the
> Switchtec device advertises a special management endpoint with a separate
> PCI function address and class code. This endpoint enables some additional
> functionality which includes:
> 
>  * Packet and Byte Counters
>  * Switch Firmware Upgrades
>  * Event and Error logs
>  * Querying port link status
>  * Custom user firmware commands
> 
> This patch introduces the switchtec kernel module which provides
> PCI driver that exposes a char device. The char device provides
> userspace access to this interface through read, write and (optionally)
> poll calls.
> 
> A userspace tool and library which utilizes this interface is available
> at [1]. This tool takes inspiration (and borrows some code) from
> nvme-cli [2]. The tool is largely complete at this time but additional
> features may be added in the future.
> 
> [1] https://github.com/sbates130272/switchtec-user
> [2] https://github.com/linux-nvme/nvme-cli
> 
> Signed-off-by: Logan Gunthorpe <logang at deltatee.com>
> Signed-off-by: Stephen Bates <stephen.bates at microsemi.com>

Reviewed-by: Greg Kroah-Hartman <gregkh at linuxfoundation.org>

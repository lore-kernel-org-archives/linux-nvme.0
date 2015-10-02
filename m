From: keith.busch@intel.com (Keith Busch)
Date: Fri, 2 Oct 2015 15:48:58 +0000 (UTC)
Subject: nvme header reshuffle
In-Reply-To: <1443794643-12730-1-git-send-email-hch@lst.de>
References: <1443794643-12730-1-git-send-email-hch@lst.de>
Message-ID: <alpine.LNX.2.00.1510021546580.23840@localhost.lm.intel.com>

On Fri, 2 Oct 2015, Christoph Hellwig wrote:
> This series reworks the header organisation in the nvme driver.  Currently
> there are two headers: include/uapi/linux/nvme.h, which contains the ioctl
> ABI and a lot of hardware description constants and include/linux/nvme.h
> which contains more hardware descriptions constants as well as driver
> internals.
>
> This series splits them into one header each for the ioctl ABI, hardware
> descr?ption and driver internals.

Thanks, looks good. There are some clashes with my most recent series,
but happy to sort it out as things merge.

For the series,

Acked-by: Keith Busch <keith.busch at intel.com>

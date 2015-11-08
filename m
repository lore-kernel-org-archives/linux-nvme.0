From: axboe@kernel.dk (Jens Axboe)
Date: Sat, 7 Nov 2015 17:20:37 -0700
Subject: [PATCH 0/2] nvme: adding support for Apple's NVMe controller
In-Reply-To: <33537e8a12dff1f96eaec9098724d01e@localhost>
References: <33537e8a12dff1f96eaec9098724d01e@localhost>
Message-ID: <563E9555.5010503@kernel.dk>

On 11/03/2015 04:31 PM, Stephan G?nther wrote:
> Adding support for Apple's NVMe controller. Patches are tested on
> linux-4.3 on a MacBook8,1. /dev/nvme0n1p* are recognized, bulk transfers
> work, and the previous patches have been confirmed to work on NVMe-based
> MacBookAir7,1 (see patches for details).
>
> Stephan G?nther (2):
>    nvme: enforce ordered split transfers
>    nvme: add pci device id for Apple NVMe controller

Added for 4.4.

-- 
Jens Axboe

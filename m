From: keith.busch@intel.com (Keith Busch)
Date: Fri, 14 Jul 2017 17:06:24 -0400
Subject: [PATCH] nvme : add Scatter-Gather List (SGL) support in NVMe
 driver.
In-Reply-To: <1499968479-5286-2-git-send-email-chaitanya.kulkarni@hgst.com>
References: <1499968479-5286-1-git-send-email-chaitanya.kulkarni@hgst.com>
 <1499968479-5286-2-git-send-email-chaitanya.kulkarni@hgst.com>
Message-ID: <20170714210623.GB24365@localhost.localdomain>

On Thu, Jul 13, 2017@10:54:39AM -0700, Chaitanya Kulkarni wrote:
> This adds SGL support for NVMe PCIe driver which is
> reimplementation of the initial version provided by
> Rajiv Shanmugam Madeswaran(smrajiv15 at gmail.com):-
> "block: nvme-core: Scatter gather list support in the
> NVMe Block Driver".
> 
> In order to enable SGL mode for the driver, the user can set the
> sgl_threshold module parameter. This parameter can be used
> in the two modes:-
> 
> 1. Allow all IOs to use SGL mode. (set sgl_threshold to 1).
> 2. Set up the IO size threshold to determine whether to use
>     SGLs or PRPs for each IO. (set sgl_threshold to 4096 to
>     use SGL only for IOs which are >= 4096 in the size).

For this to really make a difference, you should clear
blk_queue_virt_boundary for SGL capable devices.

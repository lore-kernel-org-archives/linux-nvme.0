From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Wed, 29 May 2019 23:52:10 +0900
Subject: [PATCH 2/2] nvme: enable to inject errors into admin commands
In-Reply-To: <1559063018-3682-3-git-send-email-akinobu.mita@gmail.com>
References: <1559063018-3682-1-git-send-email-akinobu.mita@gmail.com>
 <1559063018-3682-3-git-send-email-akinobu.mita@gmail.com>
Message-ID: <20190529145209.GB28274@minwooim-desktop>

On 19-05-29 02:03:38, Akinobu Mita wrote:
> This enables to inject errors into the commands submitted to the admin
> queue.
> 
> It is useful to test error handling in the controller initialization.
> 
> 	# echo 100 > /sys/kernel/debug/nvme0/fault_inject/probability
> 	# echo 1 > /sys/kernel/debug/nvme0/fault_inject/times
> 	# echo 10 > /sys/kernel/debug/nvme0/fault_inject/space
> 	# nvme reset /dev/nvme0
> 	# dmesg
> 	...
> 	nvme nvme0: Could not set queue count (16385)
> 	nvme nvme0: IO queues not created
> 
> Cc: Thomas Tai <thomas.tai at oracle.com>
> Cc: Keith Busch <kbusch at kernel.org>
> Cc: Jens Axboe <axboe at fb.com>
> Cc: Christoph Hellwig <hch at lst.de>
> Cc: Sagi Grimberg <sagi at grimberg.me>
> Signed-off-by: Akinobu Mita <akinobu.mita at gmail.com>
> ---
>  drivers/nvme/host/core.c         |  3 +++
>  drivers/nvme/host/fault_inject.c |  5 ++---
>  drivers/nvme/host/nvme.h         | 20 +++++++++++---------
>  3 files changed, 16 insertions(+), 12 deletions(-)

This looks good to me also.

Reviewed-by: Minwoo Im <minwoo.im.dev at gmail.com>

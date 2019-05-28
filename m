From: thomas.tai@oracle.com (Thomas Tai)
Date: Tue, 28 May 2019 13:47:14 -0400
Subject: [PATCH 0/2] nvme: enable to inject errors into admin commands
In-Reply-To: <1559063018-3682-1-git-send-email-akinobu.mita@gmail.com>
References: <1559063018-3682-1-git-send-email-akinobu.mita@gmail.com>
Message-ID: <8cb23080-b7ab-f773-2d25-e39b36501e3d@oracle.com>

On 5/28/19 1:03 PM, Akinobu Mita wrote:
> Currenlty fault injection support for nvme only enables to inject errors
> into the commands submitted to I/O queues.
> 
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

Hi Akinobu,
That sounds like a good idea. would you kindly update the document in 
Documentation/fault-injection/nvme-fault-injection.txt with your example?

Thank you,
Thomas

> 	...
> 	nvme nvme0: Could not set queue count (16385)
> 	nvme nvme0: IO queues not created
> 
> Akinobu Mita (2):
>    nvme: prepare for fault injection into admin commands
>    nvme: enable to inject errors into admin commands
> 
>   drivers/nvme/host/core.c         |  7 +++++--
>   drivers/nvme/host/fault_inject.c | 33 +++++++++++++++++----------------
>   drivers/nvme/host/nvme.h         | 36 +++++++++++++++++++++---------------
>   3 files changed, 43 insertions(+), 33 deletions(-)
> 
> Cc: Thomas Tai <thomas.tai at oracle.com>
> Cc: Keith Busch <kbusch at kernel.org>
> Cc: Jens Axboe <axboe at fb.com>
> Cc: Christoph Hellwig <hch at lst.de>
> Cc: Sagi Grimberg <sagi at grimberg.me>
> 

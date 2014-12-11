From: axboe@kernel.dk (Jens Axboe)
Date: Thu, 11 Dec 2014 08:20:44 -0700
Subject: [PATCH] NVMe: Fix FS mount issue (hot-remove followed by hot-add)
In-Reply-To: <alpine.LNX.2.00.1412101949260.4026@localhost.lm.intel.com>
References: <1418221540-3696-1-git-send-email-indraneel.m@samsung.com>
 <alpine.LNX.2.00.1412101949260.4026@localhost.lm.intel.com>
Message-ID: <5489B64C.5020209@kernel.dk>

On 12/10/2014 01:00 PM, Keith Busch wrote:
> On Wed, 10 Dec 2014, Indraneel M wrote:
>> After Hot-remove of a device with a mounted partition,
>> when the device is hot-added again, the new node reappears
>> as nvme0n1. Mounting this new node fails with the error:
>>
>> mount: mount /dev/nvme0n1p1 on /mnt failed: File exists.
>>
>> The old nodes's FS entries still exist and the kernel can't re-create
>> procfs and sysfs entries for the new node with the same name.
>> The patch fixes this issue.
>>
>> Signed-off-by: Indraneel M <indraneel.m at samsung.com>
>
> Acked-by: Keith Busch <keith.busch at intel.com>
>
> Now where is this going? It won't apply to linux-block/for-next (though
> it is a trivial manual merge), which I think is where the 3.19 pull
> request to mainline will come from. I hope these trees get synced up
> soon so we don't have these fragmented drivers.

He sent a for-3.19/drivers relevant patch too - I'll add your acked by 
and queue that up.

-- 
Jens Axboe

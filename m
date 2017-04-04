From: axboe@kernel.dk (Jens Axboe)
Date: Tue, 4 Apr 2017 09:50:49 -0600
Subject: [GIT PULL] nvme patches for kernel 4.12 - early merge to
 for-4.12/block
In-Reply-To: <1491300542-7500-1-git-send-email-sagi@grimberg.me>
References: <1491300542-7500-1-git-send-email-sagi@grimberg.me>
Message-ID: <2bbbc11e-7e23-94e2-bc7c-5b9fccb04d3c@kernel.dk>

On 04/04/2017 04:09 AM, Sagi Grimberg wrote:
> Hey Jens,
> 
> We're sending you an early pull request to avoid conflicts of
> some more developments we have going on. We have some more
> stuff in the pipes that will be sent closer to the merge window.
> 
> Here are the highlights:
> - Centralize nvme request completion handlers from Christoph
> - Some nvmet cleanups from Parav
> - Set of nvme-fc updates/cleanups from James
> - IPv6 support for nvme over rdma (with an net/core patch acked
>   by DaveM)
> - Add controller loss timeout functionality for fabrics drivers
>   (similar to scsi's dev_loss_tmo)
> - CPU hotplug fixes in rdma/loop host drivers
> - nvmet-rdma fix possible resource overflow under heavy rate of
>   queues establishment/teardown
> - Bunch of other cleanups for fabrics drivers

I pulled this in manually, as it throws a conflict in loop.c.
Please check that for-4.12/block and for-next look like you
expect them to.

-- 
Jens Axboe

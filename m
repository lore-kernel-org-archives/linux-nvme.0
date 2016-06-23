From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 23 Jun 2016 18:50:31 +0300
Subject: [PATCH 0/1] Fix for nvme-rdma host crash in nvmf-all.3
In-Reply-To: <004f01d1cd57$85fc0530$91f40f90$@opengridcomputing.com>
References: <cover.1466626499.git.swise@opengridcomputing.com>
 <576B8FB7.5000305@grimberg.me>
 <004f01d1cd57$85fc0530$91f40f90$@opengridcomputing.com>
Message-ID: <576C0547.4060403@grimberg.me>


>>> This patch fixes a touch-after-free bug I discovered.  It is against
>>> nvmf-all.3 branch of git://git.infradead.org/nvme-fabrics.git.  The patch
>>> is kind of ugly, so any ideas on a cleaner solution are welcome.
>>
>> Hey Steve, I don't see how this bug fixes the root-cause. Not exactly
>> sure we understand the root-cause. Is it possible that this is a chelsio
>> specific issue with send completion signaling (like we saw before)? Did
>> this happen with a non-chelsio device?
>
> Due to the stack trace, I believe this is a similar issue we saw before.  It is
> probably chelsio-specific.  I don't see it on mlx4.
>
> The fix for the previous occurrence of this crash was to signal all FLUSH
> commands.  Do you recall why that fixed it?  Perhaps this failure path needs
> some other signaled command to force the pending unsignaled WRs to be marked
> "complete" by the driver?

OK, so as discussed off-list signaling connect sends resolves the issue.
My recollection was that when the Chelsio queue-pair transitions to
error/drain state, the cxgb4 driver does not know which sends were
completed without the completion signal causing it to complete it again
and the wr_cqe might have been already freed. I assume the same is going
on here as we free the tag set before draining the qp...

From: maxg@mellanox.com (Max Gurtovoy)
Date: Tue, 4 Jun 2019 16:33:08 +0300
Subject: [Suspected-Phishing]Re: [PATCH] Revert "nvme-rdma: remove
 redundant reference between ib_device and tagset"
In-Reply-To: <d2a20c0f-092d-28ca-3365-1fb5df2cb816@mellanox.com>
References: <20190603231159.17034-1-sagi@grimberg.me>
 <b98d3c8f-85ee-06f2-b47a-a3e04261c0d1@grimberg.me>
 <F4E18075-01AA-443B-BF43-23A4BA80C10C@intel.com>
 <d2a20c0f-092d-28ca-3365-1fb5df2cb816@mellanox.com>
Message-ID: <b4a79dfe-ffc8-0571-9f54-cf5b98c21500@mellanox.com>

James,

can you test the attached patch (without the revert) ?

-Max.

On 6/4/2019 2:11 PM, Max Gurtovoy wrote:
> Hi Sagi/Christoph,
>
> please don't revert this commit yet on the branch. I'm sending a fix 
> to it in 1 hour for James approval.
>
> -Max.
>
> On 6/4/2019 2:26 AM, Harris, James R wrote:
>>
>> ?On 6/3/19, 4:14 PM, "Sagi Grimberg" <sagi@grimberg.me> wrote:
>>
>> ???? ???? > This commit caused a kernel panic when disconnecting from an
>> ???? > inaccessible controller.
>> ???? >
>> ???? > --
>> ???? > nvme nvme0: Removing ctrl: NQN "testnqn1"
>> ???? > nvme_rdma: nvme_rdma_exit_request: hctx 0 queue_idx 1
>> ???? > BUG: unable to handle kernel paging request at 0000000080000228
>> ???? > PGD 0 P4D 0
>> ???? > Oops: 0000 [#1] SMP PTI
>> ???? > ...
>> ???? > Call Trace:
>> ???? >?? blk_mq_exit_hctx+0x5c/0xf0
>> ???? >?? blk_mq_exit_queue+0xd4/0x100
>> ???? >?? blk_cleanup_queue+0x9a/0xc0
>> ???? >?? nvme_rdma_destroy_io_queues+0x52/0x60 [nvme_rdma]
>> ???? >?? nvme_rdma_shutdown_ctrl+0x3e/0x80 [nvme_rdma]
>> ???? >?? nvme_do_delete_ctrl+0x53/0x80 [nvme_core]
>> ???? >?? nvme_sysfs_delete+0x45/0x60 [nvme_core]
>> ???? >?? kernfs_fop_write+0x105/0x180
>> ???? >?? vfs_write+0xad/0x1a0
>> ???? >?? ksys_write+0x5a/0xd0
>> ???? >?? do_syscall_64+0x55/0x110
>> ???? >?? entry_SYSCALL_64_after_hwframe+0x44/0xa9
>> ???? > RIP: 0033:0x7fa215417154
>> ???? > --
>> ???? >
>> ???? ???? Should add:
>> ???? Reported-by: Harris, James R <james.r.harris at intel.com>
>>
>> Thanks Sagi.? I can confirm that reverting this patch eliminated the 
>> kernel panic on my system.
>> ???? ???? > Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
>>
>
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> https://eur03.safelinks.protection.outlook.com/?url=http%3A%2F%2Flists.infradead.org%2Fmailman%2Flistinfo%2Flinux-nvme&amp;data=02%7C01%7Cmaxg%40mellanox.com%7Cefd64e8278674d90875208d6e8dd7d41%7Ca652971c7d2e4d9ba6a4d149256f461b%7C0%7C0%7C636952435329842439&amp;sdata=aqbBsIOPBLK7nGhvgLAPB%2FiQoR0QzEie%2FWPpL5fE%2BYY%3D&amp;reserved=0 
>
-------------- next part --------------

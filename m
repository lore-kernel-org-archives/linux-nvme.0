From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 5 Jun 2019 10:27:16 -0700
Subject: [PATCH 1/1] nvme-rdma: use dynamic dma mapping per command
In-Reply-To: <1559749293-32649-1-git-send-email-maxg@mellanox.com>
References: <1559749293-32649-1-git-send-email-maxg@mellanox.com>
Message-ID: <f474d61c-a3e4-1452-99fb-6e7164f05194@grimberg.me>



On 6/5/19 8:41 AM, Max Gurtovoy wrote:
> Commit 87fd125344d6 ("nvme-rdma: remove redundant reference between
> ib_device and tagset") caused a kernel panic when disconnecting from an
> inaccessible controller (disconnect during re-connection).
> 
> --
> nvme nvme0: Removing ctrl: NQN "testnqn1"
> nvme_rdma: nvme_rdma_exit_request: hctx 0 queue_idx 1
> BUG: unable to handle kernel paging request at 0000000080000228
> PGD 0 P4D 0
> Oops: 0000 [#1] SMP PTI
> ...
> Call Trace:
>   blk_mq_exit_hctx+0x5c/0xf0
>   blk_mq_exit_queue+0xd4/0x100
>   blk_cleanup_queue+0x9a/0xc0
>   nvme_rdma_destroy_io_queues+0x52/0x60 [nvme_rdma]
>   nvme_rdma_shutdown_ctrl+0x3e/0x80 [nvme_rdma]
>   nvme_do_delete_ctrl+0x53/0x80 [nvme_core]
>   nvme_sysfs_delete+0x45/0x60 [nvme_core]
>   kernfs_fop_write+0x105/0x180
>   vfs_write+0xad/0x1a0
>   ksys_write+0x5a/0xd0
>   do_syscall_64+0x55/0x110
>   entry_SYSCALL_64_after_hwframe+0x44/0xa9
> RIP: 0033:0x7fa215417154
> --
> 
> The reason for this crash is accessing an already freed ib_device for
> performing dma_unmap during exit_request commands. The root cause for
> that is that during re-connection all the queues are destroyed and
> re-created (and the ib_device is reference counted by the queues and
> freed as well) but the tagset stays alive and all the DMA mappings (that
> we perform in init_request) kept in the request context. The original
> commit fixed a different bug that was introduced during bonding (aka nic
> teaming) tests that for some scenarios change the underlying ib_device
> and caused memory leakage and possible segmentation fault. This commit
> is a complementry

Complementary

  commit that also changes the wrong DMA mappings that
> were saved in the request context

also making the request sqe dma mappings dynamic with the
command lifetime (i.e. mapped in .queue_rq and unmapped in .complete).

  and also fixes the above crash of
> accessing freed ib_device during destruction of the tagset.
> 
> Fixes: 87fd125344d6 ("nvme-rdma: remove redundant reference between ib_device and tagset")
> Suggested-by: Sagi Grimberg <sagi at grimberg.me>
> Tested-by: Jim Harris <james.r.harris at intel.com>
> Signed-off-by: Max Gurtovoy <maxg at mellanox.com>
> ---
>   drivers/nvme/host/rdma.c | 76 ++++++++++++++++++++++++++++++------------------
>   1 file changed, 47 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> index 0e033b6..88f11c5 100644
> --- a/drivers/nvme/host/rdma.c
> +++ b/drivers/nvme/host/rdma.c
> @@ -167,15 +167,17 @@ static inline size_t nvme_rdma_inline_data_size(struct nvme_rdma_queue *queue)
>   	return queue->cmnd_capsule_len - sizeof(struct nvme_command);
>   }
>   
> -static void nvme_rdma_free_qe(struct ib_device *ibdev, struct nvme_rdma_qe *qe,
> -		size_t capsule_size, enum dma_data_direction dir)
> +static void nvme_rdma_free_mapped_qe(struct ib_device *ibdev,
> +		struct nvme_rdma_qe *qe, size_t capsule_size,
> +		enum dma_data_direction dir)

Given that we directly allocate the sqe in .init_request and not call
this, is there really a need to change the name of the function?

It creates a bit of an unnecessary churn in the patch.

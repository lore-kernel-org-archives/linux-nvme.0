From: swise@opengridcomputing.com (Steve Wise)
Date: Thu, 15 Sep 2016 11:45:43 -0500
Subject: nvmf/rdma host crash during heavy load and keep alive recovery
In-Reply-To: <01d201d20f69$449abce0$cdd036a0$@opengridcomputing.com>
References: <018301d1e9e1$da3b2e40$8eb18ac0$@opengridcomputing.com>
 <008101d1f3de$557d2850$007778f0$@opengridcomputing.com>
 <00fe01d1f3e8$8992b330$9cb81990$@opengridcomputing.com>
 <01c301d1f702$d28c7270$77a55750$@opengridcomputing.com>
 <6ef9b0d1-ce84-4598-74db-7adeed313bb6@grimberg.me>
 <045601d1f803$a9d73a20$fd85ae60$@opengridcomputing.com>
 <69c0e819-76d9-286b-c4fb-22f087f36ff1@grimberg.me>
 <08b701d1f8ba$a709ae10$f51d0a30$@opengridcomputing.com>
 <01c301d20485$0dfcd2c0$29f67840$@opengridcomputing.com> <0c159abb
 -24ee-21bf-09d2-9fe7d2 69a2eb@grimberg.me>
 <039401d2094c$084d64e0$18e82ea0$@opengridcomputing.com>
 <7f09e373-6316-26a3-ae81-dab1205d88ab@grimbe rg.me> <021201d20a14$ 0
 f203b80$2d60b280$@opengridcomputing.com>
 <021401d20a16$ed60d470$c8227d50$@opengridcomputing.com>
 <021501d20a19$327ba5b0$9772f110$@opengridcomputing.com>
 <00ab01d20ab1$ed212ff0$c7638fd0$@opengridcomputing.com>
 <022701d20d31$a9645850$fc2d08f0$@opengridcomputing.com>
 <da2e918b-0f18-e032-272d-368c6ec49c62@gri mberg.me> <011501d20f
 5f$b94e6c80$2beb4580$@opengridcomputing.com>
 <012001d20f63$5c8f7490$15ae5db0$@opengridcomputing.com>
 <01d201d20f69$449abce0$cdd036a0$@opengridcomputing.com>
Message-ID: <020001d20f70$9998fde0$cccaf9a0$@opengridcomputing.com>

> And I see that 2 sets of blk_mq_hw_ctx structs get assigned to the same 32
> queues.  Here is the output for 1 target connect with 32 cores.  So is it
> expected that the 32 nvme_rdma IO queues get assigned to 2 sets of hw_ctx
> structs?  The 2nd set is getting initialized as part of namespace scanning...


So here is the stack for the first time the nvme_rdma_queue structs are bound to
an hctx:

[ 2006.826941]  [<ffffffffa066c452>] nvme_rdma_init_hctx+0x102/0x110 [nvme_rdma]
[ 2006.835409]  [<ffffffff8133a52e>] blk_mq_init_hctx+0x21e/0x2e0
[ 2006.842530]  [<ffffffff8133a6ea>] blk_mq_realloc_hw_ctxs+0xfa/0x240
[ 2006.850097]  [<ffffffff8133b342>] blk_mq_init_allocated_queue+0x92/0x410
[ 2006.858107]  [<ffffffff8132a969>] ? blk_alloc_queue_node+0x259/0x2c0
[ 2006.865765]  [<ffffffff8133b6ff>] blk_mq_init_queue+0x3f/0x70
[ 2006.872829]  [<ffffffffa066d9f9>] nvme_rdma_create_io_queues+0x189/0x210
[nvme_rdma]
[ 2006.881917]  [<ffffffffa066e813>] ?
nvme_rdma_configure_admin_queue+0x1e3/0x290 [nvme_rdma]
[ 2006.891611]  [<ffffffffa066ec65>] nvme_rdma_create_ctrl+0x3a5/0x4c0
[nvme_rdma]
[ 2006.900260]  [<ffffffffa0654d33>] ? nvmf_create_ctrl+0x33/0x210
[nvme_fabrics]
[ 2006.908799]  [<ffffffffa0654e82>] nvmf_create_ctrl+0x182/0x210 [nvme_fabrics]
[ 2006.917228]  [<ffffffffa0654fbc>] nvmf_dev_write+0xac/0x110 [nvme_fabrics]

And here is the 2nd time the same nvme_rdma_queue is bound to a different hctx::

[ 2007.263068]  [<ffffffffa066c40c>] nvme_rdma_init_hctx+0xbc/0x110 [nvme_rdma]
[ 2007.271656]  [<ffffffff8133a52e>] blk_mq_init_hctx+0x21e/0x2e0
[ 2007.279027]  [<ffffffff8133a6ea>] blk_mq_realloc_hw_ctxs+0xfa/0x240
[ 2007.286829]  [<ffffffff8133b342>] blk_mq_init_allocated_queue+0x92/0x410
[ 2007.295066]  [<ffffffff8132a969>] ? blk_alloc_queue_node+0x259/0x2c0
[ 2007.302962]  [<ffffffff8135ce84>] ? ida_pre_get+0xb4/0xe0
[ 2007.309894]  [<ffffffff8133b6ff>] blk_mq_init_queue+0x3f/0x70
[ 2007.317164]  [<ffffffffa0272998>] nvme_alloc_ns+0x88/0x240 [nvme_core]
[ 2007.325218]  [<ffffffffa02728bc>] ? nvme_find_get_ns+0x5c/0xb0 [nvme_core]
[ 2007.333612]  [<ffffffffa0273059>] nvme_validate_ns+0x79/0x90 [nvme_core]
[ 2007.341825]  [<ffffffffa0273166>] nvme_scan_ns_list+0xf6/0x1f0 [nvme_core]
[ 2007.350214]  [<ffffffffa027338b>] nvme_scan_work+0x12b/0x140 [nvme_core]
[ 2007.358427]  [<ffffffff810a1613>] process_one_work+0x183/0x4d0

Is this expected?

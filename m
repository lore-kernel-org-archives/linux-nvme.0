From: Bart.VanAssche@sandisk.com (Bart Van Assche)
Date: Mon, 20 Feb 2017 17:03:15 +0000
Subject: [PATCHv2 1/2] nvme-rdma: move nvme cm status helper to .h file
References: <1487591069-6261-1-git-send-email-maxg@mellanox.com>
Message-ID: <1D08B61A9CF0974AA09887BE32D889DA0A9949@ULS-OP-MBXIP03.sdcorp.global.sandisk.com>

On 02/20/2017 03:44 AM, Max Gurtovoy wrote:
> This will enable the usage for nvme rdma target.
> Also move from a lookup array to a switch statement.

Hello Max,

In general un-inlining code that is not in the hot path is wrong because
this increases the size of the kernel and because this increases the
time needed to build the kernel. Would it have been possible to keep the
nvme_rdma_cm_msg() definition in a .c file?

Thanks,

Bart.

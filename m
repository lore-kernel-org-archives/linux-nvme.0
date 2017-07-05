From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Wed, 5 Jul 2017 09:59:05 +0200
Subject: [PATCH 1/1] blk-mq: map all HWQ also in hyperthreaded system
In-Reply-To: <1498653880-29223-1-git-send-email-maxg@mellanox.com>
References: <1498653880-29223-1-git-send-email-maxg@mellanox.com>
Message-ID: <20170705075905.GB4076@linux-x5ow.site>

On Wed, Jun 28, 2017@03:44:40PM +0300, Max Gurtovoy wrote:
> This patch performs sequential mapping between CPUs and queues.
> In case the system has more CPUs than HWQs then there are still
> CPUs to map to HWQs. In hyperthreaded system, map the unmapped CPUs
> and their siblings to the same HWQ.
> This actually fixes a bug that found unmapped HWQs in a system with
> 2 sockets, 18 cores per socket, 2 threads per core (total 72 CPUs)
> running NVMEoF (opens upto maximum of 64 HWQs).

Christoph/Sagi/Keith,

any updates on this patch? Without it I' not able to run NVMf on a box with 44
Cores and 88 Threads w/o adding -i 44 to the nvme connect statement.

Thanks,
	Johannes

-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850

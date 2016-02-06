From: wenbo.wang@memblaze.com (Wenbo Wang)
Date: Sat, 6 Feb 2016 14:32:24 +0000
Subject: [PATCH] NVMe: do not touch sq door bell if nvmeq has been
 suspended
In-Reply-To: <20160203163808.GC23910@localhost.localdomain>
References: <1454341324-21273-1-git-send-email-mail_weber_wang@163.com>
 <56AF8DB5.70206@fb.com>
 <BJXPR01MB19940BA759DBBADC6BF6BD2E0DF0@BJXPR01MB199.CHNPR01.prod.partner.outlook.cn>
 <20160203144123.GB23910@localhost.localdomain>
 <BJXPR01MB1992FFD0706FCD368F5AD16E0D00@BJXPR01MB199.CHNPR01.prod.partner.outlook.cn>
 <20160203163808.GC23910@localhost.localdomain>
Message-ID: <BJXPR01MB19916231021454BD8731EBDE0D30@BJXPR01MB199.CHNPR01.prod.partner.outlook.cn>

Keith,

Is the following solution OK?
synchronize_rcu guarantee that no queue_rq is running concurrently with device disable code. Together with your another patch (adding blk_sync_queue), both sync/async path shall be handled correctly.

Do you think synchronize_rcu shall be added to blk_sync_queue?

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 4c0622f..bfe9132 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -865,7 +865,9 @@ void blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async)
        if (!async) {
                int cpu = get_cpu();
                if (cpumask_test_cpu(cpu, hctx->cpumask)) {
+                       rcu_read_lock();
                        __blk_mq_run_hw_queue(hctx);
+                       rcu_read_unlock();
                        put_cpu();
                        return;
                }

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 8b1a725..d1e5e63 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1861,6 +1861,7 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
                nvme_disable_io_queues(dev);
                nvme_disable_admin_queue(dev, shutdown);
        }
+       synchronize_rcu();
        nvme_dev_unmap(dev);

        for (i = dev->queue_count - 1; i >= 0; i--)

-----Original Message-----
From: Keith Busch [mailto:keith.busch@intel.com] 
Sent: Thursday, February 4, 2016 12:38 AM
To: Wenbo Wang
Cc: Jens Axboe; Wenbo Wang; linux-kernel at vger.kernel.org; linux-nvme at lists.infradead.org; Wenwei.Tao
Subject: Re: [PATCH] NVMe: do not touch sq door bell if nvmeq has been suspended

On Wed, Feb 03, 2016@04:35:03PM +0000, Wenbo Wang wrote:
> For async io (executed by run_work worker) it should work. However for sync io in blk_mq_run_hw_queue, this seems not help, there is still a window.

Alright, for lack of a better way to sync a stopped queue, the driver's indication looks like the best we can do at this point.

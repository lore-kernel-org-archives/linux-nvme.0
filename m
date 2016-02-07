From: sagig@dev.mellanox.co.il (Sagi Grimberg)
Date: Sun, 7 Feb 2016 15:41:53 +0200
Subject: [PATCH] NVMe: do not touch sq door bell if nvmeq has been
 suspended
In-Reply-To: <BJXPR01MB19916231021454BD8731EBDE0D30@BJXPR01MB199.CHNPR01.prod.partner.outlook.cn>
References: <1454341324-21273-1-git-send-email-mail_weber_wang@163.com>
 <56AF8DB5.70206@fb.com>
 <BJXPR01MB19940BA759DBBADC6BF6BD2E0DF0@BJXPR01MB199.CHNPR01.prod.partner.outlook.cn>
 <20160203144123.GB23910@localhost.localdomain>
 <BJXPR01MB1992FFD0706FCD368F5AD16E0D00@BJXPR01MB199.CHNPR01.prod.partner.outlook.cn>
 <20160203163808.GC23910@localhost.localdomain>
 <BJXPR01MB19916231021454BD8731EBDE0D30@BJXPR01MB199.CHNPR01.prod.partner.outlook.cn>
Message-ID: <56B749A1.8030504@dev.mellanox.co.il>


> Keith,
>
> Is the following solution OK?
> synchronize_rcu guarantee that no queue_rq is running concurrently with device disable code.
> Together with your another patch (adding blk_sync_queue), both sync/async path shall be handled correctly.

This can be acceptable I think.

> Do you think synchronize_rcu shall be added to blk_sync_queue?

Or, we'll add it to blk_mq_stop_hw_queues() and then scsi
will enjoy it as well.

> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 4c0622f..bfe9132 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -865,7 +865,9 @@ void blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async)
>          if (!async) {
>                  int cpu = get_cpu();
>                  if (cpumask_test_cpu(cpu, hctx->cpumask)) {
> +                       rcu_read_lock();
>                          __blk_mq_run_hw_queue(hctx);
> +                       rcu_read_unlock();

I think the rcu is better folded into __blk_mq_run_hw_queue
to cover all the call sites.

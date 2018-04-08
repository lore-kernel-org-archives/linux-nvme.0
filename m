From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun, 8 Apr 2018 13:36:27 +0300
Subject: BUG at IP: blk_mq_get_request+0x23e/0x390 on 4.16.0-rc7
In-Reply-To: <256ebbe9-d932-a826-977b-5a5cb8483755@redhat.com>
References: <10632862.17524551.1522402353418.JavaMail.zimbra@redhat.com>
 <682acdbe-7624-14d6-36e0-e2dd4c6b771f@grimberg.me>
 <256ebbe9-d932-a826-977b-5a5cb8483755@redhat.com>
Message-ID: <ebdf8c7f-ae42-a08f-0d79-d2d4f17ec117@grimberg.me>


> Hi Sagi
> 
> Still can reproduce this issue with the change:

Thanks for validating Yi,

Would it be possible to test the following:
--
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 75336848f7a7..81ced3096433 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -444,6 +444,10 @@ struct request *blk_mq_alloc_request_hctx(struct 
request_queue *q,
                 return ERR_PTR(-EXDEV);
         }
         cpu = cpumask_first_and(alloc_data.hctx->cpumask, cpu_online_mask);
+       if (cpu >= nr_cpu_ids) {
+               pr_warn("no online cpu for hctx %d\n", hctx_idx);
+               cpu = cpumask_first(alloc_data.hctx->cpumask);
+       }
         alloc_data.ctx = __blk_mq_get_ctx(q, cpu);

         rq = blk_mq_get_request(q, NULL, op, &alloc_data);
--
...


> [? 153.384977] BUG: unable to handle kernel paging request at 
> 00003a9ed053bd48
> [? 153.393197] IP: blk_mq_get_request+0x23e/0x390

Also would it be possible to provide gdb output of:

l *(blk_mq_get_request+0x23e)

Thanks,

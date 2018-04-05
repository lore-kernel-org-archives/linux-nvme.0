From: keith.busch@intel.com (Keith Busch)
Date: Thu, 5 Apr 2018 16:41:39 -0600
Subject: IRQ/nvme_pci_complete_rq: NULL pointer dereference yet again
In-Reply-To: <719ea777-e57d-511e-52c5-cf83027d1fd0@gmail.com>
References: <5d6d1a8c-6490-4046-0fba-da0a0df3d00c@gmail.com>
 <20180405213847.GG10098@localhost.localdomain>
 <20180405212205.33dqwqck2co25a3x@sbauer-Z170X-UD5>
 <719ea777-e57d-511e-52c5-cf83027d1fd0@gmail.com>
Message-ID: <20180405224138.GH10098@localhost.localdomain>

On Thu, Apr 05, 2018@05:21:29PM -0500, Alex G. wrote:
> All you have to do is say CONFIG_KASAN=y. It took almost no time at all
> to trigger. The serial port is still stuck spewing out the logs, but the
> ssh logger has them.
> 
> I've had to put the full log somewhere else[1], as it's way too big for
> an email.
> 
> Alex
> http://gtech.myftp.org/~mrnuke/nvme_logs/log-20180405-1705.log

I take it this doesn't happen without the MD raid. Could you try with
the following patch?

---
diff --git a/drivers/md/dm-rq.c b/drivers/md/dm-rq.c
index bf0b840645cc..d377643b5d06 100644
--- a/drivers/md/dm-rq.c
+++ b/drivers/md/dm-rq.c
@@ -366,7 +366,7 @@ static void dm_complete_request(struct request *rq, blk_status_t error)
 	if (!rq->q->mq_ops)
 		blk_complete_request(rq);
 	else
-		blk_mq_complete_request(rq);
+		blk_mq_end_request(rq);
 }
 
 /*
--

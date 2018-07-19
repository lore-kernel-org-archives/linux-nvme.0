From: Bart.VanAssche@wdc.com (Bart Van Assche)
Date: Thu, 19 Jul 2018 16:04:46 +0000
Subject: [RFC PATCH 3/3] blk-mq: Remove generation seqeunce
In-Reply-To: <20180719155616.GG32160@localhost.localdomain>
References: <a32b251bd3c0a186e5c5ba82656a85fbdcc0c5e4.camel@wdc.com>
 <20180713184712.GA19419@localhost.localdomain>
 <291a13b35af1b65fbbe99a3a9cfc7d570a620cd9.camel@wdc.com>
 <20180713235807.GA19967@localhost.localdomain>
 <20180718195650.GA20336@lst.de>
 <20180718205321.GA32160@localhost.localdomain>
 <c67f3da64914a436bc76f3ec0bc261ee6178cd14.camel@wdc.com>
 <20180718211711.GB32160@localhost.localdomain>
 <20180719131903.GB13129@lst.de>
 <20180719145931.GF32160@localhost.localdomain>
 <20180719155616.GG32160@localhost.localdomain>
Message-ID: <7239f833438701fb6ce21d819bc7042af1bc1f8a.camel@wdc.com>

On Thu, 2018-07-19@09:56 -0600, Keith Busch wrote:
> Even some scsi drivers are susceptible to losing their requests with the
> reverted behavior: take virtio-scsi for example, which returns RESET_TIMER
> from it's timeout handler. With the behavior everyone seems to want,
> a natural completion at or around the same time is lost forever because
> it was blocked from completion with no way to recover.

The patch I had posted handles a completion that occurs while a timeout is
being handled properly. From https://www.mail-archive.com/linux-block at vger.kernel.org/msg22196.html:

 void blk_mq_complete_request(struct request *rq)
[ ... ]
+               if (blk_mq_change_rq_state(rq, MQ_RQ_IN_FLIGHT,
+                                          MQ_RQ_COMPLETE)) {
+                       __blk_mq_complete_request(rq);
+                       break;
+               }
+               if (blk_mq_change_rq_state(rq, MQ_RQ_TIMED_OUT, MQ_RQ_COMPLETE))
+                       break;
[ ... ]
@@ -838,25 +838,42 @@ static void blk_mq_rq_timed_out(struct request *req, bool reserved)
[ ... ]
        case BLK_EH_RESET_TIMER:
[ ... ]
+                       if (blk_mq_rq_state(req) == MQ_RQ_COMPLETE) {
+                               __blk_mq_complete_request(req);
+                               break;
+                       }

Bart.

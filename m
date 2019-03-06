From: kbusch@kernel.org (Keith Busch)
Date: Wed, 6 Mar 2019 11:53:41 -0700
Subject: Interesting 'list _add double add' with nvme drives
In-Reply-To: <e15de0114ffc415899aadc2d0aae418b@ausx13mps317.AMER.DELL.COM>
References: <e15de0114ffc415899aadc2d0aae418b@ausx13mps317.AMER.DELL.COM>
Message-ID: <20190306185341.GA1337@localhost.localdomain>

On Wed, Mar 06, 2019@06:48:28PM +0000, Alex_Gagniuc@Dellteam.com wrote:
> Hi,
> 
> I'm seeing a list error when we take away, then add back a bunch of nvme 
> drives. It's not very easy to repro, and the one surviving log is pasted 
> below.

This looks like a double completion coming from the busy request
iterator. I'm suspcious it's because that iterator considers
MQ_RQ_COMPLETE requests as "started". That doesn't really make much sense,
and I can't find a single user of this interface that actually wants to
see such requests in their callbacks.

I know you said it's difficult to repro, but could you see if the
following makes it go away?

---
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 54535f4c4570..0ddcac44f912 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -659,7 +659,7 @@ EXPORT_SYMBOL(blk_mq_complete_request);
 
 int blk_mq_request_started(struct request *rq)
 {
-	return blk_mq_rq_state(rq) != MQ_RQ_IDLE;
+	return blk_mq_rq_state(rq) == MQ_RQ_IN_FLIGHT;
 }
 EXPORT_SYMBOL_GPL(blk_mq_request_started);
 
--

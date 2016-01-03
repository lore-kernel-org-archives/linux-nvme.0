From: keith.busch@intel.com (Keith Busch)
Date: Sun, 3 Jan 2016 18:04:12 +0000
Subject: [PATCH 5/5] NVMe: IO queue deletion re-write
In-Reply-To: <20160103162625.GB31375@localhost.localdomain>
References: <1451496471-29370-1-git-send-email-keith.busch@intel.com>
 <1451496471-29370-6-git-send-email-keith.busch@intel.com>
 <20151230180430.GA12828@infradead.org>
 <20151230190706.GC12454@localhost.localdomain>
 <20160102170730.GA30184@infradead.org>
 <20160102213008.GA10969@localhost.localdomain>
 <20160103114052.GA24893@infradead.org>
 <20160103154331.GA31375@localhost.localdomain>
 <20160103161704.GA5111@infradead.org>
 <20160103162625.GB31375@localhost.localdomain>
Message-ID: <20160103180412.GC31375@localhost.localdomain>

On Sun, Jan 03, 2016@04:26:25PM +0000, Keith Busch wrote:
> In the scenario I'm describing you _don't_ want it to succeed in getting
> a request. You don't want it to wait indefinitely for one either.

I may be doing a bad job explaining this scenario. I'm sure it'll make
sense if you synthesize it.

Here's one way: run qemu with this patch and "-smp" set to 8. In the
linux nvme driver, set NVME_AQ_DEPTH to something lower than 8, like
4. Then reset the controller in the guest. This will fake an unresponsive
controller during reset.

---
diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 169e4fa..6433337 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -305,6 +305,7 @@ static uint16_t nvme_del_sq(NvmeCtrl *n, NvmeCmd *cmd)
     if (!qid || nvme_check_sqid(n, qid)) {
         return NVME_INVALID_QID | NVME_DNR;
     }
+    return NVME_NO_COMPLETE;
 
     sq = n->sq[qid];
     while (!QTAILQ_EMPTY(&sq->out_req_list)) {
--

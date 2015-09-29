From: keith.busch@intel.com (Keith Busch)
Date: Tue, 29 Sep 2015 20:03:06 +0000 (UTC)
Subject: [PATCH] NVMe: Prevent bogus synchronous IO command timeouts.
In-Reply-To: <BL2PR04MB163B7D4ED51C81B2A964344924E0@BL2PR04MB163.namprd04.prod.outlook.com>
References: <BL2PR04MB163B7D4ED51C81B2A964344924E0@BL2PR04MB163.namprd04.prod.outlook.com>
Message-ID: <alpine.LNX.2.00.1509291952040.23840@localhost.lm.intel.com>

On Tue, 29 Sep 2015, Jeffrey Lien wrote:
> Attached the patch since I can't get it sent via send-email.

If possible, you will want to remove the confidentiality disclaimer from
emails to public lists.

On your patch, I think it will be very bad for performance. We can
achieve the protection you're going for without spinlocks and use memory
barriers instead. What do you think for the following?

---
diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 78e51c2..2d21827 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -200,9 +200,10 @@ static int alloc_cmdid(struct nvme_queue *nvmeq, void *ctx,
  	} while (test_and_set_bit(cmdid, nvmeq->cmdid_data));

  	info[cmdid].fn = handler;
-	info[cmdid].ctx = ctx;
  	info[cmdid].timeout = jiffies + timeout;
  	info[cmdid].aborted = 0;
+	wmb();
+	info[cmdid].ctx = ctx;
  	return cmdid;
  }

@@ -1354,9 +1355,9 @@ static void nvme_cancel_ios(struct nvme_queue *nvmeq, bool timeout)
  			.status = cpu_to_le16(NVME_SC_ABORT_REQ << 1),
  		};

-		if (timeout && !time_after(now, info[cmdid].timeout))
+		if (info[cmdid].ctx == CMD_CTX_CANCELLED || info[cmdid].ctx == CMD_CTX_COMPLETED)
  			continue;
-		if (info[cmdid].ctx == CMD_CTX_CANCELLED)
+		if (timeout && !time_after(now, info[cmdid].timeout))
  			continue;
  		if (timeout && info[cmdid].ctx == CMD_CTX_ASYNC)
  			continue;
--

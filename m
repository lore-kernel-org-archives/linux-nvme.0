From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 20 Apr 2017 23:52:46 -0700
Subject: [PATCH] nvme:let dm-mpath distinguish nvme error codes,no retry
In-Reply-To: <1492521592-20648-1-git-send-email-guanjunxiong@huawei.com>
References: <1492521592-20648-1-git-send-email-guanjunxiong@huawei.com>
Message-ID: <20170421065246.GA3817@infradead.org>

Hi Guang,

I'll need your Signed-off-by to apply this patch.

Also I'd like to update subject and comments a bit, are you fine with
the version below?

---
>From 7a252de505d4327a93fecf321c72691b14caa727 Mon Sep 17 00:00:00 2001
From: Junxiong Guan <guanjunxiong@huawei.com>
Date: Tue, 18 Apr 2017 21:19:52 +0800
Subject: nvme: let dm-mpath distinguish nvme error codes

Currently most IOs which return the nvme error codes are retried on
the other path if those IOs returns EIO from NVMe driver. This
patch let Multipath distinguish nvme media error codes and some
generic or cmd-specific nvme error codes so that multipath will
not retry those kinds of IO, to save bandwidth.

---
 drivers/nvme/host/core.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 8dc664798293..263946b23628 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -75,6 +75,20 @@ static int nvme_error_status(struct request *req)
 		return -ENOSPC;
 	default:
 		return -EIO;
+
+	/*
+	 * XXX: these errors are a nasty side-band protocol to
+	 * drivers/md/dm-mpath.c:noretry_error() that aren't documented
+	 * anywhere..
+	 */
+	case NVME_SC_CMD_SEQ_ERROR:
+		return -EILSEQ;
+	case NVME_SC_ONCS_NOT_SUPPORTED:
+		return -EOPNOTSUPP;
+	case NVME_SC_WRITE_FAULT:
+	case NVME_SC_READ_ERROR:
+	case NVME_SC_UNWRITTEN_BLOCK:
+		return -ENODATA;
 	}
 }
 
-- 
2.11.0

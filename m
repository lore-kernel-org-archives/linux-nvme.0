From: guanjunxiong@huawei.com (Guan Junxiong)
Date: Fri, 21 Apr 2017 18:43:33 +0800
Subject: [PATCH] nvme:let dm-mpath distinguish nvme error codes,no retry
In-Reply-To: <20170421065246.GA3817@infradead.org>
References: <1492521592-20648-1-git-send-email-guanjunxiong@huawei.com>
 <20170421065246.GA3817@infradead.org>
Message-ID: <041af0d7-371f-072b-4b64-906e793b719f@huawei.com>


Hi Christoph,
  Thanks for your review.

On 2017/4/21 14:52, Christoph Hellwig wrote:
> Hi Guang,
>
> I'll need your Signed-off-by to apply this patch.
>
> Also I'd like to update subject and comments a bit, are you fine with
> the version below?
>


 It's fine.  I have signed-off-by the previous patch as the version below.
 It would be nice that you would apply this version.


---
>From 23d7fd1b4b3d61d404d5562aab32d8a7ff7d72e4 Mon Sep 17 00:00:00 2001
From: Junxiong Guan <guanjunxiong@huawei.com>
Date: Tue, 18 Apr 2017 21:19:52 +0800
Subject: [PATCH] nvme: let dm-mpath distinguish nvme error codes

Currently most IOs which return the nvme error codes are retried on
the other path if those IOs returns EIO from NVMe driver. This
patch let Multipath distinguish nvme media error codes and some
generic or cmd-specific nvme error codes so that multipath will
not retry those kinds of IO, to save bandwidth.

Signed-off-by: Junxiong Guan <guanjunxiong at huawei.com>
---
 drivers/nvme/host/core.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 9bf758e3c911..6dcd7a123b50 100644
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
2.11.1

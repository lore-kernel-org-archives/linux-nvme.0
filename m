Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2451C54E67
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Mar 2024 00:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8+FRkzHNc+9dwWUd0DemLjToWIPnwS4In9kEpqUayJg=; b=MoBidzdIDiDQcmvMK6obZ1hF3A
	ObEdR5aD51UVajLPmgipqyfq79Ln+OGZpEMwusbFSY6mIIIar+1J12FBJin7yiX3crC7C4ddnwfvU
	+oUZtJYWaiz5KrUDUhbLUwvGHRug6IBMkNY/tG1gC+JRVe8DnJikoEjIpSjbbaTinSGbin2ky1Lq6
	n/yo3s7TBa2HREO3J4OsWSNU/cXUe+tmrXinHL3w/b6IqcCheH66OwuwigDU/qd6kb1xMv+EWqauI
	kfVhc81/zadnBkWjw6vKGaJAxyjXkbTpgdblWCRq+eTaS+HjYMGl6qMp9/Z/kvbc7a2lKNQK9ZTNZ
	EWxvNkLw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpdvB-0000000BpAO-3Ec1;
	Thu, 28 Mar 2024 00:47:09 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpdtl-0000000BoF2-2SQb
	for linux-nvme@bombadil.infradead.org;
	Thu, 28 Mar 2024 00:45:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
	Content-Type:Content-ID:Content-Description;
	bh=8+FRkzHNc+9dwWUd0DemLjToWIPnwS4In9kEpqUayJg=; b=fm440o4hMtNANtUZvHaekfpNlx
	0TfnyYnoBa9GBfrHJKLI720hbWUE+QudA9QiJNQnsedTW0Pk6YI1EUMipbbIIkMNjLDs5JwiH6zja
	VLh82NoBXFA3S4OraIVThK6+A/RSqeeoJZln702GQGUItb7CCAycwYFY1A/IIJZZog3VquCNvD5/R
	cK1LEpVG+FIvrzpUvuD9YORy0vmzfZ+SILtZmKwcyUFJqCRrs5N0reuEViXIOJoxbNIBQqGDgqbmo
	NcfD9lxMWH12OQw+omMSUB7CKKzBX8hEFNDiaTwx9whFMUbgYUot5OZroaebdeaXJa4koDjvtS/j+
	NCj+Rt6w==;
Received: from sin.source.kernel.org ([145.40.73.55])
	by desiato.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpdtW-00000000fLV-01JZ
	for linux-nvme@lists.infradead.org;
	Thu, 28 Mar 2024 00:45:30 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 695E4CE1DF9;
	Thu, 28 Mar 2024 00:44:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB83FC433F1;
	Thu, 28 Mar 2024 00:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711586689;
	bh=qJCiBXwiB1nBGTKUyXuTLdyuWLMu/967LH+L7QeQ9PI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Bf6yt46XVenDrcODEhf8gDinxxhtzHz0O8IM3XXAVqNYLzwgAxIN+7aXnMaKIj+bS
	 L2lqDNth2b9GafnkSWlDX6t67XfoYNKaNZQQi9WEgfT0qPwOTku7E16WNX0+pOt3Kp
	 lh9eXipFhCwuU5UnGICLdUFRPdzMggLfNzh7kN68WYx1QTT9VZatdWQdCD4LVsDqHK
	 AlWazkQ8P5YZ8X9f1pKrwV33WdwMkH3QCSCY+b6wlkcyR3Tt9mAb6rTqH85fcZQ2PT
	 w9frW8Rj6LyJaYQ2By3FKUPJVBIj6wWpCG6jtSoD4SAUJxLnczuWGO4p+7xXdWSPoc
	 LBpRllKSmBAOA==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	linux-scsi@vger.kernel.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	dm-devel@lists.linux.dev,
	Mike Snitzer <snitzer@redhat.com>,
	linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH v3 21/30] block: Remove BLK_STS_ZONE_RESOURCE
Date: Thu, 28 Mar 2024 09:44:00 +0900
Message-ID: <20240328004409.594888-22-dlemoal@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240328004409.594888-1-dlemoal@kernel.org>
References: <20240328004409.594888-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240328_004528_770716_199E44B2 
X-CRM114-Status: GOOD (  23.13  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

The zone append emulation of the scsi disk driver was the only driver
using BLK_STS_ZONE_RESOURCE. With this code removed,
BLK_STS_ZONE_RESOURCE is now unused. Remove this macro definition and
simplify blk_mq_dispatch_rq_list() where this status code was handled.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq.c            | 26 --------------------------
 drivers/scsi/scsi_lib.c   |  1 -
 include/linux/blk_types.h | 20 ++++----------------
 3 files changed, 4 insertions(+), 43 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 5299a7ed8fec..770d636707dc 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1923,19 +1923,6 @@ static void blk_mq_handle_dev_resource(struct request *rq,
 	__blk_mq_requeue_request(rq);
 }
 
-static void blk_mq_handle_zone_resource(struct request *rq,
-					struct list_head *zone_list)
-{
-	/*
-	 * If we end up here it is because we cannot dispatch a request to a
-	 * specific zone due to LLD level zone-write locking or other zone
-	 * related resource not being available. In this case, set the request
-	 * aside in zone_list for retrying it later.
-	 */
-	list_add(&rq->queuelist, zone_list);
-	__blk_mq_requeue_request(rq);
-}
-
 enum prep_dispatch {
 	PREP_DISPATCH_OK,
 	PREP_DISPATCH_NO_TAG,
@@ -2021,7 +2008,6 @@ bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx, struct list_head *list,
 	struct request *rq;
 	int queued;
 	blk_status_t ret = BLK_STS_OK;
-	LIST_HEAD(zone_list);
 	bool needs_resource = false;
 
 	if (list_empty(list))
@@ -2063,23 +2049,11 @@ bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx, struct list_head *list,
 		case BLK_STS_DEV_RESOURCE:
 			blk_mq_handle_dev_resource(rq, list);
 			goto out;
-		case BLK_STS_ZONE_RESOURCE:
-			/*
-			 * Move the request to zone_list and keep going through
-			 * the dispatch list to find more requests the drive can
-			 * accept.
-			 */
-			blk_mq_handle_zone_resource(rq, &zone_list);
-			needs_resource = true;
-			break;
 		default:
 			blk_mq_end_request(rq, ret);
 		}
 	} while (!list_empty(list));
 out:
-	if (!list_empty(&zone_list))
-		list_splice_tail_init(&zone_list, list);
-
 	/* If we didn't flush the entire list, we could have told the driver
 	 * there was more coming, but that turned out to be a lie.
 	 */
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 2e28e2360c85..9ca96116bd33 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -1870,7 +1870,6 @@ static blk_status_t scsi_queue_rq(struct blk_mq_hw_ctx *hctx,
 	case BLK_STS_OK:
 		break;
 	case BLK_STS_RESOURCE:
-	case BLK_STS_ZONE_RESOURCE:
 		if (scsi_device_blocked(sdev))
 			ret = BLK_STS_DEV_RESOURCE;
 		break;
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 29b3170431e7..ffe0c112b128 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -136,18 +136,6 @@ typedef u16 blk_short_t;
  */
 #define BLK_STS_DEV_RESOURCE	((__force blk_status_t)13)
 
-/*
- * BLK_STS_ZONE_RESOURCE is returned from the driver to the block layer if zone
- * related resources are unavailable, but the driver can guarantee the queue
- * will be rerun in the future once the resources become available again.
- *
- * This is different from BLK_STS_DEV_RESOURCE in that it explicitly references
- * a zone specific resource and IO to a different zone on the same device could
- * still be served. Examples of that are zones that are write-locked, but a read
- * to the same zone could be served.
- */
-#define BLK_STS_ZONE_RESOURCE	((__force blk_status_t)14)
-
 /*
  * BLK_STS_ZONE_OPEN_RESOURCE is returned from the driver in the completion
  * path if the device returns a status indicating that too many zone resources
@@ -155,7 +143,7 @@ typedef u16 blk_short_t;
  * after the number of open zones decreases below the device's limits, which is
  * reported in the request_queue's max_open_zones.
  */
-#define BLK_STS_ZONE_OPEN_RESOURCE	((__force blk_status_t)15)
+#define BLK_STS_ZONE_OPEN_RESOURCE	((__force blk_status_t)14)
 
 /*
  * BLK_STS_ZONE_ACTIVE_RESOURCE is returned from the driver in the completion
@@ -164,20 +152,20 @@ typedef u16 blk_short_t;
  * after the number of active zones decreases below the device's limits, which
  * is reported in the request_queue's max_active_zones.
  */
-#define BLK_STS_ZONE_ACTIVE_RESOURCE	((__force blk_status_t)16)
+#define BLK_STS_ZONE_ACTIVE_RESOURCE	((__force blk_status_t)15)
 
 /*
  * BLK_STS_OFFLINE is returned from the driver when the target device is offline
  * or is being taken offline. This could help differentiate the case where a
  * device is intentionally being shut down from a real I/O error.
  */
-#define BLK_STS_OFFLINE		((__force blk_status_t)17)
+#define BLK_STS_OFFLINE		((__force blk_status_t)16)
 
 /*
  * BLK_STS_DURATION_LIMIT is returned from the driver when the target device
  * aborted the command because it exceeded one of its Command Duration Limits.
  */
-#define BLK_STS_DURATION_LIMIT	((__force blk_status_t)18)
+#define BLK_STS_DURATION_LIMIT	((__force blk_status_t)17)
 
 /**
  * blk_path_error - returns true if error may be path related
-- 
2.44.0



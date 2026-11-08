Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F8C606D83F
	for <linux-nvme@archiver.kernel.org>; Sun,  8 Nov 2026 20:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=QTEF7skg;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=khlhW9ub
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=MyAWQuhn8V+44YfsjM97mHie938UeW0L0TmwXewiVmM=; b=QTEF7skgsKrDQM
	yUqOa47plXJCUp/4TdaKyLx/FPB095MKbqzKkGQinNVYnChYkOwlsOgh6Z7W9ARqKu70Oz28YtJE0
	o1cb8wFmyPF7IGvxA/Xqad0Fe3DEoRVaZEXRbICxLa/lWrTEKMR2QfJvHa0dh/HnG0cu88WyjgEw3
	XEKC2BFt3Wbcq4u34NYF+6sFsD+4P2hDsjJsiFgKsFylbm9iyrvhBI2/2PG4FCzwxkINh5YexUyJ+
	W1gDUk6vXv9Xo5ujvkue5rgmN0wxKhLZ55Wiekg+w+Z+KAR69E2jvlVJAJx1I6kxDhnY3cwL0E0Tv
	0sJ6xgaqHHM+CQ7bBHnA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQ9oX-0000000Gchv-0XFP;
	Sun, 08 Nov 2026 20:48:33 +0000
Received: from out-199.mta0.migadu.com ([2001:41d0:1004:224b::c7] helo=mta0.migadu.com)
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQ9oM-0000000GcER-1l2S
	for linux-nvme@lists.infradead.org;
	Sun, 08 Nov 2026 20:48:31 +0000
X-Envelope-To: linux-nvme@lists.infradead.org
DKIM-Signature: a=rsa-sha256; bh=5TahV5Bolvu7HAVTbNzS+a27asy7oEz9GforUDQb/qY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794170900; v=1; x=1794775700;
 b=khlhW9ubhSx5/iSC0kXlG6C8XUkpZA1X4tPVj9g2/p+J8vtY12Kjo+IDe4AuM5X8g6mKlTyx
 +3sz/qdRki2CYvq+/1Y2Kizoj5r3P8mjFwV8WDcDqgSMxbrOKjSJjqUgbfyoT7S3/UrXYiSDrmr
 lmENqV00kpWWMTVMr6sf4uns=
X-Envelope-To: linux-nvme@lists.infradead.org
Received: by mta10.migadu.com with ESMTPS id 1cc8975d10d3d544;
	Sun, 08 Nov 2026 20:48:20 +0000
X-Mizu-Trace-ID: 1cc8975d10d3d544
X-Migadu-Flow: FLOW_OUT
From: John Garry <john.garry@linux.dev>
To: james.bottomley@hansenpartnership.com,
	mkp@kernel.org
Cc: hare@suse.com,
	linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org,
	snitzer@kernel.org,
	jmeneghi@redhat.com,
	bmarzins@redhat.com,
	dm-devel@lists.linux.dev,
	hch@lst.de,
	michael.christie@oracle.com,
	John Garry <john.garry@linux.dev>
Subject: [PATCH v9 21/29] scsi-multipath: add scsi_mpath_{start,end}_request()
Date: Sun,  8 Nov 2026 20:47:25 +0000
Message-ID: <20261108204733.557995-22-john.garry@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261108204733.557995-1-john.garry@linux.dev>
References: <20261108204733.557995-1-john.garry@linux.dev>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261108_124822_693333_1BA3616A 
X-CRM114-Status: GOOD (  21.52  )
X-Spam-Score: -2.1 (--)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add scsi_mpath_{start,end}_request() to handle updating private multipath
request data, like nvme_mpath_{start,end}_request().

New member Scsi_Host.mpath_nr_active is added. This is required for queue
depth multipath iopolicy.

For NVMe, this count is per controller. The reason is that many NSes may
be connected to a controller, so congestion should be judged at
controller level.

SCSI has no definition of a controller, but SCSI host is a comparable
concept.

Indeed, many SCSI disks may be connected to the same SCSI host, so it
makes sense to count number of active requests at this point. However,
for a transport like iSCSI Initiator over TCP/IP, we have a separate SCSI
host per SCSI device (so there the count would be same at SCSI device
level).

Signed-off-by: John Garry <john.garry@linux.dev>
---
 drivers/scsi/scsi_lib.c       |  8 +++-
 drivers/scsi/scsi_multipath.c | 69 +++++++++++++++++++++++++++++++++++
 include/scsi/scsi_cmnd.h      |  9 ++++-
 include/scsi/scsi_host.h      |  4 ++
 include/scsi/scsi_multipath.h | 11 ++++++
 5 files changed, 99 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 4dbd01484b4a..13562c0ab48b 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -669,7 +669,10 @@ static bool scsi_end_request(struct request *req, blk_status_t error,
 	struct scsi_device *sdev = cmd->device;
 	struct request_queue *q = sdev->request_queue;
 
-	if (blk_update_request(req, error, bytes))
+	if (sdev->scsi_mpath_dev && is_mpath_request(req)) {
+		if (scsi_mpath_end_request(req, error, bytes))
+			return true;
+	} else if (blk_update_request(req, error, bytes))
 		return true;
 
 	if (q->limits.features & BLK_FEAT_ADD_RANDOM)
@@ -1947,6 +1950,9 @@ static blk_status_t scsi_queue_rq(struct blk_mq_hw_ctx *hctx,
 	memset(cmd->sense_buffer, 0, SCSI_SENSE_BUFFERSIZE);
 	cmd->submitter = SUBMITTED_BY_BLOCK_LAYER;
 
+	if (sdev->scsi_mpath_dev && is_mpath_request(req))
+		scsi_mpath_start_request(req);
+
 	blk_mq_start_request(req);
 	if (blk_mq_is_reserved_rq(req)) {
 		reason = shost->hostt->queue_reserved_command(shost, cmd);
diff --git a/drivers/scsi/scsi_multipath.c b/drivers/scsi/scsi_multipath.c
index 2f47c39d8293..93a4545f1dbf 100644
--- a/drivers/scsi/scsi_multipath.c
+++ b/drivers/scsi/scsi_multipath.c
@@ -545,6 +545,75 @@ void scsi_mpath_put_head(struct scsi_mpath_head *scsi_mpath_head)
 }
 EXPORT_SYMBOL_GPL(scsi_mpath_put_head);
 
+void scsi_mpath_start_request(struct request *req)
+{
+	struct scsi_cmnd *scmd = blk_mq_rq_to_pdu(req);
+	struct scsi_device *sdev = scmd->device;
+	struct scsi_mpath_device *scsi_mpath_dev = sdev->scsi_mpath_dev;
+	struct scsi_mpath_head *scsi_mpath_head =
+				scsi_mpath_dev->scsi_mpath_head;
+	struct bio *clone = req->bio, *master;
+	struct mpath_head *mpath_head = &scsi_mpath_head->mpath_head;
+	struct gendisk *disk = mpath_head->disk;
+
+	if (mpath_qd_iopolicy(&scsi_mpath_head->iopolicy) &&
+	    !(scmd->flags & SCMD_MPATH_CNT_ACTIVE)) {
+		struct Scsi_Host *shost = sdev->host;
+
+		atomic_inc(&shost->mpath_nr_active);
+		scmd->flags |= SCMD_MPATH_CNT_ACTIVE;
+	}
+
+	if (blk_rq_is_passthrough(req) || !blk_queue_io_stat(disk->queue))
+		return;
+
+	if (!clone) {
+		scmd->flags &= ~SCMD_MPATH_IO_STATS;
+		return;
+	}
+
+	if (scmd->flags & SCMD_MPATH_IO_STATS)
+		return;
+
+	master = clone->bi_private;
+
+	scmd->flags |= SCMD_MPATH_IO_STATS;
+	scmd->start_time = bdev_start_io_acct(master->bi_bdev, req_op(req),
+				jiffies);
+	scmd->start_bytes = blk_rq_bytes(req);
+}
+
+bool scsi_mpath_end_request(struct request *req, blk_status_t error,
+				unsigned int nr_bytes)
+{
+	struct scsi_cmnd *scmd = blk_mq_rq_to_pdu(req);
+	struct scsi_device *sdev = scmd->device;
+	struct block_device *bi_bdev = NULL;
+
+	if (scmd->flags & SCMD_MPATH_IO_STATS) {
+		struct bio *clone = req->bio, *master = clone->bi_private;
+
+		bi_bdev = master->bi_bdev;
+	}
+
+	if (blk_update_request(req, error, nr_bytes))
+		return true;
+
+	if (scmd->flags & SCMD_MPATH_CNT_ACTIVE) {
+		struct Scsi_Host *shost = sdev->host;
+
+		atomic_dec_if_positive(&shost->mpath_nr_active);
+	}
+
+	if (!(scmd->flags & SCMD_MPATH_IO_STATS))
+		return false;
+	bdev_end_io_acct(bi_bdev, req_op(req),
+			 scmd->start_bytes >> SECTOR_SHIFT,
+			 scmd->start_time);
+
+	return false;
+}
+
 int __init scsi_multipath_init(void)
 {
 	return class_register(&scsi_mpath_device_class);
diff --git a/include/scsi/scsi_cmnd.h b/include/scsi/scsi_cmnd.h
index 5a8f7a45dc6d..62ffd33ba7ea 100644
--- a/include/scsi/scsi_cmnd.h
+++ b/include/scsi/scsi_cmnd.h
@@ -58,8 +58,11 @@ struct scsi_pointer {
  */
 #define SCMD_FORCE_EH_SUCCESS	(1 << 3)
 #define SCMD_FAIL_IF_RECOVERING	(1 << 4)
+#define SCMD_MPATH_IO_STATS	(1 << 5)
+#define SCMD_MPATH_CNT_ACTIVE	(1 << 6)
 /* flags preserved across unprep / reprep */
-#define SCMD_PRESERVED_FLAGS	(SCMD_INITIALIZED | SCMD_FAIL_IF_RECOVERING)
+#define SCMD_PRESERVED_FLAGS	(SCMD_INITIALIZED | SCMD_FAIL_IF_RECOVERING | \
+				SCMD_MPATH_IO_STATS | SCMD_MPATH_CNT_ACTIVE)
 
 /* for scmd->state */
 #define SCMD_STATE_COMPLETE	0
@@ -146,6 +149,10 @@ struct scsi_cmnd {
 					 * to release this memory.  (The memory
 					 * obtained by scsi_malloc is guaranteed
 					 * to be at an address < 16Mb). */
+	#ifdef CONFIG_SCSI_MULTIPATH
+	unsigned long		start_time;
+	unsigned int		start_bytes;
+	#endif
 
 	int result;		/* Status code from lower level driver */
 };
diff --git a/include/scsi/scsi_host.h b/include/scsi/scsi_host.h
index daaf1247673f..8cbca6b75732 100644
--- a/include/scsi/scsi_host.h
+++ b/include/scsi/scsi_host.h
@@ -756,6 +756,10 @@ struct Scsi_Host {
 	/* Delay for runtime autosuspend */
 	int rpm_autosuspend_delay;
 
+	#ifdef CONFIG_SCSI_MULTIPATH
+	atomic_t mpath_nr_active;
+	#endif
+
 	/*
 	 * We should ensure that this is aligned, both for better performance
 	 * and also because some compilers (m68k) don't automatically force
diff --git a/include/scsi/scsi_multipath.h b/include/scsi/scsi_multipath.h
index 6e50da94fc5d..dca1307c9fa4 100644
--- a/include/scsi/scsi_multipath.h
+++ b/include/scsi/scsi_multipath.h
@@ -57,6 +57,9 @@ void scsi_mpath_add_sysfs_link(struct scsi_device *sdev);
 void scsi_mpath_remove_sysfs_link(struct scsi_device *sdev);
 void scsi_mpath_dev_clear_path(struct scsi_mpath_device *scsi_mpath_dev);
 void scsi_mpath_revalidate_paths(struct scsi_mpath_device *scsi_mpath_dev);
+void scsi_mpath_start_request(struct request *req);
+bool scsi_mpath_end_request(struct request *req, blk_status_t error,
+			       unsigned int nr_bytes);
 #else /* CONFIG_SCSI_MULTIPATH */
 
 struct scsi_mpath_head {
@@ -109,5 +112,13 @@ static inline
 void scsi_mpath_revalidate_paths(struct scsi_mpath_device *scsi_mpath_dev)
 {
 }
+static inline void scsi_mpath_start_request(struct request *req)
+{
+}
+static inline bool scsi_mpath_end_request(struct request *req, blk_status_t error,
+			       unsigned int nr_bytes)
+{
+	return false;
+}
 #endif /* CONFIG_SCSI_MULTIPATH */
 #endif /* _SCSI_SCSI_MULTIPATH_H */
-- 
2.43.0



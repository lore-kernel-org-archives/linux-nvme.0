Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41417606D83E
	for <linux-nvme@archiver.kernel.org>; Sun,  8 Nov 2026 20:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=4lU/jaFj;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=PCUvMJc7;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=LWvEao3h
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=djFhY6HrcugeDpQwTBeqH0wZRhMZ8g8NzZbKP0h6x10=; b=4lU/jaFjzRsVhW
	SDwKOKzcYrdm5UjorhexEWHTiWu/ATyD0hPyCAqrbiucTLgyi4OHnP06EMxL/VwLbKy5OtTMPZvlP
	zxArd6wWprrdZhLTqyvbfxf06I7TqWcGgN7uTzDdK1MScw1i8hv4h2qhf0s6EM3wKewDoaOWwg+IM
	lmQgiTCDA5qil2ZXgyNh7aiknbeE0dietQkJLfjpYzqXB/nd9kv7rcTlg0gw+ks5iOlA8m7o7cQJY
	jOou+B30gisCuhWy1mOJv04N4GGgX8SFZpZ1ywnBnt5/ZkWVI9+oElzLMzl8mEJgny/lboIg4RBwm
	0G7EzBipJf9lyTyiSh9g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQ9oS-0000000GcVL-1gSS;
	Sun, 08 Nov 2026 20:48:28 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQ9oQ-0000000GcQa-47FE
	for linux-nvme@bombadil.infradead.org;
	Sun, 08 Nov 2026 20:48:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=djFhY6HrcugeDpQwTBeqH0wZRhMZ8g8NzZbKP0h6x10=; b=PCUvMJc7RybjrdSXzZOh7yIfKA
	VooCoO4j47P9s2Bu2IhBl3aLihR0VLPoL0RbBSbT7PZuZe+p82pAGXAyoZTemp7h+gylnYmrRRoZi
	Z2uOlSH5n2+l+9qaDtc/YninNiotwYi/7f2JSdJvGtM4DkquejHnD6ek7MGSLcv8Oa9GiU0VcpmQj
	TsjasIJkBlvrLO1xkYTak7tTIOSAswDRjAISMhh0sFJUs0Coaiiil2Te11Aq8luGTvZJUjkWFCIHQ
	NUnqaoRAFy2V3/C8/Q/STFRPhyqCaJKdvK2Ki6r5ErhcLK+k662MMoMOFvxtpkJy337v08isWZ7Qw
	OB7iCzug==;
Received: from out-202.mta0.migadu.com ([2001:41d0:1004:224b::ca] helo=mta0.migadu.com)
	by desiato.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQ9oN-000000060Ha-3AlP
	for linux-nvme@lists.infradead.org;
	Sun, 08 Nov 2026 20:48:25 +0000
X-Envelope-To: linux-nvme@lists.infradead.org
DKIM-Signature: a=rsa-sha256; bh=VPDIuqnyTg2xDal4wGmjULrT9obL2CYqMohvVopWv8o=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794170901; v=1; x=1794775701;
 b=LWvEao3hU1X6wjvd723ICY/1A3hYV3FwBCHkaeL5hzX7UfEQYXS/oOS1VfzGv43oUBHzkevb
 /HoflbrEqLXqQsgRMQpEbLcXE7d/bwnkMuxZGjvtwO7AKMg67A5bjiukviY3IRwNRhm/YEsMPVq
 Nd8yw/tb/X6eFdL3+0MlQr9Y=
X-Envelope-To: linux-nvme@lists.infradead.org
Received: by mta10.migadu.com with ESMTPS id d9db4c546fa1030a;
	Sun, 08 Nov 2026 20:48:21 +0000
X-Mizu-Trace-ID: d9db4c546fa1030a
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
Subject: [PATCH v9 22/29] scsi-multipath: update request for terminal request queuing error
Date: Sun,  8 Nov 2026 20:47:26 +0000
Message-ID: <20261108204733.557995-23-john.garry@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261108204733.557995-1-john.garry@linux.dev>
References: <20261108204733.557995-1-john.garry@linux.dev>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261108_204824_042169_DDE1B22F 
X-CRM114-Status: GOOD (  16.81  )
X-Spam-Score: -0.2 (/)
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

If we cannot queue a request in scsi_queue_rq(), then we may error out
with an error code which means that the block layer ends the request (and
does not requeue). Such an error scenario would be scsi_device transport
offline.

In this case, we should update the request to deal with when
SCMD_MPATH_IO_STATS and SCMD_MPATH_IO_STATS flags have been set.

Signed-off-by: John Garry <john.garry@linux.dev>
---
 drivers/scsi/scsi_lib.c       |  3 +++
 drivers/scsi/scsi_multipath.c | 35 +++++++++++++++++++++++++++++++++++
 include/scsi/scsi_multipath.h |  5 +++++
 3 files changed, 43 insertions(+)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 13562c0ab48b..a5a2967d17a2 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -1996,6 +1996,9 @@ static blk_status_t scsi_queue_rq(struct blk_mq_hw_ctx *hctx,
 			cmd->result = DID_NO_CONNECT << 16;
 		else
 			cmd->result = DID_ERROR << 16;
+
+		if (sdev->scsi_mpath_dev && is_mpath_request(req))
+			scsi_mpath_end_request_no_update(req, ret);
 		/*
 		 * Make sure to release all allocated resources when
 		 * we hit an error, as we will never see this command
diff --git a/drivers/scsi/scsi_multipath.c b/drivers/scsi/scsi_multipath.c
index 93a4545f1dbf..bec6dd94f3be 100644
--- a/drivers/scsi/scsi_multipath.c
+++ b/drivers/scsi/scsi_multipath.c
@@ -614,6 +614,41 @@ bool scsi_mpath_end_request(struct request *req, blk_status_t error,
 	return false;
 }
 
+void scsi_mpath_end_request_no_update(struct request *req, blk_status_t error)
+{
+	struct scsi_cmnd *scmd = blk_mq_rq_to_pdu(req);
+	struct scsi_device *sdev = scmd->device;
+	struct bio *clone = req->bio, *master = clone->bi_private;
+	struct block_device *bi_bdev = master->bi_bdev;
+	unsigned int nr_bytes;
+
+	/* Don't generate error logs if we are going to try another path */
+	if (blk_path_error(error))
+		req->rq_flags |= RQF_QUIET;
+
+	if (scmd->flags & SCMD_MPATH_CNT_ACTIVE) {
+		struct Scsi_Host *shost = sdev->host;
+
+		atomic_dec_if_positive(&shost->mpath_nr_active);
+	}
+
+	if (!(scmd->flags & SCMD_MPATH_IO_STATS))
+		return;
+
+	/*
+	 * blk_rq_bytes() value should never exceed start_bytes, but check in
+	 * case.
+	 */
+	if (scmd->start_bytes > blk_rq_bytes(req))
+		nr_bytes = scmd->start_bytes - blk_rq_bytes(req);
+	else
+		nr_bytes = 0;
+
+	bdev_end_io_acct(bi_bdev, req_op(req),
+			 nr_bytes >> SECTOR_SHIFT,
+			 scmd->start_time);
+}
+
 int __init scsi_multipath_init(void)
 {
 	return class_register(&scsi_mpath_device_class);
diff --git a/include/scsi/scsi_multipath.h b/include/scsi/scsi_multipath.h
index dca1307c9fa4..72ad109a9a81 100644
--- a/include/scsi/scsi_multipath.h
+++ b/include/scsi/scsi_multipath.h
@@ -60,6 +60,7 @@ void scsi_mpath_revalidate_paths(struct scsi_mpath_device *scsi_mpath_dev);
 void scsi_mpath_start_request(struct request *req);
 bool scsi_mpath_end_request(struct request *req, blk_status_t error,
 			       unsigned int nr_bytes);
+void scsi_mpath_end_request_no_update(struct request *req, blk_status_t error);
 #else /* CONFIG_SCSI_MULTIPATH */
 
 struct scsi_mpath_head {
@@ -120,5 +121,9 @@ static inline bool scsi_mpath_end_request(struct request *req, blk_status_t erro
 {
 	return false;
 }
+static inline void scsi_mpath_end_request_no_update(struct request *req,
+				blk_status_t error)
+{
+}
 #endif /* CONFIG_SCSI_MULTIPATH */
 #endif /* _SCSI_SCSI_MULTIPATH_H */
-- 
2.43.0



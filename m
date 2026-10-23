Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26EE8606A31D
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Oct 2026 08:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=k6ort9b1;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=UaYM1X9u
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=Vf7NOZ2eW7H+p9ePS9i9+qIoUsMW81GD/Fm7fxzsljI=; b=k6ort9b1wfYU3j
	/BRAHDD45qlaIvV1lXRV6bWO4gCf1Kr+hm09sUK+rZKfURVkVvSSwP6BMrYnIsJjD3BtbeWp8LUEB
	SYzz3Sc9PcRtOxOmkhJa7R87zhAR29Z2Gxs6xYvn+eVY8O7hd/arHAyZv23iwL9intW0wHj2s+Xn8
	rVNsdIDKEIIatZpwP+4nt0KqlxWbalXzBuwLEpUIFxz5d9oz+qltzAUOI9JkmqYEEDZw+dyKDZ3Vj
	DOMV74aloX8SC0df6Dd0UYbtJe4b/tIp/sBv/iDpgkShgviSdqslNFCfyx2y9qXGrdn2A+oFq3N8x
	69dwAfuYRQc+fYc1PvUg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xKAFA-0000000Fqsz-3Kju;
	Fri, 23 Oct 2026 08:03:16 +0000
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xKAF6-0000000Fqls-2OP7
	for linux-nvme@lists.infradead.org;
	Fri, 23 Oct 2026 08:03:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1792742590; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=Vf7NOZ2eW7H+p9ePS9i9+qIoUsMW81GD/Fm7fxzsljI=;
	b=UaYM1X9u6hEjU/zQk7LZ5kHQuRGX9RiXNtrcuMKCtngr+Vl/+k74rbWinhVXdTVEPpcMJupa9tQtjGJdSn8LnWVLOVjq4c7xaNj0133UTe3ej7XFnN0DqjhYN4qb1CPDGVF8r/9Bx5/jKRf6lmXpjvgbXsz2M01eu6yBbO0rguA=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0XDLUS4N_1792742588;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XDLUS4N_1792742588 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 23 Oct 2026 16:03:09 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Daniel Wagner <dwagner@suse.de>,
	Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH 10/11] nvmet: translate placement identifiers of writes to write streams
Date: Fri, 23 Oct 2026 16:02:50 +0800
Message-ID: <20261023080251.2606443-11-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261023080251.2606443-1-kanie@linux.alibaba.com>
References: <20261023080251.2606443-1-kanie@linux.alibaba.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261023_010312_804619_E2BB783B 
X-CRM114-Status: GOOD (  14.71  )
X-Spam-Score: -17.6 (-----------------)
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
X-Spam-Status: No, score=-26.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

A write command that carries the Data Placement Directive names a
placement identifier in the Directive Specific field.  Both sides of
the bridge use identity mapped handles: the write streams of the
backing device map to the placement handles one by one, in the order
the reclaim unit handle status reports them.  Translate the placement
identifier to the matching backing write stream on the write path, so
the data lands in the reclaim unit of the backing device that the
host selected.  The enable of the namespace has verified that the
backing placement identifiers are identity mapped.

The translated stream is assigned to every bio of the write, not
just the first one, so that a write larger than a single bio keeps
its placement over the whole chain.

Writes without the directive, and writes with a placement identifier
that is out of range, keep the default stream 0: the spec lets the
controller place such data itself.

Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 drivers/nvme/target/io-cmd-bdev.c |  7 +++++++
 drivers/nvme/target/nvmet.h       | 20 ++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index f2d9e8901df4e..832b406442440 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -255,6 +255,7 @@ static void nvmet_bdev_execute_rw(struct nvmet_req *req)
 	unsigned int sg_cnt = req->sg_cnt;
 	struct bio *bio;
 	struct scatterlist *sg;
+	u8 write_stream = 0;
 	struct blk_plug plug;
 	sector_t sector;
 	blk_opf_t opf;
@@ -300,6 +301,11 @@ static void nvmet_bdev_execute_rw(struct nvmet_req *req)
 	bio->bi_iter.bi_sector = sector;
 	bio->bi_private = req;
 	bio->bi_end_io = nvmet_bio_done;
+	if (req->cmd->rw.opcode == nvme_cmd_write &&
+	    nvmet_fdp_enabled(req->ns)) {
+		write_stream = nvmet_fdp_write_stream(req);
+		bio->bi_write_stream = write_stream;
+	}
 
 	blk_start_plug(&plug);
 	if (req->metadata_len)
@@ -323,6 +329,7 @@ static void nvmet_bdev_execute_rw(struct nvmet_req *req)
 			bio = bio_alloc(req->ns->bdev, bio_max_segs(sg_cnt),
 					opf, GFP_KERNEL);
 			bio->bi_iter.bi_sector = sector;
+			bio->bi_write_stream = write_stream;
 
 			bio_chain(bio, prev);
 			submit_bio(prev);
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 8f48227323fea..876768e3b0dad 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -1009,6 +1009,26 @@ void nvmet_execute_io_mgmt_recv(struct nvmet_req *req);
 void nvmet_execute_io_mgmt_send(struct nvmet_req *req);
 void nvmet_execute_get_log_page_fdp_configs(struct nvmet_req *req);
 void nvmet_fdp_log_forward(struct nvmet_req *req);
+
+/*
+ * Both sides of the bridge use identity mapped handles, so placement
+ * identifier i routes to backing write stream i+1; stream 0, the
+ * default, places the data without a directive.
+ */
+static inline u8 nvmet_fdp_write_stream(struct nvmet_req *req)
+{
+	u16 control = le16_to_cpu(req->cmd->rw.control);
+	u16 pid;
+
+	if ((control & 0xf0) != (NVME_RW_DTYPE_DPLCMT & 0xf0))
+		return 0;
+
+	pid = le32_to_cpu(req->cmd->rw.dsmgmt) >> 16;
+	if (pid >= req->ns->fdp.nruh)
+		return 0;
+
+	return pid + 1;
+}
 #else
 static inline bool nvmet_fdp_enabled(struct nvmet_ns *ns)
 {
-- 
2.43.7



Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D922606A31A
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Oct 2026 12:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=hOrb22OQ;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=pNlVTXtC
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=yAATOwiDV5ecRn/aMXQgwLpr1zA20LWlkOj7n44wjXA=; b=hOrb22OQLuQG/4
	z3rK/W/TV95DlfUyrFpkU0D9nJ+IYL/7g5YqbJDno0cGU63kK0Ohx5MmlXhoKPsTDe2L9M3WVYlif
	FNLrWMwa5wIzwTYD2CM5PEZS6icuhrAXZ/kLOc0oH7UH1y7pNGtxTKxvWRsS+v8gm76XOy+wPu6SX
	qpdTM+BMtuQ+s7lPAPbbvRNZpPLhWzMiTY3TeRL5njhcVV43ApX0b6UvJQXD494luvzi+XVie0lDa
	tPYOBlIIILhg/VWzIIUsRnP8xFT41W+RwUPR20rrEL2MRVXOsIWzT/3qNP3e3/h3thB5frMbPvgnv
	rWXG8XMluOGfBPc1ZZBA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMPG2-000000099X0-31hn;
	Thu, 29 Oct 2026 12:29:26 +0000
Received: from out30-111.freemail.mail.aliyun.com ([115.124.30.111])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMPFy-000000099KK-1FjF
	for linux-nvme@lists.infradead.org;
	Thu, 29 Oct 2026 12:29:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1793276959; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=yAATOwiDV5ecRn/aMXQgwLpr1zA20LWlkOj7n44wjXA=;
	b=pNlVTXtCn1dyfWQiHe7Tooxz1SDc8sZkh/+9dEsRI+ZT0AH8O+aKC4WOUj+78BKMk1KlzS2kRigqZpWzz4CXm5+0PJrhf7wjusa0NtnQBwh8mVep0kmh4NUoCU3TMr021AlQrMSST+C3ix4hivVjCu0uWD9o3Y4x1XCfW7GGlB0=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R701e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0XDjOCCi_1793276958;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XDjOCCi_1793276958 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 29 Oct 2026 20:29:18 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Daniel Wagner <dwagner@suse.de>,
	Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH v3 11/12] nvmet: translate placement identifiers of writes to write streams
Date: Thu, 29 Oct 2026 20:28:32 +0800
Message-ID: <20261029122833.284572-12-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261029122833.284572-1-kanie@linux.alibaba.com>
References: <20261029122833.284572-1-kanie@linux.alibaba.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261029_052922_878755_DFA202F5 
X-CRM114-Status: GOOD (  14.85  )
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
X-Spam-Status: No, score=-26.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
 drivers/nvme/target/nvmet.h       | 24 ++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index f2d9e8901df4..1390f70748af 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -256,6 +256,7 @@ static void nvmet_bdev_execute_rw(struct nvmet_req *req)
 	struct bio *bio;
 	struct scatterlist *sg;
 	struct blk_plug plug;
+	u8 write_stream = 0;
 	sector_t sector;
 	blk_opf_t opf;
 	int i, rc;
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
index c61cfe66f336..2013c72c3bcc 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -1010,6 +1010,26 @@ void nvmet_execute_io_mgmt_recv(struct nvmet_req *req);
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
@@ -1047,6 +1067,10 @@ static inline void nvmet_fdp_log_forward(struct nvmet_req *req)
 {
 	nvmet_req_complete(req, NVME_SC_INVALID_FIELD | NVME_STATUS_DNR);
 }
+static inline u8 nvmet_fdp_write_stream(struct nvmet_req *req)
+{
+	return 0;
+}
 #endif
 
 /*
-- 
2.43.7



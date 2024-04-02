Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A67BCD1284
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Apr 2024 12:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RXv4UFOhoo/zXR8R86dhGqOSvsPBdfl/bnIzArzV6B0=; b=UBFGmgbCRawzGhjWV9U/4iHioV
	i5N2mOBEMptvA6ip1xurkCN2ApnKycpiurHHLmiiiyJk2VpzQCkBZUFcIw2huLLB6eie/e58FFn59
	Tl45sU41QbVXwawePPqsVGrcOdwO1cF3fRuILx2uNRJKyyWB4uGWz3PE4Y/7tY4E8MdpSGnQ5SnS8
	tRcP/yysdA9kotRNud9VyXFO/UxO8TcPjyTozH3JPc6+FyCUXvgqpJc/MGdnI1qPJEg/em3X2N9AY
	3EuqVMqvd9r2f+rG/6PCjRFPuRnvDSniATbWVYKvBLtxaKnghVikzUBjP8EOwmBCFnFR7rIeYC9CT
	NHDO36dw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rrdQF-0000000B6Ic-3bJD;
	Tue, 02 Apr 2024 12:39:27 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rrdQ6-0000000B6Aw-0TJL
	for linux-nvme@lists.infradead.org;
	Tue, 02 Apr 2024 12:39:21 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 9D5B260FF8;
	Tue,  2 Apr 2024 12:39:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55541C433A6;
	Tue,  2 Apr 2024 12:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712061557;
	bh=qXjGHVWjqr2orY91/Ggfq1GwyhXXkL7+eIYmUkoNTtc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=A/G6TuxNZtLetNVGBK9hynsTp1zN0OWkMzpVUhsHGJbpPcArKXEX5mJottOGZo5FH
	 8/5XbLDLfAjKtIv/ZKfzyQMYCnjhrtubs61wYgMxngeF/dhvvJJQIQQhaOuFlEY9bN
	 XRIM1WNwUzF1HOLemq5ao5cI5xlhY9oOalS4v3MqHOdw0Mr/q60fy/QQ7Gc/IMTuE/
	 hupfbDNV3U5bz2/eXBjLNdtu1wWZxPUykVy0m8we8qFPezS8434jdacJKXuokIxULJ
	 ofEBNqdr4hPNRj+JmlqO222tshrWZoRDBtYiO1/ZRlnanwBzztbXjhTQDzGUonteQG
	 NZ4ET3zFMQXlw==
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
Subject: [PATCH v4 05/28] block: Allow using bio_attempt_back_merge() internally
Date: Tue,  2 Apr 2024 21:38:44 +0900
Message-ID: <20240402123907.512027-6-dlemoal@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240402123907.512027-1-dlemoal@kernel.org>
References: <20240402123907.512027-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240402_053918_500302_7920ED8A 
X-CRM114-Status: GOOD (  12.68  )
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

Remove "static" from the definition of bio_attempt_back_merge() and
declare this function in block/blk.h to allow using it internally from
other block layer files. The definition of enum bio_merge_status is
also moved to block/blk.h.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-merge.c | 8 +-------
 block/blk.h       | 8 ++++++++
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 4e3483a16b75..3363b1321908 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -972,13 +972,7 @@ static void blk_account_io_merge_bio(struct request *req)
 	part_stat_unlock();
 }
 
-enum bio_merge_status {
-	BIO_MERGE_OK,
-	BIO_MERGE_NONE,
-	BIO_MERGE_FAILED,
-};
-
-static enum bio_merge_status bio_attempt_back_merge(struct request *req,
+enum bio_merge_status bio_attempt_back_merge(struct request *req,
 		struct bio *bio, unsigned int nr_segs)
 {
 	const blk_opf_t ff = bio_failfast(bio);
diff --git a/block/blk.h b/block/blk.h
index 17786052f32d..bca50a9510c8 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -269,6 +269,14 @@ static inline void bio_integrity_free(struct bio *bio)
 unsigned long blk_rq_timeout(unsigned long timeout);
 void blk_add_timer(struct request *req);
 
+enum bio_merge_status {
+	BIO_MERGE_OK,
+	BIO_MERGE_NONE,
+	BIO_MERGE_FAILED,
+};
+
+enum bio_merge_status bio_attempt_back_merge(struct request *req,
+		struct bio *bio, unsigned int nr_segs);
 bool blk_attempt_plug_merge(struct request_queue *q, struct bio *bio,
 		unsigned int nr_segs);
 bool blk_bio_list_merge(struct request_queue *q, struct list_head *list,
-- 
2.44.0



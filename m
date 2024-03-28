Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8093CD11DF
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Mar 2024 00:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0dqq6mu4VRCU79pD90qlq/bk84nq+Cyk/SBmYO9AI8Q=; b=IUR1TgrVdP8FVN18jFumkLhLtS
	KN3whzTSr/7YHhjJHApVuWzrwTmTv8BBrn0WIt3c0OAZBhNFayTrAvyWcV9bFON0f+Ok7U2cEDEC/
	uBWXAXlAYiw3qAZDHX9WMFfKMviJ87QStHg6S85ESrNaVhP6vDJQ2yS5PKoNx6cp0NWg9Q0/q5gwF
	Dpnq1HieR6mA8OFhdVrNcyCR1WLPv7A5DQBVCJiROjPQ4SvjPsa+LPOLqdeFumPVygSTcigTAX+9Z
	2zj1yWy5yZCSf7L6JaaOmbNiY7G0Cmx7p6KcMaow4dR8v/+XP7gBFcOxzOxmQfRzmotMW1ab6bNRJ
	ihYO+A0g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpdsg-0000000BnSc-3ltp;
	Thu, 28 Mar 2024 00:44:34 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpdsZ-0000000BnJJ-16cu
	for linux-nvme@lists.infradead.org;
	Thu, 28 Mar 2024 00:44:30 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 3A240CE1857;
	Thu, 28 Mar 2024 00:44:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68234C43394;
	Thu, 28 Mar 2024 00:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711586663;
	bh=GRSnttSon36Brl7D5Dx+9ESml44bLMxHIragGuHvzQM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=XSaBxRRfeqVCTRVCby32lohAfjvxsK7E4403PRBbuP0ZpI6o6IWZaPNTl55Gutdbp
	 OlvPNvhg5VtqlQEdd2gpdpv3DrIql2hchehu1IkM9JmH22RFogmwicgOk0/APK3TrF
	 FdYI/LFEJU7f7jcWFRk3lEwZ1ra3ThQuJF+MEeMUKPYImPJbBXsenMaq0D54Yv2QCF
	 0gHdcXSbMpCovo8NfM/evozz6m62Qr7w77DmuYhNsmUDEXii+bu4LVAP0mw6R5tk6B
	 /wgBaIIgcO1wcu18uR9Ao83Whxzis1sYhFhoCV7anhdfcbkMc8I6U095Hhy+d2uYqM
	 VvU4mlJz9d6yg==
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
Subject: [PATCH v3 06/30] block: Allow using bio_attempt_back_merge() internally
Date: Thu, 28 Mar 2024 09:43:45 +0900
Message-ID: <20240328004409.594888-7-dlemoal@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240328004409.594888-1-dlemoal@kernel.org>
References: <20240328004409.594888-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240327_174428_269445_F6B30108 
X-CRM114-Status: GOOD (  12.47  )
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
index 2a06fd33039d..88367c10c8bc 100644
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
index a12cde1d45de..f2a521b72f9d 100644
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



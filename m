Return-Path: <SRS0=aO7+=M3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF8ADC4338F
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Aug 2021 10:11:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 836C960F0F
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Aug 2021 10:11:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 836C960F0F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/Q71YvrQsdpmUvAftcgwJP/7j/L7oPuUkDHqUCsqtxs=; b=VimC8ssrQZzzBb
	4H7Emf5rexmUQxMeR0ZlsROO0UuNiLF9Igb9aKNrW7lJGXOyICXrbUf/PFYPU6rVSMMPun+2pBmkD
	tNZRVG+Nqi7RRN14HBKSW/sZyifMQOGNXWvWdQMI8zhpMrWk0cadvwziPvcwjkK3qNk4LiXjN9lno
	j2+iOtxd8KfK/ljCIDIMWRDBrG3Z/oa024oUIQEpDdKx18YoZcvgUWVWCoBYvfM8Ywnq0KE4vycqE
	rE7fmhwLRWMkK/CmbEuDR8pRMz8ChK916whz67g4S+CWVYT0kcsVfu5ehImVHskqmJnAANYFNCUuQ
	z9xxmAWPbacDRCE1oCqA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mBDry-005e0h-Ve; Wed, 04 Aug 2021 10:11:27 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mBDny-005cAA-V5; Wed, 04 Aug 2021 10:07:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=wyyw2rjwpeKt+uQ2R+atw48w8P/AsLXlrqL/3XjtagU=; b=EmV6wYhTID92E2/QH8cEJm9OBH
 Yj11U/S2V0Hrv2p9BVSZFeXitTb/4GQ7dD/D85AjD12oMskgXdiP4UTkPDNvmOTruXevB/3R3nSZ3
 Q+haEu1tvC6c0a2RDGO8xyaj051lbiurKpzRbbMn3Snroz16BZpMSCOm7RGagO6vfL+mVcAk3RTwR
 I9blmlHNhNUQq1N41qQctVMcMJ0hKF6KhRDZMCCDTBHzWWNRyyVonzvr50lKZkfdCE13ypvIIMafG
 CVvyuhuMkN3vOsN/B5JIsZEfY2jrK1qZlNwanH9pU2DzvavPYVrs1AhnJiXJy7bMx5XrD7KKwEG1j
 m/IVXkvQ==;
Received: from [2a02:1205:5023:1f80:c068:bd3d:78b3:7d37] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mBDnR-005fxa-Fc; Wed, 04 Aug 2021 10:06:53 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Richard Weinberger <richard@nod.at>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Geoff Levand <geoff@infradead.org>, Ilya Dryomov <idryomov@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Song Liu <song@kernel.org>, Mike Snitzer <snitzer@redhat.com>,
 Coly Li <colyli@suse.de>, Stefan Haberland <sth@linux.ibm.com>,
 Jan Hoeppner <hoeppner@linux.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Phillip Lougher <phillip@squashfs.org.uk>, linux-block@vger.kernel.org,
 dm-devel@redhat.com, linux-um@lists.infradead.org,
 ceph-devel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-raid@vger.kernel.org, linux-bcache@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-scsi@vger.kernel.org
Subject: [PATCH 13/15] dasd: use bvec_virt
Date: Wed,  4 Aug 2021 11:56:32 +0200
Message-Id: <20210804095634.460779-14-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210804095634.460779-1-hch@lst.de>
References: <20210804095634.460779-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Use bvec_virt instead of open coding it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/s390/block/dasd_diag.c |  2 +-
 drivers/s390/block/dasd_eckd.c | 14 +++++++-------
 drivers/s390/block/dasd_fba.c  |  4 ++--
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/s390/block/dasd_diag.c b/drivers/s390/block/dasd_diag.c
index 6bb775236c16..db5987281010 100644
--- a/drivers/s390/block/dasd_diag.c
+++ b/drivers/s390/block/dasd_diag.c
@@ -552,7 +552,7 @@ static struct dasd_ccw_req *dasd_diag_build_cp(struct dasd_device *memdev,
 	dbio = dreq->bio;
 	recid = first_rec;
 	rq_for_each_segment(bv, req, iter) {
-		dst = page_address(bv.bv_page) + bv.bv_offset;
+		dst = bvec_virt(&bv);
 		for (off = 0; off < bv.bv_len; off += blksize) {
 			memset(dbio, 0, sizeof (struct dasd_diag_bio));
 			dbio->type = rw_cmd;
diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
index 0de1a463c509..8610ea414322 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -3267,7 +3267,7 @@ static int dasd_eckd_ese_read(struct dasd_ccw_req *cqr, struct irb *irb)
 	end_blk = (curr_trk + 1) * recs_per_trk;
 
 	rq_for_each_segment(bv, req, iter) {
-		dst = page_address(bv.bv_page) + bv.bv_offset;
+		dst = bvec_virt(&bv);
 		for (off = 0; off < bv.bv_len; off += blksize) {
 			if (first_blk + blk_count >= end_blk) {
 				cqr->proc_bytes = blk_count * blksize;
@@ -3999,7 +3999,7 @@ static struct dasd_ccw_req *dasd_eckd_build_cp_cmd_single(
 			      last_rec - recid + 1, cmd, basedev, blksize);
 	}
 	rq_for_each_segment(bv, req, iter) {
-		dst = page_address(bv.bv_page) + bv.bv_offset;
+		dst = bvec_virt(&bv);
 		if (dasd_page_cache) {
 			char *copy = kmem_cache_alloc(dasd_page_cache,
 						      GFP_DMA | __GFP_NOWARN);
@@ -4166,7 +4166,7 @@ static struct dasd_ccw_req *dasd_eckd_build_cp_cmd_track(
 	idaw_dst = NULL;
 	idaw_len = 0;
 	rq_for_each_segment(bv, req, iter) {
-		dst = page_address(bv.bv_page) + bv.bv_offset;
+		dst = bvec_virt(&bv);
 		seg_len = bv.bv_len;
 		while (seg_len) {
 			if (new_track) {
@@ -4509,7 +4509,7 @@ static struct dasd_ccw_req *dasd_eckd_build_cp_tpm_track(
 		new_track = 1;
 		recid = first_rec;
 		rq_for_each_segment(bv, req, iter) {
-			dst = page_address(bv.bv_page) + bv.bv_offset;
+			dst = bvec_virt(&bv);
 			seg_len = bv.bv_len;
 			while (seg_len) {
 				if (new_track) {
@@ -4542,7 +4542,7 @@ static struct dasd_ccw_req *dasd_eckd_build_cp_tpm_track(
 		}
 	} else {
 		rq_for_each_segment(bv, req, iter) {
-			dst = page_address(bv.bv_page) + bv.bv_offset;
+			dst = bvec_virt(&bv);
 			last_tidaw = itcw_add_tidaw(itcw, 0x00,
 						    dst, bv.bv_len);
 			if (IS_ERR(last_tidaw)) {
@@ -4778,7 +4778,7 @@ static struct dasd_ccw_req *dasd_eckd_build_cp_raw(struct dasd_device *startdev,
 			idaws = idal_create_words(idaws, rawpadpage, PAGE_SIZE);
 	}
 	rq_for_each_segment(bv, req, iter) {
-		dst = page_address(bv.bv_page) + bv.bv_offset;
+		dst = bvec_virt(&bv);
 		seg_len = bv.bv_len;
 		if (cmd == DASD_ECKD_CCW_READ_TRACK)
 			memset(dst, 0, seg_len);
@@ -4839,7 +4839,7 @@ dasd_eckd_free_cp(struct dasd_ccw_req *cqr, struct request *req)
 	if (private->uses_cdl == 0 || recid > 2*blk_per_trk)
 		ccw++;
 	rq_for_each_segment(bv, req, iter) {
-		dst = page_address(bv.bv_page) + bv.bv_offset;
+		dst = bvec_virt(&bv);
 		for (off = 0; off < bv.bv_len; off += blksize) {
 			/* Skip locate record. */
 			if (private->uses_cdl && recid <= 2*blk_per_trk)
diff --git a/drivers/s390/block/dasd_fba.c b/drivers/s390/block/dasd_fba.c
index 3ad319aee51e..e084f4dedddd 100644
--- a/drivers/s390/block/dasd_fba.c
+++ b/drivers/s390/block/dasd_fba.c
@@ -501,7 +501,7 @@ static struct dasd_ccw_req *dasd_fba_build_cp_regular(
 	}
 	recid = first_rec;
 	rq_for_each_segment(bv, req, iter) {
-		dst = page_address(bv.bv_page) + bv.bv_offset;
+		dst = bvec_virt(&bv);
 		if (dasd_page_cache) {
 			char *copy = kmem_cache_alloc(dasd_page_cache,
 						      GFP_DMA | __GFP_NOWARN);
@@ -583,7 +583,7 @@ dasd_fba_free_cp(struct dasd_ccw_req *cqr, struct request *req)
 	if (private->rdc_data.mode.bits.data_chain != 0)
 		ccw++;
 	rq_for_each_segment(bv, req, iter) {
-		dst = page_address(bv.bv_page) + bv.bv_offset;
+		dst = bvec_virt(&bv);
 		for (off = 0; off < bv.bv_len; off += blksize) {
 			/* Skip locate record. */
 			if (private->rdc_data.mode.bits.data_chain == 0)
-- 
2.30.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

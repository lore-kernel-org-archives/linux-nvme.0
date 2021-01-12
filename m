Return-Path: <SRS0=XnCc=GP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ACEBC433E0
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Jan 2021 04:28:26 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C078622D05
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Jan 2021 04:28:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C078622D05
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=sP621EdieohlYIDjsYqbTOHxW01FeUL+KzNpwTV9DEk=; b=PKDT9BgaN+k/v8vcF3IS5KD3v
	uZV98t2QKlQ+1E2UL8TOTYdha4AvuW7UhyrZLSwamBhWqcwq4ilr7deF0kGq64iM9AKMe4Lahd4oi
	wHuET8DABXq0l+P3AgP8qShS7zrhgD1gUaOvnMTbpdjesUR2kCp1n5d669BtIixLdG+alT75k3A8p
	DTKLPkgmMt5b+CkaHEtrLhf7Id+JqYGJEwih5f1Fgrz72TBuk8W28OJjMvX/RURW/34udLEpR8x5t
	PT+CyRZXRbcg2TmsxJp/mOEEok6LDztzqC+TBpPCx1NKB/5duYM2OAAxKl6ELDu2doUCAuYBAx+ov
	IfqMSZKQw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kzBHu-0001AR-IK; Tue, 12 Jan 2021 04:28:10 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kzBHl-00015c-UC
 for linux-nvme@lists.infradead.org; Tue, 12 Jan 2021 04:28:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1610425681; x=1641961681;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=qwXyOBMpSjhNvMX3TuA4Swa6BZth8f79ppVgwTS1V1A=;
 b=S0HcdCoF1E+RpCStD0wHVcWbXWG/K/WxlhCMNgIPMEF50u6qNEoc2YsH
 nHTRX/Cz2uu3i5EfEZnu0kFs1IuIw0ynovs8pNbM7En1+e0iN0mw16LPl
 z9nwSB1uRBjOATTtOECLGG27gFXfdedq7fSjD9K0cmbSlugT7G4GZ3/h4
 WLAYhDdrs/0n+qMfVDwrYUCNwlOtcOd0tSZUbH3VmMJSNg764jfYrb/8F
 kNUt4GiNd5WvpfBQrO5uKBtfkF7jSnzz6gH917fEKLyiPRVKuLNLQXjly
 G56b/I3CpeYA9BtbFbNfRsCTOTNodmxZHj7PIkeoQOPE7mrfILfdkEBoS Q==;
IronPort-SDR: ETCnTx+CPGSkNJ9ASskQp/HXCurYTx9JsZdPilytFYvlVBatKN5pBavgcXxCUXjqVlT734ZkRU
 bQoxDH5dCw1W6N0DyUMIj+hjgjv6lWohY0pJl90bAuqocZs4MngmyRTkPEGJnJuAgMCrDnOe+w
 0cSZoLMhAugQBa/3LnKM9WuaKg9ytQ/bfdENeUJ3N9gEMtfu+iHiuBgSI4/vX2K6DVYtUi40Y4
 RvlUEfRYtqZJxtf0ArMREYdXqe9CViAFF/eVl8MgxtwlRALKXZDTcNNcm08lzejn0AbiVIYB1u
 O4M=
X-IronPort-AV: E=Sophos;i="5.79,340,1602518400"; d="scan'208";a="267504917"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 12 Jan 2021 12:28:00 +0800
IronPort-SDR: 1oe/fVCL6RbqT7ZuyAAmo5DSKoEbdWse8EvuMbTm0dr9nH4tbv3zHBubAv5ss6dPLpmPElPWrc
 woP04l0+NSwOTswx8vWc/99vh0lcsef/KdO2Auq5mQRYujXzTv90bvI+SQCDiPxhDawK3p9T/1
 Rdha1axshh7g09Q1x4sxg5nowE1PSWmXZ7luMEcKXto00VAVrecFBDHa0P1NlKNuE7+hcEWA8W
 wThzDQScgagqHbyyDXbSus5dY6bVANa+sD4bQPcl78Mh3AFxlGIzWDHR5oeUFaKErVSp1ZMGBn
 n9p3Gsj9nOPY2iAYQWacK5Le
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jan 2021 20:12:45 -0800
IronPort-SDR: ENoUV6ViD+OhN4SyMyEOGFgI1dfOUK26uYgQuHPz0wjpqBXCXRofaWIQj9QJ1FEOdiBsp/jLbq
 dWvFH7tbkuwLeUOngPa6+3Irn8pa/s/qNgi2Y2McntxGmIeS/BLyrWeOjRQ3KI6gtx/4DUOlw3
 c10XoWgTBpgKuVT8DRRbvmh6ip62q/G3tQqoiBlZS+sLMzfWi3+IDg/be2kFeDtr5lDCcjM0rG
 cieMweCeSYmMbjjrNtYIxm5v6vb7pDPEKACiGlxSu1DXvAoQCI2TPlk3i05ornGsBMNF4jSOGT
 4mc=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 11 Jan 2021 20:28:00 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH V9 9/9] nvmet: call nvmet_bio_done() for zone append
Date: Mon, 11 Jan 2021 20:26:23 -0800
Message-Id: <20210112042623.6316-10-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20210112042623.6316-1-chaitanya.kulkarni@wdc.com>
References: <20210112042623.6316-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210111_232803_825913_D41558C7 
X-CRM114-Status: GOOD (  14.15  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: damien.lemoal@wdc.com, hch@lst.de,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

The function nvmet_bdev_execute_zone_append() does exactly same thing
for completion of the bio that is done in the nvmet_bio_done(),
completing the request & calling nvmet_bio_put()_to put non online bio.

Export the function nvmet_bio_done() and use that in the
nvmet_bdev_execute_zone_append() for the request completion and bio
processing. Set the bio->private after the call to submit_bio_wait() to
nvmet request. The call to nvmet_bio_done() also updates error log page
via call to blk_to_nvme_status() from nvmet_bio_done().

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/io-cmd-bdev.c |  2 +-
 drivers/nvme/target/nvmet.h       |  1 +
 drivers/nvme/target/zns.c         | 10 ++++------
 3 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index c23a719513b0..72a22351da2a 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -167,7 +167,7 @@ static u16 blk_to_nvme_status(struct nvmet_req *req, blk_status_t blk_sts)
 	return status;
 }
 
-static void nvmet_bio_done(struct bio *bio)
+void nvmet_bio_done(struct bio *bio)
 {
 	struct nvmet_req *req = bio->bi_private;
 
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index f4f9d622df0d..ab84ab75b952 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -535,6 +535,7 @@ void nvmet_ns_changed(struct nvmet_subsys *subsys, u32 nsid);
 void nvmet_bdev_ns_revalidate(struct nvmet_ns *ns);
 int nvmet_file_ns_revalidate(struct nvmet_ns *ns);
 void nvmet_ns_revalidate(struct nvmet_ns *ns);
+void nvmet_bio_done(struct bio *bio);
 
 static inline u32 nvmet_rw_data_len(struct nvmet_req *req)
 {
diff --git a/drivers/nvme/target/zns.c b/drivers/nvme/target/zns.c
index 149bc8ce7010..da4be0231428 100644
--- a/drivers/nvme/target/zns.c
+++ b/drivers/nvme/target/zns.c
@@ -283,7 +283,6 @@ void nvmet_bdev_execute_zone_append(struct nvmet_req *req)
 	struct request_queue *q = req->ns->bdev->bd_disk->queue;
 	unsigned int op = REQ_OP_ZONE_APPEND | REQ_SYNC | REQ_IDLE;
 	unsigned int max_sects = queue_max_zone_append_sectors(q);
-	u16 status = NVME_SC_SUCCESS;
 	unsigned int total_len = 0;
 	struct scatterlist *sg;
 	int ret = 0, sg_cnt;
@@ -306,7 +305,7 @@ void nvmet_bdev_execute_zone_append(struct nvmet_req *req)
 
 		ret = bio_add_hw_page(q, bio, p, l, o, max_sects, &same_page);
 		if (ret != sg->length) {
-			status = NVME_SC_INTERNAL;
+			bio->bi_status = BLK_STS_IOERR;
 			goto out_bio_put;
 		}
 		if (same_page)
@@ -316,15 +315,14 @@ void nvmet_bdev_execute_zone_append(struct nvmet_req *req)
 	}
 
 	if (total_len != nvmet_rw_data_len(req)) {
-		status = NVME_SC_INTERNAL | NVME_SC_DNR;
+		bio->bi_status = BLK_STS_IOERR;
 		goto out_bio_put;
 	}
 
 	ret = submit_bio_wait(bio);
 	req->cqe->result.u64 = nvmet_sect_to_lba(req->ns,
 						 bio->bi_iter.bi_sector);
-
 out_bio_put:
-	nvmet_req_bio_put(req, bio);
-	nvmet_req_complete(req, ret < 0 ? NVME_SC_INTERNAL : status);
+	bio->bi_private = req;
+	nvmet_bio_done(bio);
 }
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

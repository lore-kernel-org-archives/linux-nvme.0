Return-Path: <SRS0=W+Vz=CJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D245AC433E2
	for <linux-nvme@archiver.kernel.org>; Mon, 31 Aug 2020 22:28:37 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A310207EA
	for <linux-nvme@archiver.kernel.org>; Mon, 31 Aug 2020 22:28:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ib7XnQAF";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="iZ6T0JSf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A310207EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=SjAjvCGEAlUzgg6pnS73ml/ah2GNnW2pq38D1Q1mQDc=; b=Ib7XnQAFPlkE7DDM4x3Sf3RFz
	coWmaa1C2g0ro2CNtuUfuWb6XnSg1Q44imXGuIDdvTnTaeuCDmvUvbL+cCRDsHUzRKsELGelVtk7M
	EszxPiKte5D/iB9Fydc531Wfq+rOXbgBye9GLzm1DSmY2n3psuskGgB/eBWzc0KyLsOiw25gaUikG
	J5JU29lj9MA96FWbCMj2Ok0MFkUefEg/Id4RKrC/q2jEFrKHrUn0fX053QBbLuDHE21G2NU4OFW/S
	EQ1sFDqaNsEbPaKYjwdtWvko0aoIWprmuuAE6ZZN5ea7rMpR8aKhPPDYWealUv3+O0UQ9sON/jgfz
	uw6Bvqsyw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kCsHw-0005xl-2f; Mon, 31 Aug 2020 22:28:32 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kCsHS-0005jp-OV
 for linux-nvme@lists.infradead.org; Mon, 31 Aug 2020 22:28:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1598912883; x=1630448883;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=7+w20UIi2DSGNCsl4ZDeFB5lmvAh0stafgkiQqQq1qg=;
 b=iZ6T0JSf6LlljI8Kh9WHViiLEMfdd0VN1Vg6D7Qmsti/HRJn85Zejd8U
 762sqJWZH5QTAQezhQvDp3NRlT/v0H2m1Upu0oO/QgSjliXe98M2IkTID
 YbhD7ekZTRIp/AuMDSdHbGiPoGbVB0svoowIUgUgiMMMfIJ58m3Nu5BWM
 avWUOA+mdc8a9B8EM7D3MduYgWQMygAhfWVWbtxIYbiftfGomnc286RC4
 tgCgLQYbLf77AXyBy4bDe6MutupLWJSB/Z47EIcQFRHVM6X85O4ei4rPR
 Tt/fm2O4MdStneS29ZxHVjnSubiAHTJdUehyZ+Duc+UCAFBLlYzONb5S6 w==;
IronPort-SDR: pBSBdIf2ghk6ztlhXPnvX/7icSWGbUGFfYFeqoVwx8w1mlCNr9CyCdnc+ewEjsLjkW1SZjZiSC
 0I3pg5AAu+/Vh+Ryt4Bs5OGhhL48Hs7EwpOiyppfnGhznE3Xs0JPM2ELZ1f+0D+kh03DyUnJkJ
 eRMmdGtxLnOxVeYQV4thVtmS+yq1u/+Z4eMLfG6tWbMr6xI+GSB5T5UPcNsKspBAHCinp6MVaL
 TEQd1GJ5VfliHW13C1YDkXm6wFysWOZdlMhVGTFOGxqHoiDwniwQoQ+yZ2byfHnl82Rt6ORdix
 1W8=
X-IronPort-AV: E=Sophos;i="5.76,376,1592841600"; d="scan'208";a="147482882"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 01 Sep 2020 06:28:02 +0800
IronPort-SDR: bg+5LO0IZBPzyXHuIGqMjbJgj3tIQYQ5OaP1nYT5EhSUnp71b2dpg6rkRb4CYuXdH7wfNmuBqb
 bHlM7YeXUSAg==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Aug 2020 15:15:30 -0700
IronPort-SDR: Z64Dh7UwcMA5ohDMO10PdYnPRcB1O6+2ttWyJITOPjxhSTtV3ewm/mCFJR6zTEihFwUIb+Ud8G
 g/00UIJWQ+tA==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 31 Aug 2020 15:28:01 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V2 12/12] nvmet: use inline bio for passthru fast path
Date: Mon, 31 Aug 2020 15:27:07 -0700
Message-Id: <20200831222707.35611-13-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20200831222707.35611-1-chaitanya.kulkarni@wdc.com>
References: <20200831222707.35611-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200831_182803_024621_1B540B68 
X-CRM114-Status: GOOD (  18.83  )
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
Cc: kbusch@kernel.org, logang@deltatee.com, hch@lst.de,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

In nvmet_passthru_execute_cmd() which is a high frequency function
it uses bio_alloc() which leads to memory allocation from the fs pool
for each I/O.

For NVMeoF nvmet_req we already have inline_bvec allocated as a part of
request allocation that can be used with preallocated bio when we
already know the size of request before bio allocation with bio_alloc(),
which we already do.

Introduce a bio member for the nvmet_req passthru anon union. In the
fast path, check if we can get away with inline bvec and bio from
nvmet_req with bio_init() call before actually allocating from the
bio_alloc().

This will be useful to avoid any new memory allocation under high
memory pressure situation and get rid of any extra work of
allocation (bio_alloc()) vs initialization (bio_init()) when
transfer len is < NVMET_MAX_INLINE_DATA_LEN that user can configure at
compile time.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/nvmet.h    |  1 +
 drivers/nvme/target/passthru.c | 21 ++++++++++++++++++---
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 477439acb8e1..6b1430f8ac78 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -331,6 +331,7 @@ struct nvmet_req {
 			struct work_struct      work;
 		} f;
 		struct {
+			struct bio		inline_bio;
 			struct request		*rq;
 			struct work_struct      work;
 			bool			use_workqueue;
diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index 89d848006bd5..ff39f0635451 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -179,6 +179,14 @@ static void nvmet_passthru_req_done(struct request *rq,
 	blk_mq_free_request(rq);
 }
 
+static void nvmet_passthru_bio_done(struct bio *bio)
+{
+	struct nvmet_req *req = bio->bi_private;
+
+	if (bio != &req->p.inline_bio)
+		bio_put(bio);
+}
+
 static int nvmet_passthru_map_sg(struct nvmet_req *req, struct request *rq)
 {
 	unsigned int op_flags = 0;
@@ -190,14 +198,21 @@ static int nvmet_passthru_map_sg(struct nvmet_req *req, struct request *rq)
 	if (req->cmd->common.opcode == nvme_cmd_flush)
 		op_flags = REQ_FUA;
 
-	bio = bio_alloc(GFP_KERNEL, min(sg_cnt, BIO_MAX_PAGES));
-	bio->bi_end_io = bio_put;
+	if (req->transfer_len <= NVMET_MAX_INLINE_DATA_LEN) {
+		bio = &req->p.inline_bio;
+		bio_init(bio, req->inline_bvec, ARRAY_SIZE(req->inline_bvec));
+	} else {
+		bio = bio_alloc(GFP_KERNEL, min(sg_cnt, BIO_MAX_PAGES));
+	}
+
+	bio->bi_end_io = nvmet_passthru_bio_done;
 	bio->bi_opf = req_op(rq) | op_flags;
+	bio->bi_private = req;
 
 	for_each_sg(req->sg, sg, req->sg_cnt, i) {
 		if (bio_add_pc_page(rq->q, bio, sg_page(sg), sg->length,
 				    sg->offset) < sg->length) {
-			bio_put(bio);
+			nvmet_passthru_bio_done(bio);
 			return -EINVAL;
 		}
 		sg_cnt--;
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

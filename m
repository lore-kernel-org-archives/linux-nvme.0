Return-Path: <SRS0=JPfP=EQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61368C4741F
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Nov 2020 02:25:08 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1D32206C0
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Nov 2020 02:25:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IWRmIdbK";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="YBADIYb5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1D32206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=5/eU96/VLOgc3LQYkhRu7FV2KtJHgCR1Aq90LMk9y8U=; b=IWRmIdbKMeA/cLjk5ZQAK0Dxt
	Zh2581hhSqO8oeBTk4YmzQ3d2fBjBHOWon/tYx1t3PGJacRRKu0pxB+owJRCsMVKpYt8zCA23es+Y
	wn90hlZ3iJUwOdNwKaWRJB1thvtRAQqO5WoZkCtVoNBQt6bGPtobimF2MbKZVohCUjcGV63BWXExA
	0WlOBXDvm3V8egZ3a0r555HKKgO66i1ECFsn5WW1D1GN9B+YsY6qGCDnaP1NcE6Fx/axDfm+2yKP6
	syZ5F7lV4Niy4KljHOKHyjcWNXuPcNZDDWVrJ/kZVZHebZkRVedNLHXVJcokleSqEEshkIPK5ptKw
	upKtdqo7g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kcJLD-0006Qs-2w; Tue, 10 Nov 2020 02:25:03 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kcJL2-0006KU-Ll
 for linux-nvme@lists.infradead.org; Tue, 10 Nov 2020 02:24:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1604975092; x=1636511092;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=G0ZQSIMWivGujGltCMNIh/G4c4WD0kenneuIGVJ9JRA=;
 b=YBADIYb5qVZtHMA3jqQr15L6MKBBd1s+0vnt1STvqSjNnnY/NfafgWMl
 1YEY7SHYcTQhdnIQBnKv3gStLB7JKYQJSL49IQe3hRUFZWQVrWtRiYABX
 KIugJ5Qi2nKUPox2S94cKhetyXmWZoxFMMYoiA9FcQpUvVbIqOVtB3wT0
 fsfay8jBPGD/dpK3p72vj95yR2vKC0Qo8DTK2S3gImtFExv5uwbXkbjck
 TnNTL59cteDwZjaJCa2qQ4UwR0slOFL3k4QDlvB1d4/x86lhsyj/xOEpo
 q8JtDRejBWZayQLM2JKWfkSBtXSoSWfuFzFRapzDPjoEwyXRJRCpRagTZ g==;
IronPort-SDR: 34Z6bkkF4Rf4TozFcTfM5effqI0HyZMMg8qM5oZPX4LpMeFema7PhJ+QIKIp6AGeqo+RZCrpla
 GRtDttY9mDHJcwFwhsEJSrD2zem2DKDcKyeWloXrCaRxNFGqHtG9BxJuOgeEwGc/LLda69P6Ys
 XcnKTWKAyTBF6KUf4k7NJUwKafA/UchPij7MpkxEtr4thUhemHEgfykOpJK+aQZ7SVxwH4yaiU
 OM/fDl59k23k3IFqJEbVText6jDiiG4YuSBlrPazZoD/eKtSsLz3B22ZIg8UUJVNrMYlUfS0RM
 imc=
X-IronPort-AV: E=Sophos;i="5.77,465,1596470400"; d="scan'208";a="156720815"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 10 Nov 2020 10:24:51 +0800
IronPort-SDR: JeCU8GI9ayqJFNkS7IaIQLbBKoKjdKzlH4bIVIYL+7STxld5zTRDV0IALL4pLsF3wquwg5BrN1
 oq7TTVN2b8/In27eW4WtlEMQpW90gzTQRlA23dbiLi6MGocqmrJrY2b70Xx+bCfxHHubHfKDOu
 KKBgrD6vOfrRaxh87vLXBBoVnKR8EVCnn/WD5GVAQNboOM074GCdit19djhzRypENAJbKo/34Z
 IStnLXflIlmJFHIoCwykWefTbx1Gs9qIKaqHQlKpBtDdLs0uR10tyChzgTa3p+XqrUTmcXr6OG
 YnW8FtHPb2S04/5t0in8QDTm
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2020 18:09:39 -0800
IronPort-SDR: OvIUWGUTzFbd1FDzlHGeb5gRqm8aYl3bmZrGrTGqz6hx/+hVf2zkg8cSM6eS8qoqk2/4Ks9jmt
 qaTcPDHoToubJGXTMF1rjkA9brgdpbIG3eW5TTbQ/xviQteqUxNdVZ1NRTrkjuq1QfLd+GMIns
 J5dcQWtj+kjGzBIBQ6NItfTYykiMyai8cNZset+qcaJ+IKOnUL/krsoS3OCeEw2N4mZR1tybu4
 jynsXksQfgJLeS41HWukAOOK9lVZzR0eMX24w/YgYoFAkyjljmjWwcH6O50f2QlvxKXSyRxKp+
 R0w=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 09 Nov 2020 18:24:51 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: [PATCH V4 6/6] nvmet: use inline bio for passthru fast path
Date: Mon,  9 Nov 2020 18:24:05 -0800
Message-Id: <20201110022405.6707-7-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20201110022405.6707-1-chaitanya.kulkarni@wdc.com>
References: <20201110022405.6707-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201109_212453_238928_FC006EFC 
X-CRM114-Status: GOOD (  15.07  )
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
Cc: axboe@kernel.dk, sagi@grimberg.me,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, kbusch@kernel.org,
 Logan Gunthorpe <logang@deltatee.com>, hch@lst.de
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
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/nvme/target/nvmet.h    |  1 +
 drivers/nvme/target/passthru.c | 12 +++++++++---
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 2f9635273629..e89ec280e91a 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -332,6 +332,7 @@ struct nvmet_req {
 			struct work_struct      work;
 		} f;
 		struct {
+			struct bio		inline_bio;
 			struct request		*rq;
 			struct work_struct      work;
 			bool			use_workqueue;
diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index 2b24205ee79d..b9776fc8f08f 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -194,14 +194,20 @@ static int nvmet_passthru_map_sg(struct nvmet_req *req, struct request *rq)
 	if (req->sg_cnt > BIO_MAX_PAGES)
 		return -EINVAL;
 
-	bio = bio_alloc(GFP_KERNEL, req->sg_cnt);
-	bio->bi_end_io = bio_put;
+	if (req->transfer_len <= NVMET_MAX_INLINE_DATA_LEN) {
+		bio = &req->p.inline_bio;
+		bio_init(bio, req->inline_bvec, ARRAY_SIZE(req->inline_bvec));
+	} else {
+		bio = bio_alloc(GFP_KERNEL, min(req->sg_cnt, BIO_MAX_PAGES));
+		bio->bi_end_io = bio_put;
+	}
 	bio->bi_opf = req_op(rq);
 
 	for_each_sg(req->sg, sg, req->sg_cnt, i) {
 		if (bio_add_pc_page(rq->q, bio, sg_page(sg), sg->length,
 				    sg->offset) < sg->length) {
-			bio_put(bio);
+			if (bio != &req->p.inline_bio)
+				bio_put(bio);
 			return -EINVAL;
 		}
 	}
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

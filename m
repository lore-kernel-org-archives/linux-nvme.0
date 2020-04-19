Return-Path: <SRS0=4bXW=6D=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3222C38A29
	for <linux-nvme@archiver.kernel.org>; Sun, 19 Apr 2020 23:49:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A086B212CC
	for <linux-nvme@archiver.kernel.org>; Sun, 19 Apr 2020 23:49:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IlVN6GiW";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="hxCsojLn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A086B212CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=FguOZ0iIMeJMJPvzzObrAy9V5U9vtOp1f0VEsH/KrNI=; b=IlVN6GiW1DcgSS
	oZGUR+HqpyS7yb9hG4vtlt9LIR5B0a7M8KmB8+gmdpmGznWo5b7jyDcjD0GJVxDEeymr8mbQUQ3cL
	JV7GPhwdfxvef5vffPcg0btBniXDYuHsoMHb4jw4Oz8aeA3v2kMb3udFzuqVOEqO7xc/UKd88eLLR
	ZpqOrDEKAbmjg5MjZTBce90ZFhlqFRnjPSv05hgc/rAaN+WOnT7gkNpMfplbqShHX+bcIJjCEtmsa
	Ff4G8F49EMKMaSM9Ui2BhI2DbwW4/4CT/QapcE5mjyOc57ev3Ph/9BX/fcf7or4nnlI4XXI9VEJez
	SImyH6YtnI8kHpYHpTfg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jQJgY-0005DN-49; Sun, 19 Apr 2020 23:49:14 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jQJgT-0005BT-WA
 for linux-nvme@lists.infradead.org; Sun, 19 Apr 2020 23:49:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1587340149; x=1618876149;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=HEyCXseAk7sItm6psEB8xlNZstwPTgHxj6aDI5lexWo=;
 b=hxCsojLnmGvaS7Bs48ZvDenChi91CqI8TIuiPjsdzhj/SBqceZWMva0P
 fgCbOsvQR+3uyO/lUy+c2y/5vmRkCHt8IA1Xk4qkFXUSbktnpqHnpGtGr
 gIDlDSINtcDrs0iMOg6FF7RT4EdIdC355AdKccdpNDmeekqX6iRuMfA+j
 /hNQTYE25ZYC5uhLslWUDMKiRgV4ThfUQpIv+my6u4r88dRQMsdeT7R/T
 W1N2XBtjj9j/jS1cbRO9VADeHotlkLXomdMIywbnKN8eOdo7+daYYmcNw
 Sf5ELQXqtMW5SMAK9Kn2NuguX/IE7290stK3opuQiAPC6km2FqI7F5PX1 w==;
IronPort-SDR: 30TvzPktcp3vrT6Dx04dGcEzszvosyzCvNXPvn1NGFdgZlIPuvpLTjkrWArP889mSY1myJdeTJ
 0Mk8V+/V4T07iorf47kqAhGetQ8HeKkrjsarAVTeNv3gcQsAI1QGBvLmmbGf7sh92CFv2FPyKA
 MN9LIJOP01xtoVVNSuPRevGA1uEsqi28vK95Wy5YSsgwy4H4piFFV5GN82jJXxfy9Eb+QutsVC
 gP2vcDZD0zXt+bnLmZio03HnyKTIwd3F399m4dOTljrCO2YUKuAP5Nw/wBPBUWiMXYsz5nQhyY
 NY8=
X-IronPort-AV: E=Sophos;i="5.72,404,1580745600"; d="scan'208";a="244367297"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 20 Apr 2020 07:49:08 +0800
IronPort-SDR: LCKIlVJRFZ38HmRdeMdbBZNjdptUgr6/CkiZcbzlLY6UfIVQuGVoMM98J+ZEtnlI/E6MiaLplq
 CRZiOHLzn4KW2wRjt07lfWH++gUy9aaRY=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Apr 2020 16:40:03 -0700
IronPort-SDR: 7HuQFhBNsxHcAaYKgViNmelLJwJLkrXRj1h6m55lQGA6L82QJD2JzWJMF9srvS4RTV2yo4s+tt
 T8RF2aMdTMZg==
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com)
 ([10.6.138.107])
 by uls-op-cesaip02.wdc.com with ESMTP; 19 Apr 2020 16:49:08 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V3 1/7] nvmet: add ns revalidation support
Date: Sun, 19 Apr 2020 16:48:50 -0700
Message-Id: <20200419234856.59901-2-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200419234856.59901-1-chaitanya.kulkarni@wdc.com>
References: <20200419234856.59901-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200419_164910_040273_5458A84B 
X-CRM114-Status: UNSURE (   9.77  )
X-CRM114-Notice: Please train this message.
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
Cc: sagi@grimberg.me, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Anthony Iliopoulos <ailiop@suse.com>

Add support for detecting capacity changes on nvmet blockdev and file
backed namespaces. This allows for emulating and testing online resizing
of nvme devices and filesystems on top.

Signed-off-by: Anthony Iliopoulos <ailiop@suse.com>
[Fix comments posted on V1]
Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/admin-cmd.c   |  5 +++++
 drivers/nvme/target/io-cmd-bdev.c |  5 +++++
 drivers/nvme/target/io-cmd-file.c | 11 +++++++++++
 drivers/nvme/target/nvmet.h       |  2 ++
 4 files changed, 23 insertions(+)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 9d6f75cfa77c..4c79aa804887 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -486,6 +486,11 @@ static void nvmet_execute_identify_ns(struct nvmet_req *req)
 	if (!ns)
 		goto done;
 
+	if (ns->bdev)
+		nvmet_bdev_ns_revalidate(ns);
+	else
+		nvmet_file_ns_revalidate(ns);
+
 	/*
 	 * nuse = ncap = nsze isn't always true, but we have no way to find
 	 * that out from the underlying device.
diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index ea0e596be15d..0427e040e3dd 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -75,6 +75,11 @@ void nvmet_bdev_ns_disable(struct nvmet_ns *ns)
 	}
 }
 
+void nvmet_bdev_ns_revalidate(struct nvmet_ns *ns)
+{
+	ns->size = i_size_read(ns->bdev->bd_inode);
+}
+
 static u16 blk_to_nvme_status(struct nvmet_req *req, blk_status_t blk_sts)
 {
 	u16 status = NVME_SC_SUCCESS;
diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
index cd5670b83118..14364383d2fe 100644
--- a/drivers/nvme/target/io-cmd-file.c
+++ b/drivers/nvme/target/io-cmd-file.c
@@ -80,6 +80,17 @@ int nvmet_file_ns_enable(struct nvmet_ns *ns)
 	return ret;
 }
 
+void nvmet_file_ns_revalidate(struct nvmet_ns *ns)
+{
+	struct kstat stat;
+
+	if (vfs_getattr(&ns->file->f_path, &stat, STATX_SIZE,
+			AT_STATX_FORCE_SYNC))
+		return;
+
+	ns->size = stat.size;
+}
+
 static void nvmet_file_init_bvec(struct bio_vec *bv, struct scatterlist *sg)
 {
 	bv->bv_page = sg_page(sg);
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 421dff3ea143..8b479d932a7b 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -498,6 +498,8 @@ void nvmet_file_ns_disable(struct nvmet_ns *ns);
 u16 nvmet_bdev_flush(struct nvmet_req *req);
 u16 nvmet_file_flush(struct nvmet_req *req);
 void nvmet_ns_changed(struct nvmet_subsys *subsys, u32 nsid);
+void nvmet_bdev_ns_revalidate(struct nvmet_ns *ns);
+void nvmet_file_ns_revalidate(struct nvmet_ns *ns);
 
 static inline u32 nvmet_rw_len(struct nvmet_req *req)
 {
-- 
2.22.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

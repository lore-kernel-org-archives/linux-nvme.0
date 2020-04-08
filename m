Return-Path: <SRS0=zNed=5Y=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA017C2D0EA
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Apr 2020 04:16:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7396F2074F
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Apr 2020 04:16:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IrlQKaIV";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="QAFXt13D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7396F2074F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+d1sjKMss0u0v9d41jaVyXbZIePGaTGr5RpqlpyuvMg=; b=IrlQKaIV82vGu5
	Hq94swtrtHGp7G5aLp/g7TSgEPxYK2Eat5cNati95kBjK5uhzZwGJ6YuBkOLt53tXayDH/dE86dZ7
	ks/KTp4w+zjzWIFUubWa1UFS8Ro52Wd8VUU2fLx2bmlF4uJ7FTrm5DSCAorMzJz9YQ9K9Hkvyw2C5
	WP2Y5PyRVZgHtyt2frPt3bzvacBdPhGNavYhEGQb+YpNpRBkaEz2iz0xgxLVvqQ3t8DPS/fXNmYV9
	w72x3yEO1kYr1yLQsGK2nc+1AXVi/XnhtiXyeHlfKkn4quZrO3AePBhNbl2JBqSBwG+4OqLJ7Gh4l
	w4QOOPsEY3xNGQHmVzvA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jM28z-0001qC-3F; Wed, 08 Apr 2020 04:16:53 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jM28u-0001iO-5Z
 for linux-nvme@lists.infradead.org; Wed, 08 Apr 2020 04:16:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1586319408; x=1617855408;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ERH6iRLrbypbfKPGKjMa1vsuN2J/FD7US062opXS1KM=;
 b=QAFXt13Dpy3DOIQSy3KsW3IEtLF8nqouGrUsn4rXC0JNTyvPK9eo1L/9
 RzDfKXP+XfhcxQ+EyThH24a6qxMgb7afvCm3/+/32zxGOFMlFHQM1PLAq
 ApEDHo4gVVm/CQHQJMqo3ixuMwIrKamRpv0nMhkm3eKmLrAyXh1Ce7H36
 8MbOqTZg1fzqcEHoUShI9hSLl53YwTjFtC2bS2HhLvmsh1cSyxN30JXcO
 RcXcKyPXmjAp24oWtIMP1Yh9Q5SpxPrgvq5s7rtd/PT7ZCgrBp4fExPV6
 fV5VdjCvdBBoI5ud5QVzkP+jDr1xYD2WU5UIF7fUe3M4pLG72Aw5Y5vyM g==;
IronPort-SDR: 811gVA14WQTE4QyDOmAVUSS4uuj1U75UBhMKFubmj89dLvJDBR5GHdQ8sUnYkMxtCoS0kgAQua
 gwXEJiC0wii5emIjs5YftzgV2Ug3Tp4BeHz9ZSuHJyCS6q/7gyBJfyc6UGHBlN9IRrqAHGwxuG
 B0a+Lr1j+hDJ+mAr0A4y2Mz0AUoiMZE9a5Dlin3ifKEUesQqBL7Ddz7f81J8WQ/NltCYmYao8c
 RGYKY45rfxAq8ZytmFTK6kY+K/LgWO3k3OzqiuBFsq72wm2pY/e33Fr531kLs9sZoaGKZbuPM+
 IQU=
X-IronPort-AV: E=Sophos;i="5.72,357,1580745600"; d="scan'208";a="136283897"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 08 Apr 2020 12:16:44 +0800
IronPort-SDR: 6DgZ2NXSAUgS9unYylwN9FbnTOIZ/nWDw57P1rFtb2bnKvdegFcw+WaEk+z/7trT3Hk+InEaz9
 f68Nn74L5SrQtMCbAsBklf5yEay9ZeUiZ0awtmb87n8F0eCCOObGRB9bhoRp832E9xrCxgF+c2
 OD8/J/tbZDIqcBaVhaVWoKOxdMQ1hNiogw2nZebZF0fDDhxKqBtMl9lD0UOUuCUyBAIYKZB4d1
 fTGbZt2n9NVKOnfGvV/4r1wHCsQxprnOyXXPIDJJkDUJ4r7hr3XoN0IUNXQd1OyO4U1C2acXXE
 yn3vMIo8faL34H4gg3gjz5Ma
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Apr 2020 21:07:25 -0700
IronPort-SDR: a2izDhCiB3vP1ldsJwxbvDsguPN3pZn73mIkXrnwEY9LXc0a+J/2y99OZBC73RPg/Z5/grbImy
 XooanSIpPi+P2hWq8BG8OlwjjWRWwyYbfcMU6kyl/ShszbW7/9Oqpd/Yrx8IAikWz7Q5Xhhlfw
 luQNnFziNKo3pKyQFGPOhXCqkJqmfMOSLdFEv2NU0uOH3wEKAgnI+vFpfJMK+wDeCQJEViUCiG
 zT6rputS/4Yf/u2liS5Rpxg7GCHvvoVWTwZ7elS+irQ7YEkiSXjW+3RtrAWijM+sea4g0QlI97
 91I=
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com)
 ([10.6.138.107])
 by uls-op-cesaip01.wdc.com with ESMTP; 07 Apr 2020 21:16:43 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V2 1/2] nvmet: add ns revalidation support
Date: Tue,  7 Apr 2020 21:16:32 -0700
Message-Id: <20200408041633.20632-2-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200408041633.20632-1-chaitanya.kulkarni@wdc.com>
References: <20200408041633.20632-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200407_211648_304760_BF3129B8 
X-CRM114-Status: GOOD (  11.64  )
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
Cc: ailiop@suse.com, hch@lst.de,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, sagi@grimberg.me
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
index 72a7e41f3018..ba01d8e6e9c9 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -468,6 +468,11 @@ static void nvmet_execute_identify_ns(struct nvmet_req *req)
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
index eda28b22a2c8..a3ffdcca4efb 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -487,6 +487,8 @@ void nvmet_file_ns_disable(struct nvmet_ns *ns);
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

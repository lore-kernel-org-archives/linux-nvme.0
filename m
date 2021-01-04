Return-Path: <SRS0=JqC7=GH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49010C433DB
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Jan 2021 05:10:12 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F217B2087E
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Jan 2021 05:10:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F217B2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=5WkN4XFjNyWWCL9rv94wJbHzE7n21SlImJJ77/L6vDM=; b=N+1pEuuH657ie+oeSGfsLfKyv
	AXsP9ao8YmFsuRtfXszOGPHcI+fyyo0OjIc2E03jDrjRKNq1lppRS3xWA8/Fh+DmPoMAkQ8NL57iv
	MGa81lIQo9dOTJKeiptNi/TSE6iIM/+19vX6aF/CHMHe8i2cQRMBfLqRZEUwG5A5WAfJDgjCUj8cG
	Uy5g6VxaNBYDPGnsNbMY5CquP17DOBLmqTyYnNUNJm//7Vb2soSa+yDtG4mWhSEXtYZ4cjXd2WStN
	mDfbI5GWkTlX1sIsse9s3KRRVysO+QATkOCCZGpCurYOJO5nUvzJ5jFn517p+7XZQUgAJ7xK13zWx
	DxnpuRV/g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kwI86-0002u2-W6; Mon, 04 Jan 2021 05:10:07 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kwI84-0002se-4B
 for linux-nvme@lists.infradead.org; Mon, 04 Jan 2021 05:10:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1609737004; x=1641273004;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=4Wv3I+4BMA69G90XiWi7kBfe5tRi5+WACkvX6sTfcEY=;
 b=VA+mDdI5LswvJ7mWNe4RbnMCjejx3E89czeMsGa9zBZYMYXARCnp48wy
 RuWO3bNvCIHBMR//U7MGWy8g/78A+sNM2JjzuZnrOJ2k8W8Z/4MUGNQfK
 Zzox1HOis9E9qbGTp/SCVEdvghQ3Kj7bQXS49RbMFJjiYe2XYQnQwlgEn
 JjurjvzrEmgziHJzR9YJ7a7iidhEzaGEqrEN5A/Sw9Q1KXoIf3GnZYWkJ
 uO3XP4wY8n3mCR1Cq59iEYuuTKMQuz07G9ZtpVZDWAlAlc+XTk3z64edA
 6RS12uJ6u3IJ18+qi1WB/wHK57IrN/drkCWmiLTMM/nennnkuFuNCp47s w==;
IronPort-SDR: CyJWMACtrwztLKaFTA4LaZthzmUCyx7h/i817v5MxnS1PGZeh21Rs+nPdTP7AMhVPYUqpVGB3B
 Ai33eKzko3kIh/IjZY+sLV4GVr7qtGRuKfBzJcqrov8f/oo4oHFCG8sqwp0KGPBLJ7J8hmkfwG
 J3cmk7/WgFK3btuDxV/3Git/IL0qNz6qMFpjAup/ck/MUH2pW2vxMDlrQKQrkA9IXTT1QOPAr3
 fFeey79wE90tSG9OMW2u5fk6f4cDHQShxO3lnSEqFnWO3g0ZcUb704g5Vwn9tKWmLYr3vPFvCU
 ebs=
X-IronPort-AV: E=Sophos;i="5.78,473,1599494400"; d="scan'208";a="156435496"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 04 Jan 2021 13:10:01 +0800
IronPort-SDR: VZJPF1Gxe7CyqYUtYCNdy9QWZAtA5ideh5FUerAeZaIEwiUg/gHWquZkUixcntjMYqk5K8rzuC
 WYnTQEJbjpuPXSLTAfQfIb3ZElo8vENCLiIsnXzyf8TGogAaavwoxGQDHsjb8OcdnzgfcIIVkv
 q5ikL7fx1fC/L2d6StOwnSNy1vDawagWlJLKPGvEwManTPLQY/MZzN0DcljdQZsK5tJBFEqchr
 AdP56+g2NWegUuFoutjCiCXg1fWmEwbpxykrtXKW4OraO9J/kRQSN8ESLcnjGlhU901/YukjOX
 TI1qcxrlmHLHoqz7bSnV1NFo
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jan 2021 20:54:56 -0800
IronPort-SDR: U9q7B07neulLZuHfyqTLfED+3qRy/QTYsmE2hbsia4QdnDC32p5/xLEM0rz0sbVXqT2vPlcyu4
 LQZ0JRmJE9wGTl4DH1jg2O8zsmZCN8XoYVPGRRYy/GRYLVKNQY/oqLi37bnpichh9OwAZf62cX
 y4Vu2TxtR5OwQ/VkILPxnM1io9CW5b0Yr3QIyRY2JED0rYmNhR7M7InXvg1tZIk5POUVn0uLDv
 ntnzYQDnogtRXUfUZR/Gatj5mU7RSLvXf3QeJ3ontSEpt6udfSJULkvm07er4lTTRjvzJEEYT3
 CMo=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 03 Jan 2021 21:10:02 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V8 2/9] nvmet: add lba to sect conversion helpers
Date: Sun,  3 Jan 2021 21:09:31 -0800
Message-Id: <20210104050938.25745-3-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20210104050938.25745-1-chaitanya.kulkarni@wdc.com>
References: <20210104050938.25745-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210104_001004_710477_479B2FD5 
X-CRM114-Status: GOOD (  11.93  )
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
Cc: hch@lst.de, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

In this preparation patch, we add helpers to convert lbas to sectors & 
sectors to lba. This is needed to eliminate code duplication in the ZBD 
backend.

Use these helpers in the block device backend.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/io-cmd-bdev.c |  8 +++-----
 drivers/nvme/target/nvmet.h       | 10 ++++++++++
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index 125dde3f410e..23095bdfce06 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -256,8 +256,7 @@ static void nvmet_bdev_execute_rw(struct nvmet_req *req)
 	if (is_pci_p2pdma_page(sg_page(req->sg)))
 		op |= REQ_NOMERGE;
 
-	sector = le64_to_cpu(req->cmd->rw.slba);
-	sector <<= (req->ns->blksize_shift - 9);
+	sector = nvmet_lba_to_sect(req->ns, req->cmd->rw.slba);
 
 	if (req->transfer_len <= NVMET_MAX_INLINE_DATA_LEN) {
 		bio = &req->b.inline_bio;
@@ -345,7 +344,7 @@ static u16 nvmet_bdev_discard_range(struct nvmet_req *req,
 	int ret;
 
 	ret = __blkdev_issue_discard(ns->bdev,
-			le64_to_cpu(range->slba) << (ns->blksize_shift - 9),
+			nvmet_lba_to_sect(ns, range->slba),
 			le32_to_cpu(range->nlb) << (ns->blksize_shift - 9),
 			GFP_KERNEL, 0, bio);
 	if (ret && ret != -EOPNOTSUPP) {
@@ -414,8 +413,7 @@ static void nvmet_bdev_execute_write_zeroes(struct nvmet_req *req)
 	if (!nvmet_check_transfer_len(req, 0))
 		return;
 
-	sector = le64_to_cpu(write_zeroes->slba) <<
-		(req->ns->blksize_shift - 9);
+	sector = nvmet_lba_to_sect(req->ns, write_zeroes->slba);
 	nr_sector = (((sector_t)le16_to_cpu(write_zeroes->length) + 1) <<
 		(req->ns->blksize_shift - 9));
 
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 592763732065..8776dd1a0490 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -603,4 +603,14 @@ static inline bool nvmet_ns_has_pi(struct nvmet_ns *ns)
 	return ns->pi_type && ns->metadata_size == sizeof(struct t10_pi_tuple);
 }
 
+static inline __le64 nvmet_sect_to_lba(struct nvmet_ns *ns, sector_t sect)
+{
+	return cpu_to_le64(sect >> (ns->blksize_shift - SECTOR_SHIFT));
+}
+
+static inline sector_t nvmet_lba_to_sect(struct nvmet_ns *ns, __le64 lba)
+{
+	return le64_to_cpu(lba) << (ns->blksize_shift - SECTOR_SHIFT);
+}
+
 #endif /* _NVMET_H */
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

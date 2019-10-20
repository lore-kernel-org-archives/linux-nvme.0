Return-Path: <SRS0=Z/zs=YN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 631B7CA9EAD
	for <linux-nvme@archiver.kernel.org>; Sun, 20 Oct 2019 23:42:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3075B21928
	for <linux-nvme@archiver.kernel.org>; Sun, 20 Oct 2019 23:42:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="prwPnVeH";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Po9PsXfL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3075B21928
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=P+3PrnR4/wKGDg2f4Dw2DyVAa/XJQNYMJIIyxiB1eLM=; b=prwPnVeHvFVkZo
	svi0qz0xbbwg+ZaTLMC5kw+skyx9L9ffm5oa+haIM4a94ni+WY2twvUq1RcYUSfVeSx1bAbgBw+bM
	NaLZSTBocMenJIavF3N1dt2OXpZXHYEIa63FMaqzP5aCvypu1t5D1qR1mmqCFsE8mncCdaIm+fCss
	GAlNFj04UXw130npQXN3bGi4DTayoN9RbQOlItB4g8lAH+H3BSpU5d5Kw+1gGjsd6BnrsTkjzB0ET
	x/NSobnLRDcAP9yJB9s1sy+MOt0ksQvg7YGd00t1/AErcdBqTyYKAaaMsMEK++3aLZcdxpyt3qDvh
	2lK8waV/wh+MlsYGeduA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iMKqT-0000Fz-FC; Sun, 20 Oct 2019 23:42:45 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iMKq9-0008OJ-5P
 for linux-nvme@lists.infradead.org; Sun, 20 Oct 2019 23:42:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1571614945; x=1603150945;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=fSVJJZwvKl0netpa4sdM1YaY5nLWMEfZVkbALuqt6NI=;
 b=Po9PsXfLI1YVGzfap4crENpnE8EGXLw27Vekm55XYTJwDbajHytk6U/u
 +u0XD3/SeDc4NVkCEpUpd9ajt6M9eSPbx6d2jR3hl6pmtR2+1MunN9aSS
 /PuD+0mED5fPrXlngAf29LGVOH9JzYrKIAM0BfNbh+PgS4c2xu79yQubq
 /rWY6k4i1FSVmESp2CCx/aGcCFUMn8tksa4uXwGqHP9+G4ho17g67/yBv
 g1St9ZwaChKXXlbTnPqjlNMjguuAT2bYwUCD4KtqLy1wIedsIrJSl65/h
 c9SjvjEGBKmEVt91XDrXV8JYr0+YgGVikGfG4Y4jHpxba8f9wfC6sxTOV w==;
IronPort-SDR: 9cXBx7jNkz2bDxKIfoAsrbDIQv8TgX1sLgGaHHaRiPNkTamsA1StUwvArzFKEZjorkURVXVMrI
 fV5UFPDTSp5SUYb6K0SbhbuWIT/u4uXsFKMIzwHE1Tc0wdOAY1pvoCLiF0S+ib0Tfwiijn4+eR
 auUHw51beiM8bKsl/nHeMkQ6o5Rz+71J/olZebYG5q2HbLwUolshrVGRmKiR7YIKZnNvcdjVSw
 2Ti23ouun/kRaOvShAWOPKoXjCcZgsxShGR7uLEGot1S8rkuYvnBZY29WEP/w4K1Y1woXGiTwK
 M+0=
X-IronPort-AV: E=Sophos;i="5.67,321,1566835200"; d="scan'208";a="228036412"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 21 Oct 2019 07:42:24 +0800
IronPort-SDR: fCQMcQRgmyoHXVKahvZar0Wj8OL+AWIYvD/L4S0SOfz3CHVt2udwgJbt38qqLtYmR6V5DAd84A
 btJS+eE8+YfwE+GPqp20c6fjeTlr1Zfjd5poi10GqRt3AG5XkReybifwlhU1m8gZePx9o6+Ce9
 GKkQtekt9QBvtrykBAVa7EhnkKnK9NCkLt9VqjxS1GOvG7C7JrIL5F9zjJdMwAFD4My+aQwXGr
 PnZYSwXSO6lwyC781F7JN2CROdvcKF3krYB0QsuBZ6fzk2NKRwcAuul2y2i9M1wtGXL+ZyEPoC
 jt74KZh8Ttuo+AnOuCeq3ARP
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Oct 2019 16:38:05 -0700
IronPort-SDR: Ceu8fhDANrmFJUSTsSY8AgnkZRsn6qXkvVH6juAb8/yiCz+jbBlAATUiIT2zPQz0qAWSYlUYUd
 McD+cHNzbgN5hKmA4lPPxx8mn+SSdObzDt5Ef3TDTHQAmJrPJ7Abc82h2zqHG1Hf78zXO/MG+C
 nn1XS/bK+Yf2cK0EaxuzHmm1stbX7tsddwoUqZQDGa3cee/INPhMb+mIICdXFWqsr0kE+ZpZ0m
 8+WZADVM/DuQVn9vxX2HVsmXdaRaUWEk7TCFsxx6XaU3ZAdCAShNL+dlNqDnx1AP3q5wU8RqiW
 X+w=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
 by uls-op-cesaip01.wdc.com with ESMTP; 20 Oct 2019 16:42:24 -0700
From: Damien Le Moal <damien.lemoal@wdc.com>
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 2/2] nvme: Introduce nvme_block_sect()
Date: Mon, 21 Oct 2019 08:42:20 +0900
Message-Id: <20191020234220.14888-3-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191020234220.14888-1-damien.lemoal@wdc.com>
References: <20191020234220.14888-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191020_164225_208226_9121CF2D 
X-CRM114-Status: GOOD (  13.06  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Introduce the new helper function nvme_block_sect() to convert a device
logical block number to a 512B sector number. Use this new helper in
obvious places, cleaning up the code.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 drivers/nvme/host/core.c | 14 +++++++-------
 drivers/nvme/host/nvme.h |  8 ++++++++
 2 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index fa7ba09dca77..1945c18d4b62 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1647,7 +1647,7 @@ static void nvme_init_integrity(struct gendisk *disk, u16 ms, u8 pi_type)
 
 static void nvme_set_chunk_size(struct nvme_ns *ns)
 {
-	u32 chunk_size = (((u32)ns->noiob) << (ns->lba_shift - 9));
+	u32 chunk_size = nvme_block_sect(ns, ns->noiob);
 	blk_queue_chunk_sectors(ns->queue, rounddown_pow_of_two(chunk_size));
 }
 
@@ -1684,8 +1684,7 @@ static void nvme_config_discard(struct gendisk *disk, struct nvme_ns *ns)
 
 static void nvme_config_write_zeroes(struct gendisk *disk, struct nvme_ns *ns)
 {
-	u32 max_sectors;
-	unsigned short bs = 1 << ns->lba_shift;
+	u64 max_blocks;
 
 	if (!(ns->ctrl->oncs & NVME_CTRL_ONCS_WRITE_ZEROES) ||
 	    (ns->ctrl->quirks & NVME_QUIRK_DISABLE_WRITE_ZEROES))
@@ -1701,11 +1700,12 @@ static void nvme_config_write_zeroes(struct gendisk *disk, struct nvme_ns *ns)
 	 * nvme_init_identify() if available.
 	 */
 	if (ns->ctrl->max_hw_sectors == UINT_MAX)
-		max_sectors = ((u32)(USHRT_MAX + 1) * bs) >> 9;
+		max_blocks = (u64)USHRT_MAX + 1;
 	else
-		max_sectors = ((u32)(ns->ctrl->max_hw_sectors + 1) * bs) >> 9;
+		max_blocks = ns->ctrl->max_hw_sectors + 1;
 
-	blk_queue_max_write_zeroes_sectors(disk->queue, max_sectors);
+	blk_queue_max_write_zeroes_sectors(disk->queue,
+					   nvme_block_sect(ns, max_blocks));
 }
 
 static int nvme_report_ns_ids(struct nvme_ctrl *ctrl, unsigned int nsid,
@@ -1748,7 +1748,7 @@ static bool nvme_ns_ids_equal(struct nvme_ns_ids *a, struct nvme_ns_ids *b)
 static void nvme_update_disk_info(struct gendisk *disk,
 		struct nvme_ns *ns, struct nvme_id_ns *id)
 {
-	sector_t capacity = le64_to_cpu(id->nsze) << (ns->lba_shift - 9);
+	sector_t capacity = nvme_block_sect(ns, le64_to_cpu(id->nsze));
 	unsigned short bs = 1 << ns->lba_shift;
 	u32 atomic_bs, phys_bs, io_opt;
 
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index a979b62ea4b2..c629a37bc778 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -427,6 +427,14 @@ static inline u64 nvme_block_nr(struct nvme_ns *ns, sector_t sector)
 	return sector >> (ns->lba_shift - SECTOR_SHIFT);
 }
 
+/*
+ * Convert a logical block number to a 512B sector number.
+ */
+static inline sector_t nvme_block_sect(struct nvme_ns *ns, u64 lba)
+{
+	return lba << (ns->lba_shift - SECTOR_SHIFT);
+}
+
 static inline void nvme_end_request(struct request *req, __le16 status,
 		union nvme_result result)
 {
-- 
2.21.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

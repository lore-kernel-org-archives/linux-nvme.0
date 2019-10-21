Return-Path: <SRS0=hg6U=YO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC59FCA9EAC
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Oct 2019 03:40:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92EE821897
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Oct 2019 03:40:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Hxx+HLa2";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="gZKdMCv9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92EE821897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DB8LdloXjmEsle3p40485gn4JEEsU64Re6wfldXUsLQ=; b=Hxx+HLa2BlQuEr
	m2g7M/9z0Q6/M0hnm0pDxtPA69uPIPn8WG9Y8XV26CnAtCv0BmxGjdQvnlmNUOT73TTFJ3Si1zUt1
	pIyng6tM3qk1Y0jkx7Bmjy4i1eZjqFC9PsqbVG/op/gxqY1T0xk6eDToPcp6zS3G1x6HP1fOXo5vY
	+3GAR1nS+KU0bOD+08aFadCY0uAYJYjll5vuPt6YIJ1ExeX68sVufw750W7gdaYqObI6CL+sPD/N5
	xzh93U/bnM8gtmeU4NZ1+mYCcY+vrYaob2Pd4qYK+63cnSItHPCLHzstNYcimDvAHb0c/iLib205z
	R+4E0DZruZNjZ1ZyUGjQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iMOYu-0005rB-BI; Mon, 21 Oct 2019 03:40:52 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iMOYd-0005bd-6y
 for linux-nvme@lists.infradead.org; Mon, 21 Oct 2019 03:40:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1571629236; x=1603165236;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=J7WyRvqo3UbXsXANJ9cqX0+tOb31i78YTA41A9CQYN8=;
 b=gZKdMCv9KB7gz2l+4Px9sowElkhDBsRyBpMjL4T2HneuUQnkL0Kg/aDN
 3vlwX1LO8uRpWLWWMkRg6UGg0/j85dyjN55gff3FUTUl+/VNtLovh8Vy1
 SZbQz+hP/BxlwqGXe5Uwh5ZjULf+8w96JKfGZmHaMz47Cn7x+mid39p0f
 1urqYI54ICpL0AFxP8J8d58a/wUHsAapDjqTBFJkTOZLHlR8d8PpxU7vN
 UUqHOnOHjED79QY6IN8BS9mbF2rDLi+OtJDY6ob8kTnS+XkoH8xb9HqsF
 rERTDKlgOTIUW9xJrVO100xKDwKmGE+iVrye+emNQlNN19c9sOtVWfxvl Q==;
IronPort-SDR: DyZXFI5vfyq3fDJY8rDnwsEqccZ+Yk/DwlLQ1nYb3c3/guoQ1cJHNDVBi5Budx7CEKVq4dYEYu
 IPgejxsEEqpq5azUW842EMArOa0g7wuQixJCpwCEJCDmcZEjKFWQO90KWXyQ17iH8ggbFcUQ/b
 dDeAgE0Klf4ctc654sictBK4THIbzMunQbVa0WS7LB7a8TwnFAZ9jnWwcPKHbMUKsadLnNjw9g
 KsuTUL8hzCwS++cMrSzIBv5q3zORl+rOFHRLmqy1bZWwNXsSYPFsZwniEilvxvWfjQV4NYs8Sy
 c7I=
X-IronPort-AV: E=Sophos;i="5.67,322,1566835200"; d="scan'208";a="121721807"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 21 Oct 2019 11:40:10 +0800
IronPort-SDR: PHsOf/MrOuiKaN6oIAZsULC53l8Jp76hLVr4/QSGLJySq/9NwtYvGSnreYg2k3/ATzoBUGlnBy
 jFHxIvDk2QoCQI7xl8xjhegMiLmRTlM3r0OH7KKwSUCVCqMp9mAoqjm4ewDi2PzP3BmKjcz9SY
 u5LhYuFNdzaKeYFX6zQ+ahDcO9HIJ/ssaeTlx0ekQ1JcB5BAlsz9kn7nYsqqlaEjbtSVWBdxb8
 mtMOtj+0GWOT2Wrp0zCLPBgK5UIAiNEDO2vqh+f1Nzsl74Db6KHljt9lCIsE1vYCtlfvz2v6JJ
 2yfWuXvZ5ih2K8osSSp+G5AH
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Oct 2019 20:35:49 -0700
IronPort-SDR: mVFWyiIr1h+YcihDMA8WL/6VmOwWPzeOG9OOCtDBWXwpzhoxHeRJDeUoX95Iuxl5zJD3VyijaV
 HaWYpW4XDPLqLDY6cjhm5yd/fpD2YVVGnZaUXl38Vmq0j88VFoZ3CkVFZ7aMxea59ZVSSvrHH7
 VmU9LhNvRzeI0L8HpOPrXgKT7OOrfb/Nf0reduJisDAB6snBiRsdA5v+xqqfvhLpBkUTbQviLg
 WH0bNWyIjdeG0FVpkZrv31/hlM7wnlGh3a5GbZSPR5zU8ctZSXNLTYirTYxcFr5DT7rNvIxqMM
 rxQ=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
 by uls-op-cesaip01.wdc.com with ESMTP; 20 Oct 2019 20:40:08 -0700
From: Damien Le Moal <damien.lemoal@wdc.com>
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 2/2 v2] nvme: Introduce nvme_lba_to_sect()
Date: Mon, 21 Oct 2019 12:40:04 +0900
Message-Id: <20191021034004.11063-3-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191021034004.11063-1-damien.lemoal@wdc.com>
References: <20191021034004.11063-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191020_204035_267672_9AF41234 
X-CRM114-Status: GOOD (  13.09  )
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

Introduce the new helper function nvme_lba_to_sect() to convert a device
logical block number to a 512B sector number. Use this new helper in
obvious places, cleaning up the code.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 drivers/nvme/host/core.c | 14 +++++++-------
 drivers/nvme/host/nvme.h |  8 ++++++++
 2 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 6b37103b31d9..5a5d83dd9689 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1647,7 +1647,7 @@ static void nvme_init_integrity(struct gendisk *disk, u16 ms, u8 pi_type)
 
 static void nvme_set_chunk_size(struct nvme_ns *ns)
 {
-	u32 chunk_size = (((u32)ns->noiob) << (ns->lba_shift - 9));
+	u32 chunk_size = nvme_lba_to_sect(ns, ns->noiob);
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
+					   nvme_lba_to_sect(ns, max_blocks));
 }
 
 static int nvme_report_ns_ids(struct nvme_ctrl *ctrl, unsigned int nsid,
@@ -1748,7 +1748,7 @@ static bool nvme_ns_ids_equal(struct nvme_ns_ids *a, struct nvme_ns_ids *b)
 static void nvme_update_disk_info(struct gendisk *disk,
 		struct nvme_ns *ns, struct nvme_id_ns *id)
 {
-	sector_t capacity = le64_to_cpu(id->nsze) << (ns->lba_shift - 9);
+	sector_t capacity = nvme_lba_to_sect(ns, le64_to_cpu(id->nsze));
 	unsigned short bs = 1 << ns->lba_shift;
 	u32 atomic_bs, phys_bs, io_opt;
 
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 617ee8512f91..837ca66a7e33 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -427,6 +427,14 @@ static inline u64 nvme_sect_to_lba(struct nvme_ns *ns, sector_t sector)
 	return sector >> (ns->lba_shift - SECTOR_SHIFT);
 }
 
+/*
+ * Convert a device logical block number to a 512B sector number.
+ */
+static inline sector_t nvme_lba_to_sect(struct nvme_ns *ns, u64 lba)
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

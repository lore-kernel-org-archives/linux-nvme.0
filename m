Return-Path: <SRS0=0ID+=5Z=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F71CC2BA2B
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Apr 2020 16:10:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2542D2192A
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Apr 2020 16:10:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DJoOC6jC";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="KA6mXJEA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2542D2192A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/RY7Mkg8sHDpBloIdnIMRXElH0iykfneJcAElC0AXdE=; b=DJoOC6jC1XEbqZ
	54Pm7o1PZio++YH7X1ZgiVxB3yD2OHiHc/m83oHJTV47ZZTe8FUzy0yIHlJffKQTy5xmc/5LceSha
	yTjfKsIxKhp/yRtO4toDNHrJT8KLQM+5/b088LC6kmSRWynLWjvC9ga/OIQbaf6YHfwo5vPuiNLBK
	HMYXIoNppgm/8XhOt8+qlugXKCfj38rRxjMQiaEOH8/ix0T2BQYunUNTivl3XNBHiK5dot63m8k30
	80c2kJDlHvnfLZE0x/cKSlNTtd8XxD+XEbkVk5Wuyw7ancgsydw7tFX2Lcz/tgVRBd/zP5QqMd+F0
	wUhVcalodQIvLzDlSrtg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jMZlH-0005C2-2o; Thu, 09 Apr 2020 16:10:39 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jMZju-0001So-HD
 for linux-nvme@lists.infradead.org; Thu, 09 Apr 2020 16:09:16 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id CB016208E4;
 Thu,  9 Apr 2020 16:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1586448554;
 bh=wy//XnILmVutKm0reeUp4xAaNqQTOfU/VCgBux254n4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=KA6mXJEAwU3aAKw8r0Qco+pL/VxwaupnpdDV7SJk/4LmKpL4c9oLgxlNR7Ku8Ius+
 a3hhJ+cf2PaBj0jbMBFUev0Gltm3hIyyYOBxFeOMjpEMJKu/RebOj2ypmqwqx9EPco
 gsBU4R+pf0Khg9bN4OnXtGlOteC9XEq30wdxzfw8=
From: Keith Busch <kbusch@kernel.org>
To: linux-nvme@lists.infradead.org,
	hch@lst.de,
	sagi@grimberg.me
Subject: [PATCH 08/10] nvme: consolidate chunk_sectors settings
Date: Thu,  9 Apr 2020 09:09:06 -0700
Message-Id: <20200409160908.1889471-9-kbusch@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200409160908.1889471-1-kbusch@kernel.org>
References: <20200409160908.1889471-1-kbusch@kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200409_090914_618047_3970AB6F 
X-CRM114-Status: GOOD (  12.52  )
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
Cc: Keith Busch <kbusch@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Move the quirked chunk_sectors setting to the same location as noiob so
one place registers this setting. And since the noiob value is only used
locally, remove the member from struct nvme_ns.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/core.c | 22 ++++++++++------------
 drivers/nvme/host/nvme.h |  1 -
 2 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 081c9d47fb41..f80d65bb4308 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1725,12 +1725,6 @@ static void nvme_init_integrity(struct gendisk *disk, u16 ms, u8 pi_type)
 }
 #endif /* CONFIG_BLK_DEV_INTEGRITY */
 
-static void nvme_set_chunk_size(struct nvme_ns *ns)
-{
-	u32 chunk_size = nvme_lba_to_sect(ns, ns->noiob);
-	blk_queue_chunk_sectors(ns->queue, rounddown_pow_of_two(chunk_size));
-}
-
 static void nvme_config_discard(struct gendisk *disk, struct nvme_ns *ns)
 {
 	struct nvme_ctrl *ctrl = ns->ctrl;
@@ -1885,6 +1879,7 @@ static void nvme_update_disk_info(struct gendisk *disk,
 static void __nvme_revalidate_disk(struct gendisk *disk, struct nvme_id_ns *id)
 {
 	struct nvme_ns *ns = disk->private_data;
+	u32 iob;
 
 	/*
 	 * If identify namespace failed, use default 512 byte block size so
@@ -1893,7 +1888,13 @@ static void __nvme_revalidate_disk(struct gendisk *disk, struct nvme_id_ns *id)
 	ns->lba_shift = id->lbaf[id->flbas & NVME_NS_FLBAS_LBA_MASK].ds;
 	if (ns->lba_shift == 0)
 		ns->lba_shift = 9;
-	ns->noiob = le16_to_cpu(id->noiob);
+
+	if ((ns->ctrl->quirks & NVME_QUIRK_STRIPE_SIZE) &&
+	    is_power_of_2(ns->ctrl->max_hw_sectors))
+		iob = ns->ctrl->max_hw_sectors;
+	else
+		iob = nvme_lba_to_sect(ns, le16_to_cpu(id->noiob));
+
 	ns->ms = le16_to_cpu(id->lbaf[id->flbas & NVME_NS_FLBAS_LBA_MASK].ms);
 	ns->ext = ns->ms && (id->flbas & NVME_NS_FLBAS_META_EXT);
 	/* the PI implementation requires metadata equal t10 pi tuple size */
@@ -1902,8 +1903,8 @@ static void __nvme_revalidate_disk(struct gendisk *disk, struct nvme_id_ns *id)
 	else
 		ns->pi_type = 0;
 
-	if (ns->noiob)
-		nvme_set_chunk_size(ns);
+	if (iob)
+		blk_queue_chunk_sectors(ns->queue, rounddown_pow_of_two(iob));
 	nvme_update_disk_info(disk, ns, id);
 #ifdef CONFIG_NVME_MULTIPATH
 	if (ns->head->disk) {
@@ -2254,9 +2255,6 @@ static void nvme_set_queue_limits(struct nvme_ctrl *ctrl,
 		blk_queue_max_hw_sectors(q, ctrl->max_hw_sectors);
 		blk_queue_max_segments(q, min_t(u32, max_segments, USHRT_MAX));
 	}
-	if ((ctrl->quirks & NVME_QUIRK_STRIPE_SIZE) &&
-	    is_power_of_2(ctrl->max_hw_sectors))
-		blk_queue_chunk_sectors(q, ctrl->max_hw_sectors);
 	blk_queue_virt_boundary(q, ctrl->page_size - 1);
 	if (ctrl->vwc & NVME_CTRL_VWC_PRESENT)
 		vwc = true;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 6222439a0776..f3ab17778349 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -389,7 +389,6 @@ struct nvme_ns {
 #define NVME_NS_REMOVING	0
 #define NVME_NS_DEAD     	1
 #define NVME_NS_ANA_PENDING	2
-	u16 noiob;
 
 	struct nvme_fault_inject fault_inject;
 
-- 
2.24.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

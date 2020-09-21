Return-Path: <SRS0=B5n5=C6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFC5EC4363C
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Sep 2020 18:45:07 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DADF2084C
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Sep 2020 18:45:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Uy8Gp2yO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DADF2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:References:In-Reply-To:Message-Id:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/B6Sez+kYBSyWqG+gtU6xBndYPDZkYg2vNmD9H+efEQ=; b=Uy8Gp2yOl5W/F9286AwiSaXtdk
	UAIMEnegbumaJYIftb6gwQV6bY1TcOZlzylhziFFe/oaQXJ0lSKAl3ZRZi03PqCaaQ6lV+kRDGegx
	XM5tTrZJoQsMwzYeoVD6Kx4bXtRZVYqZjYYf1bfXXnyuwdLYMjRETGm2j4dmPawLwO9WfulpQq9yA
	csYC/s1A9vvG78s9tooculrLqanA8zz765ETWQBnEwEn+xvmUqZDSeF2Kl/X+LqKiCPT+G5CmGs9r
	glL9bKoSdysdyPFn8gfg459xOm9Lkg0YuezSecZHTQsfdjX/9KC2voRTmoiYEgpzzTB4RIPqbBJqw
	ZQVWAm6A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kKQoD-0004Wy-9G; Mon, 21 Sep 2020 18:45:05 +0000
Received: from mga07.intel.com ([134.134.136.100])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kKQoA-0004Ur-3e
 for linux-nvme@lists.infradead.org; Mon, 21 Sep 2020 18:45:03 +0000
IronPort-SDR: MPHj4C92jhFeK/77I7peBiw9u6EyH5K7eGwYu+ygm4EexDcCkxFsWhcKnggnzmpnOVWbd+W/N3
 bzo5BJnEr0xw==
X-IronPort-AV: E=McAfee;i="6000,8403,9751"; a="224605197"
X-IronPort-AV: E=Sophos;i="5.77,287,1596524400"; d="scan'208";a="224605197"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Sep 2020 11:45:00 -0700
IronPort-SDR: fOMXSJGvA8Fq6sXdnyaXSkSZe1s2lTCS6GrcoqIbu3dWfGuadBZOJ6Pb7O1Srv2hmLLQfEDPC/
 0qIutFG6hvhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,287,1596524400"; d="scan'208";a="334663819"
Received: from unknown (HELO nodlab-S2600WFT.lm.intel.com) ([10.232.116.103])
 by fmsmga004.fm.intel.com with ESMTP; 21 Sep 2020 11:44:59 -0700
From: Revanth Rajashekar <revanth.rajashekar@intel.com>
To: linux-nvme@lists.infradead.org,
	hch@lst.de
Subject: [PATCH 3/3] [backport] nvme: consolidate chunk_sectors settings
Date: Mon, 21 Sep 2020 12:47:28 -0600
Message-Id: <20200921184728.11291-4-revanth.rajashekar@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200921184728.11291-1-revanth.rajashekar@intel.com>
References: <20200921184728.11291-1-revanth.rajashekar@intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200921_144502_310782_F7EB0DBA 
X-CRM114-Status: GOOD (  17.97  )
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
Cc: kbusch@kernel.org, Revanth Rajashekar <revanth.rajashekar@intel.com>,
 damien.lemoal@wdc.com, backports@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Keith Busch <kbusch@kernel.org>

commit 38adf94e166e3cb4eb89683458ca578051e8218d

Move the quirked chunk_sectors setting to the same location as noiob so
one place registers this setting. And since the noiob value is only used
locally, remove the member from struct nvme_ns.

Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Revanth Rajashekar <revanth.rajashekar@intel.com>
---
 drivers/nvme/host/core.c | 22 ++++++++++------------
 drivers/nvme/host/nvme.h |  1 -
 2 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 9ac27c9a1..f8068d150 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1692,12 +1692,6 @@ static void nvme_init_integrity(struct gendisk *disk, u16 ms, u8 pi_type)
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
@@ -1852,6 +1846,7 @@ static void nvme_update_disk_info(struct gendisk *disk,
 static void __nvme_revalidate_disk(struct gendisk *disk, struct nvme_id_ns *id)
 {
 	struct nvme_ns *ns = disk->private_data;
+	u32 iob;

 	/*
 	 * If identify namespace failed, use default 512 byte block size so
@@ -1860,7 +1855,13 @@ static void __nvme_revalidate_disk(struct gendisk *disk, struct nvme_id_ns *id)
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
@@ -1869,8 +1870,8 @@ static void __nvme_revalidate_disk(struct gendisk *disk, struct nvme_id_ns *id)
 	else
 		ns->pi_type = 0;

-	if (ns->noiob)
-		nvme_set_chunk_size(ns);
+	if (iob)
+		blk_queue_chunk_sectors(ns->queue, rounddown_pow_of_two(iob));
 	nvme_update_disk_info(disk, ns, id);
 #ifdef CONFIG_NVME_MULTIPATH
 	if (ns->head->disk) {
@@ -2221,9 +2222,6 @@ static void nvme_set_queue_limits(struct nvme_ctrl *ctrl,
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
index 73065952f..a177b918f 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -376,7 +376,6 @@ struct nvme_ns {
 #define NVME_NS_REMOVING	0
 #define NVME_NS_DEAD     	1
 #define NVME_NS_ANA_PENDING	2
-	u16 noiob;

 	struct nvme_fault_inject fault_inject;

--
2.17.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

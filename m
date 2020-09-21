Return-Path: <SRS0=B5n5=C6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC1B5C4346E
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Sep 2020 18:45:06 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C3922084C
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Sep 2020 18:45:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EZh45FrQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C3922084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:References:In-Reply-To:Message-Id:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4qykzLETldmbK5eF8548bEUe2mGcAYOG2MvgIK+fJhM=; b=EZh45FrQXM+IM2n9i5ZYct4mxG
	IAWqlYQ8bWfHGR/dkDwL4ZYtcuebvupKX9R92fq0j4iRcssJgA1W2igfyviwTdvrX4xdHUZWPjCxE
	opdP1uTefeCrBA4XChw8MhEny0IDyEpu448ZBe4gGlG62LAjcDxAO0KqMT/EaNO7DjELVpZDaJelf
	8VSVHOgTTZ8NsoiOWjxExLUWjHY7Obe/2VUmMRN5ijt/cy6fnGZkuLmzCI7DrLqiQHuKbUXBPPT2G
	ElkT7GbzdxHCNgHa2y0x+R+HbVBzaiTSVjXqVIOxtStIy7zLXX/VpxEPe67xqmQVwwktiyst3mNdW
	WhOt66dQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kKQoC-0004WY-4I; Mon, 21 Sep 2020 18:45:04 +0000
Received: from mga07.intel.com ([134.134.136.100])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kKQo8-0004Ur-Eb
 for linux-nvme@lists.infradead.org; Mon, 21 Sep 2020 18:45:01 +0000
IronPort-SDR: sI5TEI5Eq8rmcRKj2tauN9Qnq0CY6cT7ZTNhVi8cZSPYmaIBz0dXZSsVOQZVMRaVtgzp5PJuGo
 AWBtHJ6Cp+HA==
X-IronPort-AV: E=McAfee;i="6000,8403,9751"; a="224605190"
X-IronPort-AV: E=Sophos;i="5.77,287,1596524400"; d="scan'208";a="224605190"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Sep 2020 11:44:58 -0700
IronPort-SDR: +X80abvLuBHaIgCdgRX6Y3MjwKHvLnWA1DuIoXGBSkZtxIIK013vxvWEwmvN3O2TxKVpt/hMDH
 lBZfwQ4F5Tig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,287,1596524400"; d="scan'208";a="334663806"
Received: from unknown (HELO nodlab-S2600WFT.lm.intel.com) ([10.232.116.103])
 by fmsmga004.fm.intel.com with ESMTP; 21 Sep 2020 11:44:57 -0700
From: Revanth Rajashekar <revanth.rajashekar@intel.com>
To: linux-nvme@lists.infradead.org,
	hch@lst.de
Subject: [PATCH 2/3] [backport] nvme: Introduce nvme_lba_to_sect()
Date: Mon, 21 Sep 2020 12:47:27 -0600
Message-Id: <20200921184728.11291-3-revanth.rajashekar@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200921184728.11291-1-revanth.rajashekar@intel.com>
References: <20200921184728.11291-1-revanth.rajashekar@intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200921_144500_659352_71FD18E0 
X-CRM114-Status: GOOD (  16.55  )
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

From: Damien Le Moal <damien.lemoal@wdc.com>

commit e08f2ae850929d40e66268ee47e443e7ea56eeb7

Introduce the new helper function nvme_lba_to_sect() to convert a device
logical block number to a 512B sector number. Use this new helper in
obvious places, cleaning up the code.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
Signed-off-by: Revanth Rajashekar <revanth.rajashekar@intel.com>
---
 drivers/nvme/host/core.c | 14 +++++++-------
 drivers/nvme/host/nvme.h |  8 ++++++++
 2 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f7d32eeee..9ac27c9a1 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1694,7 +1694,7 @@ static void nvme_init_integrity(struct gendisk *disk, u16 ms, u8 pi_type)

 static void nvme_set_chunk_size(struct nvme_ns *ns)
 {
-	u32 chunk_size = (((u32)ns->noiob) << (ns->lba_shift - 9));
+	u32 chunk_size = nvme_lba_to_sect(ns, ns->noiob);
 	blk_queue_chunk_sectors(ns->queue, rounddown_pow_of_two(chunk_size));
 }

@@ -1731,8 +1731,7 @@ static void nvme_config_discard(struct gendisk *disk, struct nvme_ns *ns)

 static void nvme_config_write_zeroes(struct gendisk *disk, struct nvme_ns *ns)
 {
-	u32 max_sectors;
-	unsigned short bs = 1 << ns->lba_shift;
+	u64 max_blocks;

 	if (!(ns->ctrl->oncs & NVME_CTRL_ONCS_WRITE_ZEROES) ||
 	    (ns->ctrl->quirks & NVME_QUIRK_DISABLE_WRITE_ZEROES))
@@ -1748,11 +1747,12 @@ static void nvme_config_write_zeroes(struct gendisk *disk, struct nvme_ns *ns)
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
@@ -1786,7 +1786,7 @@ static bool nvme_ns_ids_equal(struct nvme_ns_ids *a, struct nvme_ns_ids *b)
 static void nvme_update_disk_info(struct gendisk *disk,
 		struct nvme_ns *ns, struct nvme_id_ns *id)
 {
-	sector_t capacity = le64_to_cpu(id->nsze) << (ns->lba_shift - 9);
+	sector_t capacity = nvme_lba_to_sect(ns, le64_to_cpu(id->nsze));
 	unsigned short bs = 1 << ns->lba_shift;
 	u32 atomic_bs, phys_bs, io_opt;

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index f93ba2da1..73065952f 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -429,6 +429,14 @@ static inline u64 nvme_sect_to_lba(struct nvme_ns *ns, sector_t sector)
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
2.17.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

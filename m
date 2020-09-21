Return-Path: <SRS0=B5n5=C6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C84DBC35257
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Sep 2020 18:45:04 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 766372084C
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Sep 2020 18:45:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mapto6by"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 766372084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:References:In-Reply-To:Message-Id:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OTesJonc3yRWjz99P2Y9zCg0eF2fW2rNOVxryoFL4gw=; b=mapto6byEZ8GeC7u+bjCxGijZc
	e+zb4BqDQFlrcv2QEMiAFiefhptr3/zmEcyxfXOO4GjzJCAaUfDs5BRV3gp8vOW0KldCL4H0HpQ6h
	I18V5blsWtLliT2ZXbUygsOd/aQ5NCuao852ze42bAIrV34M+QgvKgxpWbwJ47V5RXiKa38pzY5Nv
	4IcSaJaGOkAwCMVwUsPh11IU0A0uR7lqsyy+/7PiHXOeP0wdfPqPHLjbXNE4uq7BsJKizYI2t4oUh
	AlMLkbFNQ1umBtKK7kxWNT5qbGVGo7SvrtKegFUH6Grfw0iXmVMUPWOioxm3R48S+cY0tYgmlOEx1
	FM/dWExg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kKQoA-0004VR-4B; Mon, 21 Sep 2020 18:45:02 +0000
Received: from mga07.intel.com ([134.134.136.100])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kKQo6-0004UI-Cn
 for linux-nvme@lists.infradead.org; Mon, 21 Sep 2020 18:44:59 +0000
IronPort-SDR: PXrvAn2HNrcE4sgDbJvfazbJ4Ljc+b8b4O11r3KCuco9e+6YfpW+NUQ9P9CsZ5Vjtwh0Joe44i
 VyRVOXT+UAnQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9751"; a="224605181"
X-IronPort-AV: E=Sophos;i="5.77,287,1596524400"; d="scan'208";a="224605181"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Sep 2020 11:44:55 -0700
IronPort-SDR: HXfVGUk2Pe9BpRHxJsrXVYoiwz4H9g9zfupcWsJtFzkc+zE0J9hLdIu6kXvra3sp6GxH/yl1LJ
 khuBw9qU1RJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,287,1596524400"; d="scan'208";a="334663793"
Received: from unknown (HELO nodlab-S2600WFT.lm.intel.com) ([10.232.116.103])
 by fmsmga004.fm.intel.com with ESMTP; 21 Sep 2020 11:44:55 -0700
From: Revanth Rajashekar <revanth.rajashekar@intel.com>
To: linux-nvme@lists.infradead.org,
	hch@lst.de
Subject: [PATCH 1/3] [backport] nvme: Cleanup and rename nvme_block_nr()
Date: Mon, 21 Sep 2020 12:47:26 -0600
Message-Id: <20200921184728.11291-2-revanth.rajashekar@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200921184728.11291-1-revanth.rajashekar@intel.com>
References: <20200921184728.11291-1-revanth.rajashekar@intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200921_144458_620364_314C4523 
X-CRM114-Status: GOOD (  15.39  )
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

commit 314d48dd224897e35ddcaf5a1d7d133b5adddeb7

Rename nvme_block_nr() to nvme_sect_to_lba() and use SECTOR_SHIFT
instead of its hard coded value 9. Also add a comment to decribe this
helper.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
Signed-off-by: Revanth Rajashekar <revanth.rajashekar@intel.com>
---
 drivers/nvme/host/core.c | 6 +++---
 drivers/nvme/host/nvme.h | 7 +++++--
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 071b63146..f7d32eeee 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -633,7 +633,7 @@ static blk_status_t nvme_setup_discard(struct nvme_ns *ns, struct request *req,
 	}

 	__rq_for_each_bio(bio, req) {
-		u64 slba = nvme_block_nr(ns, bio->bi_iter.bi_sector);
+		u64 slba = nvme_sect_to_lba(ns, bio->bi_iter.bi_sector);
 		u32 nlb = bio->bi_iter.bi_size >> ns->lba_shift;

 		if (n < segments) {
@@ -674,7 +674,7 @@ static inline blk_status_t nvme_setup_write_zeroes(struct nvme_ns *ns,
 	cmnd->write_zeroes.opcode = nvme_cmd_write_zeroes;
 	cmnd->write_zeroes.nsid = cpu_to_le32(ns->head->ns_id);
 	cmnd->write_zeroes.slba =
-		cpu_to_le64(nvme_block_nr(ns, blk_rq_pos(req)));
+		cpu_to_le64(nvme_sect_to_lba(ns, blk_rq_pos(req)));
 	cmnd->write_zeroes.length =
 		cpu_to_le16((blk_rq_bytes(req) >> ns->lba_shift) - 1);
 	cmnd->write_zeroes.control = 0;
@@ -698,7 +698,7 @@ static inline blk_status_t nvme_setup_rw(struct nvme_ns *ns,

 	cmnd->rw.opcode = (rq_data_dir(req) ? nvme_cmd_write : nvme_cmd_read);
 	cmnd->rw.nsid = cpu_to_le32(ns->head->ns_id);
-	cmnd->rw.slba = cpu_to_le64(nvme_block_nr(ns, blk_rq_pos(req)));
+	cmnd->rw.slba = cpu_to_le64(nvme_sect_to_lba(ns, blk_rq_pos(req)));
 	cmnd->rw.length = cpu_to_le16((blk_rq_bytes(req) >> ns->lba_shift) - 1);

 	if (req_op(req) == REQ_OP_WRITE && ctrl->nr_streams)
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index ed0226086..f93ba2da1 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -421,9 +421,12 @@ static inline int nvme_reset_subsystem(struct nvme_ctrl *ctrl)
 	return ctrl->ops->reg_write32(ctrl, NVME_REG_NSSR, 0x4E564D65);
 }

-static inline u64 nvme_block_nr(struct nvme_ns *ns, sector_t sector)
+/*
+ * Convert a 512B sector number to a device logical block number.
+ */
+static inline u64 nvme_sect_to_lba(struct nvme_ns *ns, sector_t sector)
 {
-	return (sector >> (ns->lba_shift - 9));
+	return sector >> (ns->lba_shift - SECTOR_SHIFT);
 }

 static inline void nvme_end_request(struct request *req, __le16 status,
--
2.17.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

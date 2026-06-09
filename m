Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A973CD8CAE
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Jun 2026 06:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=HHtxEV2ysy8PSEmM0vhrH6LZB5pbR1AMbeZymTwvFms=; b=TlYgmRucjrSbi8i7uMfaPty82O
	pFKslCeWFaHsncZbUGy9gfgt78Tx61MliObxBXeYayn6AjmINDIaksr+BRovxSbQUJArqxFkYCx6m
	xdk0LVVOq4rZDfwjiwcxYtS0B0YBky6/jpUbbegsTJmog2P7zqbsKR2Ylgc3nFG0pw9lbhzkYa9CN
	oOWeXkc5g2PotnmkjQEctv68iYK6El7roFBMoJzMPv3EpDo0ufOCdNlqjulL+A/vF4ZZM8hvtlhVd
	DbVw9NvQ56UF44EZ0hcUYoN8ghuWRYRnRAUxCMBhCHiQGrY44hxFqs18y9fa13Eo1VvBD6K0hA751
	Ol+ZYTHA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWpzw-00000004sRM-2mp0;
	Tue, 09 Jun 2026 06:31:40 +0000
Received: from mailgw.kylinos.cn ([124.126.103.232])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWpzt-00000004sOT-0f0Z
	for linux-nvme@lists.infradead.org;
	Tue, 09 Jun 2026 06:31:39 +0000
X-UUID: d59aa35063cc11f1aa26b74ffac11d73-20260609
X-CTIC-Tags: HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_EXISTED, SN_EXISTED
	SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_GOOD, CIE_GOOD_SPF
	GTI_FG_BS, GTI_RG_INFO, GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:95719915-c169-42c1-9e45-399d7e072dd5,IP:10,
	URL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:35
X-CID-INFO: VERSION:1.3.12,REQID:95719915-c169-42c1-9e45-399d7e072dd5,IP:10,UR
	L:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:35
X-CID-META: VersionHash:e7bac3a,CLOUDID:41e8fdd281dad083ebc367bbc5574d5c,BulkI
	D:260609143126IZHXRP7B,BulkQuantity:0,Recheck:0,SF:17|19|66|78|102|127|850
	|865|898,TC:nil,Content:0|15|50,EDM:5,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil
	,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:
	0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_FSD,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: d59aa35063cc11f1aa26b74ffac11d73-20260609
X-User: sangyao@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <sangyao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 57210125; Tue, 09 Jun 2026 14:31:23 +0800
From: Yao Sang <sangyao@kylinos.cn>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	Yao Sang <sangyao@kylinos.cn>
Subject: [PATCH] nvme-multipath: revalidate zones for namespace heads
Date: Tue,  9 Jun 2026 14:31:02 +0800
Message-Id: <20260609063102.2689195-1-sangyao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260608_233137_510339_1EB811D1 
X-CRM114-Status: GOOD (  14.83  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Zoned multipath namespace heads get BLK_FEAT_ZONED and their limits are
refreshed from the paths, but the zone state for the head disk is never
initialized.  The previous nr_zones assignment only updated a single
field and did not allocate or populate the block layer's per-zone state.

That leaves the head disk without valid zone condition information.  Code
using the head device, such as bdev_zone_is_seq(), can then treat a
sequential zone as non-sequential and submit regular writes to it.

Add a small helper to run blk_revalidate_disk_zones() for a live zoned
namespace head after the path limits have been committed and when a path
becomes live.  Return the error to the namespace update path, and keep the
live path transition as a warning-only update.  Drop the nr_zones copy, as
blk_revalidate_disk_zones() updates it together with the rest of the zoned
disk state.

Signed-off-by: Yao Sang <sangyao@kylinos.cn>
---
The failure was found with xfstests xfs/643 and xfs/646 on an NVMe
ZNS multipath namespace. Tracing showed regular REQ_OP_WRITE I/O being
submitted to sequential zones through the multipath head.

The head queue had the zoned limits stacked from the path, but the head
gendisk had not gone through blk_revalidate_disk_zones(). That left the
block layer per-zone state missing on the head disk, so users of the head
device could treat sequential zones as non-sequential.

The fix keeps the existing limit stacking and revalidates zones for the
live namespace head, so nr_zones, zone conditions and zone write plug state
are initialized together.

tested with:
- xfstests: xfs/643, xfs/646
- blktests: nvme/005, nvme/057, nvme/058
- blktests: zbd/011, zbd/012, zbd/013, block/004
  zbd/001, zbd/002, zbd/003, zbd/004,
  zbd/005, zbd/006

 drivers/nvme/host/core.c      |  4 ++++
 drivers/nvme/host/multipath.c | 24 ++++++++++++++++++++----
 drivers/nvme/host/nvme.h      |  9 +++++++++
 3 files changed, 33 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index efaddab8296e..0e28b83156c0 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2589,11 +2589,15 @@ static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_ns_info *info)
 		lim.max_write_streams = ns_lim->max_write_streams;
 		lim.write_stream_granularity = ns_lim->write_stream_granularity;
 		ret = queue_limits_commit_update(ns->head->disk->queue, &lim);
+		if (ret)
+			goto unfreeze_head_queue;
 
 		set_capacity_and_notify(ns->head->disk, get_capacity(ns->disk));
 		set_disk_ro(ns->head->disk, nvme_ns_is_readonly(ns, info));
 		nvme_mpath_revalidate_paths(ns->head);
+		ret = nvme_mpath_revalidate_zones(ns->head);
 
+unfreeze_head_queue:
 		blk_mq_unfreeze_queue(ns->head->disk->queue, memflags);
 	}
 
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 96337ae2b552..0a94a9af5fe8 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -285,6 +285,25 @@ void nvme_mpath_revalidate_paths(struct nvme_ns_head *head)
 	kblockd_schedule_work(&head->requeue_work);
 }
 
+#ifdef CONFIG_BLK_DEV_ZONED
+int nvme_mpath_revalidate_zones(struct nvme_ns_head *head)
+{
+	struct gendisk *disk = head->disk;
+	int ret;
+
+	if (!disk || !blk_queue_is_zoned(disk->queue) ||
+	    !test_bit(NVME_NSHEAD_DISK_LIVE, &head->flags))
+		return 0;
+
+	ret = blk_revalidate_disk_zones(disk);
+	if (ret)
+		dev_warn_ratelimited(disk_to_dev(disk),
+				     "failed to revalidate zoned namespace head: %d\n",
+				     ret);
+	return ret;
+}
+#endif /* CONFIG_BLK_DEV_ZONED */
+
 static bool nvme_path_is_disabled(struct nvme_ns *ns)
 {
 	enum nvme_ctrl_state state = nvme_ctrl_state(ns->ctrl);
@@ -812,6 +831,7 @@ static void nvme_mpath_set_live(struct nvme_ns *ns)
 	mutex_unlock(&head->lock);
 
 	synchronize_srcu(&head->srcu);
+	nvme_mpath_revalidate_zones(head);
 	kblockd_schedule_work(&head->requeue_work);
 }
 
@@ -1368,10 +1388,6 @@ void nvme_mpath_add_disk(struct nvme_ns *ns, __le32 anagrpid)
 		nvme_mpath_set_live(ns);
 	}
 
-#ifdef CONFIG_BLK_DEV_ZONED
-	if (blk_queue_is_zoned(ns->queue) && ns->head->disk)
-		ns->head->disk->nr_zones = ns->disk->nr_zones;
-#endif
 }
 
 void nvme_mpath_remove_disk(struct nvme_ns_head *head)
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index b367c67dcb37..60cad6959562 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -1181,6 +1181,15 @@ static inline bool nvme_mpath_queue_if_no_path(struct nvme_ns_head *head)
 }
 #endif /* CONFIG_NVME_MULTIPATH */
 
+#if defined(CONFIG_NVME_MULTIPATH) && defined(CONFIG_BLK_DEV_ZONED)
+int nvme_mpath_revalidate_zones(struct nvme_ns_head *head);
+#else
+static inline int nvme_mpath_revalidate_zones(struct nvme_ns_head *head)
+{
+	return 0;
+}
+#endif
+
 int nvme_ns_get_unique_id(struct nvme_ns *ns, u8 id[16],
 		enum blk_unique_id type);
 
-- 
2.25.1



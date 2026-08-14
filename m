Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B8CCC5CFC1
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Aug 2026 07:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=0SSEVWJCG+Lgg8ZduN4FQN+cYBYNPkj4Ffqy6MXzuT0=; b=I3F+nkkqkyl/2oxmYcvtdsxo3k
	GFR+W1gdaal/Uz7v1EzTjRXdIKBlcswQaO59csRSLXWsDenYvhq1AEuwb98HWCKjHj+Fs5b+Ggrnz
	2q8FHOnMbdmZ6vaVsuSzxyjSpdD7qLNop8Sb9PHMZkZov/1RBDS0r/Dhukcxh+vHKH5mWhFXkEnaZ
	GRq2/tJenJ9FA8KcIXAaH0hnJT8FPWREI1olzjXPzErDksbuHum6BRxRMfWMCX4IxVwfG2EfULpse
	k6Whtu3bIcmC+Bs3nvNTH6m4VMoqGOj1JXyB3Zei/wtFSOeNgAY7ythg1PNvq85k37NTf/NJ5Xsnf
	9FMqOInA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wum16-000000025SQ-1yzL;
	Fri, 14 Aug 2026 07:07:48 +0000
Received: from mailgw.kylinos.cn ([124.126.103.232])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wum13-000000025R7-0jkI
	for linux-nvme@lists.infradead.org;
	Fri, 14 Aug 2026 07:07:47 +0000
X-UUID: cf6079fe97ae11f1aa26b74ffac11d73-20260814
X-CTIC-Tags: HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED, SA_EXISTED
	SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
	CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_FG_IT, GTI_RG_INFO
	GTI_C_BU, AMN_T1, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:b2648bd2-54aa-4a3a-ab07-8c4a16507aa1,IP:10,
	URL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:35
X-CID-INFO: VERSION:1.3.12,REQID:b2648bd2-54aa-4a3a-ab07-8c4a16507aa1,IP:10,UR
	L:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:35
X-CID-META: VersionHash:e7bac3a,CLOUDID:00e1a9dd50dc1fabd36aef7fbf1d1bb4,BulkI
	D:260814150733A65TT2VW,BulkQuantity:0,Recheck:0,SF:10|66|78|102|127|850|86
	5|898,TC:nil,Content:0|15|50,EDM:5,IP:-2,URL:99|1,File:nil,RT:nil,Bulk:nil
	,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:
	0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: cf6079fe97ae11f1aa26b74ffac11d73-20260814
X-User: sangyao@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <sangyao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 118617006; Fri, 14 Aug 2026 15:07:28 +0800
From: Yao Sang <sangyao@kylinos.cn>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	dwagner@suse.de,
	hare@suse.de,
	johannes.thumshirn@wdc.com,
	martin.petersen@oracle.com,
	javier.gonz@samsung.com,
	linux-kernel@vger.kernel.org,
	Yao Sang <sangyao@kylinos.cn>
Subject: [PATCH] nvme: fix command effects log lifetime for multipath heads
Date: Fri, 14 Aug 2026 15:06:51 +0800
Message-Id: <20260814070651.3973067-1-sangyao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260814_000745_513545_01DA4364 
X-CRM114-Status: GOOD (  16.78  )
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

KASAN reported a use-after-free when an I/O passthrough command was sent
through a multipath namespace head after the controller path that first
created the head had been removed:

  BUG: KASAN: slab-use-after-free in nvme_command_effects+0x192/0x200 [nvme_core]
  Read of size 4 at addr ffff888141b14400 by task nvme/19811
  nvme_command_effects+0x192/0x200 [nvme_core]
  nvme_cmd_allowed+0x7e/0x1b0 [nvme_core]
  nvme_user_cmd.constprop.0+0x1b5/0x450 [nvme_core]
  nvme_ns_head_chr_ioctl+0xf4/0x2a0 [nvme_core]

The report showed the command effects log was allocated from
nvme_get_effects_log() during controller probe and freed from
nvme_free_ctrl() when that controller was removed.

The command effects logs are cached in ctrl->cels and freed with the
controller.  A namespace head, however, is shared by all paths to the
same namespace.  Storing the first path's log pointer in the namespace
head leaves the head pointing at controller-owned memory after that path
is removed, even though another path still keeps the namespace head alive.

Keep the command effects log pointer in struct nvme_ns instead. The
multipath head ioctl path already selects a live namespace path before
checking command effects, so use the log owned by that path's controller.

Fixes: be93e87e7802 ("nvme: support for multiple Command Sets Supported and Effects log pages")
Signed-off-by: Yao Sang <sangyao@kylinos.cn>
---
A blktests regression test has been posted as nvme/070:
https://lore.kernel.org/r/20260814070019.3860097-1-sangyao@kylinos.cn

 drivers/nvme/host/core.c | 15 +++++++--------
 drivers/nvme/host/nvme.h |  3 ++-
 drivers/nvme/host/zns.c  |  2 +-
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 1322c678f4eb..7d062236e2bd 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1236,7 +1236,7 @@ u32 nvme_command_effects(struct nvme_ctrl *ctrl, struct nvme_ns *ns, u8 opcode)
 	u32 effects = 0;
 
 	if (ns) {
-		effects = le32_to_cpu(ns->head->effects->iocs[opcode]);
+		effects = le32_to_cpu(ns->effects->iocs[opcode]);
 		if (effects & ~(NVME_CMD_EFFECTS_CSUPP | NVME_CMD_EFFECTS_LBCC))
 			dev_warn_once(ctrl->device,
 				"IO command:%02x has unusual effects:%08x\n",
@@ -4033,13 +4033,6 @@ static struct nvme_ns_head *nvme_alloc_ns_head(struct nvme_ctrl *ctrl,
 	ratelimit_set_flags(&head->rs_nuse, RATELIMIT_MSG_ON_RELEASE);
 	kref_init(&head->ref);
 
-	if (head->ids.csi) {
-		ret = nvme_get_effects_log(ctrl, head->ids.csi, &head->effects);
-		if (ret)
-			goto out_cleanup_srcu;
-	} else
-		head->effects = ctrl->effects;
-
 	ret = nvme_mpath_alloc_disk(ctrl, head);
 	if (ret)
 		goto out_cleanup_srcu;
@@ -4132,6 +4125,12 @@ static int nvme_init_ns_head(struct nvme_ns *ns, struct nvme_ns_info *info)
 	}
 
 	mutex_lock(&ctrl->subsys->lock);
+	ret = nvme_get_effects_log(ctrl, info->ids.csi, &ns->effects);
+	if (ret) {
+		if (ret > 0)
+			ret = blk_status_to_errno(nvme_error_status(ret));
+		goto out_unlock;
+	}
 	head = nvme_find_ns_head(ctrl, info->nsid);
 	if (!head) {
 		ret = nvme_subsys_check_duplicate_ids(ctrl->subsys, &info->ids);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 75e5d5a8a77c..54044b15af90 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -553,7 +553,6 @@ struct nvme_ns_head {
 	bool			shared;
 	bool			rotational;
 	bool			passthru_err_log_enabled;
-	struct nvme_effects_log *effects;
 	u64			nuse;
 	unsigned		ns_id;
 	int			instance;
@@ -618,6 +617,8 @@ struct nvme_ns {
 	struct list_head siblings;
 	struct kref kref;
 	struct nvme_ns_head *head;
+	/* Command effects log for this controller path. */
+	struct nvme_effects_log *effects;
 
 	unsigned long flags;
 #define NVME_NS_REMOVING		0
diff --git a/drivers/nvme/host/zns.c b/drivers/nvme/host/zns.c
index 2a152e87bd76..29130b3697d1 100644
--- a/drivers/nvme/host/zns.c
+++ b/drivers/nvme/host/zns.c
@@ -38,7 +38,7 @@ static int nvme_set_max_append(struct nvme_ctrl *ctrl)
 int nvme_query_zone_info(struct nvme_ns *ns, unsigned lbaf,
 		struct nvme_zone_info *zi)
 {
-	struct nvme_effects_log *log = ns->head->effects;
+	struct nvme_effects_log *log = ns->effects;
 	struct nvme_command c = { };
 	struct nvme_id_ns_zns *id;
 	int status;
-- 
2.25.1



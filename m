Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB6E7C5CFC1
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Aug 2026 07:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	bh=SbejNXDcB/ldAWM2bJ2DC7YnA/8/Chg8xD9Zqdd0Hgw=; b=lLGd/cZ8rIvVgRv9psTkrhaMVr
	ahAFn4WQbvlMZn/bD6bY9FNsoyc/1rZa5IY76g5FejKE1bNVLahL9+qldUclqqG9NWKF+IUcXbN/C
	iwtQcxwhjAl4mrRKBuV1a4XiM6ZVscbu9tNGj7mgUo7ZHo3Fpt4sLYa5jmuIZxeKP3NXNsKBvkJli
	H7ivjivBw/FEFD/dkBNsdZ+vkui2VtBu98e4EDDxXqgl3vCSuvAenTFwWQLGOHuvSp4cqry9dOUPc
	RX+znWQO3uom3CPjli8TxLIAqyL9SbBFkhLnjQfTqrFdp+ZLO6FpJP2JHe4NzqkSd1UwcSpgyEPdv
	hLqWfxIA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wvrWZ-00000005WZN-3DF8;
	Mon, 17 Aug 2026 07:12:47 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wvrWU-00000005WYF-2rUq
	for linux-nvme@lists.infradead.org;
	Mon, 17 Aug 2026 07:12:46 +0000
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20260817071235epoutp02ae13e306b537af48c9239999b78e238f~Mhj6TyRkG1159111591epoutp02-
	for <linux-nvme@lists.infradead.org>; Mon, 17 Aug 2026 07:12:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20260817071235epoutp02ae13e306b537af48c9239999b78e238f~Mhj6TyRkG1159111591epoutp02-
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1786950755;
	bh=SbejNXDcB/ldAWM2bJ2DC7YnA/8/Chg8xD9Zqdd0Hgw=;
	h=From:To:Cc:Subject:Date:References:From;
	b=MVe/y08s+dFdnBoZPU573IRmla31K4iQF6t//1sE0qtRE/ouekMFXMFocMYPvdZXp
	 LbGRFENU7khQdvVGMMgsOLDBHYN4b4wj3l19MmbExNP2vBX2jX4BAKlD7aXUngqSRz
	 bhsuV87Z1n53b6n2u6G/dOjdTSQ26b1zWrdlwLR4=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20260817071235epcas5p35bea68161ae1dc8d0bd57a73da338f1d~Mhj6CCihE1640116401epcas5p37;
	Mon, 17 Aug 2026 07:12:35 +0000 (GMT)
Received: from epcas5p4.samsung.com (unknown [182.195.38.86]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4hNkYZ1vrlz2SSKZ; Mon, 17 Aug
	2026 07:12:34 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20260817071233epcas5p19cd2497118e33c212af714ad84b06ac8~Mhj4Hh4lm2748727487epcas5p1m;
	Mon, 17 Aug 2026 07:12:33 +0000 (GMT)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260817071231epsmtip17d838ac8d4a53ee14d204a01846750f9~Mhj26H51N2913829138epsmtip1h;
	Mon, 17 Aug 2026 07:12:31 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: kbusch@kernel.org, hch@lst.de, harimishal1@gmail.com, sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org, gregkh@linuxfoundation.org, Kanchan
	Joshi <joshi.k@samsung.com>
Subject: [PATCH] nvme: fix racy access to FDP placement id array
Date: Mon, 17 Aug 2026 12:41:58 +0530
Message-Id: <20260817071158.2794-1-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260817071233epcas5p19cd2497118e33c212af714ad84b06ac8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260817071233epcas5p19cd2497118e33c212af714ad84b06ac8
References: <CGME20260817071233epcas5p19cd2497118e33c212af714ad84b06ac8@epcas5p1.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260817_001243_382750_BF10772F 
X-CRM114-Status: GOOD (  20.50  )
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

nvme_query_fdp_info() is called per-path and therefore prone to races.

It populates head->nr_plids/head->plids for fdp registration.
But nothing protects that pair from concurrent access - two paths scanning
the same namespace can race to populate it.

Avoid the race by moving this initialization work to nvme_alloc_ns_head()
which is called once per shared namespace.

Fixes: 30b5f20bb2dd ("nvme: register fdp parameters with the block layer")
Reported-by: Hari Mishal <harimishal1@gmail.com>
Link: https://lore.kernel.org/linux-nvme/20260725135111.14041-2-harimishal1@gmail.com/
Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
---
 drivers/nvme/host/core.c | 38 +++++++++++++++++---------------------
 drivers/nvme/host/nvme.h |  1 +
 2 files changed, 18 insertions(+), 21 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 1322c678f4eb..c62c8f37979b 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2341,14 +2341,6 @@ static int nvme_query_fdp_info(struct nvme_ns *ns, struct nvme_ns_info *info)
 	size_t size;
 	int i, ret;
 
-	/*
-	 * The FDP configuration is static for the lifetime of the namespace,
-	 * so return immediately if we've already registered this namespace's
-	 * streams.
-	 */
-	if (head->nr_plids)
-		return 0;
-
 	ret = nvme_get_features(ctrl, NVME_FEAT_FDP, info->endgid, NULL, 0,
 				&fdp);
 	if (ret) {
@@ -2395,6 +2387,7 @@ static int nvme_query_fdp_info(struct nvme_ns *ns, struct nvme_ns_info *info)
 
 	for (i = 0; i < head->nr_plids; i++)
 		head->plids[i] = le16_to_cpu(ruhs->ruhsd[i].pid);
+	head->write_stream_granularity = min(info->runs, U32_MAX);
 free:
 	kfree(ruhs);
 	return ret;
@@ -2442,12 +2435,6 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
 			goto out;
 	}
 
-	if (ns->ctrl->ctratt & NVME_CTRL_ATTR_FDPS) {
-		ret = nvme_query_fdp_info(ns, info);
-		if (ret < 0)
-			goto out;
-	}
-
 	if (nvme_invalid_lba_sz(le64_to_cpu(id->nsze),
 			id->lbaf[lbaf].ds - SECTOR_SHIFT, &capacity)) {
 		dev_warn_once(ns->ctrl->device,
@@ -2490,10 +2477,7 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
 		capacity = 0;
 
 	lim.max_write_streams = ns->head->nr_plids;
-	if (lim.max_write_streams)
-		lim.write_stream_granularity = min(info->runs, U32_MAX);
-	else
-		lim.write_stream_granularity = 0;
+	lim.write_stream_granularity = ns->head->write_stream_granularity;
 
 	/*
 	 * Only set the DEAC bit if the device guarantees that reads from
@@ -4001,10 +3985,11 @@ static void nvme_add_ns_cdev(struct nvme_ns *ns)
 	set_bit(NVME_NS_CDEV_LIVE, &ns->flags);
 }
 
-static struct nvme_ns_head *nvme_alloc_ns_head(struct nvme_ctrl *ctrl,
+static struct nvme_ns_head *nvme_alloc_ns_head(struct nvme_ns *ns,
 		struct nvme_ns_info *info)
 	__must_hold(&ctrl->subsys->lock)
 {
+	struct nvme_ctrl *ctrl = ns->ctrl;
 	struct nvme_ns_head *head;
 	size_t size = sizeof(*head);
 	int ret = -ENOMEM;
@@ -4040,15 +4025,26 @@ static struct nvme_ns_head *nvme_alloc_ns_head(struct nvme_ctrl *ctrl,
 	} else
 		head->effects = ctrl->effects;
 
+	if (ctrl->ctratt & NVME_CTRL_ATTR_FDPS) {
+		ns->head = head;
+		ret = nvme_query_fdp_info(ns, info);
+		if (ret < 0)
+			goto out_clear_ns_head;
+	}
+
 	ret = nvme_mpath_alloc_disk(ctrl, head);
 	if (ret)
-		goto out_cleanup_srcu;
+		goto out_cleanup_fdp;
 
 	list_add_tail(&head->entry, &ctrl->subsys->nsheads);
 
 	kref_get(&ctrl->subsys->ref);
 
 	return head;
+out_cleanup_fdp:
+	kfree(head->plids);
+out_clear_ns_head:
+	ns->head = NULL;
 out_cleanup_srcu:
 	cleanup_srcu_struct(&head->srcu);
 out_ida_remove:
@@ -4141,7 +4137,7 @@ static int nvme_init_ns_head(struct nvme_ns *ns, struct nvme_ns_info *info)
 				info->nsid);
 			goto out_unlock;
 		}
-		head = nvme_alloc_ns_head(ctrl, info);
+		head = nvme_alloc_ns_head(ns, info);
 		if (IS_ERR(head)) {
 			ret = PTR_ERR(head);
 			goto out_unlock;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 75e5d5a8a77c..c20e8ef8baa0 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -571,6 +571,7 @@ struct nvme_ns_head {
 
 	u16			nr_plids;
 	u16			*plids;
+	u32			write_stream_granularity;
 #ifdef CONFIG_NVME_MULTIPATH
 	struct bio_list		requeue_list
 		__guarded_by(&requeue_lock);
-- 
2.25.1



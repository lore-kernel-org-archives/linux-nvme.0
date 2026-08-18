Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9A72C5DF67
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Aug 2026 06:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EsS2WpuQ78f1+PLmhLQx4yDIi+iJ4s+h13yCa0uKg0Q=; b=hpV+luPGT0Ezh9tsBmYZakjtTs
	emPmEseiZNMeOlCM7bTZGDrgTEh6Q44cU4ZeTUPlmFrqDNBk3fKRRYvMCb9BwNrO36ZbtBdRW2/4Q
	KVBZwWuRbeJQeURe4hMbYEpILhReNw97jt/hX8GwdrhufWcUmlRrQOp79CFRZV0UJxVn39cq47EEB
	6pKtyBgeOTDlI3zjnFk7HHhUAn6iGBXuAfQc8IGvjG6eRRTzXJ5k5gmkFx3fZgtxX62VkFZDsm9Rt
	x0du6z6kzEotns3mUrbC+5zCD2guncety5LLIyZfrtBKneDKhfWjE/jmbEr1S+WbjZp/byoVDtezN
	fIBf5AiA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwCvP-00000007NLp-0lZT;
	Tue, 18 Aug 2026 06:03:51 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwCvK-00000007NFi-30ge
	for linux-nvme@lists.infradead.org;
	Tue, 18 Aug 2026 06:03:48 +0000
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20260818060335epoutp03602d8172cdd3041c3b29edea86457daf~M0Q8-z7h42951029510epoutp03K
	for <linux-nvme@lists.infradead.org>; Tue, 18 Aug 2026 06:03:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20260818060335epoutp03602d8172cdd3041c3b29edea86457daf~M0Q8-z7h42951029510epoutp03K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1787033015;
	bh=EsS2WpuQ78f1+PLmhLQx4yDIi+iJ4s+h13yCa0uKg0Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HlAS+CRi4Rn3tZMArb0eveMUxyWv/b6M4YcH1KRa3tgUAeSFl+FcZF3SzZAp2X/c4
	 hDoz91oitjlmzUfDotPkIWhc/eib67fTEj1K11Fv/p7GvI7/dubxqMtHtUgSo8EWCy
	 xh5jHVTLCD2PaDotO4/fL+Nhg3ula3m6hkIKK6/Q=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
	20260818060335epcas5p2e9e5983ce7264bc238cc2dfda13d9924~M0Q8vLbKy1455214552epcas5p2W;
	Tue, 18 Aug 2026 06:03:35 +0000 (GMT)
Received: from epcas5p3.samsung.com (unknown [182.195.38.87]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4hPJzT5Hxdz6B9m6; Tue, 18 Aug
	2026 06:03:33 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20260818060333epcas5p348cde01f8ce24cff3dd0de782f0bf48f~M0Q65cic82349123491epcas5p36;
	Tue, 18 Aug 2026 06:03:33 +0000 (GMT)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260818060332epsmtip1e7ea88e708d29910e1288b3783efbfd0~M0Q50igMn3115631156epsmtip1G;
	Tue, 18 Aug 2026 06:03:32 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: kbusch@kernel.org, hch@lst.de, harimishal1@gmail.com, sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org, gregkh@linuxfoundation.org,
	gost.dev@samsung.com, Kanchan Joshi <joshi.k@samsung.com>
Subject: [PATCH v2 2/2] nvme: fix racy access to FDP placement id array
Date: Tue, 18 Aug 2026 11:32:53 +0530
Message-Id: <20260818060253.4104-3-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260818060253.4104-1-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260818060333epcas5p348cde01f8ce24cff3dd0de782f0bf48f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260818060333epcas5p348cde01f8ce24cff3dd0de782f0bf48f
References: <20260818060253.4104-1-joshi.k@samsung.com>
	<CGME20260818060333epcas5p348cde01f8ce24cff3dd0de782f0bf48f@epcas5p3.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260817_230347_100542_2BEA474D 
X-CRM114-Status: GOOD (  19.29  )
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
 drivers/nvme/host/core.c | 30 +++++++++++-------------------
 drivers/nvme/host/nvme.h |  1 +
 2 files changed, 12 insertions(+), 19 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index a2e0abf0ea8a..aa3c3b7d5544 100644
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
@@ -4042,15 +4026,23 @@ static struct nvme_ns_head *nvme_alloc_ns_head(struct nvme_ns *ns,
 	} else
 		head->effects = ctrl->effects;
 
+	if (ctrl->ctratt & NVME_CTRL_ATTR_FDPS) {
+		ret = nvme_query_fdp_info(ns, info);
+		if (ret < 0)
+			goto out_cleanup_srcu;
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
 out_cleanup_srcu:
 	cleanup_srcu_struct(&head->srcu);
 out_ida_remove:
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



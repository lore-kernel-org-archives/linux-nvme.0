Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6E3FC02181
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Jan 2025 07:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ZJrz+cwq3RPHWsZm1fbuGv+qRDE+SgYxwDacQqNg1Kk=; b=LZ/huHHQzbFdF/NMdS8A/kUEYa
	BiMoRuw9VItV6Zi5iIaemIAxJSwp9Evcrhee1oLDk4p6NfJ8BLEDCIqU25Z59JAzovKLwxRfm8RKE
	GPWh46Xo+X/iFi7dxyvn7DJ+5qd/bLtMRxo3G9YMaTZekG4PeCSsu7kfNHNxwPTfzSvKPbPgFuISQ
	RJ7oNy4Ei2jV0xleZ++c0laZIeUzMspygwvpr7eKMGwWQVNeY3s4h8POrI4q298ahL13uWQqJ7IEe
	hgy2N/obA1TjTR2v/CkIYDoQqdQEGVkUAHxykkuxQAsFjPLcl4NnEwy8L0QQD4XvUmm2FxIVkS8yl
	bC4Qu4Eg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tbDtW-0000000E5T3-0TcU;
	Fri, 24 Jan 2025 07:14:22 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tbDtU-0000000E5SI-1EdY
	for linux-nvme@lists.infradead.org;
	Fri, 24 Jan 2025 07:14:21 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id BFB48A40CFC;
	Fri, 24 Jan 2025 07:12:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 769D2C4CED2;
	Fri, 24 Jan 2025 07:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737702858;
	bh=nEvLTour6pu8g2UnkzRVXUUPngLccNPpVyrkZr3zeQE=;
	h=From:To:Cc:Subject:Date:From;
	b=vI8KLPTEuPc01FhP+de4NCkR8oSpo1nCAWjpVUgvaY6B5U5VmSJkxNo6ZJJsZms+Q
	 P9QcUpB2g9di1Z4Jd0X6Qvxw2mcMkMCIcmx8WXmJxjUlirWEo+Z8gmFvXkuWUroLCH
	 WM+xKwOygps3aBepOHqSIYQuoDTGHC+UY60xHOnEZq7bpC+FB/nfBy7hRWhSEEIcfS
	 plyD7/++3u6Jy02aS9TZHdSsq/hP50JCSEtbZ761VGSo7ov5Pho+vKSSW74EpEBBB0
	 se0IYbGSeHxfDw6Te1WpgDoiKbc8+FOp+pVtNo4wQTz11spJ3hlIDK5WUPGhe3c1SV
	 Tta+dhVAPuqHw==
From: hare@kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH] nvmet: remove max_nsid calculation
Date: Fri, 24 Jan 2025 08:14:14 +0100
Message-Id: <20250124071414.104643-1-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250123_231420_396183_9B9D2353 
X-CRM114-Status: GOOD (  10.11  )
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

From: Hannes Reinecke <hare@kernel.org>

We never look at the 'max_nsid' value, and it's questionable
whether it is even calculated correctly. So remove it.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/nvme/target/core.c  | 18 ------------------
 drivers/nvme/target/nvmet.h |  1 -
 2 files changed, 19 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index a058f473652c..78ba6162361a 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -121,18 +121,6 @@ u16 nvmet_zero_sgl(struct nvmet_req *req, off_t off, size_t len)
 	return 0;
 }
 
-static u32 nvmet_max_nsid(struct nvmet_subsys *subsys)
-{
-	struct nvmet_ns *cur;
-	unsigned long idx;
-	u32 nsid = 0;
-
-	nvmet_for_each_enabled_ns(&subsys->namespaces, idx, cur)
-		nsid = cur->nsid;
-
-	return nsid;
-}
-
 static u32 nvmet_async_event_result(struct nvmet_async_event *aen)
 {
 	return aen->event_type | (aen->event_info << 8) | (aen->log_page << 16);
@@ -657,8 +645,6 @@ void nvmet_ns_free(struct nvmet_ns *ns)
 	mutex_lock(&subsys->lock);
 
 	xa_erase(&subsys->namespaces, ns->nsid);
-	if (ns->nsid == subsys->max_nsid)
-		subsys->max_nsid = nvmet_max_nsid(subsys);
 
 	mutex_unlock(&subsys->lock);
 
@@ -708,9 +694,6 @@ struct nvmet_ns *nvmet_ns_alloc(struct nvmet_subsys *subsys, u32 nsid)
 	if (percpu_ref_init(&ns->ref, nvmet_destroy_namespace, 0, GFP_KERNEL))
 		goto out_free;
 
-	if (ns->nsid > subsys->max_nsid)
-		subsys->max_nsid = nsid;
-
 	if (xa_insert(&subsys->namespaces, ns->nsid, ns, GFP_KERNEL))
 		goto out_exit;
 
@@ -729,7 +712,6 @@ struct nvmet_ns *nvmet_ns_alloc(struct nvmet_subsys *subsys, u32 nsid)
 
 	return ns;
 out_exit:
-	subsys->max_nsid = nvmet_max_nsid(subsys);
 	percpu_ref_exit(&ns->ref);
 out_free:
 	kfree(ns);
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 62a554b00951..4dc7ba5d02a7 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -316,7 +316,6 @@ struct nvmet_subsys {
 
 	struct xarray		namespaces;
 	unsigned int		nr_namespaces;
-	u32			max_nsid;
 	u16			cntlid_min;
 	u16			cntlid_max;
 
-- 
2.35.3



Return-Path: <SRS0=UXA3=OE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 083DFC433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Sep 2021 06:40:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9BD661157
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Sep 2021 06:40:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B9BD661157
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pg7o0nVk5drIa6+O3Ip7YSC6opzr17sZVHFSU4V74Hc=; b=xkNjYtTZWWwOY0
	qAza8Ws7nRSIFRdDPcmw7k5PF5FOxRyRjPADOaOMMwxVR8uSWy3CqVcFMBGGfFWgkrnBBCtn3n2tq
	YLfePBwEF1C3aof+DAJnHChscdqwuNkibroNQhP+/USrvre8fRJim/POOZiw+1iIUOPIjfwYRbgAc
	f8w7o8GoJ09YiaaXfKpo2Ot7KjRIvVEnLHgnaMIiDv4fwjZCYiSeIWvAt4oWnJABWDLPf+mutP8a7
	x/9QkvyjGtk50KRWDKuNZIiUn4w9+x4Gs8Zw8bAdFHu3C6YrVxziXSrnjUITf/oqQzcXPe2lViTY6
	bPGfETQso1NqbArRwSWQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mQ27D-004J5z-9F; Tue, 14 Sep 2021 06:40:23 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mQ27A-004J5M-9U
 for linux-nvme@lists.infradead.org; Tue, 14 Sep 2021 06:40:21 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id A35C168B05; Tue, 14 Sep 2021 08:40:16 +0200 (CEST)
Date: Tue, 14 Sep 2021 08:40:16 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Anton Eidelman <anton.eidelman@gmail.com>,
 linux-nvme@lists.infradead.org, axboe@fb.com,
 Anton Eidelman <anton@lightbitslabs.com>,
 Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH v2 3/3] nvme/multipath: fix stale ana state for
 namespaces just added by scan work
Message-ID: <20210914064016.GB27942@lst.de>
References: <20210912185459.13496-4-anton@lightbitslabs.com>
 <20210913153023.70879-1-anton@lightbitslabs.com>
 <20210913153023.70879-4-anton@lightbitslabs.com>
 <20210913160310.GC6442@lst.de>
 <20210913160831.GC3283786@dhcp-10-100-145-180.wdc.com>
 <520b56e9-cac4-3cd7-9d2e-16633c6e7df5@grimberg.me>
 <20210914063052.GA27942@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210914063052.GA27942@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210913_234020_678347_3EEE437C 
X-CRM114-Status: GOOD (  29.27  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Sep 14, 2021 at 08:30:52AM +0200, Christoph Hellwig wrote:
> On Tue, Sep 14, 2021 at 09:24:30AM +0300, Sagi Grimberg wrote:
> > I agree it should not happen with xarray as inserts preserve sorting,
> > but that patch has the non-trivial removal of the namespaces_rwsem which
> > synchronizes in a lot in a lot of error recovery flows. It's very
> > possible that xarray will introduce regressions.
> 
> I've actually started looking over the series earlier today, and staring
> it I'm pretty sure the namespaces_rwsem is completely broken.  There
> is nothing preventing the namespaces from going away in these loops.
> 
> But I can't see why we don't just always do a sorted insertation into
> the ->namespaces list.  Just trying to figure out the history of the
> delayed sort ATM.

Anton, can you try this instead of your last patch?


diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 97f8211cf92c1..3e3c835777458 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -13,7 +13,6 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/backing-dev.h>
-#include <linux/list_sort.h>
 #include <linux/slab.h>
 #include <linux/types.h>
 #include <linux/pr.h>
@@ -3716,15 +3715,6 @@ static int nvme_init_ns_head(struct nvme_ns *ns, unsigned nsid,
 	return ret;
 }
 
-static int ns_cmp(void *priv, const struct list_head *a,
-		const struct list_head *b)
-{
-	struct nvme_ns *nsa = container_of(a, struct nvme_ns, list);
-	struct nvme_ns *nsb = container_of(b, struct nvme_ns, list);
-
-	return nsa->head->ns_id - nsb->head->ns_id;
-}
-
 struct nvme_ns *nvme_find_get_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 {
 	struct nvme_ns *ns, *ret = NULL;
@@ -3745,6 +3735,23 @@ struct nvme_ns *nvme_find_get_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 }
 EXPORT_SYMBOL_NS_GPL(nvme_find_get_ns, NVME_TARGET_PASSTHRU);
 
+/*
+ * Add the namespace to the controller list while keeping the list ordered.
+ */
+static void nvme_ns_add_to_ctrl_list(struct nvme_ns *ns)
+{
+	struct nvme_ns *tmp;
+
+	list_for_each_entry_reverse(tmp, &ns->ctrl->namespaces, list) {
+		if (tmp->head->ns_id < ns->head->ns_id) {
+			list_add(&tmp->list, &ns->ctrl->namespaces);
+			return;
+		}
+	}
+
+	list_add_tail(&ns->list, &ns->ctrl->namespaces);
+}
+
 static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid,
 		struct nvme_ns_ids *ids)
 {
@@ -3794,10 +3801,9 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid,
 	if (nvme_update_ns_info(ns, id))
 		goto out_unlink_ns;
 
-	down_write(&ctrl->namespaces_rwsem);
-	list_add_tail(&ns->list, &ctrl->namespaces);
-	up_write(&ctrl->namespaces_rwsem);
-
+	down_write(&ns->ctrl->namespaces_rwsem);
+	nvme_ns_add_to_ctrl_list(ns);
+	up_write(&ns->ctrl->namespaces_rwsem);
 	nvme_get_ctrl(ctrl);
 
 	if (device_add_disk(ctrl->device, ns->disk, nvme_ns_id_attr_groups))
@@ -4082,10 +4088,6 @@ static void nvme_scan_work(struct work_struct *work)
 	if (nvme_scan_ns_list(ctrl) != 0)
 		nvme_scan_ns_sequential(ctrl);
 	mutex_unlock(&ctrl->scan_lock);
-
-	down_write(&ctrl->namespaces_rwsem);
-	list_sort(NULL, &ctrl->namespaces, ns_cmp);
-	up_write(&ctrl->namespaces_rwsem);
 }
 
 /*

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

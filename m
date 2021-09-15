Return-Path: <SRS0=dHSS=OF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAEF1C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Sep 2021 07:21:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D26160EE9
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Sep 2021 07:21:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7D26160EE9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=T7tDMXaP3DIqP37LhyNvbD5FmOptepd21VaP+EmkGAI=; b=lOO0UmpfbJVWca
	l5RbbSGwVVbxvvcfILnJZV6IQ2hX6ZrioZU9dq5pfiodRy1D6x2V5hYboQLJDzFgPBKKmqiR33BYv
	09+Mi1AjsfH01cZoK6tOaSctltlO2FtQtNTT3VPk3D+xOBIB+PHxY3jjrN+boM/or4bPpZEoYnN9+
	at+Ig+RDKCaqUUhVUvToYqupTVsN8HK10W9Q0HuC9Gpb3lPeck+V3gEg8rVcreXxgIIRUrOVyyuyu
	nxrtxmbVQTaYBGMEIXs9zvmY4eMuiTR3rkFhTZLUVyBW4vcMACHt2m+woHCKQpIHQvmiAE//zPENs
	6ZvkjxPWp4mZPPssKFZw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mQPEU-008HxT-Be; Wed, 15 Sep 2021 07:21:26 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mQPE5-008HxL-K2
 for linux-nvme@bombadil.infradead.org; Wed, 15 Sep 2021 07:21:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=jmIZ1KGsiiT4GpkPqfwLj5LaEEKfVDu/O5se9uQnGWc=; b=nhKqyfqJEVRZNBci27Wx/SmCV1
 ERQ0bZ3QtLl5kIwOopQ1poM0Yt+Fi69ydpfpBI+XNIUr8uIYg/8KBvtFLoqAzEUZr7V2335Bo6YUW
 nOQ1FIOQOm3GT+DOaP2tK/Z3qPlGZbXTvWKQK/d//OSO3DcPaFYJj12ZI+yADMFvI6pQZSlqz2clw
 cjVO2wfl41sFf4GMECN5eCyTLryHKvx8bHfjKm58CYqhUGdtwOgajpqbvtnyPLCLuobyMd68fkOLA
 eS6Q10XAm66D+7cLb9y8RB8jlajVx6NowQCrficoyv4n1mdARqKfqqegsiPP/3jSH8EIxYQB6X6wc
 32JTh+pg==;
Received: from [2001:4bb8:184:72db:8457:d7a:6e21:dd20] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mQPDD-00FSLa-72; Wed, 15 Sep 2021 07:20:22 +0000
From: Christoph Hellwig <hch@lst.de>
To: kbusch@kernel.org,
	sagi@grimberg.me
Cc: anton.eidelman@gmail.com,
	linux-nvme@lists.infradead.org
Subject: [PATCH] nvme: keep ctrl->namespaces ordered
Date: Wed, 15 Sep 2021 09:20:06 +0200
Message-Id: <20210915072006.956307-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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

Various places in the nvme code that rely on ctrl->namespace to be
ordered.  Ensure that the namespae is inserted into the list at the
right position from the start instead of sorting it after the fact.

Fixes: 540c801c65eb ("NVMe: Implement namespace list scanning")
Reported-by: Anton Eidelman <anton.eidelman@gmail.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 38 ++++++++++++++++++++------------------
 1 file changed, 20 insertions(+), 18 deletions(-)

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
-- 
2.30.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

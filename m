Return-Path: <SRS0=Q2qb=ZS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C954C432C0
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Nov 2019 22:27:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F4AC2071E
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Nov 2019 22:27:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XZvp4izZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F4AC2071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=exVNVkjZZyqm6Zt8rKWlD3inDDUPkj5ZQAjg5oI59Fw=; b=XZvp4izZHaaJSU
	1l4fTWN5zPHLSRfPwFO00v93+wfhEcdp9r76mWO8AbReuCZaNTX7cifbrQ6fddDIGWhOO86hXcTV7
	aTkVYOHTqGyQ4LzzJSHw5lhzCjevNZDb+r1tJqXyK7bgpkiQfboW95olZpuYu3VcPuOEEeE81//WN
	NLST5lNsOc1c3+BVEHdGOLWbS67cnG7JP8EKfGXDcu+q4cKokbZf5ypLTI1kVU1wqoMguOiOTc0xE
	TrqHnCQJQEpj25IVIq/6O9/49vofWp+31jxQRruJMmJPiK1NUAbUwGyxJvZDaxvTJwHEqvPLLFB1H
	IiNF1T8aBDaSVwfF2GlA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iZjIl-0007UR-0a; Tue, 26 Nov 2019 22:27:19 +0000
Received: from mga07.intel.com ([134.134.136.100])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iZjIh-0007R3-Ho
 for linux-nvme@lists.infradead.org; Tue, 26 Nov 2019 22:27:16 +0000
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 26 Nov 2019 14:27:13 -0800
X-IronPort-AV: E=Sophos;i="5.69,247,1571727600"; d="scan'208";a="211562926"
Received: from unknown (HELO caliente.lm.intel.com) ([10.232.116.67])
 by orsmga006-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 26 Nov 2019 14:27:13 -0800
From: Edmund Nadolski <edmund.nadolski@intel.com>
To: edmund.nadolski@intel.com, linux-nvme@lists.infradead.org,
 kbusch@kernel.org
Subject: [PATCH v2 1/1] nvme: remove unused return code from nvme_alloc_ns
Date: Tue, 26 Nov 2019 15:26:32 -0700
Message-Id: <20191126222632.2446-2-edmund.nadolski@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191126222632.2446-1-edmund.nadolski@intel.com>
References: <20191126222632.2446-1-edmund.nadolski@intel.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191126_142715_629226_F20154C2 
X-CRM114-Status: GOOD (  12.22  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

The return code of nvme_alloc_ns is never used, so change it
to void. Emit an informative message if an error occurs.

Signed-off-by: Edmund Nadolski <edmund.nadolski@intel.com>
---
 drivers/nvme/host/core.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index e6ee34376c5e..69c407d3d9ba 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3486,17 +3486,17 @@ static int nvme_setup_streams_ns(struct nvme_ctrl *ctrl, struct nvme_ns *ns)
 	return 0;
 }
 
-static int nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
+static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 {
 	struct nvme_ns *ns;
 	struct gendisk *disk;
 	struct nvme_id_ns *id;
 	char disk_name[DISK_NAME_LEN];
-	int node = ctrl->numa_node, flags = GENHD_FL_EXT_DEVT, ret;
+	int node = ctrl->numa_node, flags = GENHD_FL_EXT_DEVT, ret = -ENOMEM;
 
 	ns = kzalloc_node(sizeof(*ns), GFP_KERNEL, node);
 	if (!ns)
-		return -ENOMEM;
+		goto out;
 
 	ns->queue = blk_mq_init_queue(ctrl->tagset);
 	if (IS_ERR(ns->queue)) {
@@ -3525,10 +3525,8 @@ static int nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 	if (ret)
 		goto out_free_queue;
 
-	if (id->ncap == 0) {
-		ret = -EINVAL;
+	if (id->ncap == 0)
 		goto out_free_id;
-	}
 
 	ret = nvme_init_ns_head(ns, nsid, id);
 	if (ret)
@@ -3571,7 +3569,7 @@ static int nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 	nvme_fault_inject_init(&ns->fault_inject, ns->disk->disk_name);
 	kfree(id);
 
-	return 0;
+	return;
  out_put_disk:
 	put_disk(ns->disk);
  out_unlink_ns:
@@ -3585,9 +3583,9 @@ static int nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 	blk_cleanup_queue(ns->queue);
  out_free_ns:
 	kfree(ns);
-	if (ret > 0)
-		ret = blk_status_to_errno(nvme_error_status(ret));
-	return ret;
+ out:
+	dev_warn(ctrl->device, "could not allocate %sns.\n",
+		(ret == -ENOMEM) ? "memory for " : "" );
 }
 
 static void nvme_ns_remove(struct nvme_ns *ns)
-- 
2.20.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

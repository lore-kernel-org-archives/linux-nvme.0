Return-Path: <SRS0=HRbs=ZT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3056C432C0
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Nov 2019 17:18:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52991206E0
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Nov 2019 17:18:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="k8JurwXx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52991206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pOPQnvVbRYLQFNavTB365n3McvRfynhoPo+P2HF/cq8=; b=k8JurwXxLCj2qk
	jySjlBJOmacR7RDFV3K4p5HTjnLYqhypQm9QzUX+RAZrrBUTerki3dTxXBU6uAf2qGSiFO3eZ/wIQ
	X4o2yFfJTfjVoljP+VzMDhAZomMloDZusCNRag5RsbL61hcLD/55XAUHHnWQFAWy2OBslYxqB7mNc
	ha0P/5HeKC/9iU9kb2oyU9OJMaFud3PG9FM+E9/6AdO6pepjBkEslxJMIiyURNl+LA4sWJfkIbek0
	EeQbmuPXfp8AeQZp8RIXhlbBLyFG46syDqf6ebbCekszDkGBlPHWE9xLAFw2IHRh856kTh6mOhJWZ
	oeFlbSX6/p3D09nWE0ZQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ia0xT-0007ZL-2c; Wed, 27 Nov 2019 17:18:31 +0000
Received: from mga02.intel.com ([134.134.136.20])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ia0xN-0007TP-AX
 for linux-nvme@lists.infradead.org; Wed, 27 Nov 2019 17:18:26 +0000
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 27 Nov 2019 09:18:23 -0800
X-IronPort-AV: E=Sophos;i="5.69,250,1571727600"; d="scan'208";a="203138896"
Received: from unknown (HELO caliente.lm.intel.com) ([10.232.116.67])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 27 Nov 2019 09:18:23 -0800
From: Edmund Nadolski <edmund.nadolski@intel.com>
To: edmund.nadolski@intel.com, linux-nvme@lists.infradead.org,
 kbusch@kernel.org
Subject: [PATCH v3 1/1] nvme: remove unused return code from nvme_alloc_ns
Date: Wed, 27 Nov 2019 10:17:43 -0700
Message-Id: <20191127171743.32730-2-edmund.nadolski@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191127171743.32730-1-edmund.nadolski@intel.com>
References: <20191127171743.32730-1-edmund.nadolski@intel.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191127_091825_422170_ABF0660A 
X-CRM114-Status: GOOD (  10.71  )
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
to void.

Signed-off-by: Edmund Nadolski <edmund.nadolski@intel.com>
---
 drivers/nvme/host/core.c | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index e6ee34376c5e..34ef1e4e0799 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3486,7 +3486,7 @@ static int nvme_setup_streams_ns(struct nvme_ctrl *ctrl, struct nvme_ns *ns)
 	return 0;
 }
 
-static int nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
+static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 {
 	struct nvme_ns *ns;
 	struct gendisk *disk;
@@ -3496,13 +3496,11 @@ static int nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 
 	ns = kzalloc_node(sizeof(*ns), GFP_KERNEL, node);
 	if (!ns)
-		return -ENOMEM;
+		return;
 
 	ns->queue = blk_mq_init_queue(ctrl->tagset);
-	if (IS_ERR(ns->queue)) {
-		ret = PTR_ERR(ns->queue);
+	if (IS_ERR(ns->queue))
 		goto out_free_ns;
-	}
 
 	if (ctrl->opts && ctrl->opts->data_digest)
 		ns->queue->backing_dev_info->capabilities
@@ -3525,10 +3523,8 @@ static int nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 	if (ret)
 		goto out_free_queue;
 
-	if (id->ncap == 0) {
-		ret = -EINVAL;
+	if (id->ncap == 0)	/* no namespace (legacy quirk) */
 		goto out_free_id;
-	}
 
 	ret = nvme_init_ns_head(ns, nsid, id);
 	if (ret)
@@ -3537,10 +3533,8 @@ static int nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 	nvme_set_disk_name(disk_name, ns, ctrl, &flags);
 
 	disk = alloc_disk_node(0, node);
-	if (!disk) {
-		ret = -ENOMEM;
+	if (!disk)
 		goto out_unlink_ns;
-	}
 
 	disk->fops = &nvme_fops;
 	disk->private_data = ns;
@@ -3571,7 +3565,7 @@ static int nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 	nvme_fault_inject_init(&ns->fault_inject, ns->disk->disk_name);
 	kfree(id);
 
-	return 0;
+	return;
  out_put_disk:
 	put_disk(ns->disk);
  out_unlink_ns:
@@ -3585,9 +3579,6 @@ static int nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 	blk_cleanup_queue(ns->queue);
  out_free_ns:
 	kfree(ns);
-	if (ret > 0)
-		ret = blk_status_to_errno(nvme_error_status(ret));
-	return ret;
 }
 
 static void nvme_ns_remove(struct nvme_ns *ns)
-- 
2.20.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

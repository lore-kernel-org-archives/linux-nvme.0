Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2EBDC02193
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Feb 2025 21:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Rp5fYvpzjxUhO+asCrm+VjHu/niZwZ9xyrFGLn7LK14=; b=zy70XnYvnQ8un4DdNKRfMCSCSN
	ennwt6//DPnv55rV0LwnsJjMME2YJwB3/4TyopkARDz2ePb2K+6i930VOGyto4u8bLRDfNW3Y8dFZ
	PMJ08PbbVDM83P6ODajb3IDBTzHilRnYKkpzlmEqdNk+xE+Wv7pSTd+lolBg5ty02Qwu2mMQUUqSf
	6PS2IGsuDe104Cd2kR62hI9jUnZIPPiil9zXdyItMkwSvjybsxe9oLOuNdGMO5giqOCGUrxfTnba6
	qmwp7fFp+o9FCXrmWTWQrjvbqQuCs9/X7ax8q/tTtciwP/G3XpzpSOBvuad60nwh3+hce9gvsK8JY
	iolnVCeg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tfQEl-00000001YzV-2ND3;
	Tue, 04 Feb 2025 21:13:39 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tfQEi-00000001Yz8-1Tcf
	for linux-nvme@lists.infradead.org;
	Tue, 04 Feb 2025 21:13:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738703614;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Rp5fYvpzjxUhO+asCrm+VjHu/niZwZ9xyrFGLn7LK14=;
	b=QXlySsAy9rwxVH8rLM8wdwh8hPost8yIzB+BOW6vxsRlLptHZ4HqBVm1yNgUMeGWbegAqB
	9fhhKete7jBNUA0Jepg/Jhum3yaCaU8B9J7ceu0L02vGGYwavrVlMvNzkVTB1/7KZ9lolO
	7qsRK+UsI0O+zOP2rvR9OR2LuKmxhg8=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-232-Fp5HKAoWOwi7S6GDu3ztIA-1; Tue,
 04 Feb 2025 16:13:32 -0500
X-MC-Unique: Fp5HKAoWOwi7S6GDu3ztIA-1
X-Mimecast-MFC-AGG-ID: Fp5HKAoWOwi7S6GDu3ztIA
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 869391956087;
	Tue,  4 Feb 2025 21:13:30 +0000 (UTC)
Received: from bgurney-thinkpadp1gen5.remote.csb (unknown [10.22.65.73])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0A86830001BE;
	Tue,  4 Feb 2025 21:13:27 +0000 (UTC)
From: Bryan Gurney <bgurney@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	kbusch@kernel.org,
	hch@lst.de,
	sagi@grimberg.me,
	axboe@kernel.dk
Cc: jmeneghi@redhat.com,
	bmarzins@redhat.com,
	Bryan Gurney <bgurney@redhat.com>
Subject: [PATCH] nvme: remove multipath module parameter
Date: Tue,  4 Feb 2025 16:11:58 -0500
Message-ID: <20250204211158.43126-1-bgurney@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250204_131336_459263_E1517B0E 
X-CRM114-Status: GOOD (  15.01  )
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

Since device-mapper multipath will no longer be operating on NVMe
devices, there is no longer a need for the "multipath" parameter.

Note that, when compiled with CONFIG_NVME_MULTIPATH off multi-path
capable controllers and namespaces will continue to present multiple
device entries - one for each controller/namespace discovered.  This
could be confusing, as device-mapper multipath relies upon code in
nvme/host/multipath.c, and running device-mapper multipath with a
kernel compiled with CONFIG_NVME_MULTIPATH disabled is not supported.

Closes: https://lore.kernel.org/linux-nvme/20241121220321.40616-1-bgurney@redhat.com/

Tested-by: John Meneghini <jmeneghi@redhat.com>
Reviewed-by: John Meneghini <jmeneghi@redhat.com>

Signed-off-by: Bryan Gurney <bgurney@redhat.com>
---
 drivers/nvme/host/core.c      | 14 ++++----------
 drivers/nvme/host/multipath.c | 14 ++++++--------
 drivers/nvme/host/nvme.h      |  2 --
 3 files changed, 10 insertions(+), 20 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 2bcd9f710cb6..b07cd482fbc1 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3809,14 +3809,6 @@ static int nvme_init_ns_head(struct nvme_ns *ns, struct nvme_ns_info *info)
 					info->nsid);
 			goto out_put_ns_head;
 		}
-
-		if (!multipath) {
-			dev_warn(ctrl->device,
-				"Found shared namespace %d, but multipathing not supported.\n",
-				info->nsid);
-			dev_warn_once(ctrl->device,
-				"Support for shared namespaces without CONFIG_NVME_MULTIPATH is deprecated and will be removed in Linux 6.0.\n");
-		}
 	}
 
 	list_add_tail_rcu(&ns->siblings, &head->list);
@@ -3915,12 +3907,14 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, struct nvme_ns_info *info)
 		sprintf(disk->disk_name, "nvme%dc%dn%d", ctrl->subsys->instance,
 			ctrl->instance, ns->head->instance);
 		disk->flags |= GENHD_FL_HIDDEN;
-	} else if (multipath) {
+	} else {
+#ifdef CONFIG_NVME_MULTIPATH
 		sprintf(disk->disk_name, "nvme%dn%d", ctrl->subsys->instance,
 			ns->head->instance);
-	} else {
+#else
 		sprintf(disk->disk_name, "nvme%dn%d", ctrl->instance,
 			ns->head->instance);
+#endif
 	}
 
 	if (nvme_update_ns_info(ns, info))
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index a85d190942bd..28ab868182b2 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -9,11 +9,6 @@
 #include <trace/events/block.h>
 #include "nvme.h"
 
-bool multipath = true;
-module_param(multipath, bool, 0444);
-MODULE_PARM_DESC(multipath,
-	"turn on native support for multiple controllers per subsystem");
-
 static const char *nvme_iopolicy_names[] = {
 	[NVME_IOPOLICY_NUMA]	= "numa",
 	[NVME_IOPOLICY_RR]	= "round-robin",
@@ -632,9 +627,11 @@ int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, struct nvme_ns_head *head)
 	 * We also do this for private namespaces as the namespace sharing flag
 	 * could change after a rescan.
 	 */
+#ifdef CONFIG_NVME_MULTIPATH
 	if (!(ctrl->subsys->cmic & NVME_CTRL_CMIC_MULTI_CTRL) ||
-	    !nvme_is_unique_nsid(ctrl, head) || !multipath)
+	    !nvme_is_unique_nsid(ctrl, head))
 		return 0;
+#endif
 
 	blk_set_stacking_limits(&lim);
 	lim.dma_alignment = 3;
@@ -1038,10 +1035,11 @@ int nvme_mpath_init_identify(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 	size_t ana_log_size;
 	int error = 0;
 
+#ifdef CONFIG_NVME_MULTIPATH
 	/* check if multipath is enabled and we have the capability */
-	if (!multipath || !ctrl->subsys ||
-	    !(ctrl->subsys->cmic & NVME_CTRL_CMIC_ANA))
+	if (!ctrl->subsys || !(ctrl->subsys->cmic & NVME_CTRL_CMIC_ANA))
 		return 0;
+#endif
 
 	/* initialize this in the identify path to cover controller resets */
 	atomic_set(&ctrl->nr_active, 0);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 2c76afd00390..6dea04f05b59 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -972,7 +972,6 @@ static inline void nvme_trace_bio_complete(struct request *req)
 		trace_block_bio_complete(ns->head->disk->queue, req->bio);
 }
 
-extern bool multipath;
 extern struct device_attribute dev_attr_ana_grpid;
 extern struct device_attribute dev_attr_ana_state;
 extern struct device_attribute subsys_attr_iopolicy;
@@ -982,7 +981,6 @@ static inline bool nvme_disk_is_ns_head(struct gendisk *disk)
 	return disk->fops == &nvme_ns_head_ops;
 }
 #else
-#define multipath false
 static inline bool nvme_ctrl_use_ana(struct nvme_ctrl *ctrl)
 {
 	return false;
-- 
2.47.0



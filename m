Return-Path: <SRS0=Ir45=W2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C865BC3A5A6
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Aug 2019 19:20:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A34FC23429
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Aug 2019 19:20:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cZi7/6GC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A34FC23429
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=RumipyvSALffFksdJro/Ec+zYD3h+x+29kB1aqFpDcA=; b=cZi7/6GCNuR+tmoRpFQO/1jd+K
	VDI2FiT8j6LmxWozPs5Ewv2WR/301n60mYe6Vpv/76Y0pxNgM0EPElAy0fhTATZiFljr0BrE1LuGH
	JJvZNqbv4cXXZAa2bMXYSweO5KjwMNH45c+JIZhPRErLfsY9+32bHb6ahnW/y++mhdNMD3A1ts9wR
	ENy7DgkqGX0ShbWVLhVWk/hcPkNmgufXmkhwzClvSB6OystVBoLs8DOHgzrPkRWOh+HCSChV5iGvq
	s6GIMwBkcaOeqX0pLMYZjlcM8GgB4uiKxeXv2g0PS9CRwvAQdU+RA3VwskwBjvRqhebpEHAfcC7tb
	WSOPuKvg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92 #3 (Red Hat Linux))
	id 1i3mRX-0005Bu-3V; Fri, 30 Aug 2019 19:20:19 +0000
Received: from [2600:1700:65a0:78e0:514:7862:1503:8e4d]
 (helo=sagi-Latitude-E7470.lbits)
 by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
 id 1i3mQW-00030j-11; Fri, 30 Aug 2019 19:19:16 +0000
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org
Subject: [PATCH v10 5/7] nvme: make nvme_identify_ns propagate errors back
Date: Fri, 30 Aug 2019 12:19:12 -0700
Message-Id: <20190830191914.29713-6-sagi@grimberg.me>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190830191914.29713-1-sagi@grimberg.me>
References: <20190830191914.29713-1-sagi@grimberg.me>
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
Cc: Keith Busch <keith.busch@intel.com>, James Smart <james.smart@broadcom.com>,
 Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

right now callers of nvme_identify_ns only know that it failed,
but don't know why. Make nvme_identify_ns propagate the error back.
Because nvme_submit_sync_cmd may return a positive status code, we
make nvme_identify_ns receive the id by reference and return that
status up the call chain, but make sure not to leak positive nvme
status codes to the upper layers.

Reviewed-by: Minwoo Im <minwoo.im.dev@gmail.com>
Reviewed-by: Hannes Reinecke <hare@suse.com>
Reviewed-by: James Smart <james.smart@broadcom.com>
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/core.c | 39 ++++++++++++++++++++-------------------
 1 file changed, 20 insertions(+), 19 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 5e5ff7aab3ca..73d65172006d 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1096,10 +1096,9 @@ static int nvme_identify_ns_list(struct nvme_ctrl *dev, unsigned nsid, __le32 *n
 				    NVME_IDENTIFY_DATA_SIZE);
 }
 
-static struct nvme_id_ns *nvme_identify_ns(struct nvme_ctrl *ctrl,
-		unsigned nsid)
+static int nvme_identify_ns(struct nvme_ctrl *ctrl,
+		unsigned nsid, struct nvme_id_ns **id)
 {
-	struct nvme_id_ns *id;
 	struct nvme_command c = { };
 	int error;
 
@@ -1108,18 +1107,17 @@ static struct nvme_id_ns *nvme_identify_ns(struct nvme_ctrl *ctrl,
 	c.identify.nsid = cpu_to_le32(nsid);
 	c.identify.cns = NVME_ID_CNS_NS;
 
-	id = kmalloc(sizeof(*id), GFP_KERNEL);
-	if (!id)
-		return NULL;
+	*id = kmalloc(sizeof(**id), GFP_KERNEL);
+	if (!*id)
+		return -ENOMEM;
 
-	error = nvme_submit_sync_cmd(ctrl->admin_q, &c, id, sizeof(*id));
+	error = nvme_submit_sync_cmd(ctrl->admin_q, &c, *id, sizeof(**id));
 	if (error) {
 		dev_warn(ctrl->device, "Identify namespace failed (%d)\n", error);
-		kfree(id);
-		return NULL;
+		kfree(*id);
 	}
 
-	return id;
+	return error;
 }
 
 static int nvme_features(struct nvme_ctrl *dev, u8 op, unsigned int fid,
@@ -1743,13 +1741,13 @@ static int nvme_revalidate_disk(struct gendisk *disk)
 		return -ENODEV;
 	}
 
-	id = nvme_identify_ns(ctrl, ns->head->ns_id);
-	if (!id)
-		return -ENODEV;
+	ret = nvme_identify_ns(ctrl, ns->head->ns_id, &id);
+	if (ret)
+		goto out;
 
 	if (id->ncap == 0) {
 		ret = -ENODEV;
-		goto out;
+		goto free_id;
 	}
 
 	__nvme_revalidate_disk(disk, id);
@@ -1760,8 +1758,11 @@ static int nvme_revalidate_disk(struct gendisk *disk)
 		ret = -ENODEV;
 	}
 
-out:
+free_id:
 	kfree(id);
+out:
+	if (ret > 0)
+		ret = blk_status_to_errno(nvme_error_status(ret));
 	return ret;
 }
 
@@ -3332,11 +3333,9 @@ static int nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 	blk_queue_logical_block_size(ns->queue, 1 << ns->lba_shift);
 	nvme_set_queue_limits(ctrl, ns->queue);
 
-	id = nvme_identify_ns(ctrl, nsid);
-	if (!id) {
-		ret = -EIO;
+	ret = nvme_identify_ns(ctrl, nsid, &id);
+	if (ret)
 		goto out_free_queue;
-	}
 
 	if (id->ncap == 0) {
 		ret = -EINVAL;
@@ -3398,6 +3397,8 @@ static int nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 	blk_cleanup_queue(ns->queue);
  out_free_ns:
 	kfree(ns);
+	if (ret > 0)
+		ret = blk_status_to_errno(nvme_error_status(ret));
 	return ret;
 }
 
-- 
2.17.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

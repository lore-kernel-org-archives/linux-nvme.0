Return-Path: <SRS0=7vxi=YC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21224ECE58C
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Oct 2019 16:29:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3E2220B7C
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Oct 2019 16:29:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kqqrXl50";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Un1RQirr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3E2220B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=6+pzRo89t6MXs+/qm8fQtW9JR6oa2vfOoz2APC+paLQ=; b=kqqrXl50sB1eRy
	pqL0XNZ9OvZLoRqtIpar4C1bxwQ8IVPPDk1Pxo76Lh4zOUWYuR9PCv03vJG8A2FyZ2kwXU2wzq9v7
	ZjjHVq4OZn7+XrCURqWFsvfrYsvtDpBjLGoz5c9mRi+lXHp5qhhOFm+0u8/l+fM4RdsjkKoMZfvy/
	KaoT8qbSnBspxFaoEtcETX/HSiHXP9boQhEu124TRnEMjw+H55oyncjQjNLEA5aadaWJ98SUvCnnR
	UvSjjHsR7omt96Gj4e7FpOY9ve0XbbIAl+9kUv6mOGfPCIroNPc5DGOrr2arhZuHm9sdrBzQeLzxx
	jPyBXSUkST7W41vW/oOQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1iIEqH-000404-IN; Wed, 09 Oct 2019 16:29:37 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iIEqD-0003zF-W5
 for linux-nvme@lists.infradead.org; Wed, 09 Oct 2019 16:29:35 +0000
Received: from washi1.fujisawa.hgst.com (unknown [199.255.47.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 11DF020B7C;
 Wed,  9 Oct 2019 16:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1570638573;
 bh=SEluYkGdZFdi1G/4No8jnOToASnRSalVGFVQ5zg3QMI=;
 h=From:To:Cc:Subject:Date:From;
 b=Un1RQirrAA0yFVr3ZlZ6xemVjl0gcek9vQyVPrxlnbC9Jo2lXeYZLUMW5PWDvU/Uv
 CwX3tQmzhc/jepqXXnSzLMOvsahhTD9dsYVDCvhCKz/6+BVK+3donxS3GS01H5f+M7
 3TBt/qToHKWmphSMWOgkUcNtZAs30z3AhUD8hICs=
From: Keith Busch <kbusch@kernel.org>
To: linux-nvme@lists.infradead.org,
	stable@vger.kernel.org
Subject: [PATCH 4.19] nvme: Assign subsys instance from first ctrl
Date: Thu, 10 Oct 2019 01:29:10 +0900
Message-Id: <20191009162910.1801-1-kbusch@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191009_092934_065913_0A76D32A 
X-CRM114-Status: GOOD (  11.80  )
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
Cc: Hannes Reinecke <hare@suse.com>, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <kbusch@kernel.org>, Logan Gunthorpe <logang@deltatee.com>,
 Christoph Hellwig <hch@lst.de>, Minwoo Im <minwoo.im@samsung.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

commit 733e4b69d508d03c20adfdcf4bd27abc60fae9cc upstream

The namespace disk names must be unique for the lifetime of the
subsystem. This was accomplished by using their parent subsystems'
instances which were allocated independently from the controllers
connected to that subsystem. This allowed name prefixes assigned to
namespaces to match a controller from an unrelated subsystem, and has
created confusion among users examining device nodes.

Ensure a namespace's subsystem instance never clashes with a controller
instance of another subsystem by transferring the instance ownership
to the parent subsystem from the first controller discovered in that
subsystem.

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Minwoo Im <minwoo.im@samsung.com>
Reviewed-by: Hannes Reinecke <hare@suse.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/core.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index ae0b01059fc6..cab4f368ef2d 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -88,7 +88,6 @@ EXPORT_SYMBOL_GPL(nvme_reset_wq);
 struct workqueue_struct *nvme_delete_wq;
 EXPORT_SYMBOL_GPL(nvme_delete_wq);
 
-static DEFINE_IDA(nvme_subsystems_ida);
 static LIST_HEAD(nvme_subsystems);
 static DEFINE_MUTEX(nvme_subsystems_lock);
 
@@ -2139,7 +2138,8 @@ static void nvme_init_subnqn(struct nvme_subsystem *subsys, struct nvme_ctrl *ct
 
 static void __nvme_release_subsystem(struct nvme_subsystem *subsys)
 {
-	ida_simple_remove(&nvme_subsystems_ida, subsys->instance);
+	if (subsys->instance >= 0)
+		ida_simple_remove(&nvme_instance_ida, subsys->instance);
 	kfree(subsys);
 }
 
@@ -2255,12 +2255,8 @@ static int nvme_init_subsystem(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 	subsys = kzalloc(sizeof(*subsys), GFP_KERNEL);
 	if (!subsys)
 		return -ENOMEM;
-	ret = ida_simple_get(&nvme_subsystems_ida, 0, 0, GFP_KERNEL);
-	if (ret < 0) {
-		kfree(subsys);
-		return ret;
-	}
-	subsys->instance = ret;
+
+	subsys->instance = -1;
 	mutex_init(&subsys->lock);
 	kref_init(&subsys->ref);
 	INIT_LIST_HEAD(&subsys->ctrls);
@@ -2275,7 +2271,7 @@ static int nvme_init_subsystem(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 	subsys->dev.class = nvme_subsys_class;
 	subsys->dev.release = nvme_release_subsystem;
 	subsys->dev.groups = nvme_subsys_attrs_groups;
-	dev_set_name(&subsys->dev, "nvme-subsys%d", subsys->instance);
+	dev_set_name(&subsys->dev, "nvme-subsys%d", ctrl->instance);
 	device_initialize(&subsys->dev);
 
 	mutex_lock(&nvme_subsystems_lock);
@@ -2308,6 +2304,8 @@ static int nvme_init_subsystem(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 		list_add_tail(&subsys->entry, &nvme_subsystems);
 	}
 
+	if (!found)
+		subsys->instance = ctrl->instance;
 	ctrl->subsys = subsys;
 	mutex_unlock(&nvme_subsystems_lock);
 
@@ -2319,7 +2317,6 @@ static int nvme_init_subsystem(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 		return -EINVAL;
 	}
 
-	mutex_lock(&subsys->lock);
 	list_add_tail(&ctrl->subsys_entry, &subsys->ctrls);
 	mutex_unlock(&subsys->lock);
 
@@ -3545,7 +3542,9 @@ static void nvme_free_ctrl(struct device *dev)
 		container_of(dev, struct nvme_ctrl, ctrl_device);
 	struct nvme_subsystem *subsys = ctrl->subsys;
 
-	ida_simple_remove(&nvme_instance_ida, ctrl->instance);
+	if (subsys && ctrl->instance != subsys->instance)
+		ida_simple_remove(&nvme_instance_ida, ctrl->instance);
+
 	kfree(ctrl->effects);
 	nvme_mpath_uninit(ctrl);
 
@@ -3775,7 +3774,6 @@ int __init nvme_core_init(void)
 
 void nvme_core_exit(void)
 {
-	ida_destroy(&nvme_subsystems_ida);
 	class_destroy(nvme_subsys_class);
 	class_destroy(nvme_class);
 	unregister_chrdev_region(nvme_chr_devt, NVME_MINORS);
-- 
2.21.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

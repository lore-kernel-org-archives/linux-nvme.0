Return-Path: <SRS0=EcNd=W3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0E9AC3A59B
	for <linux-nvme@archiver.kernel.org>; Sat, 31 Aug 2019 00:02:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF7AA23431
	for <linux-nvme@archiver.kernel.org>; Sat, 31 Aug 2019 00:02:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="aGHGcGtg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF7AA23431
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Subject:MIME-Version:Message-Id:Date:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=RhHdWKvQkoRJ4pURT65lK1KeesWjLmY9WXARsajz0a4=; b=aGHGcGtgXLM4fY
	U9vxyTmJICXJ20yEEH90x2tPyJe03+xqTwdeLlZ8dRSnFitrAJUEpbbar5Tx262epgiZR1jbZuLbG
	eNj4v+l8o9T2HtVS9+8EIagddxX+huaexS5ZgiVQAclnUxmzWFzNJbAe7wZ/W88hAbVPJyOLMQqwc
	/DUt4lAcoqWMX/IUmp2iUhcsvsedcc5ETfy2oR3ipC1YXpeq4dhctY7qQwXKF7ep4F5UJMNItUMCT
	4oOW1oPrgIXAhHbBMu3/ZG0X06+CAAaNbWwMNZ4ZXcCRYf40wrDM6vJoT8BmH/hO+40IS0yqqjkHD
	+XVO0UGg3xRCymlbmucA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92 #3 (Red Hat Linux))
	id 1i3qqR-0002gc-Rg; Sat, 31 Aug 2019 00:02:19 +0000
Received: from ale.deltatee.com ([207.54.116.67])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i3qqN-0002ff-N9
 for linux-nvme@lists.infradead.org; Sat, 31 Aug 2019 00:02:17 +0000
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
 by ale.deltatee.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.89) (envelope-from <gunthorp@deltatee.com>)
 id 1i3qqE-0003Cm-6L; Fri, 30 Aug 2019 18:02:07 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
 (envelope-from <gunthorp@deltatee.com>)
 id 1i3qqC-00020M-63; Fri, 30 Aug 2019 18:02:04 -0600
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>
Date: Fri, 30 Aug 2019 18:01:39 -0600
Message-Id: <20190831000139.7662-1-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 hch@lst.de, sagi@grimberg.me, axboe@fb.com, kbusch@kernel.org, hare@suse.com,
 martin.petersen@oracle.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH] nvme-core: Fix subsystem instance mismatches
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190830_170216_092229_AB99BC70 
X-CRM114-Status: GOOD (  14.06  )
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
 "Martin K . Petersen" <martin.petersen@oracle.com>, Jens Axboe <axboe@fb.com>,
 Keith Busch <kbusch@kernel.org>, Logan Gunthorpe <logang@deltatee.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

With multipath enabled (which is now default in many distros), nvme
controllers and their respective namespaces can be numbered
differently. For example: nvme0n1 might actually belong to controller
nvme1, which is super confusing (and may have broken any scripts that
rely on the numbering relation). To make matters worse, the mismatches
can sometimes change from boot to boot so anyone dealing with the
nvme control device has to inspect sysfs every boot to ensure they
get the right one.

The reason for this is that the X in nvmeXn1 is the subsystem's instance
number (when multipath is enabled) which is distinct from the
controller's instance and the subsystem instance is assigned from a
separate IDA after the controller gets identified and this can race
a bit when multiple controllers are being setup.

To fix this, assign the subsystem's instance based on the instance
number of the controller's instance that first created it. There should
always be fewer subsystems than controllers so the should not be a need
to create extra subsystems that overlap existing controllers.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/nvme/host/core.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index d3d6b7bd6903..ca201b71ab49 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -81,7 +81,6 @@ EXPORT_SYMBOL_GPL(nvme_reset_wq);
 struct workqueue_struct *nvme_delete_wq;
 EXPORT_SYMBOL_GPL(nvme_delete_wq);
 
-static DEFINE_IDA(nvme_subsystems_ida);
 static LIST_HEAD(nvme_subsystems);
 static DEFINE_MUTEX(nvme_subsystems_lock);
 
@@ -2332,7 +2331,6 @@ static void nvme_release_subsystem(struct device *dev)
 	struct nvme_subsystem *subsys =
 		container_of(dev, struct nvme_subsystem, dev);
 
-	ida_simple_remove(&nvme_subsystems_ida, subsys->instance);
 	kfree(subsys);
 }
 
@@ -2461,12 +2459,7 @@ static int nvme_init_subsystem(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 	subsys = kzalloc(sizeof(*subsys), GFP_KERNEL);
 	if (!subsys)
 		return -ENOMEM;
-	ret = ida_simple_get(&nvme_subsystems_ida, 0, 0, GFP_KERNEL);
-	if (ret < 0) {
-		kfree(subsys);
-		return ret;
-	}
-	subsys->instance = ret;
+	subsys->instance = ctrl->instance;
 	mutex_init(&subsys->lock);
 	kref_init(&subsys->ref);
 	INIT_LIST_HEAD(&subsys->ctrls);
@@ -4074,7 +4067,6 @@ static int __init nvme_core_init(void)
 
 static void __exit nvme_core_exit(void)
 {
-	ida_destroy(&nvme_subsystems_ida);
 	class_destroy(nvme_subsys_class);
 	class_destroy(nvme_class);
 	unregister_chrdev_region(nvme_chr_devt, NVME_MINORS);
-- 
2.20.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

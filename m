Return-Path: <SRS0=Tecl=W7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3817CC3A5A8
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Sep 2019 16:37:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CC5F2087E
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Sep 2019 16:37:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Blq28wtc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CC5F2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=sHZC1odUHBpbvMe/H/5yX3Q04P1c2WqwSexxIE4DlL0=; b=Blq28wtcDKQAI8
	2rIu8y2vMWUQ2awaErN9BNbE6MrJY3OUqXbZo0Mk9V1MZWdzqkbAod7MKYaOTfzfsQHIJTl3hGNy+
	dFLFuh4VW5tw/Dgx8X6solgPrGP6DqiM3jg/Q2q8GrJGIpN6mOwKEWUz7WZdU4Apara/P2fWeppBD
	BjCKkKN65P49DsTFV86gp62BErg1surNyIKgp60unT6eOhHYLTfDBzT7xNk+2TQHb9pO0CHibZ8pG
	wfctQ5lksde+hFdMEUs9J5FKGjUqwVRG9/IhfIdsitQj15e+pNnr4v8przyL/xhFs+2ktuhNhdpDB
	kFk79JmCuWxzCm7oki9g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92 #3 (Red Hat Linux))
	id 1i5YHm-0004Ua-3y; Wed, 04 Sep 2019 16:37:34 +0000
Received: from mga18.intel.com ([134.134.136.126])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i5YHi-0004Tk-9a
 for linux-nvme@lists.infradead.org; Wed, 04 Sep 2019 16:37:31 +0000
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 04 Sep 2019 09:37:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,467,1559545200"; d="scan'208";a="199068030"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
 by fmsmga001.fm.intel.com with ESMTP; 04 Sep 2019 09:37:28 -0700
Date: Wed, 4 Sep 2019 10:35:57 -0600
From: Keith Busch <kbusch@kernel.org>
To: Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH] nvme-core: Fix subsystem instance mismatches
Message-ID: <20190904163557.GF21302@localhost.localdomain>
References: <20190831000139.7662-1-logang@deltatee.com>
 <20190831152910.GA29439@localhost.localdomain>
 <33af4d94-9f6d-9baa-01fa-0f75ccee263e@deltatee.com>
 <20190903164620.GA20847@localhost.localdomain>
 <20190904060558.GA10849@lst.de>
 <20190904144426.GB21302@localhost.localdomain>
 <20190904154215.GA20422@lst.de>
 <20190904155445.GD21302@localhost.localdomain>
 <ef3bf93b-cb47-95c5-7d96-f81d9acfdb55@deltatee.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ef3bf93b-cb47-95c5-7d96-f81d9acfdb55@deltatee.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190904_093730_382723_D0B35796 
X-CRM114-Status: GOOD (  24.82  )
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
Cc: Keith Busch <keith.busch@intel.com>, Hannes Reinecke <hare@suse.com>,
 Sagi Grimberg <sagi@grimberg.me>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Sep 04, 2019 at 10:07:12AM -0600, Logan Gunthorpe wrote:
> Yes, I agree, we can't solve the mismatch problem in the general case:
> with sequences of hot plug events there will always be a case that
> mismatches. I just think we can do better in the simple common default case.

This may be something where udev can help us. I might be able to find
some time to look at that, but not today.
 
> > Can we just ensure there is never a matching controller then? This
> > patch will accomplish that and simpler than wrapping the instance in a
> > refcount'ed object:
> > 
> > http://lists.infradead.org/pipermail/linux-nvme/2019-May/024142.html
> 
> I don't really like that idea. It reduces the confusion caused by
> mismatching numbers, but causes the controller to never match the
> namespace, which is also confusing but in a different way.
> 
> I like the nvme_instance idea. It's not going to be perfect but it has
> some nice properties: the subsystem will try to match the controller's
> instance whenever possible, but in cases where it doesn't, the instance
> number of the subsystem will never be the same as an existing controller.
> 
> I'll see if I can work up a quick patch set and see what people think.

How about this: we have the subsys copy the controller's instance,
and the nvme_free_ctrl() doesn't release it if its subsys matches?

---
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 14c0bfb55615..8a8279ece5ee 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -81,7 +81,6 @@ EXPORT_SYMBOL_GPL(nvme_reset_wq);
 struct workqueue_struct *nvme_delete_wq;
 EXPORT_SYMBOL_GPL(nvme_delete_wq);
 
-static DEFINE_IDA(nvme_subsystems_ida);
 static LIST_HEAD(nvme_subsystems);
 static DEFINE_MUTEX(nvme_subsystems_lock);
 
@@ -2344,7 +2343,8 @@ static void nvme_release_subsystem(struct device *dev)
 	struct nvme_subsystem *subsys =
 		container_of(dev, struct nvme_subsystem, dev);
 
-	ida_simple_remove(&nvme_subsystems_ida, subsys->instance);
+	if (subsys->instance >= 0)
+		ida_simple_remove(&nvme_instance_ida, subsys->instance);
 	kfree(subsys);
 }
 
@@ -2473,12 +2473,8 @@ static int nvme_init_subsystem(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
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
@@ -2497,7 +2493,7 @@ static int nvme_init_subsystem(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 	subsys->dev.class = nvme_subsys_class;
 	subsys->dev.release = nvme_release_subsystem;
 	subsys->dev.groups = nvme_subsys_attrs_groups;
-	dev_set_name(&subsys->dev, "nvme-subsys%d", subsys->instance);
+	dev_set_name(&subsys->dev, "nvme-subsys%d", ctrl->instance);
 	device_initialize(&subsys->dev);
 
 	mutex_lock(&nvme_subsystems_lock);
@@ -2528,6 +2524,8 @@ static int nvme_init_subsystem(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 		goto out_put_subsystem;
 	}
 
+	if (!found)
+		subsys->instance = ctrl->instance;
 	ctrl->subsys = subsys;
 	list_add_tail(&ctrl->subsys_entry, &subsys->ctrls);
 	mutex_unlock(&nvme_subsystems_lock);
@@ -3803,7 +3801,9 @@ static void nvme_free_ctrl(struct device *dev)
 		container_of(dev, struct nvme_ctrl, ctrl_device);
 	struct nvme_subsystem *subsys = ctrl->subsys;
 
-	ida_simple_remove(&nvme_instance_ida, ctrl->instance);
+	if (subsys && ctrl->instance != subsys->instance)
+		ida_simple_remove(&nvme_instance_ida, ctrl->instance);
+
 	kfree(ctrl->effects);
 	nvme_mpath_uninit(ctrl);
 	__free_page(ctrl->discard_page);
@@ -4085,7 +4085,6 @@ static int __init nvme_core_init(void)
 
 static void __exit nvme_core_exit(void)
 {
-	ida_destroy(&nvme_subsystems_ida);
 	class_destroy(nvme_subsys_class);
 	class_destroy(nvme_class);
 	unregister_chrdev_region(nvme_chr_devt, NVME_MINORS);
--

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

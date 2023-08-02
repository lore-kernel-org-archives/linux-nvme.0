Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEDC2C001E0
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Aug 2023 12:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gbjw6kBMNr9cIUFvykIr82ehZb9LshEfPz3ryc7otTg=; b=zqXQkagVHd1+eAECk/sES408X0
	OmZHMl+/+4m70tnzcmIzIHjJG7nmjA+byAw0toE11RiIhNaAEg66QQZJ9SoUV84dlezTEq2tX45qO
	4WAi4aPiMDj7/hM7DJ0fy8nSvCa6U4l8WdssYw8oZEpwpepgnFs4hYOFpXGFXtoi2DPYMchXv8zso
	XrjZ8sreLyI0EeSbDo/IuN5vIlrJzjjccG5+xmEvdAchZ6O0WEyyhhb/4tUZ3VOMkqqxCqVXmHOVm
	yeMpbvUqNmsWa/Nw12uUMcvIQsB9kook9Rn4HUaOpq4tzUd9jUGZaRXvw1PD245EfoeuV6Fcqf1Bu
	gNXbEfaQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qRAwi-004tUD-0z;
	Wed, 02 Aug 2023 12:27:20 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qRAwf-004tTQ-0Z
	for linux-nvme@lists.infradead.org;
	Wed, 02 Aug 2023 12:27:18 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 46DBD68AA6; Wed,  2 Aug 2023 14:27:12 +0200 (CEST)
Date: Wed, 2 Aug 2023 14:27:11 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org, linux-pm@vger.kernel.org,
	rafael@kernel.org, len.brown@intel.com, pavel@ucw.cz,
	gregkh@linuxfoundation.org, kbusch@kernel.org, hch@lst.de,
	sagi@grimberg.me
Subject: Re: [PATCH 0/3] nvme-core: restructure nvme_init_ctrl()
Message-ID: <20230802122711.GA30792@lst.de>
References: <20230802032629.24309-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230802032629.24309-1-kch@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230802_052717_365982_538490EC 
X-CRM114-Status: GOOD (  20.17  )
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

On Tue, Aug 01, 2023 at 08:26:26PM -0700, Chaitanya Kulkarni wrote:
> Hi,
> 
> Restructure nvme_init_ctrl() for better initialization flow.
> 
> Currenlty nvme_init_ctrl() initialized nvme authentication, fault
> injection, and device PM QoS after adding the controller device with
> a call to cdev_device_add(). This has led to additional code complexity,
> as it required handling the unwinding of these initializations if any
> of them failed.

The current code is in fact also broken, as after device_add
(which cdev_device_add does underneath) fails we can't just cleaup, but
most call put_device.  I think this single patch is what we should be
doing, but I don't fell fully confindent in it without some extra
error injection:

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 47d7ba2827ff29..5da55a271a5ab0 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4405,14 +4405,12 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 	BUILD_BUG_ON(NVME_DSM_MAX_RANGES * sizeof(struct nvme_dsm_range) >
 			PAGE_SIZE);
 	ctrl->discard_page = alloc_page(GFP_KERNEL);
-	if (!ctrl->discard_page) {
-		ret = -ENOMEM;
-		goto out;
-	}
+	if (!ctrl->discard_page)
+		return -ENOMEM;
 
 	ret = ida_alloc(&nvme_instance_ida, GFP_KERNEL);
 	if (ret < 0)
-		goto out;
+		goto out_free_discard_page;
 	ctrl->instance = ret;
 
 	device_initialize(&ctrl->ctrl_device);
@@ -4431,13 +4429,6 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 	if (ret)
 		goto out_release_instance;
 
-	nvme_get_ctrl(ctrl);
-	cdev_init(&ctrl->cdev, &nvme_dev_fops);
-	ctrl->cdev.owner = ops->module;
-	ret = cdev_device_add(&ctrl->cdev, ctrl->device);
-	if (ret)
-		goto out_free_name;
-
 	/*
 	 * Initialize latency tolerance controls.  The sysfs files won't
 	 * be visible to userspace unless the device actually supports APST.
@@ -4448,23 +4439,27 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 
 	nvme_fault_inject_init(&ctrl->fault_inject, dev_name(ctrl->device));
 	nvme_mpath_init_ctrl(ctrl);
+
 	ret = nvme_auth_init_ctrl(ctrl);
 	if (ret)
-		goto out_free_cdev;
+		goto out_fault_inject_fini;
 
-	return 0;
-out_free_cdev:
+	nvme_get_ctrl(ctrl);
+	cdev_init(&ctrl->cdev, &nvme_dev_fops);
+	ctrl->cdev.owner = ops->module;
+	ret = cdev_device_add(&ctrl->cdev, ctrl->device);
+	if (ret)
+		put_device(ctrl->device);
+	return ret;
+
+out_fault_inject_fini:
 	nvme_fault_inject_fini(&ctrl->fault_inject);
 	dev_pm_qos_hide_latency_tolerance(ctrl->device);
-	cdev_device_del(&ctrl->cdev, ctrl->device);
-out_free_name:
-	nvme_put_ctrl(ctrl);
 	kfree_const(ctrl->device->kobj.name);
 out_release_instance:
 	ida_free(&nvme_instance_ida, ctrl->instance);
-out:
-	if (ctrl->discard_page)
-		__free_page(ctrl->discard_page);
+out_free_discard_page:
+	__free_page(ctrl->discard_page);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(nvme_init_ctrl);


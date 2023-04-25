Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A14F1C6FD18
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Apr 2023 04:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=pCqJAGRx2qLkKQPSh9JiaPYSfcvunDSFXVK/m6DQnxY=; b=WDTslID/jOzU7dL5RI3Vy6lVGl
	uYaPWYMyWcfSMIo8iYO9y7tKaexWwfTHmnvWFFE5xU/06tiHTTiJoz73QTgX2lgOAc30KEsF5T2E8
	xMXE7n1e1NkUUDF7iJbBYYrdmVYDtJw7PpBGI12X69tU8Je4qVgrj4r4/I8zPXJWx1zdY8oYzbfNv
	yImvRaacU9Sc6OR41wLUThym0Wbq6vsG0GIw9O0EghJWYN9ZWmc8fPll3JrKfSwRhNG9kgFam9FtG
	kxMdlD81OU2uQMdafI6Jk8Ni+KzgQ6j5WPpVsFDwu1wRHJVt22v3t86uLanVCm1eTCNAh/UcMQIIz
	GC8obpPw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1prAXO-000Aap-1m;
	Tue, 25 Apr 2023 04:44:22 +0000
Received: from mail-oa1-x32.google.com ([2001:4860:4864:20::32])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1prAXL-000AZl-0O
	for linux-nvme@lists.infradead.org;
	Tue, 25 Apr 2023 04:44:20 +0000
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-187af4a5453so1896019fac.1
        for <linux-nvme@lists.infradead.org>; Mon, 24 Apr 2023 21:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682397851; x=1684989851;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pCqJAGRx2qLkKQPSh9JiaPYSfcvunDSFXVK/m6DQnxY=;
        b=bEkpS0LQMOYIywGY9gjYCe0hq36PE3bwfuY2Zz5e63MmhH78E9ZbJMoRz1XyW+EqZC
         8XfjTaZTY7n0kEeAhucmzyMpmzaML4V3IrJUrW1Hobke1hgnXffLRiWAkH7rPvC4i9d1
         J+N2sePLBimbQ1CGV88YaBlVMHDOM4vh4iI72Yr+cjN6KAtMXD9qa8MEmy567cqdyVn+
         HX/wRH1HUrgMuuLLxIHwdFCsdCYqlPbhZ5ECPPE3xxgJL3i2xs/Nmalb3NhOlGWDRVYd
         8eY0petIQf9EigX+ua/QrvKCNGhHeAO1newQEwIXgJ5ETSuKY+m0mStrOVd7gfLH+Ek0
         9pRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682397851; x=1684989851;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pCqJAGRx2qLkKQPSh9JiaPYSfcvunDSFXVK/m6DQnxY=;
        b=K1xopTu6OHfd3yJadZaxsF1zrWWIh18f7984vPbnZZQTk2ngxTE7xAdMvs4lkAADCW
         JQp6MOAzpo7LiatqERDT1TrjNUdYH5QL+lFt2NLviHMxE7UwmSn4x95+HaxYOAE7/Zn2
         x2TUwC3SnO/6hIx8rKrfnEMbl4ZDpF67cSjgGk+NZleerzgDw+XwlS+odhI9OtIJx7QX
         lHQf5lq5Pcl0jn4pgQUp9K5po2YjTR9hxL8InrMto5JqIcZJ7mobMpCgMqdSTvrBWHAy
         QsjqjrzAdB+GBcFUXg8dmK1pAjkE0bexK1800dENbCJhhpEnsjJ5Z+jr41S1h+5aB+Bq
         ImMA==
X-Gm-Message-State: AAQBX9cCw11VQaMqzdwqPRIN8Qj4SLO+HU5URgD6saZPzwAISordrAgP
	GoGOzRePIH1z8cMkHcb/77bSgo09JYi7YQ==
X-Google-Smtp-Source: AKy350Y/0u9cHK/wI8uzhyW9hJ2kxkM4sJ+eSm/nOAe7LkGG6egKB8pOnX6DTm7dbHwzpsQ8ue0BFg==
X-Received: by 2002:a05:6870:8888:b0:187:b5df:ef39 with SMTP id m8-20020a056870888800b00187b5dfef39mr9246932oam.56.1682397851133;
        Mon, 24 Apr 2023 21:44:11 -0700 (PDT)
Received: from archlinux ([190.194.6.55])
        by smtp.gmail.com with ESMTPSA id a9-20020a056830100900b006a3bd777dfdsm4050437otp.12.2023.04.24.21.44.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 21:44:10 -0700 (PDT)
Date: Tue, 25 Apr 2023 01:44:07 -0300
From: Irvin Cote <irvincoteg@gmail.com>
To: hch@lst.de
Cc: kbusch@kernel.org, axboe@fb.com, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, chaitanyak@nvidia.com
Subject: Correcting erroneous patch
Message-ID: <ZEdal/WS/NWxRKSm@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230424_214419_157686_473A3703 
X-CRM114-Status: GOOD (  26.83  )
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

Following the error comment in the previous e-mail thread, I have identified the cause of the error.

nvme_free_ctrl which is the ctrl's release method, and nvme_init_ctrl's
teardown path, both call ida_free on ctrl->instance. 
To properly decrement the ref-count while avoiding such issues:

-The final nvme_put_ctrl was placed in nvme_pci_alloc_dev at the end of the teardown path
 so that nvme_free_ctrl executes last.

-I have addressed the broader issue of double-freeing between the teardown-path and the release method,
 by marking the resources as freed in the former and implementing checks in the latter.

This is the object of the last two patches, while the first one is just a cleanup.
The patches were written one on top of the other.


-------------------------------------------------------
From ff763a79d3746e3fd034e067e2fad798e95ff9a7 Mon Sep 17 00:00:00 2001
From: Irvin Cote <irvincoteg@gmail.com>
Date: Mon, 24 Apr 2023 23:46:48 -0300
Subject: [PATCH 1/3] nvme-core: nvme_init_ctrl cleanup 

Removed an incoherent check at the last exit label
and renamed it for better clarity.

Signed-off-by: Irvin Cote <irvincoteg@gmail.com>
---
 drivers/nvme/host/core.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index d6a9bac91a4c..353443250d48 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -5149,14 +5149,12 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
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
@@ -5204,9 +5202,8 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
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
-- 
2.39.2


-------------------------------------------------------

From 9bd93f3ae34a2f095d9a4687b453ef2bbc598f22 Mon Sep 17 00:00:00 2001
From: Irvin Cote <irvincoteg@gmail.com>
Date: Mon, 24 Apr 2023 23:58:11 -0300
Subject: [PATCH 2/3] nvme-pci: Adjusting ctrl deref count

If there is a failure in nvme_init_ctrl
the dereference counting is not properly
handled and the code exits with a non-zero
ctrl ref-count. This is because nvme_init_ctrl
takes two refs but only accounts for one deref
in its teardown path. Instead of adding another deref
there in the core layer, we take care of it here and
we make sure that it is the last thing we do so that
all teardown logic executes before the release of
the controller as the two have some identical instructions.

Signed-off-by: Irvin Cote <irvincoteg@gmail.com>
---
 drivers/nvme/host/pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index cd7873de3121..65e4b9f1b632 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2975,6 +2975,7 @@ static struct nvme_dev *nvme_pci_alloc_dev(struct pci_dev *pdev,
 	kfree(dev->queues);
 out_free_dev:
 	kfree(dev);
+	nvme_put_ctrl(&dev->ctrl);
 	return ERR_PTR(ret);
 }
 
-- 
2.39.2


-------------------------------------------------------

From 4ac05d1742c2b7e5bcb84dde1a64052ede071796 Mon Sep 17 00:00:00 2001
From: Irvin Cote <irvincoteg@gmail.com>
Date: Tue, 25 Apr 2023 00:44:51 -0300
Subject: [PATCH 3/3] nvme-core: preventing double freeing in ctrl release

The teardown logic and the release method for
the controller both free the same resources.
This introduces double-freeing issues.
Since the release of the ctrl is the last step
of the teardown, we can solve this by setting the freed
pointers to NULL in the teardown path and add checks
in the release method.
The only issue is with ida_free as ida doesn't offer any way to
indicate that an ID has already been freed.
In our specific case we can set the ID to -1 to indicate that.
We can do that because, the way we've setup ida to manage ctrl instances,
it always returns non-negative IDS.

Signed-off-by: Irvin Cote <irvincoteg@gmail.com>
---
 drivers/nvme/host/core.c | 7 +++++--
 drivers/nvme/host/pci.c  | 8 ++++++--
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 353443250d48..15df7846fde8 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -5091,14 +5091,15 @@ static void nvme_free_ctrl(struct device *dev)
 		container_of(dev, struct nvme_ctrl, ctrl_device);
 	struct nvme_subsystem *subsys = ctrl->subsys;
 
-	if (!subsys || ctrl->instance != subsys->instance)
+	if ((!subsys || ctrl->instance != subsys->instance) && ctrl->instance != -1)
 		ida_free(&nvme_instance_ida, ctrl->instance);
 
 	nvme_free_cels(ctrl);
 	nvme_mpath_uninit(ctrl);
 	nvme_auth_stop(ctrl);
 	nvme_auth_free(ctrl);
-	__free_page(ctrl->discard_page);
+	if(ctrl->discard_page)
+		__free_page(ctrl->discard_page);
 	free_opal_dev(ctrl->opal_dev);
 
 	if (subsys) {
@@ -5202,8 +5203,10 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 	kfree_const(ctrl->device->kobj.name);
 out_release_instance:
 	ida_free(&nvme_instance_ida, ctrl->instance);
+	ctrl->instance = -1;
 out_free_discard_page:
 	__free_page(ctrl->discard_page);
+	ctrl->discard_page = NULL;
 	return ret;
 }
 EXPORT_SYMBOL_GPL(nvme_init_ctrl);
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 65e4b9f1b632..ff5c876739bc 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2681,8 +2681,10 @@ static void nvme_pci_free_ctrl(struct nvme_ctrl *ctrl)
 
 	nvme_free_tagset(dev);
 	put_device(dev->dev);
-	kfree(dev->queues);
-	kfree(dev);
+	if(dev->queues)
+		kfree(dev->queues);
+	if(dev)
+		kfree(dev);
 }
 
 static void nvme_reset_work(struct work_struct *work)
@@ -2973,8 +2975,10 @@ static struct nvme_dev *nvme_pci_alloc_dev(struct pci_dev *pdev,
 out_put_device:
 	put_device(dev->dev);
 	kfree(dev->queues);
+	dev->queues = NULL;
 out_free_dev:
 	kfree(dev);
+	dev = NULL;
 	nvme_put_ctrl(&dev->ctrl);
 	return ERR_PTR(ret);
 }
-- 
2.39.2



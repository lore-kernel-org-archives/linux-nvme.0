Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C589C77B78
	for <linux-nvme@archiver.kernel.org>; Wed,  3 May 2023 15:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=tPIipKgTlqdpegnWlgQlSJ+XqyJ5yhguaEJrq4DhnLE=; b=d2HfsdyFXPl5Ny4VBeIqbxWUSO
	QfZzAWvUKp8gEIfVsaCnFBPdfjAIpbkt5KdmWMuce8J2w6pKOzyb3wK77shXXI7QP+uX9x5UGVQl1
	tI/XKq/EMoQr5lSieFviJNLMFz2H/SiwoRNVUucuceVELxc1y+6LgQG6NvmdvwhFTnYosxwEZLVdj
	FWKm90ly86+/b23wd+F7yxunsAUOEGC13j+j7uu9awF1Olg0VTVPdrUJQ9OAcL5GKY2zxuDJK+b8l
	ZudlyWD8BnqrbtDwT4dM7Qs16Cpj933ObFzAO/CJc+UMUdAi833MVpwfXkq9BqJtdqmLuUkyxRwNc
	KLEYn6Qg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1puE6m-004uuP-2e;
	Wed, 03 May 2023 15:09:32 +0000
Received: from mail-wm1-f49.google.com ([209.85.128.49])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1puE6k-004ut6-2r
	for linux-nvme@lists.infradead.org;
	Wed, 03 May 2023 15:09:32 +0000
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-3f3284dff6cso8504765e9.0
        for <linux-nvme@lists.infradead.org>; Wed, 03 May 2023 08:09:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683126567; x=1685718567;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tPIipKgTlqdpegnWlgQlSJ+XqyJ5yhguaEJrq4DhnLE=;
        b=M4uW9+rcEYS70eZRiPydUVPuvJ85sKQ0Ta6c9erKBjqV1biNtWjSft3gOQNN0wp/cY
         utcpVxNIPEuvbeUUlkjkrYnyXpX7K8KdPfzkH+8WyH20s7ddU5nahJJkmjRSw9xjE3+S
         BIi4GcMwKBMJ2iwWLw0cDV2UszjPkquNLpSIXaWvIwon+mO5TBp/V0oW0kg31IdyZaUD
         gwEgZUaG8eResLrtD08TSsX34hnLsjlKACYThyGMObQI9LvN/BP6pNIg3UeAMYPy426G
         RjFpECsOvaqERhUlRCBmDVPz/JoqcPfU9o3dBnqoz5Hs8i0CxmDVQFAvKNVrihc00/hW
         KWcg==
X-Gm-Message-State: AC+VfDzeuFNEj8HCunQMJIZ0ePqOtnnWCzuLviEqSMZSvfO4eGwmA6KI
	x0nfB1j3zICa6uQ53S46awqxgMUoiD8=
X-Google-Smtp-Source: ACHHUZ7+EPdelb93fH1KNLRRCKb/xKh30Q28rvPXdKTriKoh8UMh5zfqLZWWngbp/I9wQDG3VQXInQ==
X-Received: by 2002:a05:600c:510a:b0:3f1:7490:e595 with SMTP id o10-20020a05600c510a00b003f17490e595mr13808270wms.2.1683126567123;
        Wed, 03 May 2023 08:09:27 -0700 (PDT)
Received: from localhost.localdomain (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id f8-20020a5d4dc8000000b002f9e04459desm33983779wru.109.2023.05.03.08.09.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 08:09:26 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Cc: Irvin Cote <irvincoteg@gmail.com>
Subject: [PATCH] nvme: Fix memory leak in nvme_init_ctrl error path
Date: Wed,  3 May 2023 18:09:25 +0300
Message-Id: <20230503150925.863308-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230503_080930_930900_AC6B4FAB 
X-CRM114-Status: GOOD (  20.09  )
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

nvme_init_ctrl may fail before creating the misc device or after creating
the misc device.

If we fail before creating the misc device, we just need to deallocate what
was allocated before and return (as usually done).

If we fail after we create the misc device, we must put
the final reference on the device in order to make sure that internal
device resources are cleaned up.

The device release also triggers nvme_free_ctrl method so we need to make
sure to identify that we failed during the initialization itself and skip
cleaning because nvme_init_ctrl error path cleaned up on its own (we do
that by marking the ctrl->instance to UNINITIALIZED).

We also drop the explicit dev_name deallocation because it is freed in
the device release sequence.

This addresses a memory leak triggered by blktests nvme/044 which happens
to fail exactly after misc device initialization:
--
unreferenced object 0xffff95678a54cd00 (size 256):
  comm "nvme", pid 1941, jiffies 4294761594 (age 10.010s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 08 cd 54 8a 67 95 ff ff  ..........T.g...
    08 cd 54 8a 67 95 ff ff e0 b5 7b 8b ff ff ff ff  ..T.g.....{.....
  backtrace:
    [<ffffffff8b349205>] kmalloc_trace+0x25/0x90
    [<ffffffff8b7c0463>] device_add+0x303/0x690
    [<ffffffff8b4103c4>] cdev_device_add+0x44/0x90
    [<ffffffffc0de1c42>] 0xffffffffc0de1c42
    [<ffffffffc0d788b3>] 0xffffffffc0d788b3
    [<ffffffffc0d8c66d>] 0xffffffffc0d8c66d
    [<ffffffffc0d8c831>] 0xffffffffc0d8c831
    [<ffffffff8b40a8b2>] vfs_write+0xc2/0x3c0
    [<ffffffff8b40aeff>] ksys_write+0x5f/0xe0
    [<ffffffff8bc0eb58>] do_syscall_64+0x38/0x90
    [<ffffffff8be000aa>] entry_SYSCALL_64_after_hwframe+0x72/0xdc
--

Reported-by: Irvin Cote <irvincoteg@gmail.com>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/core.c | 28 ++++++++++++++++------------
 drivers/nvme/host/nvme.h |  1 +
 2 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index ea508e9a1de7..b374e6007553 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -5083,6 +5083,9 @@ static void nvme_free_ctrl(struct device *dev)
 		container_of(dev, struct nvme_ctrl, ctrl_device);
 	struct nvme_subsystem *subsys = ctrl->subsys;
 
+	if (ctrl->instance == NVME_CTRL_INSTANCE_UNINITIALIZED)
+		return;
+
 	if (!subsys || ctrl->instance != subsys->instance)
 		ida_free(&nvme_instance_ida, ctrl->instance);
 
@@ -5137,18 +5140,19 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 	INIT_DELAYED_WORK(&ctrl->failfast_work, nvme_failfast_work);
 	memset(&ctrl->ka_cmd, 0, sizeof(ctrl->ka_cmd));
 	ctrl->ka_cmd.common.opcode = nvme_admin_keep_alive;
+	ctrl->instance = NVME_CTRL_INSTANCE_UNINITIALIZED;
 
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
-	if (ret < 0)
-		goto out;
+	if (ret < 0) {
+		__free_page(ctrl->discard_page);
+		return ret;
+	}
 	ctrl->instance = ret;
 
 	device_initialize(&ctrl->ctrl_device);
@@ -5172,7 +5176,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 	ctrl->cdev.owner = ops->module;
 	ret = cdev_device_add(&ctrl->cdev, ctrl->device);
 	if (ret)
-		goto out_free_name;
+		goto out_put_ctrl;
 
 	/*
 	 * Initialize latency tolerance controls.  The sysfs files won't
@@ -5193,14 +5197,14 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 	nvme_fault_inject_fini(&ctrl->fault_inject);
 	dev_pm_qos_hide_latency_tolerance(ctrl->device);
 	cdev_device_del(&ctrl->cdev, ctrl->device);
-out_free_name:
+out_put_ctrl:
+	/* pairs with nvme_get_ctrl */
 	nvme_put_ctrl(ctrl);
-	kfree_const(ctrl->device->kobj.name);
 out_release_instance:
 	ida_free(&nvme_instance_ida, ctrl->instance);
-out:
-	if (ctrl->discard_page)
-		__free_page(ctrl->discard_page);
+	ctrl->instance = NVME_CTRL_INSTANCE_UNINITIALIZED;
+	/* pairs with device_initialize .release method will cleanup */
+	nvme_put_ctrl(ctrl);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(nvme_init_ctrl);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index bf46f122e9e1..920403589670 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -255,6 +255,7 @@ struct nvme_ctrl {
 	struct request_queue *connect_q;
 	struct request_queue *fabrics_q;
 	struct device *dev;
+#define NVME_CTRL_INSTANCE_UNINITIALIZED (-1)
 	int instance;
 	int numa_node;
 	struct blk_mq_tag_set *tagset;
-- 
2.34.1



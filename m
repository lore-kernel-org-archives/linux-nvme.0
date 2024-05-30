Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F307C25B74
	for <linux-nvme@archiver.kernel.org>; Thu, 30 May 2024 07:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=3UyTm6T9E8JAR19ob99yKTME3iMRLNxNVW2HWL/fV0c=; b=455WMFI4if8g7CkGeS2FkLjYH7
	gnVadnu4cHCiOxFFn53fmiXEpEiM25ZjQDqmnbehoJfWGiaDFPHudNulzMjJzU+GI9jhTZwQz+qAI
	3A3WRrGXceDnbuBL0IgdqFaGy7GSc4QLZp51FuAH6s+o47ayWwsUMnQP9Xy/7Lguk69D8h42lCqFP
	QooPKKRRtdhCodODJDtERe4bh8c7+ZJdCofuSvmFvnWCqtkD4viNSnU/2i5AkUckOtMcb3w89hmBa
	jAR4zUdLI3fdeKMuDtDqC415pvL3qQVKsF1hYTplQtw8HY7grwIOgF2HJF1hUobiqXjO4Lda+Mz1c
	VJxFOFMQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCa7Y-00000006VEI-1vLK;
	Thu, 30 May 2024 07:22:44 +0000
Received: from mail-lj1-f171.google.com ([209.85.208.171])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCa7R-00000006VCm-44OL
	for linux-nvme@lists.infradead.org;
	Thu, 30 May 2024 07:22:39 +0000
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2e9618794c0so834191fa.1
        for <linux-nvme@lists.infradead.org>; Thu, 30 May 2024 00:22:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717053755; x=1717658555;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3UyTm6T9E8JAR19ob99yKTME3iMRLNxNVW2HWL/fV0c=;
        b=bin1zqQs5GdTJTRWI2gTaGd9PrJ3rI5DPlSf579Vyl8acVupPvfTnMmqQa1FCQDdwQ
         jc1VNtiyY0Ep8f3m+TaUt0AtnuR9UaQT/LhR74EQeC8HILzU+6G/fI/SHhs3kvQQ2KW7
         WLkziIWyohCbkmAOE5LRRM/9VLz6Y/+JOh1suhx/Q8emplad2c2NPN0SNrWW5NmO3/7E
         ytAumhi182cg7O4ftJ5QZJHu/sMB93uhoK8oZnouOanQV/7qOyAKGhksWik2UguMSp8C
         r0EmqhxOrLHx8j2yaY3/ujEkcjEhuBleOzZIICx3peYpew3yvFpcYF93giDNbusfyrY0
         sD6Q==
X-Gm-Message-State: AOJu0YyYHeGlqybAcfo1YeI5mIuvI7DC8p91ItTF+Pom3k2iT4cmPJKd
	366miaJ+rHA3M79uPBdto+L4aTjO959aVc3Yvg5Ei80BUH843yT08yDHqg==
X-Google-Smtp-Source: AGHT+IHldlp12XlOeb8JvrWGKyUDZ708lCjR5FBahsTiZ3n79qWqFk+H3DYQpz45N2VTHKKqpaEClw==
X-Received: by 2002:a05:651c:2116:b0:2e6:f1bf:9897 with SMTP id 38308e7fff4ca-2ea84854e6emr6993251fa.4.1717053755074;
        Thu, 30 May 2024 00:22:35 -0700 (PDT)
Received: from vastdata-ubuntu2.vstd.int (85.65.193.189.dynamic.barak-online.net. [85.65.193.189])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4212709d34csm15766445e9.31.2024.05.30.00.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 00:22:34 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Maurizio Lombardi <mlombard@redhat.com>,
	Yi Zhang <yi.zhang@redhat.com>,
	Hannes Reinecke <hare@suse.de>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH rfc] nvme: fix a possible memory leak when failing to initialize ctrl auth
Date: Thu, 30 May 2024 10:22:33 +0300
Message-Id: <20240530072233.899680-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240530_002238_047866_46F1E2AD 
X-CRM114-Status: GOOD (  18.73  )
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

In case nvme_auth_init_ctrl fails, we leak memory [1] due to not dropping
the device reference to zero, causing a device private allocation to leak.

Dropping the reference to zero to trigger device .release() is a bit
problematic here because the callers of nvme_init_ctrl() cannot sanely
understand if it failed before or after a device was added, hence don't
know if they need to cleanup or allow the ctrl device release to cleanup.

Instead, we simply move the call to nvme_auth_init_ctrl before we add the
device such that nvme_init_ctrl either fails without creating a device
or it succeeds. We also add a code comment to try and prevent similar issues
from coming back in the future.

[1]:
--
unreferenced object 0xffff91488fb07200 (size 256):
  comm "nvme", pid 29344, jiffies 4295069699
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 08 72 b0 8f 48 91 ff ff .........r..H...
    08 72 b0 8f 48 91 ff ff 00 d6 55 a2 ff ff ff ff .r..H.....U.....
  backtrace (crc 36f6c278):
    [<ffffffffa2b8b46a>] kmemleak_alloc+0x4a/0x90
    [<ffffffffa1e57897>] kmalloc_trace+0x2f7/0x3a0
    [<ffffffffa2562fd0>] device_add+0x510/0x8c0
    [<ffffffffa1ee5b9e>] cdev_device_add+0x4e/0xc0
    [<ffffffffc133b7a0>] nvme_init_ctrl+0x360/0x460 [nvme_core]
    [<ffffffffc13b0af6>] 0xffffffffc13b0af6
    [<ffffffffc120e565>] 0xffffffffc120e565
    [<ffffffffa1edeb14>] vfs_write+0x104/0x490
    [<ffffffffa1edf263>] ksys_write+0x73/0x100
    [<ffffffffa1edf319>] __x64_sys_write+0x19/0x30
    [<ffffffffa1a0553e>] x64_sys_call+0x7e/0x25c0
    [<ffffffffa2b7be01>] do_syscall_64+0x71/0x130
    [<ffffffffa2c0012b>] entry_SYSCALL_64_after_hwframe+0x76/0x7e
unreferenced object 0xffff91488ed7ea00 (size 256):
  comm "nvme", pid 37478, jiffies 4295155857
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 08 ea d7 8e 48 91 ff ff ............H...
    08 ea d7 8e 48 91 ff ff 00 d6 55 a2 ff ff ff ff ....H.....U.....
  backtrace (crc fc1acf5):
    [<ffffffffa2b8b46a>] kmemleak_alloc+0x4a/0x90
    [<ffffffffa1e57897>] kmalloc_trace+0x2f7/0x3a0
    [<ffffffffa2562fd0>] device_add+0x510/0x8c0
    [<ffffffffa1ee5b9e>] cdev_device_add+0x4e/0xc0
    [<ffffffffc133b7a0>] nvme_init_ctrl+0x360/0x460 [nvme_core]
    [<ffffffffc13707b7>] 0xffffffffc13707b7
    [<ffffffffc120e565>] 0xffffffffc120e565
    [<ffffffffa1edeb14>] vfs_write+0x104/0x490
    [<ffffffffa1edf263>] ksys_write+0x73/0x100
    [<ffffffffa1edf319>] __x64_sys_write+0x19/0x30
    [<ffffffffa1a0553e>] x64_sys_call+0x7e/0x25c0
    [<ffffffffa2b7be01>] do_syscall_64+0x71/0x130
    [<ffffffffa2c0012b>] entry_SYSCALL_64_after_hwframe+0x76/0x7e
--

Suggested-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/core.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f62fd49c1411..a7e820840cf7 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4655,9 +4655,13 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 		goto out;
 	}
 
+	ret = nvme_auth_init_ctrl(ctrl);
+	if (ret)
+		goto out;
+
 	ret = ida_alloc(&nvme_instance_ida, GFP_KERNEL);
 	if (ret < 0)
-		goto out;
+		goto out_free_auth;
 	ctrl->instance = ret;
 
 	device_initialize(&ctrl->ctrl_device);
@@ -4683,6 +4687,15 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 	if (ret)
 		goto out_free_name;
 
+	/*
+	 * NOTE: please do not add any function calls after cdev_device_add
+	 * becuase once we added a device we have to pair our cleanup with
+	 * the device reference model, which makes the callers of nvme_init_ctrl
+	 * unable to understand if they should cleanup upon failure, or the
+	 * device release will take care of it. So make sure that once a device
+	 * was created, this function will not fail.
+	 */
+
 	/*
 	 * Initialize latency tolerance controls.  The sysfs files won't
 	 * be visible to userspace unless the device actually supports APST.
@@ -4693,20 +4706,15 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 
 	nvme_fault_inject_init(&ctrl->fault_inject, dev_name(ctrl->device));
 	nvme_mpath_init_ctrl(ctrl);
-	ret = nvme_auth_init_ctrl(ctrl);
-	if (ret)
-		goto out_free_cdev;
 
 	return 0;
-out_free_cdev:
-	nvme_fault_inject_fini(&ctrl->fault_inject);
-	dev_pm_qos_hide_latency_tolerance(ctrl->device);
-	cdev_device_del(&ctrl->cdev, ctrl->device);
 out_free_name:
 	nvme_put_ctrl(ctrl);
 	kfree_const(ctrl->device->kobj.name);
 out_release_instance:
 	ida_free(&nvme_instance_ida, ctrl->instance);
+out_free_auth:
+	nvme_auth_free(ctrl);
 out:
 	if (ctrl->discard_page)
 		__free_page(ctrl->discard_page);
-- 
2.40.1



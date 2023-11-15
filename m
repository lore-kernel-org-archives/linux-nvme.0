Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C11EC2BB3F
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Nov 2023 18:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=iiqeEd+SqdqCRIn1p4O2vFaLNnvzT4PHHcDNR7I1Uik=; b=ZU6WFwhjGqe9XMC9tkPTAaWW9E
	jBRN484fJ4YHIimxC6EY99Onaf+zKm+m1RY8ZLb/duRJvSKN32MBdIs8HZUIEMTrb3CdwYurP3BhA
	bHyWOP8bKzqd/mvGflAdF+cIpsS4Y5umYcdo5D6QxAKruVDb4AKDJAbh9CFWAQmdKJNmgbZ5jf7wO
	033asw+CvLi50+KLEKT2sn2k6d+q+FSk8i2Vv3GzQev7xPXymSomtYBrG7l8zCOJcXYc4hye7fGZD
	cXw+hEdBAS0lLVJ7w4d0Klc3ULfYfgFkUXXjFW7dwbdTYbGBEVuJ4vAHHIOcwDgBYQALT/93g5tCm
	cg6x35Kg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r3L2P-001XkD-0Y;
	Wed, 15 Nov 2023 18:54:57 +0000
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r3L2M-001Xjg-0X
	for linux-nvme@lists.infradead.org;
	Wed, 15 Nov 2023 18:54:55 +0000
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-6bf03b98b9bso881605b3a.1
        for <linux-nvme@lists.infradead.org>; Wed, 15 Nov 2023 10:54:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1700074489; x=1700679289; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iiqeEd+SqdqCRIn1p4O2vFaLNnvzT4PHHcDNR7I1Uik=;
        b=DKNwm5vmISsCL1p7VaBO7jaOKHs+rofEb8MvS6MOcptaUbI7ihTlPQkQrkFOyiIKCT
         Hq1O/xPBI1v+nK5Ihims8dR4vpSl/xp5fC6PJj79339ZBDsttCPDaoH80EIt9DAqLNcH
         yqtQYFK1pewmxPRSD4dc6GThEOdDOK2Bg7yRphGVMCawjLPMRmPvGtyEVnjPATcZHQnn
         VAOhk2qFSqp37Z5on3KFI93eW/Cvr8h+fPC5t1xYNKq3dNv8OhMXJDm22vslypoajDVL
         jhj0BGavvuDAyr7diDY+XCYgk/IHXWa5AuiinTW+mrFL7eSfKFKf5neN3+0FLySJAzlf
         uzKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700074489; x=1700679289;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iiqeEd+SqdqCRIn1p4O2vFaLNnvzT4PHHcDNR7I1Uik=;
        b=KN7j04YTqz/S0IEdbkDWxlf9ToEuL+mj7Li7z/uIrvnW1nNl2inrmpIS6boOPhUjM/
         IT7Z3M8WEbycJrPOTRWIbp9Cd3fdgtAw89qXO+UpniYQS05FhwlCLuuTSthB5WCWoeEp
         HqioOmQf6XEWAs1V7ty4xa86956i4M+knkKvQPfw6TsI83ytdD+tffj7W2vxyHS2Tp2J
         Rtk5UdJzdNHGljmC3jJpeASFQ8lJVcSQxiWWF3x8hoq7S8uzJV1tuXh1uzLF8PXiUsxG
         wHbBKJwnJOhijtp+M3gWcB1FtPu7xdgiDjM0NtZp+v9NC/Mhn7VnO0FdHjrX/R+o3Fex
         VnJg==
X-Gm-Message-State: AOJu0YwcfZJJhASdm3pMUcBTaeJt3mFHrTIvKY4SJVsT9tNGRy6M98bb
	zDxBTosH50XxD1BZumtNmRxvOQ==
X-Google-Smtp-Source: AGHT+IFrsJNWu2MFPbDjYv0LhdHK4l5b2SYr5UhYuqVcCzDEwqaElgEDRvuUN1Pjw2T0f7b/VS3Hrw==
X-Received: by 2002:a05:6a00:1f1a:b0:68c:44ed:fb6 with SMTP id be26-20020a056a001f1a00b0068c44ed0fb6mr9560276pfb.16.1700074488956;
        Wed, 15 Nov 2023 10:54:48 -0800 (PST)
Received: from dev-yzhong.dev.purestorage.com ([208.88.159.129])
        by smtp.googlemail.com with ESMTPSA id e17-20020a056a001a9100b006c39efc97b3sm3099012pfv.113.2023.11.15.10.54.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 10:54:48 -0800 (PST)
From: Yuanyuan Zhong <yzhong@purestorage.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	randyj@purestorage.com,
	hcoutinho@purestorage.com,
	Yuanyuan Zhong <yzhong@purestorage.com>
Subject: [PATCH] nvme-core: remove head->effects to fix use-after-free
Date: Wed, 15 Nov 2023 11:54:39 -0700
Message-Id: <20231115185439.2616073-1-yzhong@purestorage.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231115_105454_301010_722F21A7 
X-CRM114-Status: GOOD (  15.12  )
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

The head->effects stores a pointer to the controller's Command Sets
Supported and Effects log. When the namespace head is shared by multiple
controllers, if the particular controller is removed, dereferencing
head->effects causes use-after-free:

[  227.820066] ==================================================================
[  227.820069] BUG: KFENCE: use-after-free read in nvme_command_effects+0x1f/0x90 [nvme_core]

[  227.820091] Use-after-free read at 0x00000000c02dadcf (in kfence-#0):
[  227.820094]  nvme_command_effects+0x1f/0x90 [nvme_core]
[  227.820107]  nvme_passthru_start+0x19/0x80 [nvme_core]
[  227.820121]  nvme_submit_user_cmd+0xc7/0x170 [nvme_core]
[  227.820136]  nvme_user_cmd.constprop.16+0x152/0x1d0 [nvme_core]
[  227.820149]  nvme_ns_head_ioctl+0x92/0x140 [nvme_core]
[  227.820162]  blkdev_ioctl+0x1c5/0x280
[  227.820169]  __x64_sys_ioctl+0x93/0xd0
[  227.820174]  do_syscall_64+0x45/0xf0
[  227.820177]  entry_SYSCALL_64_after_hwframe+0x6e/0x76

[  227.820182] kfence-#0: 0x000000000fac1d5d-0x00000000a28a73c3, size=4096, cache=kmalloc-4k

[  227.820185] allocated by task 2559 on cpu 3 at 188.703118s:
[  227.820233]  __kmem_cache_alloc_node+0x3c9/0x410
[  227.820236]  kmalloc_trace+0x2a/0xa0
[  227.820238]  nvme_get_effects_log+0x68/0xd0 [nvme_core]
[  227.820251]  nvme_init_identify+0x5ef/0x640 [nvme_core]
[  227.820263]  nvme_init_ctrl_finish+0x8d/0x250 [nvme_core]
[  227.820275]  nvme_tcp_setup_ctrl+0x1ce/0x710 [nvme_tcp]
[  227.820281]  nvme_tcp_create_ctrl+0x359/0x450 [nvme_tcp]
[  227.820286]  nvmf_dev_write+0x203/0x3b0 [nvme_fabrics]
[  227.820292]  vfs_write+0xd2/0x3d0
[  227.820294]  ksys_write+0x5d/0xd0
[  227.820297]  do_syscall_64+0x45/0xf0
[  227.820298]  entry_SYSCALL_64_after_hwframe+0x6e/0x76

[  227.820302] freed by task 2521 on cpu 28 at 220.115945s:
[  227.820329]  nvme_free_ctrl+0xa6/0x260 [nvme_core]
[  227.820342]  device_release+0x37/0x90
[  227.820345]  kobject_release+0x57/0x120
[  227.820347]  nvme_sysfs_delete+0x39/0x50 [nvme_core]
[  227.820360]  kernfs_fop_write_iter+0x144/0x1e0
[  227.820362]  vfs_write+0x25f/0x3d0
[  227.820364]  ksys_write+0x5d/0xd0
[  227.820366]  do_syscall_64+0x45/0xf0
[  227.820368]  entry_SYSCALL_64_after_hwframe+0x6e/0x76

Fix this by removing head->effects. Use the Commands Supported and Effects log
in ctrl->cels directly.

Fixes: be93e87e7802 ("nvme: support for multiple Command Sets Supported and Effects log pages")
Signed-off-by: Yuanyuan Zhong <yzhong@purestorage.com>
Reviewed-by: Randy Jennings <randyj@purestorage.com>
Reviewed-by: Hamilton Coutinho <hcoutinho@purestorage.com>
---
 drivers/nvme/host/core.c | 17 ++++++++---------
 drivers/nvme/host/nvme.h |  1 -
 2 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 88b54cdcbd68..14fdc2de3a75 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1085,7 +1085,9 @@ u32 nvme_command_effects(struct nvme_ctrl *ctrl, struct nvme_ns *ns, u8 opcode)
 	u32 effects = 0;
 
 	if (ns) {
-		effects = le32_to_cpu(ns->head->effects->iocs[opcode]);
+		struct nvme_effects_log	*cel = xa_load(&ctrl->cels, ns->head->ids.csi);
+
+		effects = le32_to_cpu(cel->iocs[opcode]);
 		if (effects & ~(NVME_CMD_EFFECTS_CSUPP | NVME_CMD_EFFECTS_LBCC))
 			dev_warn_once(ctrl->device,
 				"IO command:%02x has unusual effects:%08x\n",
@@ -2872,7 +2874,8 @@ static int nvme_get_effects_log(struct nvme_ctrl *ctrl, u8 csi,
 
 	xa_store(&ctrl->cels, csi, cel, GFP_KERNEL);
 out:
-	*log = cel;
+	if (log)
+		*log = cel;
 	return 0;
 }
 
@@ -3388,13 +3391,6 @@ static struct nvme_ns_head *nvme_alloc_ns_head(struct nvme_ctrl *ctrl,
 	head->shared = info->is_shared;
 	kref_init(&head->ref);
 
-	if (head->ids.csi) {
-		ret = nvme_get_effects_log(ctrl, head->ids.csi, &head->effects);
-		if (ret)
-			goto out_cleanup_srcu;
-	} else
-		head->effects = ctrl->effects;
-
 	ret = nvme_mpath_alloc_disk(ctrl, head);
 	if (ret)
 		goto out_cleanup_srcu;
@@ -3779,6 +3775,9 @@ static void nvme_scan_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 	if (ret || !info.is_ready)
 		return;
 
+	if (info.ids.csi && nvme_get_effects_log(ctrl, info.ids.csi, NULL))
+		return;
+
 	ns = nvme_find_get_ns(ctrl, nsid);
 	if (ns) {
 		nvme_validate_ns(ns, &info);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 39a90b7cb125..38298c072ec3 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -445,7 +445,6 @@ struct nvme_ns_head {
 	struct kref		ref;
 	bool			shared;
 	int			instance;
-	struct nvme_effects_log *effects;
 
 	struct cdev		cdev;
 	struct device		cdev_device;
-- 
2.34.1



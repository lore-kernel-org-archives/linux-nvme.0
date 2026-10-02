Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00B93CA5FDD
	for <linux-nvme@archiver.kernel.org>; Fri,  2 Oct 2026 16:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IaFagpghjtV9+3wZXz2ZSUNu1qs1ItHjvm01FGweyZ4=; b=W4zWT3dvd4CuWOVm/JyOhEIhdY
	bzRbI6L8VscXptK0i/qGWFioJNbVQeV3l9thojcWuSsYqZZz6XlauoHQAprRHf+4obhBTYcemTzdx
	Wt3OiJ8JP9sKPo/cgE3ww93LfKJLkE5TYxnNzRqH8HjxFvcnmdyzhwQsmZ/eiwQ4hWBBXrWJV00w1
	QHaB2IQ1S0ju/7KGzfDYoIcXTHcDWXVWoD89hB7Gd4CeORCNJBAOeiKrb5swfqZdD9ZiNqsIymDIj
	bd6A4kFapposYxYHYOKbbuX/ZugSrFD9v+2xENp3eqEhkEjSIj+/gpsEiu5CaIf3uSGuBcdeAdzPo
	tMnBIxSg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xCgA7-0000000C2Gc-2psl;
	Fri, 02 Oct 2026 16:31:07 +0000
Received: from mail-pj2-x10.google.com ([2607:f8b0:4864:39::10])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xCgA4-0000000C2Fl-1mWs
	for linux-nvme@lists.infradead.org;
	Fri, 02 Oct 2026 16:31:05 +0000
Received: by mail-pj2-x10.google.com with SMTP id 98e67ed59e1d1-396ccd5cf02so4087560a91.3
        for <linux-nvme@lists.infradead.org>; Fri, 02 Oct 2026 09:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790958663; x=1791563463; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IaFagpghjtV9+3wZXz2ZSUNu1qs1ItHjvm01FGweyZ4=;
        b=k3aSYFBTDmeJ0tRbjFLyZpdqkmZzlwcuyHQ7hM+Mz09tYD79F2l6aC8u6LyMmmFSlx
         Kha8UH7MzjkS29fNP2Pu4K47KrBaSaxgmDzJu97JftS63hDg693ZBomqUDrpfDBfrSHB
         sxNNb5gKm5CTAdkYB3fE3DbAQahsEW3Q94g33QRPE5vp5xh+JJWoGj55os7b9MJMrfIE
         IYUMH9zv/jJB6nhCEbJgCh6lmgkoYoIYLAlrVe95IEtJMchAUZHo6Rlnk61y/+ZtpXy+
         fuMmh+FKXj5mH89aP0TBdFB3erQUBvVcGzvxivBR2P1PQKSYQKAxaMSaTniNsPeAt2L2
         9nwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790958663; x=1791563463;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IaFagpghjtV9+3wZXz2ZSUNu1qs1ItHjvm01FGweyZ4=;
        b=mcwPcFoj7oQALL59Fb1qAOsWSrJwZ1Wry2rNXSqXE3k2Oy9vEATrpJ/fMf3uWYaAWE
         mDkVUepQbYGGnFUejt+0/cwbs7JXpitGBpGrybBvYaU8nBHQh+utv2RCT7scl0uW2P2z
         f1DsbhxhvOOlsmAbsp/FZOnOhoEEcfbiwzhc63sYnoejxmnEjREAycS3011Fwdj3joWu
         pGzPH5Bl73D2zMal6JZBcZBOI3EUCKD6RhD1PKl3eE8CoI3LMeaWeHoo3yOKNnEv6UsI
         Cl3Yqkn6xsLHc17meiUA2+IPxN8biIZtwfnm93WwwFIfPL6cZc3bMp+9p79NQjMhn/ke
         KSDg==
X-Forwarded-Encrypted: i=1; AKwUvBwwp1WEnHLwwPpfQn4w09MSTIDDg24UfzuY6nDeIzL00Td885rAv666C2rgGQoP25rBuMvygG89Ize9@lists.infradead.org
X-Gm-Message-State: AFq9FYJNtuJfdtqwg+D9Xl8CI6di1hNvQJ2vpIMUYSHutWPnOqW40DWo
	7mT2kjGxFFMv5Koznujzme80n3PVFDG+xuX1p735REGmP3+fHFfrHh17l6fBJsKd
X-Gm-Gg: AYBFou2+8xD0CwDnQwyHTMTftQdO3YsD9ksybBX23KzWiJOgniiaENQQZR38J1/RhEk
	dsYOMiap1FnLQThDhRaN4WNxprNDuYOA5OO1XSRy37gY1uvt0btgtGaZMVmgtXr/FoeSDrpweK1
	1ipQixfsx95lFRajD8kugaiun8B2nxrD069juOhOaPfT3RG7iUMB0Cr2NHp/6fZ+qU6o8S8hPhh
	6HGU+dl4gQzQU9G733u7iu9ItLI9cV3MktgVb0tKEyR5URXjObzPCajUuDvr6gwG1aXJIPz6INd
	Hlc/4ikG3Ici5UXugp9FY6K4AzsvaBBRPB8ONNVu3QTu0x8UQMSS1u0YNZ06aVTHUl8CNtRGp+l
	/v34YQ99lyVKDsOccuSgdfYPyKtXkSPUmwiVOIySGo5Nhiq8MO0sxIL9h5I/K63GREjE0hwf68C
	ROXAa+RX+1pCQZy0kOpldTZciwFe/sgOzWvDy20t4ifm6e5zl1YmRSDdcvQ19vIDvpU1gFGw==
X-Received: by 2002:a17:90b:5687:b0:3a4:cbc4:4a98 with SMTP id 98e67ed59e1d1-3a6cec878e2mr3192049a91.64.1790958662555;
        Fri, 02 Oct 2026 09:31:02 -0700 (PDT)
Received: from thangnn-ASUS.. ([2a09:bac1:7aa0:50::3cf:1b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a4f4747100sm9483860a91.11.2026.10.02.09.30.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 09:31:01 -0700 (PDT)
From: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+76c0f0ce8f1e846b4f84@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com,
	stable@vger.kernel.org
Subject: [PATCH] nvme: keep the effects log per namespace path, not in the shared head
Date: Fri,  2 Oct 2026 23:30:56 +0700
Message-ID: <20261002163056.48708-1-ngocthang2710.1999@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <6abf0753.eb639fcc.2b981.0008.GAE@google.com>
References: <6abf0753.eb639fcc.2b981.0008.GAE@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261002_093104_480949_5D310817 
X-CRM114-Status: GOOD (  23.65  )
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

nvme_alloc_ns_head() points head->effects at an effects log owned by the
controller that created the head: an entry in that controller's ctrl->cels
xarray, or ctrl->effects for the NVM command set, which also lives there.
The head is shared by all controllers attached to the same namespace and
can outlive its creator. Once that controller is deleted, nvme_free_cels()
frees the log while the head still points at it.

Any later user then reads freed memory: nvme_query_zone_info() when another
controller scans or rescans a zoned namespace, as reported by syzbot, and
nvme_command_effects() for I/O passthrough on a surviving path.

  BUG: KASAN: slab-use-after-free in nvme_query_zone_info+0x4fd/0x6f0
  Read of size 4 at addr ffff88803745a5f4 by task kworker/u8:13/5985
   nvme_query_zone_info+0x4fd/0x6f0 drivers/nvme/host/zns.c:47
   nvme_update_ns_info_block+0x1b2e/0x2af0 drivers/nvme/host/core.c:2430
   nvme_update_ns_info+0xc6/0xd90 drivers/nvme/host/core.c:2553
   nvme_alloc_ns+0x1a9f/0x3e50 drivers/nvme/host/core.c:4293
   nvme_scan_ns+0x79d/0x910 drivers/nvme/host/core.c:4483
  Freed by task 5948:
   kfree+0x22b/0x6d0 mm/slub.c:6801
   nvme_free_cels drivers/nvme/host/core.c:5165 [inline]
   nvme_free_ctrl+0x1e4/0x6b0 drivers/nvme/host/core.c:5183
   device_release+0xd2/0x270 drivers/base/core.c:2640
   put_device+0x1f/0x30 drivers/base/core.c:3884
   nvme_sysfs_delete+0xc9/0xf0 drivers/nvme/host/sysfs.c:500

The Commands Supported and Effects log is a per-controller property, so
store the pointer in struct nvme_ns instead and look it up for every
namespace path in nvme_init_ns_head(). Each nvme_ns holds a reference on
its controller, so the log stays valid for as long as the path exists,
and commands are checked against the log of the controller that actually
executes them. The lookup stays under subsys->lock, which already
serialized nvme_get_effects_log() for head creation.

Reproduced with two nvme-loop controllers connected to one subsystem
backed by a zoned null_blk device: delete the first controller, then
rescan the second or connect a third.

Fixes: be93e87e7802 ("nvme: support for multiple Command Sets Supported and Effects log pages")
Cc: stable@vger.kernel.org
Reported-by: syzbot+76c0f0ce8f1e846b4f84@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=76c0f0ce8f1e846b4f84
Signed-off-by: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
---
Tested in QEMU (x86_64, KASAN) on v7.3-rc5:

 - Deterministic: two nvme-loop controllers on one subsystem backed by a
   zoned null_blk, delete nvme0, rescan nvme1, connect a third. Before:
   KASAN slab-use-after-free in nvme_query_zone_info() on both the rescan
   and the new-controller path. After: clean.
 - syzbot C reproducer, kasan_multi_shot: 175 reports before; 0 reports
   in two runs after (~900 controllers created/deleted per run).
 - Zone Append is still detected on every path (no "Forcing to
   read-only mode"), and direct I/O to the zoned namespace works.

Deepanshu, Cc'ing you since you posted a test patch on this report.
Pinning the scanning controller in scan_work doesn't cover this case:
the freed log belongs to a different controller, the one that created
the shared head.

 drivers/nvme/host/core.c | 21 +++++++++++++--------
 drivers/nvme/host/nvme.h |  2 +-
 drivers/nvme/host/zns.c  |  2 +-
 3 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index beea23d04a70..e0fea859dfaa 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1234,7 +1234,7 @@ u32 nvme_command_effects(struct nvme_ctrl *ctrl, struct nvme_ns *ns, u8 opcode)
 	u32 effects = 0;
 
 	if (ns) {
-		effects = le32_to_cpu(ns->head->effects->iocs[opcode]);
+		effects = le32_to_cpu(ns->effects->iocs[opcode]);
 		if (effects & ~(NVME_CMD_EFFECTS_CSUPP | NVME_CMD_EFFECTS_LBCC))
 			dev_warn_once(ctrl->device,
 				"IO command:%02x has unusual effects:%08x\n",
@@ -4033,13 +4033,6 @@ static struct nvme_ns_head *nvme_alloc_ns_head(struct nvme_ns *ns,
 	kref_init(&head->ref);
 	ns->head = head;
 
-	if (head->ids.csi) {
-		ret = nvme_get_effects_log(ctrl, head->ids.csi, &head->effects);
-		if (ret)
-			goto out_cleanup_srcu;
-	} else
-		head->effects = ctrl->effects;
-
 	if (ctrl->ctratt & NVME_CTRL_ATTR_FDPS) {
 		ret = nvme_query_fdp_info(ns, info);
 		if (ret < 0)
@@ -4141,6 +4134,18 @@ static int nvme_init_ns_head(struct nvme_ns *ns, struct nvme_ns_info *info)
 	}
 
 	mutex_lock(&ctrl->subsys->lock);
+	/*
+	 * The effects log belongs to this controller, not to the shared head,
+	 * which may outlive the controller that created it.
+	 */
+	if (info->ids.csi) {
+		ret = nvme_get_effects_log(ctrl, info->ids.csi, &ns->effects);
+		if (ret)
+			goto out_unlock;
+	} else {
+		ns->effects = ctrl->effects;
+	}
+
 	head = nvme_find_ns_head(ctrl, info->nsid);
 	if (!head) {
 		ret = nvme_subsys_check_duplicate_ids(ctrl->subsys, &info->ids);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 2cff9fcbf740..7d6ced8ed78b 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -554,7 +554,6 @@ struct nvme_ns_head {
 	bool			shared;
 	bool			rotational;
 	bool			passthru_err_log_enabled;
-	struct nvme_effects_log *effects;
 	u64			nuse;
 	unsigned		ns_id;
 	int			instance;
@@ -620,6 +619,7 @@ struct nvme_ns {
 	struct list_head siblings;
 	struct kref kref;
 	struct nvme_ns_head *head;
+	struct nvme_effects_log *effects;
 
 	unsigned long flags;
 #define NVME_NS_REMOVING		0
diff --git a/drivers/nvme/host/zns.c b/drivers/nvme/host/zns.c
index e31ec6f4f94f..ef75448036f7 100644
--- a/drivers/nvme/host/zns.c
+++ b/drivers/nvme/host/zns.c
@@ -38,7 +38,7 @@ static int nvme_set_max_append(struct nvme_ctrl *ctrl)
 int nvme_query_zone_info(struct nvme_ns *ns, unsigned lbaf,
 		struct nvme_zone_info *zi)
 {
-	struct nvme_effects_log *log = ns->head->effects;
+	struct nvme_effects_log *log = ns->effects;
 	struct nvme_command c = { };
 	struct nvme_id_ns_zns *id;
 	int status;
-- 
2.43.0



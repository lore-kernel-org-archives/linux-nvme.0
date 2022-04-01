Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71979C433F5
	for <linux-nvme@archiver.kernel.org>; Fri,  1 Apr 2022 09:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=tYSXtIUt8rYy7pV+jkn6KiRqNNerIJawkePXUCxfILY=; b=fDLyOe3QaFM5l6Sv1JUOtBHLGk
	E+gRPSFQSloEUKCCz5/7z26rZ0hpCx9piUPGTWv/FLfFBwl6c41q5fhi9wUFdVj3BY2ChNTyC4wVr
	04qp3L+9Vt8Pj67rL1p6mtpouPNt+r4yz9/ohrV3EvYGnfIezlq1oPh+d7yyvQNawMxHnhK59kgju
	d4Xtaei6k1cyYr13CsSzglE3GXeTCDADFgLRGKs/l5JJQapg32WiknLBx02dIM29zGVLLC//OmshW
	1Vckh+Rh+sb9f1ozywIhMPZ4jGDFb1tfvAwd7x2urGYKQ8NhTWuz3i8xF3fH/7/YPOMSbFv78o+ZT
	DKsNE/vg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1naDab-005289-RQ; Fri, 01 Apr 2022 09:29:05 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1naDaZ-00525X-2G
 for linux-nvme@lists.infradead.org; Fri, 01 Apr 2022 09:29:04 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 21FD71FCFF;
 Fri,  1 Apr 2022 09:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1648805338; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=tYSXtIUt8rYy7pV+jkn6KiRqNNerIJawkePXUCxfILY=;
 b=M2jiVytGkDCaB5Y9VKV6sViYIPP8qwdXVpzG2P0zSzjUv+aMZpNVR9B6T9YSL6yvt9Dm4J
 kV1ryg1wBA69/vru+Hv/Yyj18H/vvVi/Y2PCQ6tvwciRpXpiJpxN5R2O/edEc0gqdya17p
 0zZRLln7NSREzA7SCXsSN9O+fy8BvVQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1648805338;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=tYSXtIUt8rYy7pV+jkn6KiRqNNerIJawkePXUCxfILY=;
 b=Li7HFxsnwwMbFkKPvBde+xyJgEGAn/ssqc6nqQQxO64/8PXm07sqEy/Y4BRXp/oN3KrX9e
 Em/hE0vIvbJ8kJAw==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id 191FDA3B89;
 Fri,  1 Apr 2022 09:28:58 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
 id 05D195193AD7; Fri,  1 Apr 2022 11:28:58 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH] nvme: add namespace paths links
Date: Fri,  1 Apr 2022 11:28:55 +0200
Message-Id: <20220401092855.90652-1-hare@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220401_022903_291259_F04C13C8 
X-CRM114-Status: GOOD (  13.52  )
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

It is really annoying to always have to loop through the entire
/sys/block directory just to find the namespace path links for
a single namespace in libnvme/nvme-cli.
So provide links to the namespace paths for efficient lookup.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/host/core.c      | 3 +++
 drivers/nvme/host/multipath.c | 8 ++++++++
 2 files changed, 11 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f204c6f78b5b..df4d89aa061f 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4054,6 +4054,9 @@ static void nvme_ns_remove(struct nvme_ns *ns)
 
 	if (!nvme_ns_head_multipath(ns->head))
 		nvme_cdev_del(&ns->cdev, &ns->cdev_device);
+	else
+		sysfs_remove_link(&disk_to_dev(ns->head->disk)->kobj,
+				  ns->disk->disk_name);
 	del_gendisk(ns->disk);
 	blk_cleanup_queue(ns->queue);
 
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 7fc58e1f6b09..dc9a4018f90d 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -801,6 +801,8 @@ static int nvme_lookup_ana_group_desc(struct nvme_ctrl *ctrl,
 
 void nvme_mpath_add_disk(struct nvme_ns *ns, struct nvme_id_ns *id)
 {
+	int ret;
+
 	if (nvme_ctrl_use_ana(ns->ctrl)) {
 		struct nvme_ana_group_desc desc = {
 			.grpid = id->anagrpid,
@@ -831,6 +833,12 @@ void nvme_mpath_add_disk(struct nvme_ns *ns, struct nvme_id_ns *id)
 	if (blk_queue_is_zoned(ns->queue) && ns->head->disk)
 		ns->head->disk->queue->nr_zones = ns->queue->nr_zones;
 #endif
+	ret = sysfs_create_link(&disk_to_dev(ns->head->disk)->kobj,
+				&disk_to_dev(ns->disk)->kobj,
+				ns->disk->disk_name);
+	if (ret)
+		dev_warn(ns->ctrl->device,
+			 "failed to create namespace path link\n");
 }
 
 void nvme_mpath_shutdown_disk(struct nvme_ns_head *head)
-- 
2.29.2



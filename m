Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 519A6C83F26
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Jul 2025 07:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xep330KiCxC8UYWjH8HfWj6/IVPLkq7X4qwUn4wYUn0=; b=kYVKdmiJ6BTNg0SY2WWSkINH9j
	DLACfHBGIXEcdsrmkjOcA0l4lN07I1sppZ7zVVlZ+xYEGPICnp79lblfyB4f0GQxH9VI/stROrHy0
	Jg0vVAkV65zojXsgE6Mymv9Fv0T+7uANkfRQpSNnnyLlyPZ0KcwB5PL1kQNiD+7v5OE/HeAP31ZxZ
	IGNmms/Px/m7kyitAjDSdo9ohSBglM0GHFtWt/tl1mgm48AThOygWJknLhyle7lsH9k9otBPXI66w
	MLVPkiTf6/hWvrnY8AOqcGEaqAI7AGw16GTK1WY4kfUThAcoc9Sd8l1QQ3GFPSxsGYLkPNH5I4f+t
	WSspZZoA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ugeQe-0000000G5SC-3OvI;
	Tue, 29 Jul 2025 07:07:16 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ugeQY-0000000G5Q9-1lAB
	for linux-nvme@lists.infradead.org;
	Tue, 29 Jul 2025 07:07:11 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id CAEF95C5407;
	Tue, 29 Jul 2025 07:07:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D2C9C4CEEF;
	Tue, 29 Jul 2025 07:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753772829;
	bh=qQrAAOGIhFO0lhuqmaX6f/ogFH06N6Z1KSlwv/2rL88=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RgAbKbQ8uPhZV8D5/Nhju4pny8JNJezqiOrvg5u55ng3YwBy2s9kaoIIudUsiQ7bf
	 0iFeM4U6Nyf/kywdZnRkTonG8zKX/iSsCOxIcsUTFf0gY6JFJmskKlUdSNXP85pkdB
	 7mJeELONo2UeF7lOl8SDDiGB0JdolM3nBM0lAVVD1vXNnMVP893NG/qTbVScbNH4he
	 eThP2rMHv17niFUFR/96zEf+yacinrUWGrpb24+s+qhUAwBR8O9ZgcYjoI4LOmyVPJ
	 r8eBlzzgmgpcmuMBKJM497IdRgXMNQgooX1oH7HinOfaGkylZad8flanBv2DF543QA
	 vsZb2JaA/GM2A==
From: hare@kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 2/6] nvme: export nvme_find_get_subsystem()/nvme_put_subsystem()
Date: Tue, 29 Jul 2025 09:06:49 +0200
Message-ID: <20250729070653.125258-3-hare@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250729070653.125258-1-hare@kernel.org>
References: <20250729070653.125258-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250729_000710_591369_777C5EE4 
X-CRM114-Status: GOOD (  11.87  )
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

From: Hannes Reinecke <hare@kernel.org>

Export functions to find and release a subsystem based on the
subsystem NQN.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/nvme/host/core.c | 14 ++++++++++++--
 drivers/nvme/host/nvme.h |  2 ++
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 895fb163d48e..a2f3da453af4 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -147,7 +147,6 @@ static const struct class nvme_ns_chr_class = {
 	.name = "nvme-generic",
 };
 
-static void nvme_put_subsystem(struct nvme_subsystem *subsys);
 static void nvme_remove_invalid_namespaces(struct nvme_ctrl *ctrl,
 					   unsigned nsid);
 static void nvme_update_keep_alive(struct nvme_ctrl *ctrl,
@@ -3115,7 +3114,7 @@ static void nvme_destroy_subsystem(struct kref *ref)
 	put_device(&subsys->dev);
 }
 
-static void nvme_put_subsystem(struct nvme_subsystem *subsys)
+void nvme_put_subsystem(struct nvme_subsystem *subsys)
 {
 	kref_put(&subsys->ref, nvme_destroy_subsystem);
 }
@@ -3148,6 +3147,17 @@ static struct nvme_subsystem *__nvme_find_get_subsystem(const char *subsysnqn)
 	return NULL;
 }
 
+struct nvme_subsystem *nvme_find_get_subsystem(const char *subsysnqn)
+{
+	struct nvme_subsystem *subsys;
+
+	mutex_lock(&nvme_subsystems_lock);
+	subsys = __nvme_find_get_subsystem(subsysnqn);
+	mutex_unlock(&nvme_subsystems_lock);
+	return subsys;
+}
+EXPORT_SYMBOL_GPL(nvme_find_get_subsystem);
+
 static inline bool nvme_discovery_ctrl(struct nvme_ctrl *ctrl)
 {
 	return ctrl->opts && ctrl->opts->discovery_nqn;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 7df2ea21851f..f1eb8ae57c84 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -948,6 +948,8 @@ extern const struct attribute_group *nvme_subsys_attrs_groups[];
 extern const struct attribute_group *nvme_dev_attr_groups[];
 extern const struct block_device_operations nvme_bdev_ops;
 
+struct nvme_subsystem *nvme_find_get_subsystem(const char *subsysnqn);
+void nvme_put_subsystem(struct nvme_subsystem *subsys);
 void nvme_delete_ctrl_sync(struct nvme_ctrl *ctrl);
 struct nvme_ns *nvme_find_path(struct nvme_ns_head *head);
 #ifdef CONFIG_NVME_MULTIPATH
-- 
2.43.0



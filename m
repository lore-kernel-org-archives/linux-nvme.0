Return-Path: <SRS0=YADc=KM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4D24C433ED
	for <linux-nvme@archiver.kernel.org>; Mon, 17 May 2021 08:27:12 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 880F261221
	for <linux-nvme@archiver.kernel.org>; Mon, 17 May 2021 08:27:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 880F261221
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=7rvoTJpGrZP5dm8Uo6/cew+7u6WVadsb88fkkOfYlss=; b=encPvsPUrhgOtFnGtkoO6v/9ro
	OIH44tXaSU24Quf/0rAZBihBLnbrlmRWapXxynJzmpWXXC2XcyR6XN+jrGJ/+B8FJ+/zW6V6gTydg
	Kev034O6e+GygUV1KvVdxufcfXYJckDTrq4fd1dH9zYA9ooC6q/8GuRJb8sMIBQiIvxUR1GGkFA7Z
	dRRUuC23EYPrzeXqO1NUYsDOKYkiOANiWe3/0qAhDjInpCcvRIMlEICje/f9kZHkfKbhSlzD3WoMz
	7jTTlREWfrJlYyGqyNLvc4vlnBJ0ufzGlych6DWTaDkZQy0XcUD4TMUM/YfegiSfnm8ejCUblMk99
	jmX0cQAA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1liYaX-00EESt-Eo; Mon, 17 May 2021 08:26:57 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1liYNy-00EBk9-Pk
 for linux-nvme@desiato.infradead.org; Mon, 17 May 2021 08:13:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=1w62x+OU+Uj9e/f5c+QNQppW/YigC7AeGD/xlHtQT2c=; b=LJgtaSl4U6lnKdeEctcf93KpTu
 QJDMxtViz+Txl53o9eu1oxmVMOZn6oGQDQqEBNw2v6E8uVKi02ieGaXXnyKsqzLwhyafHLNQmLYiL
 yI7MTLrDUOVpAl/U+SWZGGKXNJPpP8UbK11WvuLwdR42a/TGtUC5SHtT0Hfc+YNJDkTXMeMPO9UFI
 ZI2MCrKXaAB3JyAJOe1DluaQ32XIvaMq1737aUCYyVQ9aXe7XXgHeNBD66t5f7vL/x0bshPdzY72H
 8VL4x8PD+LbDtUaVLcLT76xTfhEWOZbcBHEf8pJPc/sXqEkrRyTD7LeqYaaqYh25qglT/ZIR1tk1G
 mnroNmQg==;
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1liYNt-00DaEh-Lp
 for linux-nvme@lists.infradead.org; Mon, 17 May 2021 08:13:57 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id A6FDFAF3E;
 Mon, 17 May 2021 08:13:49 +0000 (UTC)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH] nvme: add 'iopolicy' module parameter
Date: Mon, 17 May 2021 10:13:48 +0200
Message-Id: <20210517081348.90645-1-hare@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210517_011353_876085_FB3F8D5D 
X-CRM114-Status: GOOD (  12.32  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

While the 'iopolicy' sysfs attribute can be set at runtime, most
storage arrays prefer to use the 'round-robin' iopolicy to be
used. So to avoid having to code a large udev rule detailing
every single storage array add a module parameter 'iopolicy'
to allow the admin to switch the default.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/host/core.c      |  4 +---
 drivers/nvme/host/multipath.c | 10 ++++++++++
 drivers/nvme/host/nvme.h      |  4 ++++
 3 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 6a5386267c10..37740e11eef3 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2608,9 +2608,7 @@ static int nvme_init_subsystem(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 	subsys->vendor_id = le16_to_cpu(id->vid);
 	subsys->cmic = id->cmic;
 	subsys->awupf = le16_to_cpu(id->awupf);
-#ifdef CONFIG_NVME_MULTIPATH
-	subsys->iopolicy = NVME_IOPOLICY_NUMA;
-#endif
+	nvme_mpath_default_iopolicy(subsys);
 
 	subsys->dev.class = nvme_subsys_class;
 	subsys->dev.release = nvme_release_subsystem;
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index ecc99bd5f8ad..9a67ac8347c3 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -13,6 +13,16 @@ module_param(multipath, bool, 0444);
 MODULE_PARM_DESC(multipath,
 	"turn on native support for multiple controllers per subsystem");
 
+static int iopolicy = NVME_IOPOLICY_NUMA;
+module_param(iopolicy, int, 0444);
+MODULE_PARM_DESC(iopolicy,
+	"Default multipath I/O policy; 0 - NUMA (default), 1 - Round-robin");
+
+void nvme_mpath_default_iopolicy(struct nvme_subsystem *subsys)
+{
+	subsys->iopolicy = iopolicy;
+}
+
 void nvme_mpath_unfreeze(struct nvme_subsystem *subsys)
 {
 	struct nvme_ns_head *h;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 05f31a2c64bb..0ff7f9d3373f 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -706,6 +706,7 @@ static inline bool nvme_ctrl_use_ana(struct nvme_ctrl *ctrl)
 void nvme_mpath_unfreeze(struct nvme_subsystem *subsys);
 void nvme_mpath_wait_freeze(struct nvme_subsystem *subsys);
 void nvme_mpath_start_freeze(struct nvme_subsystem *subsys);
+void nvme_mpath_default_iopolicy(struct nvme_subsystem *subsys);
 bool nvme_mpath_set_disk_name(struct nvme_ns *ns, char *disk_name, int *flags);
 void nvme_failover_req(struct request *req);
 void nvme_kick_requeue_lists(struct nvme_ctrl *ctrl);
@@ -803,6 +804,9 @@ static inline void nvme_mpath_wait_freeze(struct nvme_subsystem *subsys)
 static inline void nvme_mpath_start_freeze(struct nvme_subsystem *subsys)
 {
 }
+static inline void nvme_mpath_default_iopolicy(struct nvme_subsystem *subsys)
+{
+}
 #endif /* CONFIG_NVME_MULTIPATH */
 
 int nvme_revalidate_zones(struct nvme_ns *ns);
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

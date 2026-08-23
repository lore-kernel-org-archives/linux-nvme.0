Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 506F7C5B572
	for <linux-nvme@archiver.kernel.org>; Sun, 23 Aug 2026 00:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=+Jc12zKSf8mmT3ZniJisN3BvVvP0RfZaq/VsQ1cAOq4=; b=HytMhFxfRJvrWp/0lAVH7jqj+F
	8riHe7aJxiOaAoIz4BXAVXhpqoqjgju7GXALZ7UZLr+6MgxBRRCpJiJHGm+6bS7PCZwWvoZWYrcFe
	ZtwkM1BB/y6eQ7IRJFYQiCQTvtlZ+0uVCCR8mGAUwsBZaF5m5yRKEM2GdAuYdydh3ImlDrcEvSFJV
	9J8HnyQFA7xjDU7jXttXGlWe7hm5pJn99kpvgVjTfsstPU5hnYfRcB0iTPABWd7s9ytsedzSOnMoR
	Mb2ixBQ7JkNZG3pRwf+1zogbwRpe9WqiIrxXNGpkZCQ/OZYaA6G4M+eMkXKmFLKBoHUmkv5qScC8b
	r4oLQwfg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxwMe-0000000Ew7s-48uy;
	Sun, 23 Aug 2026 00:47:08 +0000
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxwMd-0000000Ew7Y-1p8P
	for linux-nvme@lists.infradead.org;
	Sun, 23 Aug 2026 00:47:08 +0000
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-2ccf2360620so19446685ad.3
        for <linux-nvme@lists.infradead.org>; Sat, 22 Aug 2026 17:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1787446026; x=1788050826; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+Jc12zKSf8mmT3ZniJisN3BvVvP0RfZaq/VsQ1cAOq4=;
        b=DBSniuuRPKM0t95KDhWUb9QDL4ZCwSIjpcE7UZPML24FzytDrNQV8nMu8V+asqkUCl
         +eEGujZFwlcc2tAznB0Dc/goLTaCXko8qqc4glCezeINhfn07Y2uTPAmr9iJtmcEkEin
         Yw31NkkFMk3AOKIkDIMU+3WGKvQFycFoe3a0FAPhQVnUTiyKFMCvZEO0Aet6j7sit0BA
         p3s05w1VLBJdyvH6fH0wF8OrUFlW/uxBWC6TEnAh6qOUeRSZhurcfS8bDTT7db90cxqW
         F4aFKEqQH+q4knN1+GNceM6dyhrvSGEqv1rJArRxwd9E/lw0fTKb5Ek6wb5oPnBCkyHb
         LGyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787446026; x=1788050826;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+Jc12zKSf8mmT3ZniJisN3BvVvP0RfZaq/VsQ1cAOq4=;
        b=d/4TfRX1x2mO1yib0FKywpnUVKwIWuLEkPQYasLHHSaULXq0nXtx0sZ3ofH6ZBJrg9
         Djxrw2UvxFryevJjqrCXBLxPCAgo3+V3E8JGXeH0Y0hw2vpullheKorYySbFYHDvB/4C
         Dk9Sn5MJDEjPs2jCumA2tIbCaaEAWLne0tKEiaOBBS7yi917bFssePBj7ELIJLhmddQo
         dQ6VW3M6alvySXjq8tTJn+RHqT7o85O98ZUjD0KotN57wOMzSisVbOYz05ftR5RvPJ9z
         4ouHsKc/fpeajFOB7/dyiPGgJPNw2OGal4ctph+vMvcJCwRpxeY+z5lGAEkU6xrV25fz
         9s0A==
X-Gm-Message-State: AFuF++nPXI8IQN1PY2waqwqk/JRRvKjOWZS1sUx4/NYjcEtZyZv/3hY0
	svtoQC4sxtwAwMTywabaWNY3gCGMWNColl1FVgUk3r7I6ScsBG1siI5KqhOeiGH0/gA=
X-Gm-Gg: AR+sD12ncQVVYljtGFd4exyqH464jd1byg+7G04F23G/Hc4E9asRBwcTX/nEW/mZN5S
	+sQ65iuHHoalw0fzqf4wftaYuq6lSy5We6/0DdetOR+VuGFmwTULPDHQLaQWSmo1A5fASrR0KD+
	aNfjbqFTD/9LYQsVi4RJVZAfXCgqFA4soeJVxhIepA8SW2Dj/keaFG2QXYM7seMiJDkzE8IZ0Iw
	kleenv3IwDHQWJBtZbgsPQXqceyaALi/2xmZl6W1d188GFt6Nk+xQiS3GPEO9SJgUMhuVXZzD04
	igy0cmrrH4D/lrtwzs1JGMj10MN1Kx9SN/ob0u4vC91aDjJTehJlRj8jChf24vGBQzoH9FHsIlw
	CLUFJFvNuhRxQ5T20PIp2zbnYHE8qXToaSBHoOJ/OpzI32d5sxNSxV6AEAusnCbbKSjpRAvQS2+
	saNqAjVZjshlWDl0XBGvxPB+GNSaBYHneeOggjdUkxrkr81g==
X-Received: by 2002:a17:903:3804:b0:2cc:777f:d67c with SMTP id d9443c01a7336-2d64b0c5704mr320127395ad.13.1787446026282;
        Sat, 22 Aug 2026 17:47:06 -0700 (PDT)
Received: from ceto ([2607:fb90:9c20:7a99::791d])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-32801d7f812sm5767957eec.1.2026.08.22.17.47.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2026 17:47:05 -0700 (PDT)
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Mohamed Khalfella <mkhalfella@purestorage.com>
Subject: [PATCH v2] nvme: remove stale namespaces by NSID range during scan
Date: Sat, 22 Aug 2026 17:46:41 -0700
Message-ID: <20260823004641.1369895-1-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260822_174707_472929_D95ACA71 
X-CRM114-Status: GOOD (  16.75  )
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

nvme_scan_ns_list() drops the stale namespaces in each gap in the
reported NSID list one NSID at a time. Every iteration calls
nvme_find_get_ns() to look the namespace up and removes it if it is
present. The loop runs once per NSID in the gap rather than once per
namespace actually present.

NSIDs are 32-bit, so a target with a sparse NSID space can make a
single gap spin the loop billions of times with nothing to remove.

  watchdog: BUG: soft lockup - CPU#4 stuck for 26s!
  Workqueue: nvme-wq nvme_scan_work [nvme_core]
  RIP: 0010:__srcu_read_unlock+0xb/0x20
  Call Trace:
   nvme_find_get_ns+0x7d/0xb0 [nvme_core]
   nvme_scan_ns_list+0xe8/0x280 [nvme_core]
   nvme_scan_work+0x18a/0x280 [nvme_core]
   process_one_work+0x197/0x380
   worker_thread+0x2fe/0x410
   kthread+0xe0/0x100

Rename nvme_remove_invalid_namespaces() to nvme_remove_nsid_range()
and give it an open (start, end) NSID range. ctrl->namespaces is
sorted by NSID, so the whole gap is dropped in a single walk that
stops once end is reached. This bounds the work by the namespaces
that are present instead of by the size of the gap.

Fixes: 540c801c65eb ("NVMe: Implement namespace list scanning")
Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/core.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 5f2744be7388..cc014cdc72ff 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -155,8 +155,6 @@ static const struct class nvme_ns_chr_class = {
 };
 
 static void nvme_put_subsystem(struct nvme_subsystem *subsys);
-static void nvme_remove_invalid_namespaces(struct nvme_ctrl *ctrl,
-					   unsigned nsid);
 static void nvme_update_keep_alive(struct nvme_ctrl *ctrl,
 				   struct nvme_command *cmd);
 static int nvme_get_log_lsi(struct nvme_ctrl *ctrl, u32 nsid, u8 log_page,
@@ -4513,15 +4511,16 @@ static void nvme_scan_ns_async(void *data, async_cookie_t cookie)
 	nvme_scan_ns(scan_info->ctrl, nsid);
 }
 
-static void nvme_remove_invalid_namespaces(struct nvme_ctrl *ctrl,
-					unsigned nsid)
+static void nvme_remove_nsid_range(struct nvme_ctrl *ctrl, u32 start, u32 end)
 {
 	struct nvme_ns *ns, *next;
 	LIST_HEAD(rm_list);
 
 	mutex_lock(&ctrl->namespaces_lock);
 	list_for_each_entry_safe(ns, next, &ctrl->namespaces, list) {
-		if (ns->head->ns_id > nsid) {
+		if (ns->head->ns_id >= end)
+			break;
+		if (ns->head->ns_id > start) {
 			list_del_rcu(&ns->list);
 			synchronize_srcu(&ctrl->srcu);
 			list_add_tail_rcu(&ns->list, &rm_list);
@@ -4571,13 +4570,14 @@ static int nvme_scan_ns_list(struct nvme_ctrl *ctrl)
 				goto out;
 			async_schedule_domain(nvme_scan_ns_async, &scan_info,
 						&domain);
-			while (++prev < nsid)
-				nvme_ns_remove_by_nsid(ctrl, prev);
+			if (prev + 1 < nsid)
+				nvme_remove_nsid_range(ctrl, prev, nsid);
+			prev = max(prev + 1, nsid);
 		}
 		async_synchronize_full_domain(&domain);
 	}
  out:
-	nvme_remove_invalid_namespaces(ctrl, prev);
+	nvme_remove_nsid_range(ctrl, prev, UINT_MAX);
  free:
 	async_synchronize_full_domain(&domain);
 	kfree(ns_list);
@@ -4597,7 +4597,7 @@ static void nvme_scan_ns_sequential(struct nvme_ctrl *ctrl)
 	for (i = 1; i <= nn; i++)
 		nvme_scan_ns(ctrl, i);
 
-	nvme_remove_invalid_namespaces(ctrl, nn);
+	nvme_remove_nsid_range(ctrl, nn, UINT_MAX);
 }
 
 static void nvme_clear_changed_ns_log(struct nvme_ctrl *ctrl)
-- 
2.54.0



Return-Path: <SRS0=dg6g=FI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CFC8C433FE
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Dec 2020 15:03:32 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6AEB22B2D
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Dec 2020 15:03:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6AEB22B2D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=jjwQ8pe2xdW4TGVoRaHgsfRRwiCY5xhbDpsTEhEXNJo=; b=rD99uNvBJ1RVwBgsN/grk3vIWn
	xvNATbOh9wbD5/EaeokpcuIM1Er2RM/VsbZsEwNRAQVrGHeSogFD7udg+3nG/jF/NMnjvSo9MjRnX
	uqr49V9uHTGc7BdyVS/yjtgul0TgpKZ0jdyYE3gt/2vDNYfbadoYJsHquX55kU6hl2jXU3rQDL/fh
	heAvwPKnlmGBzkzjB6m5JY0qXsTJzDSclIcSSHje0alGQOUUbzWJZec60xJuatpDUr21z6rpBbS6W
	VQhr3UIEjpJ6Bizmu4rUt7n7vWOeA7T/DxvDLPrucQwHRmPsPiVBBmgXOCY3z+0X8lbFgMIbIsZuD
	vOw2ngew==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1klCcH-0001iC-Cd; Fri, 04 Dec 2020 15:03:25 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1klCcE-0001gh-A1
 for linux-nvme@lists.infradead.org; Fri, 04 Dec 2020 15:03:23 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id C8182AC9A;
 Fri,  4 Dec 2020 15:03:20 +0000 (UTC)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Subject: [PATCH] nvme: re-read ANA log on NS CHANGED AEN
Date: Fri,  4 Dec 2020 16:03:10 +0100
Message-Id: <20201204150310.30434-1-hare@suse.de>
X-Mailer: git-send-email 2.16.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201204_100322_515472_2BA96744 
X-CRM114-Status: GOOD (  18.32  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <keith.busch@wdc.com>, Hannes Reinecke <hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

As discussed on the mailing list we might be getting an NS CHANGED AEN
for a namespace on a newly created ANA group, and due to optimisations
within the spec no corresponding ANA CHANGED AEN will be send.
Ideally we would re-read the ANA log when we're figuring out that
no ANA Group exists, but that code is hidden behind two stacked void
functions, so it'll be impossible to recover from an error on reading
the ANA log.
Instead this patch re-reads the ANA log on every NS CHANGED AEN prior
to scanning the namespaces; that will resolve the situation, too,
but doesn't risk into running into an unrecoverable error.

Reported-by: Martin George <marting@netapp.com>
Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/host/core.c      |  8 +++++++-
 drivers/nvme/host/multipath.c | 18 ++++++++++++++----
 drivers/nvme/host/nvme.h      |  1 +
 3 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 95ef4943d8bd..084a05442ac2 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -123,7 +123,7 @@ static void nvme_set_queue_dying(struct nvme_ns *ns)
 	nvme_update_bdev_size(ns->disk);
 }
 
-static void nvme_queue_scan(struct nvme_ctrl *ctrl)
+void nvme_queue_scan(struct nvme_ctrl *ctrl)
 {
 	/*
 	 * Only new queue scan work when admin and IO queues are both alive
@@ -4292,6 +4292,12 @@ static void nvme_handle_aen_notice(struct nvme_ctrl *ctrl, u32 result)
 	switch (aer_notice_type) {
 	case NVME_AER_NOTICE_NS_CHANGED:
 		set_bit(NVME_AER_NOTICE_NS_CHANGED, &ctrl->events);
+#ifdef CONFIG_NVME_MULTIPATH
+		if (ctrl->ana_log_buf) {
+			queue_work(nvme_wq, &ctrl->ana_work);
+			break;
+		}
+#endif
 		nvme_queue_scan(ctrl);
 		break;
 	case NVME_AER_NOTICE_FW_ACT_STARTING:
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 74896be40c17..b920d57d0e39 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -535,10 +535,16 @@ static int nvme_read_ana_log(struct nvme_ctrl *ctrl)
 		goto out_unlock;
 	}
 
-	error = nvme_parse_ana_log(ctrl, &nr_change_groups,
-			nvme_update_ana_state);
-	if (error)
-		goto out_unlock;
+	/*
+	 * Don't update ANA groups if triggered by an NS CHANGED
+	 * AEN; we'll be rescanning all namespaces anyway afterwards.
+	 */
+	if (!test_bit(NVME_AER_NOTICE_NS_CHANGED, &ctrl->events)) {
+		error = nvme_parse_ana_log(ctrl, &nr_change_groups,
+					   nvme_update_ana_state);
+		if (error)
+			goto out_unlock;
+	}
 
 	/*
 	 * In theory we should have an ANATT timer per group as they might enter
@@ -557,6 +563,10 @@ static int nvme_read_ana_log(struct nvme_ctrl *ctrl)
 		del_timer_sync(&ctrl->anatt_timer);
 out_unlock:
 	mutex_unlock(&ctrl->ana_lock);
+
+	if (test_bit(NVME_AER_NOTICE_NS_CHANGED, &ctrl->events))
+		nvme_queue_scan(ctrl);
+
 	return error;
 }
 
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index cc111136a981..b0d01c2ce092 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -589,6 +589,7 @@ void nvme_uninit_ctrl(struct nvme_ctrl *ctrl);
 void nvme_start_ctrl(struct nvme_ctrl *ctrl);
 void nvme_stop_ctrl(struct nvme_ctrl *ctrl);
 int nvme_init_identify(struct nvme_ctrl *ctrl);
+void nvme_queue_scan(struct nvme_ctrl *ctrl);
 
 void nvme_remove_namespaces(struct nvme_ctrl *ctrl);
 
-- 
2.16.4


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

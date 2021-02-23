Return-Path: <SRS0=3q+x=HZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86AFFC433E6
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Feb 2021 11:59:56 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F31686023C
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Feb 2021 11:59:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F31686023C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=vdhvXnpEKdrf7wXF928eZTAjlu+v9LpXm4dTBGJeZrE=; b=t9Ji0SXhAn4p6yp3/w6FmGsda
	v5vYRbCOTtT/FO+Y1A4wAnYo4BzouEVfvQ5cK+D91ehRNa0kaFK6DTn1kTyZGCwgsPNEa1D7ROn6k
	hs4c426rS5JJ5UUUrmdRcghN9dl7TJyEhp+IwlcQkDnABBhASYN6VgW0j/CB7Xm/CV+MVxqUN+8TE
	BR9IkKDu7tbeka36nx/HY41oxzWDA48vS0hGci6XDpRUuV0tDFHCAo6vdhQ6FukD9KHbnq2RXku7X
	YtFbBczopBukLve3GjUF/E+7ogkD2aJblnmm22R43B2Q3afbt8Boaq5j9Ax9wFac4U27u8rkeyVxG
	y38ITGKzg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lEWLp-0007Xq-4N; Tue, 23 Feb 2021 11:59:37 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lEWLj-0007Vt-PJ
 for linux-nvme@lists.infradead.org; Tue, 23 Feb 2021 11:59:32 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 652E1AECE;
 Tue, 23 Feb 2021 11:59:29 +0000 (UTC)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 2/2] nvme: delete disk when last path is gone
Date: Tue, 23 Feb 2021 12:59:22 +0100
Message-Id: <20210223115922.104369-3-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210223115922.104369-1-hare@suse.de>
References: <20210223115922.104369-1-hare@suse.de>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210223_065932_070413_062963ED 
X-CRM114-Status: GOOD (  17.25  )
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
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 Hannes Reinecke <hare@suse.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

The multipath code currently deletes the disk only after all references
to it are dropped rather than when the last path to that disk is lost.
This has been reported to cause problems with some use cases like MD RAID.

This patch implements an alternative behaviour of deleting the disk when
the last path is gone, ie the same behaviour as non-multipathed nvme
devices. The new behaviour will be selected with the 'fail_if_no_path'
attribute, as returning it's arguably the same functionality.

Suggested-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/host/core.c      |  1 +
 drivers/nvme/host/multipath.c |  3 ++-
 drivers/nvme/host/nvme.h      | 17 +++++++++++++++--
 3 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 2fb3ecc0c53b..d717a6283d6e 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -542,6 +542,7 @@ static void nvme_free_ns_head(struct kref *ref)
 		container_of(ref, struct nvme_ns_head, ref);
 
 	nvme_mpath_remove_disk(head);
+	nvme_mpath_put_disk(head);
 	ida_simple_remove(&head->subsys->ns_ida, head->instance);
 	cleanup_srcu_struct(&head->srcu);
 	nvme_put_subsystem(head->subsys);
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index d5773ea105b1..f995b8234622 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -724,6 +724,8 @@ void nvme_mpath_add_disk(struct nvme_ns *ns, struct nvme_id_ns *id)
 
 void nvme_mpath_remove_disk(struct nvme_ns_head *head)
 {
+	if (test_bit(NVME_NSHEAD_FAIL_IF_NO_PATH, &head->flags))
+		return;
 	if (!head->disk)
 		return;
 	if (head->disk->flags & GENHD_FL_UP)
@@ -741,7 +743,6 @@ void nvme_mpath_remove_disk(struct nvme_ns_head *head)
 		 */
 		head->disk->queue = NULL;
 	}
-	put_disk(head->disk);
 }
 
 int nvme_mpath_init(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 3d2513f8194d..e6efa085f08a 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -681,8 +681,12 @@ static inline void nvme_mpath_check_last_path(struct nvme_ns *ns)
 {
 	struct nvme_ns_head *head = ns->head;
 
-	if (head->disk && list_empty(&head->list))
-		kblockd_schedule_work(&head->requeue_work);
+	if (head->disk && list_empty(&head->list)) {
+		if (test_bit(NVME_NSHEAD_FAIL_IF_NO_PATH, &head->flags))
+			nvme_mpath_remove_disk(head);
+		else
+			kblockd_schedule_work(&head->requeue_work);
+	}
 }
 
 static inline void nvme_trace_bio_complete(struct request *req)
@@ -693,6 +697,12 @@ static inline void nvme_trace_bio_complete(struct request *req)
 		trace_block_bio_complete(ns->head->disk->queue, req->bio);
 }
 
+static inline void nvme_mpath_put_disk(struct nvme_ns_head *head)
+{
+	if (head->disk)
+		put_disk(head->disk);
+}
+
 extern struct device_attribute dev_attr_ana_grpid;
 extern struct device_attribute dev_attr_ana_state;
 extern struct device_attribute dev_attr_fail_if_no_path;
@@ -731,6 +741,9 @@ static inline void nvme_mpath_add_disk(struct nvme_ns *ns,
 static inline void nvme_mpath_remove_disk(struct nvme_ns_head *head)
 {
 }
+static inline void nvme_mpath_put_disk(struct nvme_ns_head *head)
+{
+}
 static inline bool nvme_mpath_clear_current_path(struct nvme_ns *ns)
 {
 	return false;
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

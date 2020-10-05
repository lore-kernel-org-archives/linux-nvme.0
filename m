Return-Path: <SRS0=0roG=DM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3ECCC4363A
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Oct 2020 09:43:09 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A1A420796
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Oct 2020 09:43:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FpV1aYRX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A1A420796
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:References:In-Reply-To:Message-Id:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rvEaUvKU01/5E5sa9tnXid9+WNsgmie04lXkXwrChvw=; b=FpV1aYRXeqq7ly7GcBpJB5cVv0
	uS7jFqmRuR/sdNtbfyN+gZBgl9tgwkkDiV6prVGpKT6bDnf5m5HL9TcV0BWJeFCuSLCRb8NZVcsdu
	oilJcuu0Ivi8M/YrcEEpmsGM5pwAprGipG8hQUwq3URHwERpEHC4Ewh803fqkPz6A1+CAnv1YV2Yt
	Ld37tVQDyaJ7AQ0/d/30LKrihSPOKKwrfDjH+kbntdG2WKubrCsZgBRWSN48VBD4cG/+4h59c1gu3
	sVhtyVUiieyHzx7wns2NfWnbWdagHF8ve4T6rEagDXwE2hI6C5F2wGqfDkenk1K/v6wqq8QVLS9DV
	vAtDXBUA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kPN1N-0004D0-Ql; Mon, 05 Oct 2020 09:43:05 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kPN1I-0004BA-ME
 for linux-nvme@lists.infradead.org; Mon, 05 Oct 2020 09:43:01 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 4F733AF3B;
 Mon,  5 Oct 2020 09:42:58 +0000 (UTC)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 2/3] nvme: add 'queue_if_no_path' semantics
Date: Mon,  5 Oct 2020 11:42:55 +0200
Message-Id: <20201005094256.49358-3-hare@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20201005094256.49358-1-hare@suse.de>
References: <20201005094256.49358-1-hare@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201005_054300_916448_508298CA 
X-CRM114-Status: GOOD (  18.08  )
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

Instead of reverting the handling of the 'last' path for all
setups we should be restricting it to the non-fabrics case.
So add a 'queue_if_no_path' flag which will switch to the
current behaviour; disabling this flag will revert to the
original (pre-fabrics) behaviour.
And set this flag per default for fabrics.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/host/core.c      | 7 ++++++-
 drivers/nvme/host/multipath.c | 4 ++++
 drivers/nvme/host/nvme.h      | 1 +
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index af950d58c562..79b88b4c448f 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -474,8 +474,11 @@ static void nvme_free_ns_head(struct kref *ref)
 	struct nvme_ns_head *head =
 		container_of(ref, struct nvme_ns_head, ref);
 
-	if (head->disk)
+	if (head->disk) {
+		if (test_bit(NVME_NSHEAD_QUEUE_IF_NO_PATH, &head->flags))
+			nvme_mpath_remove_disk(head);
 		put_disk(head->disk);
+	}
 	ida_simple_remove(&head->subsys->ns_ida, head->instance);
 	cleanup_srcu_struct(&head->srcu);
 	nvme_put_subsystem(head->subsys);
@@ -3686,6 +3689,8 @@ static struct nvme_ns_head *nvme_alloc_ns_head(struct nvme_ctrl *ctrl,
 	head->subsys = ctrl->subsys;
 	head->ns_id = nsid;
 	head->ids = *ids;
+	if (ctrl->ops->flags & NVME_F_FABRICS)
+		set_bit(NVME_NSHEAD_QUEUE_IF_NO_PATH, &head->flags);
 	kref_init(&head->ref);
 
 	ret = __nvme_check_ids(ctrl->subsys, head);
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 55045291b4de..05c4fbc35bb2 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -682,6 +682,10 @@ void nvme_mpath_remove_disk(struct nvme_ns_head *head)
 {
 	if (!head->disk)
 		return;
+	if (test_bit(NVME_NSHEAD_QUEUE_IF_NO_PATH, &head->flags)) {
+		kblockd_schedule_work(&head->requeue_work);
+		return;
+	}
 	if (head->disk->flags & GENHD_FL_UP)
 		del_gendisk(head->disk);
 	blk_set_queue_dying(head->disk->queue);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index b6180bb3361d..baf4a84918d8 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -411,6 +411,7 @@ struct nvme_ns_head {
 	struct mutex		lock;
 	unsigned long		flags;
 #define NVME_NSHEAD_DISK_LIVE	0
+#define NVME_NSHEAD_QUEUE_IF_NO_PATH 1
 	struct nvme_ns __rcu	*current_path[];
 #endif
 };
-- 
2.16.4


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

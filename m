Return-Path: <SRS0=GcL3=KF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADFDDC433B4
	for <linux-nvme@archiver.kernel.org>; Mon, 10 May 2021 14:49:48 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AF0160FDA
	for <linux-nvme@archiver.kernel.org>; Mon, 10 May 2021 14:49:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AF0160FDA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=eYMtWOJ1nRViFiW4r94y2KtnO95ghDalmSxkxOpn1ec=; b=dbioK2ikKmXHwrCCJ5yP2aTCht
	rLDrQNIxirwuwZiLhtnPPtG5lHI2f/mrIez0yJIDA6LRGHKGSCn7/osEXgCL4rwKbHtw8kqqRnMHL
	kAZ91nR2MEIxNjoaocSQktMv1rOycvDn8mvfxGth0+Rb/nQ7SZUZp1HM5CrAVWD5qR6N8K+jqmDKz
	ZVEMQjJgbF7Hs3FZ5vRelnHOLojyPmCdJjMjhShHsx8F2rYaDbMg0mDuK+04s7snKm2gKqODXAkOT
	tEKKPKRu/nQgrOQLpAXxfWkA/K5m3XPdzrvGxDv1BmMZmgt/dzIvhLKdd9xcVMozacFZNaI0zwgP0
	g8U2Eg5Q==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lg7Dg-00EgHn-5u; Mon, 10 May 2021 14:49:16 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lg7Dd-00EgH5-ME
 for linux-nvme@desiato.infradead.org; Mon, 10 May 2021 14:49:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=LrchbBiOKkbiRd4DEB6akfFjb8ySDAh08FluWNjRJIQ=; b=Px5uO8Hq/SAlFXad+km7v/GWIa
 ydCFwKuHap1qlI8FJFaTvDoNQhfLCPfNa3zhm8liCK+bAZzgSIJ9Mv33RMNMt7Aq7TpR1nWPVId+S
 F2zrgH5vst+CInPbAH2WRyzHvPsamKOIQqwvZxsD2ywNJY/vLqNNHdm3sJTky9S1jzWHWWun7Ihdd
 AMwBuucitAadFGgr2Fu+Ut1S/4ABXWaJQXyllGxDlNDuXoCIM5V9nobj+oTAmOs3xlCgLBPG+sL5S
 HPyYrQvCrb+7psh+HGSgscFOtcHoR+qaRO9V6wcSUU27qIq/Y+1DKSdL3UvjNjcLccOyDgzXH64R5
 7sSYHeSw==;
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lg7Db-008pQQ-2M
 for linux-nvme@lists.infradead.org; Mon, 10 May 2021 14:49:12 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id C3D8AB137;
 Mon, 10 May 2021 14:49:09 +0000 (UTC)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH] nvme: allow to re-attach namespaces after all paths are down
Date: Mon, 10 May 2021 16:49:06 +0200
Message-Id: <20210510144906.8305-1-hare@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210510_074911_271418_0E1E9078 
X-CRM114-Status: GOOD (  15.42  )
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

We should only remove the ns head from the list of heads per
subsystem if the reference count drops to zero. Removing it
at the start of nvme_ns_remove() will prevent us from reattaching
the namespace to the correct ns head once a path becomes available
again.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/host/core.c | 33 ++++++++++++++++++++++-----------
 1 file changed, 22 insertions(+), 11 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 762125f2905f..08ff0fc01f9e 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -546,6 +546,9 @@ static void nvme_free_ns_head(struct kref *ref)
 	struct nvme_ns_head *head =
 		container_of(ref, struct nvme_ns_head, ref);
 
+	mutex_lock(&head->subsys->lock);
+	list_del_init(&head->entry);
+	mutex_unlock(&head->subsys->lock);
 	nvme_mpath_remove_disk(head);
 	ida_simple_remove(&head->subsys->ns_ida, head->instance);
 	cleanup_srcu_struct(&head->srcu);
@@ -3605,16 +3608,26 @@ static int nvme_init_ns_head(struct nvme_ns *ns, unsigned nsid,
 		head->shared = is_shared;
 	} else {
 		ret = -EINVAL;
-		if (!is_shared || !head->shared) {
-			dev_err(ctrl->device,
-				"Duplicate unshared namespace %d\n", nsid);
-			goto out_put_ns_head;
-		}
-		if (!nvme_ns_ids_equal(&head->ids, ids)) {
-			dev_err(ctrl->device,
-				"IDs don't match for shared namespace %d\n",
+		/*
+		 * If multipath is enabled we might hit an ns head with no
+		 * paths, but that doesn't indicate it's a shared namespace.
+		 */
+		if (!nvme_ns_head_multipath(head) ||
+		    !list_empty(&head->list)) {
+			if (!is_shared || !head->shared) {
+				dev_err(ctrl->device,
+					"Duplicate unshared namespace %d\n", nsid);
+				goto out_put_ns_head;
+			}
+			if (!nvme_ns_ids_equal(&head->ids, ids)) {
+				dev_err(ctrl->device,
+					"IDs don't match for shared namespace %d\n",
 					nsid);
-			goto out_put_ns_head;
+				goto out_put_ns_head;
+			}
+		} else {
+			/* But the ids might have changed, so reset them */
+			head->ids = *ids;
 		}
 	}
 
@@ -3764,8 +3777,6 @@ static void nvme_ns_remove(struct nvme_ns *ns)
 
 	mutex_lock(&ns->ctrl->subsys->lock);
 	list_del_rcu(&ns->siblings);
-	if (list_empty(&ns->head->list))
-		list_del_init(&ns->head->entry);
 	mutex_unlock(&ns->ctrl->subsys->lock);
 
 	synchronize_rcu(); /* guarantee not available in head->list */
-- 
2.26.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

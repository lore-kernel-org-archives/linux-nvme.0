Return-Path: <SRS0=0ID+=5Z=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3789C2BA2B
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Apr 2020 16:09:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4884E21744
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Apr 2020 16:09:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QwEyJ5sB";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hb077R+x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4884E21744
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=YW859UIdqfTqliiF/aqcOhs0wx/Qo/j3pOpfnaoQvOU=; b=QwEyJ5sBNI9l98
	YLm/BMdeDSGZloY4uIj8bbUA3GzAO3hHXD4GXBukgwmAgWTJpKcwCmk5VlYRGrXr00k8gUjoTcFKI
	WuoiQSS+HLyk89HBUa4mXyCpP1YctQO0Q6sCMtPMWuKbFlQXVIae8x2ThhWscB+dgcu3dFGTEDrpq
	AFFoij9uMfxj6d0ci28BkofcF0kgEhRE6qDqs4Hvo9Yea9+KCwh968S2KGRrt78dVURYdIi73EHWT
	R6UG+9Ffkt/5e1KWchxgSCYLH4QWKS4q0ZvwCbbU0/BKWc27MzwXrME/Koj1Zhky7fFJNofJBWSS/
	jAOQrCjiL4Jt6YpvOVrQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jMZkA-0001iQ-AG; Thu, 09 Apr 2020 16:09:30 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jMZjq-0001Pz-Kj
 for linux-nvme@lists.infradead.org; Thu, 09 Apr 2020 16:09:12 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 0A8A72087E;
 Thu,  9 Apr 2020 16:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1586448550;
 bh=H6tPIUgEVgLHyPf1zRhcNrN6u0CHS2qkpeZEQpaDepE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=hb077R+xQOzPiTMW7MdhznHdvZL6zZvVcJkgAxgddjgH/q3Nl4Sa8VlaxsA09QHIc
 4BSO22/fGoPkQY/P+xRpKFL2doxeXa1uYjWaHlRtBV6CqGYLrUN9TqXqdqCVrklNBk
 rV38v8Y7Syuozf9dLXaZDuJAiT9aapTqNkimgXCM=
From: Keith Busch <kbusch@kernel.org>
To: linux-nvme@lists.infradead.org,
	hch@lst.de,
	sagi@grimberg.me
Subject: [PATCH 01/10] nvme: unlink head after removing last namespace
Date: Thu,  9 Apr 2020 09:08:59 -0700
Message-Id: <20200409160908.1889471-2-kbusch@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200409160908.1889471-1-kbusch@kernel.org>
References: <20200409160908.1889471-1-kbusch@kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200409_090910_692368_BE5E5246 
X-CRM114-Status: GOOD (  11.95  )
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
Cc: Keith Busch <kbusch@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

The driver had been unlinking the namespace head from the subsystem's
list only after the last reference was released, and outside of the
list's subsys->lock protection.

There is no reason to track an empty head, so unlink the entry from the
subsystem's list when the last namespace using that head is removed and
with the mutex lock protecting the list update. The next namespace to
attach reusing the previous NSID will allocate a new head rather than
find the old head with mismatched identifiers.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/core.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 5de3b993525b..ba621f9229e5 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -433,7 +433,6 @@ static void nvme_free_ns_head(struct kref *ref)
 
 	nvme_mpath_remove_disk(head);
 	ida_simple_remove(&head->subsys->ns_ida, head->instance);
-	list_del_init(&head->entry);
 	cleanup_srcu_struct(&head->srcu);
 	nvme_put_subsystem(head->subsys);
 	kfree(head);
@@ -3414,7 +3413,6 @@ static int __nvme_check_ids(struct nvme_subsystem *subsys,
 
 	list_for_each_entry(h, &subsys->nsheads, entry) {
 		if (nvme_ns_ids_valid(&new->ids) &&
-		    !list_empty(&h->list) &&
 		    nvme_ns_ids_equal(&new->ids, &h->ids))
 			return -EINVAL;
 	}
@@ -3658,6 +3656,8 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
  out_unlink_ns:
 	mutex_lock(&ctrl->subsys->lock);
 	list_del_rcu(&ns->siblings);
+	if (list_empty(&ns->head->list))
+		list_del_init(&ns->head->entry);
 	mutex_unlock(&ctrl->subsys->lock);
 	nvme_put_ns_head(ns->head);
  out_free_id:
@@ -3677,7 +3677,10 @@ static void nvme_ns_remove(struct nvme_ns *ns)
 
 	mutex_lock(&ns->ctrl->subsys->lock);
 	list_del_rcu(&ns->siblings);
+	if (list_empty(&ns->head->list))
+		list_del_init(&ns->head->entry);
 	mutex_unlock(&ns->ctrl->subsys->lock);
+
 	synchronize_rcu(); /* guarantee not available in head->list */
 	nvme_mpath_clear_current_path(ns);
 	synchronize_srcu(&ns->head->srcu); /* wait for concurrent submissions */
-- 
2.24.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

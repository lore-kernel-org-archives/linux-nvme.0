Return-Path: <SRS0=LCWA=KG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D300C433B4
	for <linux-nvme@archiver.kernel.org>; Tue, 11 May 2021 10:42:15 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 511836144F
	for <linux-nvme@archiver.kernel.org>; Tue, 11 May 2021 10:42:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 511836144F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=novISbwD7kpm19a9m8y0Mr5usTIxGV5qNacXo9t7EhU=; b=QK18RW8ace11Q07lvGOp6WzLhi
	Cwl12ki2+Q/77BUtqKpVCpBy2XPNbQQk6uYLh6Spi6eSnXcLRomBmNuzUG3nPZ0uCllK/+CJBqwYM
	k/Dl847PipgfsUNzg/FRnTkMZF8+4H8IGwYLm5Vkcw8n7b11cmDvbHY5u5yd52SxkcFjAPzk+NmCq
	LVWn14nVau530gq3hnWfZ0FjB121fwrBi1lTmwKukNwmNBm3U/hBaV8tzff6zXAD9QPUptW7gSpP5
	9Cqv6Ea05tNDOZpAHQnP499Zt0ZgOz0D2jaJgKtPyWo5feLw8NW6ootalVDz+We3ItATPRTLdwg00
	+Z8PEhOw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lgPpo-00GzMB-88; Tue, 11 May 2021 10:41:52 +0000
Received: from [2607:7c80:54:e::133] (helo=bombadil.infradead.org)
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lgMGx-00GSSp-VF
 for linux-nvme@desiato.infradead.org; Tue, 11 May 2021 06:53:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=WQlUg02sDTItBSb44ioNol53leKlwjG61wcQnCNMklY=; b=0mFK1g5nvxl3Qp5U6mVr2hgqcP
 MWIPr7WEWl0KlzVbt+99WlD50Bkc9myAmKkK1n+JItLNM3EnMHd6ai8ul5B+wVfEiHzacngR/4Mx4
 BJmFv3wLUdZF2qAEwUJ6Ut79zCsZQkssaI+xYfD7gm52F/seLoUNlCxt7fHZXMDZCIAtPoHEQ8TIa
 bouwyJ9Q4c7uxMysikdd0Btsr6arhU4Mnm9F9SnuykW58eFFfauCx497nM67fSwqdn+MfkmYzewSd
 JyZUzmPLJPETZNqXTkml6UxAP6fvRLZfdTMfQzIyZ4g5jE2wUmpHizIb29DtXRTYM555bWHq8TnrC
 Sl7gxg/g==;
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lgMGv-009LYE-4A
 for linux-nvme@lists.infradead.org; Tue, 11 May 2021 06:53:38 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 3DAF1AF45;
 Tue, 11 May 2021 06:53:34 +0000 (UTC)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCHv2] nvme: allow to re-attach namespaces after all paths are down
Date: Tue, 11 May 2021 08:53:32 +0200
Message-Id: <20210511065332.31163-1-hare@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210510_235337_331392_BD3D0496 
X-CRM114-Status: GOOD (  13.43  )
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210510_235337_331392_BD3D0496 
X-CRM114-Status: UNSURE (   9.93  )
X-CRM114-Notice: Please train this message.
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

Changes to v1:
- Always check NSIDs after reattach

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/host/core.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 522c9b229f80..aa19a7e80a47 100644
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
@@ -3549,7 +3552,7 @@ static struct nvme_ns_head *nvme_alloc_ns_head(struct nvme_ctrl *ctrl,
 		goto out_ida_remove;
 	head->subsys = ctrl->subsys;
 	head->ns_id = nsid;
-	head->ids = *ids;
+	memcpy(&head->ids, ids, sizeof(sturct nvme_ns_ids));
 	kref_init(&head->ref);
 
 	ret = __nvme_check_ids(ctrl->subsys, head);
@@ -3605,15 +3608,23 @@ static int nvme_init_ns_head(struct nvme_ns *ns, unsigned nsid,
 		head->shared = is_shared;
 	} else {
 		ret = -EINVAL;
+		/*
+		 * If multipath is enabled we might hit an ns head with no
+		 * paths, but that doesn't indicate it's a shared namespace.
+		 */
+		if (nvme_ns_head_multipath(head) &&
+		    list_empty(&head->list))
+			goto check_ids;
 		if (!is_shared || !head->shared) {
 			dev_err(ctrl->device,
 				"Duplicate unshared namespace %d\n", nsid);
 			goto out_put_ns_head;
 		}
+check_ids:
 		if (!nvme_ns_ids_equal(&head->ids, ids)) {
 			dev_err(ctrl->device,
 				"IDs don't match for shared namespace %d\n",
-					nsid);
+				nsid);
 			goto out_put_ns_head;
 		}
 	}
@@ -3764,8 +3775,6 @@ static void nvme_ns_remove(struct nvme_ns *ns)
 
 	mutex_lock(&ns->ctrl->subsys->lock);
 	list_del_rcu(&ns->siblings);
-	if (list_empty(&ns->head->list))
-		list_del_init(&ns->head->entry);
 	mutex_unlock(&ns->ctrl->subsys->lock);
 
 	synchronize_rcu(); /* guarantee not available in head->list */
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

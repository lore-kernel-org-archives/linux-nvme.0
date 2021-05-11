Return-Path: <SRS0=LCWA=KG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB6B4C433B4
	for <linux-nvme@archiver.kernel.org>; Tue, 11 May 2021 12:01:10 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7B3F613BC
	for <linux-nvme@archiver.kernel.org>; Tue, 11 May 2021 12:01:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7B3F613BC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=BolS0tYzrNfL4+pHy+ENXmb0Ki6fRzqyuoZIwSZ+Mmg=; b=C+JPAnbcytoJlHmJ89meN8IgRy
	S2VtTK9a02zaTZCF9mHJQtYwV5PmAT92o3PcLfZ/SRVtH3RssUkePYyc5SlMC79Nm2pWBvsVcDSxe
	zWN/fcoa1WBB2J7iNmpCFkld6xecuJ6h24DVQ9/dldsRcywGiXdCfQOUy+4/dzmn1LrCz9hEaiYfi
	38qU7wiaipZDI/W30sYuPew0lLDrqjwcddUPI3tFs6ISHDiRp0RfqRdXTr4/Vuelp9J9k6318LDbQ
	GJxHmRfY1vyyYReONI+M5lZmN3mvw3MLverFodz7xBZWo+uk/YzoSGySbH1zJidYaVzLG4jKdTH2U
	tlWjqdCA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lgR44-00HGZ9-55; Tue, 11 May 2021 12:00:40 +0000
Received: from [2607:7c80:54:e::133] (helo=bombadil.infradead.org)
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lgNIe-00GYLr-Pf
 for linux-nvme@desiato.infradead.org; Tue, 11 May 2021 07:59:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=DfjVyChrYrJymSOAzykInyaaf7YXF4eZ/dekvXk7Xng=; b=Gto4icXq42uJ90p/Ry2ZMf+I4R
 SzSdEzPmy82NQ3yU4pUdBjQeJe9YUlK2lwvLhxHA/G4bSviqSzm+x72rpAmZMmLAHVEIm4SXgbYH+
 Wbeed4cuUefIARssRXCO7jy/dve/7YZBU16glvhPZBLJw6yQd9KyfE7ydwXtcLuqt31iIF0KeDPhK
 DquNQOHjF1jY3K/UAbVI8InzLhmTg6i+mNpoGTBAorEViyKD/Ep3dyeciECErPWi8wcuVj7pgdYDI
 8s/DlSQs2vpMe5YrF2B9A8QNKGRiEv5dGQl7RtijKGBPkkFhDIkeOQuMtEUQTrE/Tyr9NEB4Ux/Tq
 j86dYAuQ==;
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lgNIa-009NWW-Tb
 for linux-nvme@lists.infradead.org; Tue, 11 May 2021 07:59:26 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 2C06EADE2;
 Tue, 11 May 2021 07:59:23 +0000 (UTC)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCHv3] nvme: allow to re-attach namespaces after all paths are down
Date: Tue, 11 May 2021 09:59:19 +0200
Message-Id: <20210511075919.139624-1-hare@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210511_005925_122569_B808E142 
X-CRM114-Status: GOOD (  13.16  )
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210511_005925_122569_B808E142 
X-CRM114-Status: UNSURE (   9.57  )
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

Changes to v2:
- Drop memcpy() statement
Changes to v1:
- Always check NSIDs after reattach

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/host/core.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 522c9b229f80..6a5386267c10 100644
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

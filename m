Return-Path: <SRS0=yFSL=I5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD385C433B4
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Mar 2021 14:54:24 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84E546101A
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Mar 2021 14:54:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84E546101A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=MIhqzfoc+iSQejcDG/XgvdD956BH0n66FpUwSlATCzo=; b=Qvo4wbCU8QTWq1ofsQAQZoaI4
	uE+xQfcO540Vwsin9Vha2rGIVuzaVpR7LKRX0ig9QnRkQIGb6ZfC8zxueFyaFVB3chkdF9Ntxpfpc
	HcGtCvU3hjHcRzRrIKK5ZHTQC+thrW2tKmWdMkDgT1dSLRrm6Xkw8UCdQDLdFvOT87OQjB1sSUZRY
	ATt4LwhRW2gYwvcE526eP2HG4E7zqe9hXCi9YcaQJkstPpDYVi806tAQdkgt+LItRGqxU+YJMJFEk
	piFge0/x1JjbB8GB545JBs86aHoLPRxjEq2rCq1CP2dIwZUKoWkS9fUga+BLP6Tj2Mj4pf8yFbiVV
	6DOIK3MhA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lRcEZ-006q5S-9H; Wed, 31 Mar 2021 14:54:15 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lRcED-006q0w-Md
 for linux-nvme@lists.infradead.org; Wed, 31 Mar 2021 14:53:57 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 26EEAB308;
 Wed, 31 Mar 2021 14:53:53 +0000 (UTC)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 2/2] nvme: do not detach nshead when a namespace is removed
Date: Wed, 31 Mar 2021 16:53:51 +0200
Message-Id: <20210331145351.35926-3-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210331145351.35926-1-hare@suse.de>
References: <20210331145351.35926-1-hare@suse.de>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210331_155354_306654_1BC94053 
X-CRM114-Status: GOOD (  14.02  )
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

'struct nshead' and 'struct ns' have different lifetimes; the nshead
can (and occasionally will) stay around even if no namespaces are
connected, as it will only be finally removed once the last
reference is gone.
But while it is in this state we should still be able to access
it during lookup; a nshead with no controllers is perfectly valid
(at least for fabrics), and the namespace has no business with
removing the nshead from the subsystem lists.

This patch fixes the situation by only removing the nshead from the
subsystem list once it's being finally removed.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/host/core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index ee898c8da786..05fecbd33fa7 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -542,6 +542,10 @@ static void nvme_free_ns_head(struct kref *ref)
 	struct nvme_ns_head *head =
 		container_of(ref, struct nvme_ns_head, ref);
 
+	mutex_lock(&head->subsys->lock);
+	list_del_init(&head->entry);
+	mutex_unlock(&head->subsys->lock);
+
 #ifdef CONFIG_NVME_MULTIPATH
 	if (head->disk)
 		put_disk(head->disk);
@@ -3993,8 +3997,6 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid,
  out_unlink_ns:
 	mutex_lock(&ctrl->subsys->lock);
 	list_del_rcu(&ns->siblings);
-	if (list_empty(&ns->head->list))
-		list_del_init(&ns->head->entry);
 	mutex_unlock(&ctrl->subsys->lock);
 	nvme_put_ns_head(ns->head);
  out_free_queue:
@@ -4015,8 +4017,6 @@ static void nvme_ns_remove(struct nvme_ns *ns)
 
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

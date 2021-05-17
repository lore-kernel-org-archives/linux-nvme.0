Return-Path: <SRS0=YADc=KM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C80A3C433ED
	for <linux-nvme@archiver.kernel.org>; Mon, 17 May 2021 08:29:17 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B2EB61244
	for <linux-nvme@archiver.kernel.org>; Mon, 17 May 2021 08:29:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B2EB61244
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=HbH9P4HAKEiw4HWDy3hisgmHPVp2VwE9JDNhhaDW8yE=; b=Up2l1PtOiVFqFmeHR8ljQXl3rC
	Z96tfrGP/yjFRH7pzZnRkQdlXWgSPQoSex9oR5qthJeMScef88IYLP7J2JZ/3zu5/yDQ+T8UJ64sV
	myYOo9b1uvoXFn7qGRXm9+z2AmTvzIPliABdWWT+0tcsjzHiOHNPLp2+UOljm9MBzSySvDHx9S4TN
	lDIwvbHFX8WkBrxctMcB7oXAZPmZneJaf8wT5CwzEjgZxa2mc6wAiD5Vr0vhE6d+WaRFju9oL9g1d
	JS6QCP3MwMWRdlHkVZVpC4NWwG8goSnO9wH54mllosa+q8tmB6NOjb+I1cKy/q/Ok7Bg3K1eZQCCg
	WgrJs6TQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1liYch-00EFC5-1A; Mon, 17 May 2021 08:29:11 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1liYSC-00ECOk-0M
 for linux-nvme@desiato.infradead.org; Mon, 17 May 2021 08:18:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=qVOopO5Jr5DsFCc8UxFVytZ25sp1tZVlQjSMXIdBsaU=; b=yctOKPV5asmiS76vCVjZBEWLLs
 2aa4p5tmtTM+rYsJAZJsHfaUxuf8OMuMS8tubMr4doWG33ob8w5lizfzF9Lq3nDsp1nC1nxu9IWBW
 rxc94LrvXS5HZzPHSclFOSs5p8zNL4Uqxbwq5HPu4dlRSmk+R/scp/jUfOMwLit66bmSt4e7YgmWf
 nChvP98FdUl9iAMtekhjS6IRhsUtq5qxeuGEWoFYfqJq8TfDQPFNNgO7OvmFtGSyG+i7ubtsX9lVF
 SePZSmcCNu6+9dW+pRMoe8Aw9tZQ0RJHyQWOT2nzysveR54rvA3faQZsA1g2+grqVil87jcuJGlCW
 St3LwomA==;
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1liYS8-00DaXw-OB
 for linux-nvme@lists.infradead.org; Mon, 17 May 2021 08:18:18 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 5611EAE8D;
 Mon, 17 May 2021 08:18:15 +0000 (UTC)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCHv4] nvme: allow to re-attach namespaces after all paths are down
Date: Mon, 17 May 2021 10:18:09 +0200
Message-Id: <20210517081809.104813-1-hare@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210517_011816_953422_27F33BFD 
X-CRM114-Status: GOOD (  13.15  )
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

Changes to v3:
- Simplify if() clause to detect duplicate namespaces
Changes to v2:
- Drop memcpy() statement
Changes to v1:
- Always check NSIDs after reattach

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/host/core.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 522c9b229f80..a60144a4054a 100644
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
@@ -3605,7 +3608,11 @@ static int nvme_init_ns_head(struct nvme_ns *ns, unsigned nsid,
 		head->shared = is_shared;
 	} else {
 		ret = -EINVAL;
-		if (!is_shared || !head->shared) {
+		/*
+		 * If multipath is enabled we might hit an ns head with no
+		 * paths, but that doesn't indicate it's a shared namespace.
+		 */
+		if (!list_empty(&head->list) && (!is_shared || !head->shared)) {
 			dev_err(ctrl->device,
 				"Duplicate unshared namespace %d\n", nsid);
 			goto out_put_ns_head;
@@ -3764,8 +3771,6 @@ static void nvme_ns_remove(struct nvme_ns *ns)
 
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

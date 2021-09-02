Return-Path: <SRS0=DVYa=NY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89EAFC432BE
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Sep 2021 09:20:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EDDA60FE6
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Sep 2021 09:20:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4EDDA60FE6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=hcVoM6g21s0aNxu93dVtxvBQtRC54oH+L2ZlY0VEViw=; b=DY98r+md93or0Z
	dLr0G5/2z1hjrOs0qk64NJ/LfdqzPRaXWN4DhYr6jPVvgqeamGzE7YIpU4VjLaGNltfaLP4ViO5DG
	t2DTRJP/VSIafYQhEZmf0wqnPCNcSL5QTF2OGkb5UJVyBAf8dyBziR4fuQ27Ak+6FqVUQo7TulTnx
	2tOMela2CkBNfuI+xnWVqAzpYflUgZNzb5gPOokdvQnktM3UOo5yq++1gTA1+L8t7DVLjg1xFdpeI
	DZ1+dsMAHNQMW0Y74gtzgLjLD4cPbiZNQeVWmwHjn0CWB+aUqU+vttOqATMTw+dOWhdqIaDhJLkAh
	9PI33iRTkymPR9d+73lA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mLitP-0094A2-0V; Thu, 02 Sep 2021 09:20:19 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mLitE-00948v-Ke
 for linux-nvme@lists.infradead.org; Thu, 02 Sep 2021 09:20:12 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id DC3B020320;
 Thu,  2 Sep 2021 09:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1630574405; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=mCLKxbu6H+gkdS0vBCZqNAhLeUSXY2O0pR+5uorc2Nw=;
 b=JGF7G2OHkGr0sf/v0m6TDelhbrvh4KOEC7hFWe5P59cDLhEA1aEklrx1qysiYXZtXBWtBH
 GhyIRC3MQpEcDddcAUaF0F8n6pe70Up3S6aPDkWFd2JxAFMPNTYzEEkk+GTeuZbVMSfWcB
 ytcYx87TF6x3qLvIWIjI/NGTizWJJIE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1630574405;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=mCLKxbu6H+gkdS0vBCZqNAhLeUSXY2O0pR+5uorc2Nw=;
 b=DguZ15XQXGjXoPokT0nFdDs7FBrn0b7Se0GxWqm0Ui+n3W+t6g6SfpH+Krux6Jhir5xq1X
 FGTZiVVVgCefKDAg==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id 56DE9A3B8D;
 Thu,  2 Sep 2021 09:20:00 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 17828)
 id C55C1518DECC; Thu,  2 Sep 2021 11:20:05 +0200 (CEST)
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Daniel Wagner <dwagner@suse.de>,
 Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH v2] nvme: avoid race in shutdown namespace removal
Date: Thu,  2 Sep 2021 11:20:02 +0200
Message-Id: <20210902092002.67614-1-dwagner@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210902_022008_873591_83522895 
X-CRM114-Status: GOOD (  13.27  )
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

When we remove the siblings entry, we update ns->head->list, hence we
can't separate the removal and test for being empty. They have to be
in the same critical section to avoid a race.

To avoid breaking the refcounting imbalance again, add a list empty
check to nvme_find_ns_head.

Fixes: 5396fdac56d8 ("nvme: fix refcounting imbalance when all paths are down")
Cc: Hannes Reinecke <hare@suse.de>
Cc: Keith Busch <kbusch@kernel.org>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
v2:
 - added nvme_find_ns_head fix as suggested by hch
v1:
 - https://lore.kernel.org/linux-nvme/20210830093618.97657-1-dwagner@suse.de/

 drivers/nvme/host/core.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 4a3a33f5f11c..ac9a61d1d011 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3524,7 +3524,9 @@ static struct nvme_ns_head *nvme_find_ns_head(struct nvme_subsystem *subsys,
 	lockdep_assert_held(&subsys->lock);
 
 	list_for_each_entry(h, &subsys->nsheads, entry) {
-		if (h->ns_id == nsid && nvme_tryget_ns_head(h))
+		if (h->ns_id != nsid)
+			continue;
+		if (!list_empty(&h->list) && nvme_tryget_ns_head(h))
 			return h;
 	}
 
@@ -3836,6 +3838,10 @@ static void nvme_ns_remove(struct nvme_ns *ns)
 
 	mutex_lock(&ns->ctrl->subsys->lock);
 	list_del_rcu(&ns->siblings);
+	if (list_empty(&ns->head->list)) {
+		list_del_init(&ns->head->entry);
+		last_path = true;
+	}
 	mutex_unlock(&ns->ctrl->subsys->lock);
 
 	/* guarantee not available in head->list */
@@ -3856,13 +3862,6 @@ static void nvme_ns_remove(struct nvme_ns *ns)
 	list_del_init(&ns->list);
 	up_write(&ns->ctrl->namespaces_rwsem);
 
-	/* Synchronize with nvme_init_ns_head() */
-	mutex_lock(&ns->head->subsys->lock);
-	if (list_empty(&ns->head->list)) {
-		list_del_init(&ns->head->entry);
-		last_path = true;
-	}
-	mutex_unlock(&ns->head->subsys->lock);
 	if (last_path)
 		nvme_mpath_shutdown_disk(ns->head);
 	nvme_put_ns(ns);
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

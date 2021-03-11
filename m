Return-Path: <SRS0=tknV=IJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3913AC433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Mar 2021 15:55:45 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7B9264FDE
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Mar 2021 15:55:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7B9264FDE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=K6d4eaMVcmlU3rziBEtStFBlX3jEfe5LjbZToI1mZfI=; b=LhY0rQQo3K31QKJSBwsB/TUyPN
	BW/ADaDmbpieLZG6AJNWoDi0aIeUhi/1PKPyXiT+PSjAPOrli/o8VT7MbaPV+lE79UZH51cY6olNO
	kuifB7g+ljiOTFIryNfwA5/PXTKlyMJnyfCUUknlDmBdLz9ewT7DhbD+Jpd66NbZTdp2DJNGAu6WV
	67TirOwAfAxqV47VaulTrW7Pf0csT30QGybIqAYYkWyrcWGn+puA5IYg2sDhqeUj/JXwBS0YuXb3M
	iFdCEocpoHI8eN7gXrif6ca/91/l8PCxooPFtGHhNTSQYJhQWWoXEfMuP+sIFFwyb2x5XogsogNXn
	dPV1/NtQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lKNed-009VsT-R6; Thu, 11 Mar 2021 15:55:17 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lKNeL-009Vqw-6P
 for linux-nvme@lists.infradead.org; Thu, 11 Mar 2021 15:55:03 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id B791FAC23;
 Thu, 11 Mar 2021 15:54:55 +0000 (UTC)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH] nvme: Do not detach nshead when a namespace is removed
Date: Thu, 11 Mar 2021 16:54:54 +0100
Message-Id: <20210311155454.7845-1-hare@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210311_155458_939353_1EC96459 
X-CRM114-Status: GOOD (  15.46  )
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
opener is gone.
Once the system enters this state it becomes very hard to recover,
as the only way to remove a namespace is to disconnect the controller,
but the nshead is precisely _not_ related to a controller. This leads
to the very annoying behaviour that a subsequent 'nvme connect' call
will establish a _different_ nshead, _and_ the previous nshead will
stay around:

> nvme list
/dev/nvme0n1     9329c4c4af01db2c     Linux \
    1          17.18  GB /  17.18  GB      4 KiB +  0 B   5.3.18-4
> nvme disconnect -d /dev/nvme0
> nvme list
/dev/nvme0n1                                \
    -1          0.00   B /   0.00   B      1   B +  0 B   n1
> nvme connect
> nvme list
/dev/nvme0n1     9329c4c4af01db2c     Linux \
    -1          0.00   B /   0.00   B      1   B +  0 B   5.3.18-4
/dev/nvme0n2     9329c4c4af01db2c     Linux \
    1          17.18  GB /  17.18  GB      4 KiB +  0 B   5.3.18-4

This patch fixes the situation by only removing the nshead from the
internal lists once it's being finally removed.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/host/core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 206e6f883ca8..20fa62ae297a 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -542,6 +542,10 @@ static void nvme_free_ns_head(struct kref *ref)
 	struct nvme_ns_head *head =
 		container_of(ref, struct nvme_ns_head, ref);
 
+	mutex_lock(&head->subsys->lock);
+	list_del_init(&head->entry);
+	mutex_unlock(&head->subsys->lock);
+
 	nvme_mpath_remove_disk(head);
 	ida_simple_remove(&head->subsys->ns_ida, head->instance);
 	cleanup_srcu_struct(&head->srcu);
@@ -3983,8 +3987,6 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid,
  out_unlink_ns:
 	mutex_lock(&ctrl->subsys->lock);
 	list_del_rcu(&ns->siblings);
-	if (list_empty(&ns->head->list))
-		list_del_init(&ns->head->entry);
 	mutex_unlock(&ctrl->subsys->lock);
 	nvme_put_ns_head(ns->head);
  out_free_queue:
@@ -4005,8 +4007,6 @@ static void nvme_ns_remove(struct nvme_ns *ns)
 
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

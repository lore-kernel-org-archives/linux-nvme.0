Return-Path: <SRS0=Glcz=NV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A4C2C432BE
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Aug 2021 09:37:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D93936103D
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Aug 2021 09:37:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D93936103D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=29zy2E3yyA4kvDFLUt1HOyKi4L5pe7fl0qIzEIZbdHA=; b=TVyJOlwe1v6ba5
	wX97iFLdC3sEC7zCOncH3DOp5I8h0FTdFu8jsw80ZlNdY/MJ+x22OE9AheK9Pln+eyF+OyQSyghXK
	1iF+UOZAQOeB9p22l8/mrGJNlt5ReVAkyQbRbx/xuMv19YY7gsZOFYFTHi3smDgk6DbQuJQ9Q5yCQ
	lmXgn0vd/rN1nC1Qm1n21zty5lyl0E9RKakWGHrbQim/FCBe44RkliqyxSP9k+mb4OGPLq0su+lxt
	iLW8u57XT2LIPIoke3qHuaEFi/o+poP9DXStDUf4oRD8wBcdZNjBntwmmeEMnl9cA40fiLEFkU+7I
	NZTdD1T3sFHXORHevldg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mKdih-00GsYX-7W; Mon, 30 Aug 2021 09:36:47 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mKdiK-00GsXH-LH
 for linux-nvme@lists.infradead.org; Mon, 30 Aug 2021 09:36:28 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 320F31FDE9;
 Mon, 30 Aug 2021 09:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1630316180; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=O4mIgMIAjdBJAp1QnJNYKrG6vlL/YYTQqpNFWU7STG0=;
 b=uvRjxpGXemNhyBIWKHcKAHrhalQM6AOFW65JvSxG8cjtcS1o6dERhr7KGjkG9RaNnnMxiN
 ntrklrQ+i45kn+n2wP1PAy4fhGToOxwRucKlKFIZ3heaGIM9rqMu5INViNgE2GbnVcGuwK
 iHXjr7HRnrU+n0Ov80iZzyh7xYwCjAs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1630316180;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=O4mIgMIAjdBJAp1QnJNYKrG6vlL/YYTQqpNFWU7STG0=;
 b=FWn92FvIkrBaOc+nlaJEks2HGvxAX3li4QY9lkU0e5RqismcNxh+XvxlCoc49FNMV8wEtN
 loCd8+uEjqir5KDA==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id 2B755A3B8C;
 Mon, 30 Aug 2021 09:36:20 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 17828)
 id 19E34518DCCD; Mon, 30 Aug 2021 11:36:20 +0200 (CEST)
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Daniel Wagner <dwagner@suse.de>,
 Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH v1] nvme: avoid race in shutdown namespace removal
Date: Mon, 30 Aug 2021 11:36:18 +0200
Message-Id: <20210830093618.97657-1-dwagner@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210830_023624_894159_29AA4C93 
X-CRM114-Status: GOOD (  15.00  )
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

Fixes: 5396fdac56d8 ("nvme: fix refcounting imbalance when all paths are down")
Cc: Hannes Reinecke <hare@suse.de>
Cc: Keith Busch <kbusch@kernel.org>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---

I am able to hit this race window when I try to remove two paths
at the same time by making delete_controller asynchronous.

[   93.977701] nvme nvme0: Removing ctrl: NQN "nqn.2014-08.org.nvmexpress:NVMf:uuid:de63429f-50a4-4e03-ade6-0be27b75be77"
[   93.994213] nvme nvme1: Removing ctrl: NQN "nqn.2014-08.org.nvmexpress:NVMf:uuid:de63429f-50a4-4e03-ade6-0be27b75be77"
[   94.009093] del cdev ffff991a00b3c388 minor 0
[   94.009102] CPU: 2 PID: 13239 Comm: nvme Not tainted 5.14.0-rc4+ #29
[   94.009109] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0-59-gc9ba527-rebuilt.opensuse.org 04/01/2014
[   94.009112] Call Trace:
[   94.009119]  dump_stack_lvl+0x33/0x42
[   94.009133]  nvme_cdev_del+0x2d/0x60 [nvme_core]
[   94.009148]  nvme_mpath_shutdown_disk+0x41/0x50 [nvme_core]
[   94.009157]  nvme_ns_remove+0x199/0x1c0 [nvme_core]
[   94.009166]  nvme_remove_namespaces+0xac/0xf0 [nvme_core]
[   94.009175]  nvme_do_delete_ctrl+0x43/0x60 [nvme_core]
[   94.009182]  nvme_sysfs_delete+0x42/0x60 [nvme_core]
[   94.009190]  kernfs_fop_write_iter+0x12c/0x1a0
[   94.009219]  new_sync_write+0x11c/0x1b0
[   94.009229]  vfs_write+0x1ea/0x250
[   94.009236]  ksys_write+0xa1/0xe0
[   94.009242]  do_syscall_64+0x37/0x80
[   94.009256]  entry_SYSCALL_64_after_hwframe+0x44/0xae

With the patch only one of the nvme_do_delete_ctrl() will see
last_path = true and I can't observe any crash.

Though one thing I am not really sure how it interacts with
nvme_init_ns_head() as we could be in running nvme_init_ns_head()
after we have set last_path = true. I haven't really figured
out yet what this would mean. Is this a real problem?

 drivers/nvme/host/core.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 42b69f3c6e20..953d07d6a29d 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3809,8 +3809,13 @@ static void nvme_ns_remove(struct nvme_ns *ns)
 	set_capacity(ns->disk, 0);
 	nvme_fault_inject_fini(&ns->fault_inject);
 
+	/* Synchronize with nvme_init_ns_head() */
 	mutex_lock(&ns->ctrl->subsys->lock);
 	list_del_rcu(&ns->siblings);
+	if (list_empty(&ns->head->list)) {
+		list_del_init(&ns->head->entry);
+		last_path = true;
+	}
 	mutex_unlock(&ns->ctrl->subsys->lock);
 
 	synchronize_rcu(); /* guarantee not available in head->list */
@@ -3830,13 +3835,6 @@ static void nvme_ns_remove(struct nvme_ns *ns)
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

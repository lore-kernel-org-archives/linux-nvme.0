Return-Path: <SRS0=yFSL=I5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15867C433ED
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Mar 2021 14:54:19 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B23B26101A
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Mar 2021 14:54:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B23B26101A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ncQ3d38knuGTC8efj9xtHl7v8dInxnKvNNgf8zxbyk8=; b=AES0Bv5rdksol9F9ET5W7Cn7x
	Nh0WuBkZ+I/b1R0rs7VVTmI3lzydtRTrmIPVIs6Tb4Ik6SByU1qw1iGXjrDY0/2cwQ06DteBOUjNG
	8e0OnEuDpcdvBIC8pK88iDNCz/4xHiHTOk9WAU8DG4hvl/c9pQZu342nLJs+vg3v1Z8CmKSTIsWir
	phIkaLiM0lRDvt85LtALEJhUZk8btuTNWgZ1URN1ZDmcwmdzY7+rFhuQsSYD7dpR0fM40JaK+O+WH
	eudVqCfaijYpI25XDvusS0e7m6d41ogSAmhH+U5tb7prs0I6RsbyDUxSl9YgJMua0SJr/3UhcMnQR
	JLwQJ0lvg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lRcER-006q3q-HZ; Wed, 31 Mar 2021 14:54:07 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lRcED-006q0x-Mc
 for linux-nvme@lists.infradead.org; Wed, 31 Mar 2021 14:53:56 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 26B99B2F5;
 Wed, 31 Mar 2021 14:53:53 +0000 (UTC)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
 Hannes Reinecke <hare@suse.de>
Subject: [PATCH 1/2] nvme-mpath: delete disk after last connection
Date: Wed, 31 Mar 2021 16:53:50 +0200
Message-Id: <20210331145351.35926-2-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210331145351.35926-1-hare@suse.de>
References: <20210331145351.35926-1-hare@suse.de>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210331_155354_301438_709F6A7F 
X-CRM114-Status: GOOD (  18.86  )
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

From: Keith Busch <kbusch@kernel.org>

The multipath code currently deletes the disk only after all references
to it are dropped rather than when the last path to that disk is lost.
This has been reported to cause problems with some usage, like MD RAID.

Delete the disk when the last path is gone. This is the same behavior we
currently have with non-multipathed nvme devices.

The following is just a simple example that demonstrates what is currently
observed using a simple nvme loop back (loop setup file not shown):

 # nvmetcli restore loop.json
 [   31.156452] nvmet: adding nsid 1 to subsystem testnqn1
 [   31.159140] nvmet: adding nsid 1 to subsystem testnqn2

 # nvme connect -t loop -n testnqn1 -q hostnqn
 [   36.866302] nvmet: creating controller 1 for subsystem testnqn1 for NQN hostnqn.
 [   36.872926] nvme nvme3: new ctrl: "testnqn1"

 # nvme connect -t loop -n testnqn1 -q hostnqn
 [   38.227186] nvmet: creating controller 2 for subsystem testnqn1 for NQN hostnqn.
 [   38.234450] nvme nvme4: new ctrl: "testnqn1"

 # nvme connect -t loop -n testnqn2 -q hostnqn
 [   43.902761] nvmet: creating controller 3 for subsystem testnqn2 for NQN hostnqn.
 [   43.907401] nvme nvme5: new ctrl: "testnqn2"

 # nvme connect -t loop -n testnqn2 -q hostnqn
 [   44.627689] nvmet: creating controller 4 for subsystem testnqn2 for NQN hostnqn.
 [   44.641773] nvme nvme6: new ctrl: "testnqn2"

 # mdadm --create /dev/md0 --level=mirror --raid-devices=2 /dev/nvme3n1 /dev/nvme5n1
 [   53.497038] md/raid1:md0: active with 2 out of 2 mirrors
 [   53.501717] md0: detected capacity change from 0 to 66060288

 # cat /proc/mdstat
 Personalities : [raid1]
 md0 : active raid1 nvme5n1[1] nvme3n1[0]
       64512 blocks super 1.2 [2/2] [UU]

Now delete all paths to one of the namespaces:

 # echo 1 > /sys/class/nvme/nvme3/delete_controller
 # echo 1 > /sys/class/nvme/nvme4/delete_controller

We have no path, but mdstat says:

 # cat /proc/mdstat
 Personalities : [raid1]
 md0 : active (auto-read-only) raid1 nvme5n1[1]
       64512 blocks super 1.2 [2/1] [_U]

And this is reported to cause a problem.

With the proposed patch, the following messages appear:

 [  227.516807] md/raid1:md0: Disk failure on nvme3n1, disabling device.
 [  227.516807] md/raid1:md0: Operation continuing on 1 devices.

And mdstat shows only the viable members:

 # cat /proc/mdstat
 Personalities : [raid1]
 md0 : active (auto-read-only) raid1 nvme5n1[1]
       64512 blocks super 1.2 [2/1] [_U]

Reported-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/host/core.c      | 5 ++++-
 drivers/nvme/host/multipath.c | 1 -
 drivers/nvme/host/nvme.h      | 2 +-
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 40215a0246e4..ee898c8da786 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -542,7 +542,10 @@ static void nvme_free_ns_head(struct kref *ref)
 	struct nvme_ns_head *head =
 		container_of(ref, struct nvme_ns_head, ref);
 
-	nvme_mpath_remove_disk(head);
+#ifdef CONFIG_NVME_MULTIPATH
+	if (head->disk)
+		put_disk(head->disk);
+#endif
 	ida_simple_remove(&head->subsys->ns_ida, head->instance);
 	cleanup_srcu_struct(&head->srcu);
 	nvme_put_subsystem(head->subsys);
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index a1d476e1ac02..adea060d1470 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -702,7 +702,6 @@ void nvme_mpath_remove_disk(struct nvme_ns_head *head)
 		 */
 		head->disk->queue = NULL;
 	}
-	put_disk(head->disk);
 }
 
 int nvme_mpath_init(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index b0863c59fac4..6b8992774998 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -680,7 +680,7 @@ static inline void nvme_mpath_check_last_path(struct nvme_ns *ns)
 	struct nvme_ns_head *head = ns->head;
 
 	if (head->disk && list_empty(&head->list))
-		kblockd_schedule_work(&head->requeue_work);
+		nvme_mpath_remove_disk(head);
 }
 
 static inline void nvme_trace_bio_complete(struct request *req)
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

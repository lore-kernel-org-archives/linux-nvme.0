Return-Path: <SRS0=FZGd=J4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C89D1C433B4
	for <linux-nvme@archiver.kernel.org>; Sat,  1 May 2021 12:05:22 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27F9B613EA
	for <linux-nvme@archiver.kernel.org>; Sat,  1 May 2021 12:05:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27F9B613EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=CIc3Y/eN6BD4+TH7h7yFhQt/UCx2ynUx1ENUJcAGmZc=; b=LJcVe6GXgZjwZYEjebK4o2T5dR
	8p9CwrhLM1mZBBq79nlMzWjqS5k91FUcekmt2y3mSTGE6489T/zH5QDG+Rhx5GSi8WHpekoV3B8qo
	/hXI6isiLH5t5Ao0XPUjnGgdqWMhSRoaE1XrcR8YeQngVMPNCVVKpC30rtTnI7nigjjpU5GXY++au
	pSTN12sm8/NQB4wAaAp0FKRbU4YAxsLUGCh3EDQFCJsYNGPqP+ZZ0+2UFVVOx8KG/Xu7VZDM2lVWc
	B+dIheUWXAArsXPBhmpWAlZ5ck2mf6XkzmNDc/mUP2VV6n5mEO3UbvHWYtQ6fOrmJ92lnr7A1X3fD
	KBbVItiA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lcoMp-00A0Hc-8p; Sat, 01 May 2021 12:05:03 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lcoMl-00A0H7-PX
 for linux-nvme@desiato.infradead.org; Sat, 01 May 2021 12:04:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=t22w5gesPaGn9NAwmLxPxW4s8sWYIGf4PGIGzRh2D60=; b=grz2MzGLB9FS4i4DEQqZmvHs3F
 h2bdLVZsUGkXbqcHsfJD6fwzYdR2/N+X2fFNo1e5c4FSaOvYCfYSFk4KzmJs3+WLD0JCCBrulh7pz
 2hXFa5Xh1VZP8riStZJa6tZxq+zJ2vXvUbU53+nXUmqxpAogQjYqExfuaaYdxyx9xuuVBNI8+7PvR
 WQ5IbsnVZnuaLWICibmcBcoOEtYi/pIJOKwVmv8LUdXzh8PjAkZ7iiu54LsvuHsrQZP7NIOvbo/ah
 C1cJaueloM28GP4F08bgbgcdZm7L8/HOqgIDoeW89FE1LFktip9eMah4wqtrPAbNYNNraN2iFEwrF
 WJ1dnxKw==;
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lcoMi-001yRf-M3
 for linux-nvme@lists.infradead.org; Sat, 01 May 2021 12:04:58 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 5A1F3B062;
 Sat,  1 May 2021 12:04:55 +0000 (UTC)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
 Hannes Reinecke <hare@suse.de>, Daniel Wagner <daniel.wagner@suse.de>
Subject: [PATCHv3] nvme-mpath: delete disk after last connection
Date: Sat,  1 May 2021 14:04:47 +0200
Message-Id: <20210501120447.45478-1-hare@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210501_050457_033610_07E2311F 
X-CRM114-Status: GOOD (  18.02  )
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
 md0 : active raid1 nvme5n1[1] nvme3n1[0]
       64512 blocks super 1.2 [2/2] [UU]

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
Reviewed-by: Daniel Wagner <daniel.wagner@suse.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/core.c      |  2 +-
 drivers/nvme/host/multipath.c |  1 -
 drivers/nvme/host/nvme.h      | 11 ++++++++++-
 3 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index e6612971f4eb..6ccf0a8e7fba 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -546,7 +546,7 @@ static void nvme_free_ns_head(struct kref *ref)
 	struct nvme_ns_head *head =
 		container_of(ref, struct nvme_ns_head, ref);
 
-	nvme_mpath_remove_disk(head);
+	nvme_mpath_put_disk(head);
 	ida_simple_remove(&head->subsys->ns_ida, head->instance);
 	cleanup_srcu_struct(&head->srcu);
 	nvme_put_subsystem(head->subsys);
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 0d0de3433f37..d92532f518e9 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -775,7 +775,6 @@ void nvme_mpath_remove_disk(struct nvme_ns_head *head)
 		 */
 		head->disk->queue = NULL;
 	}
-	put_disk(head->disk);
 }
 
 int nvme_mpath_init(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 05f31a2c64bb..be92c3a685c0 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -719,12 +719,18 @@ bool nvme_mpath_clear_current_path(struct nvme_ns *ns);
 void nvme_mpath_clear_ctrl_paths(struct nvme_ctrl *ctrl);
 struct nvme_ns *nvme_find_path(struct nvme_ns_head *head);
 
+static inline void nvme_mpath_put_disk(struct nvme_ns_head *head)
+{
+	if (head->disk)
+		put_disk(head->disk);
+}
+
 static inline void nvme_mpath_check_last_path(struct nvme_ns *ns)
 {
 	struct nvme_ns_head *head = ns->head;
 
 	if (head->disk && list_empty(&head->list))
-		kblockd_schedule_work(&head->requeue_work);
+		nvme_mpath_remove_disk(head);
 }
 
 static inline void nvme_trace_bio_complete(struct request *req)
@@ -764,6 +770,9 @@ static inline void nvme_mpath_add_disk(struct nvme_ns *ns,
 		struct nvme_id_ns *id)
 {
 }
+static inline void nvme_mpath_put_disk(struct nvme_ns_head *head)
+{
+}
 static inline void nvme_mpath_remove_disk(struct nvme_ns_head *head)
 {
 }
-- 
2.26.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

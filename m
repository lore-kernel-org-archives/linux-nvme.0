Return-Path: <SRS0=tapN=C7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84EF4C4727D
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Sep 2020 12:15:29 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D11FF2395C
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Sep 2020 12:15:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Qhj9jlWp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D11FF2395C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:References:In-Reply-To:Message-Id:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=j5HKsU6J/DThNrtW1F6A26F8deKrk8o6SWLH2n/7FLY=; b=Qhj9jlWp820JG+eb/vmQtBzRw3
	qVbKraHsD7ETm2u+brZYAKkP/uN8hk7s9laQcxkRML9ZxADXyoG34NKHBglONlTfgEJczdkFY3kS9
	SOL77EZc1mUnebWFNAOcpexb4QmGpGbc4Q13hrypIG47P2bpSgLVe/H3zssZWiarIaSATpzpHIzwz
	AA2GEo0JQD7Z5R3uk26FPmvxviWq3MG8ZHgR8e+0Z5zO76X1QdxmZGQPP29MfTXdxSI+FMuhp1a/h
	SvzXCeU1FcqQG695Hf4tqDHNFfgnWm9XOhk7bx4tK2udz9cnXrA/eSZNUFFDUW9LVjBt7qJjPoapz
	msYn1HWg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kKhCg-0003pU-Ee; Tue, 22 Sep 2020 12:15:26 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kKhCU-0003le-MI
 for linux-nvme@lists.infradead.org; Tue, 22 Sep 2020 12:15:17 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 9AB26AD04;
 Tue, 22 Sep 2020 12:15:48 +0000 (UTC)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 2/7] nvmet-fc: use per-target workqueue when removing
 associations
Date: Tue, 22 Sep 2020 14:14:56 +0200
Message-Id: <20200922121501.32851-3-hare@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200922121501.32851-1-hare@suse.de>
References: <20200922121501.32851-1-hare@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200922_081515_038540_1245D2E4 
X-CRM114-Status: GOOD (  19.39  )
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
Cc: Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
 Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 James Smart <james.smart@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

When removing target ports all outstanding associations need to be
terminated / cleaned up. As this involves several exchanges on the
wire a synchronization point is required to establish when these
exchanges have ran their course and it's safe to delete the association.
So add a per-target workqueue and flush this workqueue to ensure
the association can really be deleted.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/target/fc.c | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 04ec0076ae59..63f5deb3b68a 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -99,6 +99,7 @@ struct nvmet_fc_tgtport {
 	struct list_head		tgt_list; /* nvmet_fc_target_list */
 	struct device			*dev;	/* dev for dma mapping */
 	struct nvmet_fc_target_template	*ops;
+	struct workqueue_struct		*work_q;
 
 	struct nvmet_fc_ls_iod		*iod;
 	spinlock_t			lock;
@@ -1403,10 +1404,17 @@ nvmet_fc_register_targetport(struct nvmet_fc_port_info *pinfo,
 	ida_init(&newrec->assoc_cnt);
 	newrec->max_sg_cnt = template->max_sgl_segments;
 
+	newrec->work_q = alloc_workqueue("ntfc%d", 0, 0,
+					 newrec->fc_target_port.port_num);
+	if (!newrec->work_q) {
+		ret = -ENOMEM;
+		goto out_free_newrec;
+	}
+
 	ret = nvmet_fc_alloc_ls_iodlist(newrec);
 	if (ret) {
 		ret = -ENOMEM;
-		goto out_free_newrec;
+		goto out_free_workq;
 	}
 
 	nvmet_fc_portentry_rebind_tgt(newrec);
@@ -1418,6 +1426,8 @@ nvmet_fc_register_targetport(struct nvmet_fc_port_info *pinfo,
 	*portptr = &newrec->fc_target_port;
 	return 0;
 
+out_free_workq:
+	destroy_workqueue(newrec->work_q);
 out_free_newrec:
 	put_device(dev);
 out_ida_put:
@@ -1443,6 +1453,8 @@ nvmet_fc_free_tgtport(struct kref *ref)
 	list_del(&tgtport->tgt_list);
 	spin_unlock_irqrestore(&nvmet_fc_tgtlock, flags);
 
+	destroy_workqueue(tgtport->work_q);
+
 	nvmet_fc_free_ls_iodlist(tgtport);
 
 	/* let the LLDD know we've finished tearing it down */
@@ -1481,11 +1493,13 @@ __nvmet_fc_free_assocs(struct nvmet_fc_tgtport *tgtport)
 				&tgtport->assoc_list, a_list) {
 		if (!nvmet_fc_tgt_a_get(assoc))
 			continue;
-		if (!schedule_work(&assoc->del_work))
+		if (!queue_work(tgtport->work_q, &assoc->del_work))
 			/* already deleting - release local reference */
 			nvmet_fc_tgt_a_put(assoc);
 	}
 	spin_unlock_irqrestore(&tgtport->lock, flags);
+
+	flush_workqueue(tgtport->work_q);
 }
 
 /**
@@ -1536,12 +1550,14 @@ nvmet_fc_invalidate_host(struct nvmet_fc_target_port *target_port,
 			continue;
 		assoc->hostport->invalid = 1;
 		noassoc = false;
-		if (!schedule_work(&assoc->del_work))
+		if (!queue_work(tgtport->work_q, &assoc->del_work))
 			/* already deleting - release local reference */
 			nvmet_fc_tgt_a_put(assoc);
 	}
 	spin_unlock_irqrestore(&tgtport->lock, flags);
 
+	flush_workqueue(tgtport->work_q);
+
 	/* if there's nothing to wait for - call the callback */
 	if (noassoc && tgtport->ops->host_release)
 		tgtport->ops->host_release(hosthandle);
@@ -1579,14 +1595,15 @@ nvmet_fc_delete_ctrl(struct nvmet_ctrl *ctrl)
 		}
 		spin_unlock_irqrestore(&tgtport->lock, flags);
 
-		nvmet_fc_tgtport_put(tgtport);
-
 		if (found_ctrl) {
-			if (!schedule_work(&assoc->del_work))
+			if (!queue_work(tgtport->work_q, &assoc->del_work))
 				/* already deleting - release local reference */
 				nvmet_fc_tgt_a_put(assoc);
+			flush_workqueue(tgtport->work_q);
+			nvmet_fc_tgtport_put(tgtport);
 			return;
 		}
+		nvmet_fc_tgtport_put(tgtport);
 
 		spin_lock_irqsave(&nvmet_fc_tgtlock, flags);
 	}
-- 
2.16.4


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

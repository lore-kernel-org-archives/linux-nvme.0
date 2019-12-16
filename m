Return-Path: <SRS0=UA0h=2G=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF8FFC43603
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Dec 2019 15:30:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80A17206E0
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Dec 2019 15:30:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="a7SuHqyp";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hl3yBJ0k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80A17206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=oCUazKbN5GrpAy+kILI70tfb5QFRimcQ2KDLIHlcrs0=; b=a7SuHqyphV1KZM
	e1PjRiO+UZjQ/OzuMm9IcV5zqW9XxiF5sqoBYsjui1DkZnj/s2S6PhBp6SIwicsftAv2ZE+VWJryc
	p7UfnxSb/c7QAUpKtmo9Ce4cS4IMsdzFTBpUCT5eVGbaXlYuy62ZGvdBsBIt/ukX8fKqAoYmhk/3t
	KWvedRCNsdb85HhD5QWboZT8H3UzBZvigToy4M0YWbWSxnRYkT2IKeIMkM+FBKCUxEebfsVvbhX25
	xTvCr2vhrDwVJC6BfiQJu6LWeIU9rYXfx9iewKccLaMhhpBfeDgCF61bBr/5mAeE8/mod2cxlRhgf
	BOo2HSqe+LZEHDapOtIg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1igsKJ-0001Al-SY; Mon, 16 Dec 2019 15:30:27 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1igsKG-0001AB-Nl
 for linux-nvme@lists.infradead.org; Mon, 16 Dec 2019 15:30:26 +0000
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 00B7F205C9;
 Mon, 16 Dec 2019 15:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1576510223;
 bh=12sb/5OqKzx59Eu3YJyO/ZohO9VLocu098PmIdgT3Oc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Hl3yBJ0kF1uAe/pkJr+mh9ZXXmVisy7WfDGHGW2s9ondc73rJlKAgYoczF9Y8Iy6t
 HFbDKHgXB8oaqOZondW4QKi8Q0a/8MUUvtnOIcC6b8UZbnkMbz8XuOTvNvUTglkFl0
 rJYK1EiS+9E8VVe7wGFOz5/2eFG1U9BaSsm5hLlY=
Date: Tue, 17 Dec 2019 00:30:19 +0900
From: Keith Busch <kbusch@kernel.org>
To: Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH] nvme: Translate more status codes to blk_status_t
Message-ID: <20191216153019.GA11424@redsun51.ssa.fujisawa.hgst.com>
References: <20191205195730.5774-1-kbusch@kernel.org>
 <93B95176-A634-4A62-A8BF-2C599E597979@netapp.com>
 <C041F01A-6577-4DC4-A992-6F040EC6C0C9@netapp.com>
 <18f741dd-2445-141e-ea2b-4185476da8d2@grimberg.me>
 <1db1bb81-f2e6-4ec2-ea43-b5e609be1a4e@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1db1bb81-f2e6-4ec2-ea43-b5e609be1a4e@suse.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191216_073024_814707_AC136072 
X-CRM114-Status: GOOD (  16.70  )
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
Cc: "hch@lst.de" <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, "Meneghini,
 John" <John.Meneghini@netapp.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Dec 16, 2019 at 09:02:28AM +0100, Hannes Reinecke wrote:
> On 12/13/19 10:02 PM, Sagi Grimberg wrote:
> I never liked the reset here in the first place; I/O errors, okay, but reset
> does imply that something unrecoverable happened.
> Which clearly it didn't as the controller did provide us with a reply, and
> it's just us being too daft to understand it.
> 
> So I do agree with Sagi here; we should restrict controller reset to real
> communication failures, not failed error handling.
> We did that in SCSI, and it turned out to be a mess.

I also think resetting as the default is too harsh of recovery on the
first escalation to a potential path related error. If we're really having
path communication problems, the timeout work will come in to clean up,
or we can white-list some errors if we agree reset is an appropriate
action. We mentioned so very early in the native mpath development:

  https://patchwork.kernel.org/patch/9918145/#20876583

Beyond reducing the errors that trigger reset, it would be good to make
mpath also delay with ACRE's CRD values. It should work if we retype the
requeue work to a delayed_work like the below (untested) patch:

---
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index e6ee34376c5e..a39c125d6305 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -264,17 +264,11 @@ static inline bool nvme_req_needs_retry(struct request *req)
 static void nvme_retry_req(struct request *req)
 {
 	struct nvme_ns *ns = req->q->queuedata;
-	unsigned long delay = 0;
-	u16 crd;
-
-	/* The mask and shift result must be <= 3 */
-	crd = (nvme_req(req)->status & NVME_SC_CRD) >> 11;
-	if (ns && crd)
-		delay = ns->ctrl->crdt[crd - 1] * 100;
+	u16 status = nvme_req(req)->status;
 
 	nvme_req(req)->retries++;
 	blk_mq_requeue_request(req, false);
-	blk_mq_delay_kick_requeue_list(req->q, delay);
+	blk_mq_delay_kick_requeue_list(req->q, nvme_retry_delay(status, ns));
 }
 
 void nvme_complete_rq(struct request *req)
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 797c18337d96..40b33f2a19ad 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -111,7 +111,8 @@ void nvme_failover_req(struct request *req)
 		break;
 	}
 
-	kblockd_schedule_work(&ns->head->requeue_work);
+	kblockd_mod_delayed_work_on(WORK_CPU_UNBOUND, &ns->head->requeue_work,
+				    nvme_retry_delay(status, ns));
 }
 
 void nvme_kick_requeue_lists(struct nvme_ctrl *ctrl)
@@ -121,7 +122,7 @@ void nvme_kick_requeue_lists(struct nvme_ctrl *ctrl)
 	down_read(&ctrl->namespaces_rwsem);
 	list_for_each_entry(ns, &ctrl->namespaces, list) {
 		if (ns->head->disk)
-			kblockd_schedule_work(&ns->head->requeue_work);
+			kblockd_schedule_work(&ns->head->requeue_work.work);
 	}
 	up_read(&ctrl->namespaces_rwsem);
 }
@@ -162,7 +163,7 @@ void nvme_mpath_clear_ctrl_paths(struct nvme_ctrl *ctrl)
 	down_read(&ctrl->namespaces_rwsem);
 	list_for_each_entry(ns, &ctrl->namespaces, list)
 		if (nvme_mpath_clear_current_path(ns))
-			kblockd_schedule_work(&ns->head->requeue_work);
+			kblockd_schedule_work(&ns->head->requeue_work.work);
 	up_read(&ctrl->namespaces_rwsem);
 	mutex_unlock(&ctrl->scan_lock);
 }
@@ -339,7 +340,7 @@ static blk_qc_t nvme_ns_head_make_request(struct request_queue *q,
 static void nvme_requeue_work(struct work_struct *work)
 {
 	struct nvme_ns_head *head =
-		container_of(work, struct nvme_ns_head, requeue_work);
+		container_of(work, struct nvme_ns_head, requeue_work.work);
 	struct bio *bio, *next;
 
 	spin_lock_irq(&head->requeue_lock);
@@ -367,7 +368,7 @@ int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, struct nvme_ns_head *head)
 	mutex_init(&head->lock);
 	bio_list_init(&head->requeue_list);
 	spin_lock_init(&head->requeue_lock);
-	INIT_WORK(&head->requeue_work, nvme_requeue_work);
+	INIT_DELAYED_WORK(&head->requeue_work, nvme_requeue_work);
 
 	/*
 	 * Add a multipath node if the subsystems supports multiple controllers.
@@ -432,7 +433,7 @@ static void nvme_mpath_set_live(struct nvme_ns *ns)
 	}
 
 	synchronize_srcu(&ns->head->srcu);
-	kblockd_schedule_work(&ns->head->requeue_work);
+	kblockd_schedule_work(&ns->head->requeue_work.work);
 }
 
 static int nvme_parse_ana_log(struct nvme_ctrl *ctrl, void *data,
@@ -680,8 +681,8 @@ void nvme_mpath_remove_disk(struct nvme_ns_head *head)
 		del_gendisk(head->disk);
 	blk_set_queue_dying(head->disk->queue);
 	/* make sure all pending bios are cleaned up */
-	kblockd_schedule_work(&head->requeue_work);
-	flush_work(&head->requeue_work);
+	kblockd_schedule_work(&head->requeue_work.work);
+	flush_work(&head->requeue_work.work);
 	blk_cleanup_queue(head->disk->queue);
 	put_disk(head->disk);
 }
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 1024fec7914c..929427defbcb 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -356,7 +356,7 @@ struct nvme_ns_head {
 	struct gendisk		*disk;
 	struct bio_list		requeue_list;
 	spinlock_t		requeue_lock;
-	struct work_struct	requeue_work;
+	struct delayed_work	requeue_work;
 	struct mutex		lock;
 	struct nvme_ns __rcu	*current_path[];
 #endif
@@ -393,6 +393,15 @@ struct nvme_ns {
 
 };
 
+static inline unsigned long nvme_retry_delay(u16 status, struct nvme_ns *ns)
+{
+	/* The mask and shift result must be <= 3 */
+	u16 crd = (status & NVME_SC_CRD) >> 11;
+	if (ns && crd)
+		return ns->ctrl->crdt[crd - 1] * 100;
+	return 0;
+}
+
 struct nvme_ctrl_ops {
 	const char *name;
 	struct module *module;
@@ -567,7 +576,7 @@ static inline void nvme_mpath_check_last_path(struct nvme_ns *ns)
 	struct nvme_ns_head *head = ns->head;
 
 	if (head->disk && list_empty(&head->list))
-		kblockd_schedule_work(&head->requeue_work);
+		kblockd_schedule_work(&head->requeue_work.work);
 }
 
 static inline void nvme_trace_bio_complete(struct request *req,
--

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

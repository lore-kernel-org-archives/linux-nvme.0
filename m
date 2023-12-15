Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1A99C35274
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Dec 2023 14:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=erKKb0H7SqC5E2Ri4hvjnBoK0v3Z/VHjHExpDsFsfS8=; b=OgzYsrL3+98NCeN3JR68ieQvWP
	wt3YTE5wfB20ihhba0PigKZhqnU8H0xjXjJNNpGfkZnYZOlGbed67CNbk21ZIQcP/i1IJfHJE5IvS
	GJ86Ff/ErdUeAZcQDWIfWNsdjbI1heIOHCnI2vOIWXNxhK/rBNMNfgZ3B4uMCR0iOcODDi6oQkqaf
	d1X/8FqyFzdWkroWIq4qh9gll7sutcfPcxAl4a5XjNR067iE0LAfQwxj9qLELTTjoihv1y0Ub8LOP
	rbm2k0dM4WPK1LzkQEo7l0BnV+Ksz5Ecy8YKkKx/8vPTIJF3/eKYqjspKqyWQqMeZeLQwIZZxsgAD
	axblh8mw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rE9EB-003ZGW-2q;
	Fri, 15 Dec 2023 14:31:47 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rE9E8-003ZEw-0Q
	for linux-nvme@lists.infradead.org;
	Fri, 15 Dec 2023 14:31:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702650701;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=erKKb0H7SqC5E2Ri4hvjnBoK0v3Z/VHjHExpDsFsfS8=;
	b=VtYp1tAW5MsbqrBkFxff7J38L6xbJibO+/ZmtxTjSXqC5jJhqTZxODz9QdNmUabnZpjtdN
	fhN/SHWJ6ubJpkEpUpnYUbG5yuBmQpRFEYzeDc9ixZKbA/s3EIjXmdGLaokk3dyzg031Uq
	GUJO5RLL7hlOq8xGW4I+7cKACWkDhI4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-561-KutriXVDME6j3DkW-cgdlw-1; Fri,
 15 Dec 2023 09:31:38 -0500
X-MC-Unique: KutriXVDME6j3DkW-cgdlw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8A08D28EC103;
	Fri, 15 Dec 2023 14:31:38 +0000 (UTC)
Received: from kalibr.redhat.com (unknown [10.47.238.49])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9C73840C6EB9;
	Fri, 15 Dec 2023 14:31:37 +0000 (UTC)
From: Maurizio Lombardi <mlombard@redhat.com>
To: kbusch@kernel.org
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH] nvme-pci: fix sleeping function called from interrupt context
Date: Fri, 15 Dec 2023 15:31:36 +0100
Message-Id: <20231215143136.252497-1-mlombard@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231215_063144_268369_961E334F 
X-CRM114-Status: GOOD (  13.68  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

the nvme_handle_cqe() interrupt handler calls nvme_complete_async_event()
but the latter may call some blocking functions. Sleeping functions
can't be called in interrupt context.

BUG: sleeping function called from invalid context
in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 0, name: swapper/15
 Call Trace:
 <IRQ>
  __cancel_work_timer+0x31e/0x460
  ? nvme_change_ctrl_state+0xcf/0x3c0 [nvme_core]
  ? nvme_change_ctrl_state+0xcf/0x3c0 [nvme_core]
  nvme_complete_async_event+0x365/0x480 [nvme_core]
  nvme_poll_cq+0x262/0xe50 [nvme]

Fix the bug by deferring the call to nvme_complete_async_event() to
the nvme_wq workqueue, add a wait_queue to be sure there are no async
events waiting to be completed before stopping the controller.

Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
---
 drivers/nvme/host/pci.c | 40 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 38 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 61af7ff1a9d6..4ac3d3606c4f 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -139,6 +139,8 @@ struct nvme_dev {
 	u32 cmbsz;
 	u32 cmbloc;
 	struct nvme_ctrl ctrl;
+	wait_queue_head_t async_wq;
+	atomic_t async_completing;
 	u32 last_ps;
 	bool hmb;
 
@@ -161,6 +163,13 @@ struct nvme_dev {
 	unsigned int nr_poll_queues;
 };
 
+struct nvme_compl_async_data {
+	struct work_struct cmpl_work;
+	struct nvme_dev *dev;
+	union nvme_result result;
+	__le16 status;
+};
+
 static int io_queue_depth_set(const char *val, const struct kernel_param *kp)
 {
 	return param_set_uint_minmax(val, kp, NVME_PCI_MIN_QUEUE_SIZE,
@@ -1008,6 +1017,20 @@ static inline struct blk_mq_tags *nvme_queue_tagset(struct nvme_queue *nvmeq)
 	return nvmeq->dev->tagset.tags[nvmeq->qid - 1];
 }
 
+static void nvme_complete_async_event_work(struct work_struct *work)
+{
+	struct nvme_compl_async_data *data;
+	struct nvme_dev *dev;
+
+	data = container_of(work, struct nvme_compl_async_data, cmpl_work);
+	dev = data->dev;
+
+	nvme_complete_async_event(&dev->ctrl, data->status, &data->result);
+	atomic_dec(&dev->async_completing);
+	wake_up(&dev->async_wq);
+	kfree(data);
+}
+
 static inline void nvme_handle_cqe(struct nvme_queue *nvmeq,
 				   struct io_comp_batch *iob, u16 idx)
 {
@@ -1022,8 +1045,18 @@ static inline void nvme_handle_cqe(struct nvme_queue *nvmeq,
 	 * for them but rather special case them here.
 	 */
 	if (unlikely(nvme_is_aen_req(nvmeq->qid, command_id))) {
-		nvme_complete_async_event(&nvmeq->dev->ctrl,
-				cqe->status, &cqe->result);
+		struct nvme_compl_async_data *data;
+
+		data = kmalloc(sizeof(*data), GFP_ATOMIC);
+		if (!data)
+			return;
+
+		INIT_WORK(&data->cmpl_work, nvme_complete_async_event_work);
+		data->dev = nvmeq->dev;
+		data->status = cqe->status;
+		data->result = cqe->result;
+		atomic_inc(&nvmeq->dev->async_completing);
+		queue_work(nvme_wq, &data->cmpl_work);
 		return;
 	}
 
@@ -2933,6 +2966,8 @@ static struct nvme_dev *nvme_pci_alloc_dev(struct pci_dev *pdev,
 	INIT_WORK(&dev->ctrl.reset_work, nvme_reset_work);
 	mutex_init(&dev->shutdown_lock);
 
+	init_waitqueue_head(&dev->async_wq);
+	atomic_set(&dev->async_completing, 0);
 	dev->nr_write_queues = write_queues;
 	dev->nr_poll_queues = poll_queues;
 	dev->nr_allocated_queues = nvme_max_io_queues(dev) + 1;
@@ -3135,6 +3170,7 @@ static void nvme_remove(struct pci_dev *pdev)
 	}
 
 	flush_work(&dev->ctrl.reset_work);
+	wait_event(dev->async_wq, !atomic_read(&dev->async_completing));
 	nvme_stop_ctrl(&dev->ctrl);
 	nvme_remove_namespaces(&dev->ctrl);
 	nvme_dev_disable(dev, true);
-- 
2.39.3



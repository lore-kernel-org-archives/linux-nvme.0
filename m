Return-Path: <SRS0=ZzGD=FR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32693C433FE
	for <linux-nvme@archiver.kernel.org>; Sun, 13 Dec 2020 19:15:17 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 925EA224DE
	for <linux-nvme@archiver.kernel.org>; Sun, 13 Dec 2020 19:15:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 925EA224DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=marvell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-ID:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=wKOI39DOYuKXJW5LenEgZAOUaDrK9Jz7XAiE5DlT2E8=; b=AsVwbdEiPosm76ZyUvBHWtcxE
	UL7KP/oIManA4khKc9UX+2NirwwbXisogHt1oQvuZr+Qit4ZL7Ss1tuU9cvP82CK1AA2nx0oSC9Un
	9cpaIwK8Kq6RX5kB4LUueKDVzDjWK+Fr1+JzWQH2nSej6bTaTdqXfBXeHtDbdDntYW4Sq80VCM5hY
	uEf6bSqau/LO2ZFBYp6PJkkaWYTU2lhgTY2zCs5iAbvcnwUwixrpBZ1M85zoy9QIwXtsRBea3OCZP
	YlqKdU4gCzVueKaopgPcd3DrPy9v/KNq67zk3drZ6G+Xfby/7qSXERlu1ESMMe7SqClwyNucvqktE
	l5bn8k+Lw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1koWpt-000500-Oc; Sun, 13 Dec 2020 19:15:13 +0000
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1koWpq-0004yv-JJ
 for linux-nvme@lists.infradead.org; Sun, 13 Dec 2020 19:15:12 +0000
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 0BDJA7vU031564; Sun, 13 Dec 2020 11:14:35 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=IRWQz0nI9bxWzin2sHSg09kPXDeqvKdK4LmC4u130Og=;
 b=BRgQl853QvptZF1830IQBMQxxm3fgsRBvdUrUfrpTxpsRPOp/NbUUKzQ2+Ud+M9Qef/V
 vpmQU3J92IekboGdcZmgDiPUgqw5+7434BrcY3zCSbbTp/obCDk9ylOsY5e7rdUr8ox+
 62yJykfY563UBDEi2Xw9K8NfuuAE+IlBBk5+rdlqZTEqXPepR5WAsgHOUde3OVpaxySy
 yh3fo90YEq+4+PrXmnLbMfXgmlNKpunV7SdsWXTagWoenaW7ypCvDLnY07WWJVpt9E/5
 SE5no/DtQh3iK1yvtawQ/zBh06MeRIWVtQzp+zbc+Nd0U7QhwdqyYYID4mjqakl0Hds9 uw== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
 by mx0b-0016f401.pphosted.com with ESMTP id 35cx8t28ev-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
 Sun, 13 Dec 2020 11:14:35 -0800
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Sun, 13 Dec 2020 11:14:33 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Sun, 13 Dec 2020 11:14:32 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sun, 13 Dec 2020 11:14:32 -0800
Received: from lbtlvb-pcie154.il.qlogic.org (unknown [10.5.220.141])
 by maili.marvell.com (Postfix) with ESMTP id 381603F7041;
 Sun, 13 Dec 2020 11:14:29 -0800 (PST)
From: Shai Malin <smalin@marvell.com>
To: <linux-nvme@lists.infradead.org>, <sagi@grimberg.me>,
 <Erik.Smith@dell.com>, <Douglas.Farley@dell.com>, <liuw@vmware.com>
Subject: [RFC PATCH v2 6/7] nvme-tcp-offload: Add queue level implementation
Date: Sun, 13 Dec 2020 21:14:00 +0200
Message-ID: <20201213191401.22734-7-smalin@marvell.com>
X-Mailer: git-send-email 2.16.6
In-Reply-To: <20201213191401.22734-1-smalin@marvell.com>
References: <20201213191401.22734-1-smalin@marvell.com>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343, 18.0.737
 definitions=2020-12-13_06:2020-12-11,
 2020-12-13 signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201213_141510_803498_F7F28652 
X-CRM114-Status: GOOD (  25.48  )
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
Cc: smalin@marvell.com, aelior@marvell.com, agershberg@marvell.com,
 mkalderon@marvell.com, nassa@marvell.com, dbalandin@marvell.com,
 malin1024@gmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Dean Balandin <dbalandin@marvell.com>

In this patch we implement queue level functionality.
The implementation is similar to the nvme-tcp module, the main
difference being that we call the vendor specific create_queue op which
creates the TCP connection, and NVMeTPC connection including
icreq+icresp negotiation.
Once create_queue returns successfully, we can move on to the fabrics
connect.

Signed-off-by: Dean Balandin <dbalandin@marvell.com>
Signed-off-by: Shai Malin <smalin@marvell.com>
Signed-off-by: Ariel Elior <aelior@marvell.com>
Signed-off-by: Michal Kalderon <mkalderon@marvell.com>
---
 drivers/nvme/host/tcp-offload.c | 307 ++++++++++++++++++++++++++++++--
 drivers/nvme/host/tcp-offload.h |   6 +
 2 files changed, 294 insertions(+), 19 deletions(-)

diff --git a/drivers/nvme/host/tcp-offload.c b/drivers/nvme/host/tcp-offload.c
index d9da0fc5eb75..12f675bdd221 100644
--- a/drivers/nvme/host/tcp-offload.c
+++ b/drivers/nvme/host/tcp-offload.c
@@ -23,6 +23,11 @@ to_tcp_ofld_ctrl(struct nvme_ctrl *nctrl)
 	return container_of(nctrl, struct nvme_tcp_ofld_ctrl, nctrl);
 }
 
+static inline int nvme_tcp_ofld_qid(struct nvme_tcp_ofld_queue *queue)
+{
+	return queue - queue->ctrl->queues;
+}
+
 /**
  * nvme_tcp_ofld_register_dev() - NVMeTCP Offload Library registration
  * function.
@@ -190,18 +195,98 @@ nvme_tcp_ofld_alloc_tagset(struct nvme_ctrl *nctrl, bool admin)
 	return set;
 }
 
+static bool nvme_tcp_ofld_poll_queue(struct nvme_tcp_ofld_queue *queue)
+{
+	/* Placeholder - implement logic to determine if poll queue */
+
+	return false;
+}
+
+static void __nvme_tcp_ofld_stop_queue(struct nvme_tcp_ofld_queue *queue)
+{
+	queue->dev->ops->drain_queue(queue);
+	queue->dev->ops->destroy_queue(queue);
+
+	/* Placeholder - additional cleanup such as cancel_work_sync io_work */
+	clear_bit(NVME_TCP_OFLD_Q_LIVE, &queue->flags);
+}
+
+static void nvme_tcp_ofld_stop_queue(struct nvme_ctrl *nctrl, int qid)
+{
+	struct nvme_tcp_ofld_ctrl *ctrl = to_tcp_ofld_ctrl(nctrl);
+	struct nvme_tcp_ofld_queue *queue = &ctrl->queues[qid];
+
+	if (!test_and_clear_bit(NVME_TCP_OFLD_Q_LIVE, &queue->flags))
+		return;
+
+	__nvme_tcp_ofld_stop_queue(queue);
+}
+
+static void nvme_tcp_ofld_free_queue(struct nvme_ctrl *nctrl, int qid)
+{
+	struct nvme_tcp_ofld_ctrl *ctrl = to_tcp_ofld_ctrl(nctrl);
+	struct nvme_tcp_ofld_queue *queue = &ctrl->queues[qid];
+
+	if (!test_and_clear_bit(NVME_TCP_OFLD_Q_ALLOCATED, &queue->flags))
+		return;
+
+	/* Placeholder - additional queue cleanup */
+}
+
+static void
+nvme_tcp_ofld_terminate_admin_queue(struct nvme_ctrl *nctrl, bool remove)
+{
+	nvme_tcp_ofld_stop_queue(nctrl, 0);
+	if (remove) {
+		if (nctrl->admin_q && !blk_queue_dead(nctrl->admin_q))
+			blk_cleanup_queue(nctrl->admin_q);
+
+		if (nctrl->fabrics_q)
+			blk_cleanup_queue(nctrl->fabrics_q);
+
+		if (nctrl->admin_tagset)
+			blk_mq_free_tag_set(nctrl->admin_tagset);
+	}
+}
+
 static int nvme_tcp_ofld_start_queue(struct nvme_ctrl *nctrl, int qid)
 {
-	/* Placeholder - start_queue */
-	return 0;
+	struct nvme_tcp_ofld_ctrl *ctrl = to_tcp_ofld_ctrl(nctrl);
+	struct nvme_tcp_ofld_queue *queue = &ctrl->queues[qid];
+	int rc;
+
+	set_bit(NVME_TCP_OFLD_Q_ALLOCATED, &queue->flags);
+	queue = &ctrl->queues[qid];
+	if (qid)
+		rc = nvmf_connect_io_queue(nctrl, qid,
+					   nvme_tcp_ofld_poll_queue(queue));
+	else
+		rc = nvmf_connect_admin_queue(nctrl);
+
+	if (!rc) {
+		set_bit(NVME_TCP_OFLD_Q_LIVE, &queue->flags);
+	} else {
+		if (test_bit(NVME_TCP_OFLD_Q_ALLOCATED, &queue->flags))
+			__nvme_tcp_ofld_stop_queue(queue);
+		dev_err(nctrl->device,
+			"failed to connect queue: %d ret=%d\n", qid, rc);
+	}
+
+	return rc;
 }
 
 static int nvme_tcp_ofld_configure_admin_queue(struct nvme_ctrl *nctrl,
 					       bool new)
 {
+	struct nvme_tcp_ofld_ctrl *ctrl = to_tcp_ofld_ctrl(nctrl);
+	struct nvme_tcp_ofld_queue *queue = &ctrl->queues[0];
 	int rc;
 
-	/* Placeholder - alloc_admin_queue */
+	rc = ctrl->dev->ops->create_queue(queue, 0, NVME_AQ_DEPTH);
+	if (rc)
+		return rc;
+
+	set_bit(NVME_TCP_OFLD_Q_ALLOCATED, &queue->flags);
 	if (new) {
 		nctrl->admin_tagset =
 				nvme_tcp_ofld_alloc_tagset(nctrl, true);
@@ -243,7 +328,7 @@ static int nvme_tcp_ofld_configure_admin_queue(struct nvme_ctrl *nctrl,
 	return 0;
 
 out_stop_queue:
-	/* Placeholder - stop admin queue */
+	nvme_tcp_ofld_stop_queue(nctrl, 0);
 out_cleanup_queue:
 	if (new)
 		blk_cleanup_queue(nctrl->admin_q);
@@ -254,7 +339,115 @@ static int nvme_tcp_ofld_configure_admin_queue(struct nvme_ctrl *nctrl,
 	if (new)
 		blk_mq_free_tag_set(nctrl->admin_tagset);
 out_free_queue:
-	/* Placeholder - free admin queue */
+	nvme_tcp_ofld_free_queue(nctrl, 0);
+
+	return rc;
+}
+
+static unsigned int nvme_tcp_ofld_nr_io_queues(struct nvme_ctrl *nctrl)
+{
+	unsigned int nr_io_queues;
+
+	nr_io_queues = min(nctrl->opts->nr_io_queues, num_online_cpus());
+	nr_io_queues += min(nctrl->opts->nr_write_queues, num_online_cpus());
+	nr_io_queues += min(nctrl->opts->nr_poll_queues, num_online_cpus());
+
+	return nr_io_queues;
+}
+
+static void
+nvme_tcp_ofld_set_io_queues(struct nvme_ctrl *nctrl, unsigned int nr_io_queues)
+{
+	struct nvme_tcp_ofld_ctrl *ctrl = to_tcp_ofld_ctrl(nctrl);
+	struct nvmf_ctrl_options *opts = nctrl->opts;
+
+	if (opts->nr_write_queues && opts->nr_io_queues < nr_io_queues) {
+		/*
+		 * separate read/write queues
+		 * hand out dedicated default queues only after we have
+		 * sufficient read queues.
+		 */
+		ctrl->queue_type_mapping[HCTX_TYPE_READ] = opts->nr_io_queues;
+		nr_io_queues -= ctrl->queue_type_mapping[HCTX_TYPE_READ];
+		ctrl->queue_type_mapping[HCTX_TYPE_DEFAULT] =
+			min(opts->nr_write_queues, nr_io_queues);
+		nr_io_queues -= ctrl->queue_type_mapping[HCTX_TYPE_DEFAULT];
+	} else {
+		/*
+		 * shared read/write queues
+		 * either no write queues were requested, or we don't have
+		 * sufficient queue count to have dedicated default queues.
+		 */
+		ctrl->queue_type_mapping[HCTX_TYPE_DEFAULT] =
+			min(opts->nr_io_queues, nr_io_queues);
+		nr_io_queues -= ctrl->queue_type_mapping[HCTX_TYPE_DEFAULT];
+	}
+}
+
+static void
+nvme_tcp_ofld_terminate_io_queues(struct nvme_ctrl *nctrl, int start_from)
+{
+	int i;
+
+	/* admin-q will be ignored because of the loop condition */
+	for (i = start_from; i >= 1; i--)
+		nvme_tcp_ofld_stop_queue(nctrl, i);
+}
+
+static int nvme_tcp_ofld_create_io_queues(struct nvme_ctrl *nctrl)
+{
+	struct nvme_tcp_ofld_ctrl *ctrl = to_tcp_ofld_ctrl(nctrl);
+	int i, rc;
+
+	for (i = 1; i < nctrl->queue_count; i++) {
+		rc = ctrl->dev->ops->create_queue(&ctrl->queues[i],
+						  i, nctrl->sqsize + 1);
+		if (rc)
+			goto out_free_queues;
+	}
+
+	return 0;
+
+out_free_queues:
+	nvme_tcp_ofld_terminate_io_queues(nctrl, --i);
+
+	return rc;
+}
+
+static int nvme_tcp_ofld_alloc_io_queues(struct nvme_ctrl *nctrl)
+{
+	unsigned int nr_io_queues;
+	int rc;
+
+	nr_io_queues = nvme_tcp_ofld_nr_io_queues(nctrl);
+	rc = nvme_set_queue_count(nctrl, &nr_io_queues);
+	if (rc)
+		return rc;
+
+	nctrl->queue_count = nr_io_queues + 1;
+	if (nctrl->queue_count < 2)
+		return 0;
+
+	dev_info(nctrl->device, "creating %d I/O queues.\n", nr_io_queues);
+	nvme_tcp_ofld_set_io_queues(nctrl, nr_io_queues);
+
+	return nvme_tcp_ofld_create_io_queues(nctrl);
+}
+
+static int nvme_tcp_ofld_start_io_queues(struct nvme_ctrl *nctrl)
+{
+	int i, rc = 0;
+
+	for (i = 1; i < nctrl->queue_count; i++) {
+		rc = nvme_tcp_ofld_start_queue(nctrl, i);
+		if (rc)
+			goto terminate_queues;
+	}
+
+	return 0;
+
+terminate_queues:
+	nvme_tcp_ofld_terminate_io_queues(nctrl, --i);
 
 	return rc;
 }
@@ -262,9 +455,10 @@ static int nvme_tcp_ofld_configure_admin_queue(struct nvme_ctrl *nctrl,
 static int
 nvme_tcp_ofld_configure_io_queues(struct nvme_ctrl *nctrl, bool new)
 {
-	int rc;
+	int rc = nvme_tcp_ofld_alloc_io_queues(nctrl);
 
-	/* Placeholder - alloc_io_queues */
+	if (rc)
+		return rc;
 
 	if (new) {
 		nctrl->tagset = nvme_tcp_ofld_alloc_tagset(nctrl, false);
@@ -282,7 +476,9 @@ nvme_tcp_ofld_configure_io_queues(struct nvme_ctrl *nctrl, bool new)
 		}
 	}
 
-	/* Placeholder - start_io_queues */
+	rc = nvme_tcp_ofld_start_io_queues(nctrl);
+	if (rc)
+		goto out_cleanup_connect_q;
 
 	if (!new) {
 		nvme_start_queues(nctrl);
@@ -294,11 +490,14 @@ nvme_tcp_ofld_configure_io_queues(struct nvme_ctrl *nctrl, bool new)
 
 	return 0;
 
+out_cleanup_connect_q:
+	if (new && nctrl->connect_q)
+		blk_cleanup_queue(nctrl->connect_q);
 out_free_tag_set:
 	if (new)
 		blk_mq_free_tag_set(nctrl->tagset);
 out_free_io_queues:
-	/* Placeholder - free_io_queues */
+	nvme_tcp_ofld_terminate_io_queues(nctrl, nctrl->queue_count);
 
 	return rc;
 }
@@ -374,9 +573,9 @@ static int nvme_tcp_ofld_setup_ctrl(struct nvme_ctrl *nctrl, bool new)
 	return 0;
 
 destroy_io:
-	/* Placeholder - stop and destroy io queues*/
+	nvme_tcp_ofld_terminate_io_queues(nctrl, nctrl->queue_count);
 destroy_admin:
-	/* Placeholder - stop and destroy admin queue*/
+	nvme_tcp_ofld_terminate_admin_queue(nctrl, new);
 
 	return rc;
 }
@@ -559,22 +758,92 @@ nvme_tcp_ofld_queue_rq(struct blk_mq_hw_ctx *hctx,
 	return BLK_STS_OK;
 }
 
+static void
+nvme_tcp_ofld_exit_request(struct blk_mq_tag_set *set,
+			   struct request *rq, unsigned int hctx_idx)
+{
+	/* Placeholder */
+}
+
+static int
+nvme_tcp_ofld_init_hctx(struct blk_mq_hw_ctx *hctx, void *data,
+			unsigned int hctx_idx)
+{
+	struct nvme_tcp_ofld_ctrl *ctrl = data;
+	struct nvme_tcp_ofld_queue *queue = &ctrl->queues[hctx_idx + 1];
+
+	hctx->driver_data = queue;
+	return 0;
+}
+
+static int nvme_tcp_ofld_map_queues(struct blk_mq_tag_set *set)
+{
+	struct nvme_tcp_ofld_ctrl *ctrl = set->driver_data;
+	struct nvmf_ctrl_options *opts = ctrl->nctrl.opts;
+
+	if (opts->nr_write_queues && ctrl->queue_type_mapping[HCTX_TYPE_READ]) {
+		/* separate read/write queues */
+		set->map[HCTX_TYPE_DEFAULT].nr_queues =
+			ctrl->queue_type_mapping[HCTX_TYPE_DEFAULT];
+		set->map[HCTX_TYPE_DEFAULT].queue_offset = 0;
+		set->map[HCTX_TYPE_READ].nr_queues =
+			ctrl->queue_type_mapping[HCTX_TYPE_READ];
+		set->map[HCTX_TYPE_READ].queue_offset =
+			ctrl->queue_type_mapping[HCTX_TYPE_DEFAULT];
+	} else {
+		/* shared read/write queues */
+		set->map[HCTX_TYPE_DEFAULT].nr_queues =
+			ctrl->queue_type_mapping[HCTX_TYPE_DEFAULT];
+		set->map[HCTX_TYPE_DEFAULT].queue_offset = 0;
+		set->map[HCTX_TYPE_READ].nr_queues =
+			ctrl->queue_type_mapping[HCTX_TYPE_DEFAULT];
+		set->map[HCTX_TYPE_READ].queue_offset = 0;
+	}
+	blk_mq_map_queues(&set->map[HCTX_TYPE_DEFAULT]);
+	blk_mq_map_queues(&set->map[HCTX_TYPE_READ]);
+
+	if (opts->nr_poll_queues && ctrl->queue_type_mapping[HCTX_TYPE_POLL]) {
+		/* map dedicated poll queues only if we have queues left */
+		set->map[HCTX_TYPE_POLL].nr_queues =
+				ctrl->queue_type_mapping[HCTX_TYPE_POLL];
+		set->map[HCTX_TYPE_POLL].queue_offset =
+			ctrl->queue_type_mapping[HCTX_TYPE_DEFAULT] +
+			ctrl->queue_type_mapping[HCTX_TYPE_READ];
+		blk_mq_map_queues(&set->map[HCTX_TYPE_POLL]);
+	}
+
+	dev_info(ctrl->nctrl.device,
+		 "mapped %d/%d/%d default/read/poll queues.\n",
+		 ctrl->queue_type_mapping[HCTX_TYPE_DEFAULT],
+		 ctrl->queue_type_mapping[HCTX_TYPE_READ],
+		 ctrl->queue_type_mapping[HCTX_TYPE_POLL]);
+
+	return 0;
+}
+
+static int nvme_tcp_ofld_poll(struct blk_mq_hw_ctx *hctx)
+{
+	/* Placeholder - Implement polling mechanism */
+
+	return 0;
+}
+
 static struct blk_mq_ops nvme_tcp_ofld_mq_ops = {
 	.queue_rq	= nvme_tcp_ofld_queue_rq,
 	.init_request	= nvme_tcp_ofld_init_request,
-	/*
-	 * All additional ops will be also implemented and registered similar to
-	 * tcp.c
-	 */
+	.complete	= nvme_complete_rq,
+	.exit_request	= nvme_tcp_ofld_exit_request,
+	.init_hctx	= nvme_tcp_ofld_init_hctx,
+	.map_queues	= nvme_tcp_ofld_map_queues,
+	.poll		= nvme_tcp_ofld_poll,
 };
 
 static struct blk_mq_ops nvme_tcp_ofld_admin_mq_ops = {
 	.queue_rq	= nvme_tcp_ofld_queue_rq,
 	.init_request	= nvme_tcp_ofld_init_request,
-	/*
-	 * All additional ops will be also implemented and registered similar to
-	 * tcp.c
-	 */
+	.complete	= nvme_complete_rq,
+	.exit_request	= nvme_tcp_ofld_exit_request,
+	.init_hctx	= nvme_tcp_ofld_init_hctx,
 };
 
 static const struct nvme_ctrl_ops nvme_tcp_ofld_ctrl_ops = {
diff --git a/drivers/nvme/host/tcp-offload.h b/drivers/nvme/host/tcp-offload.h
index c3f74f700c6a..02a2592d4dca 100644
--- a/drivers/nvme/host/tcp-offload.h
+++ b/drivers/nvme/host/tcp-offload.h
@@ -42,11 +42,17 @@ struct nvme_tcp_ofld_req {
 		     __le16 status);
 };
 
+enum nvme_tcp_ofld_queue_flags {
+	NVME_TCP_OFLD_Q_ALLOCATED = 0,
+	NVME_TCP_OFLD_Q_LIVE = 1,
+};
+
 /* Allocated by nvme_tcp_ofld */
 struct nvme_tcp_ofld_queue {
 	/* Offload device associated to this queue */
 	struct nvme_tcp_ofld_dev *dev;
 	struct nvme_tcp_ofld_ctrl *ctrl;
+	unsigned long flags;
 
 	/* Vendor specific driver context */
 	void *private_data;
-- 
2.22.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

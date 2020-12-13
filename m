Return-Path: <SRS0=ZzGD=FR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05046C4361B
	for <linux-nvme@archiver.kernel.org>; Sun, 13 Dec 2020 19:14:41 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 931C0224DE
	for <linux-nvme@archiver.kernel.org>; Sun, 13 Dec 2020 19:14:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 931C0224DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=marvell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-ID:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=d4YQDj97/csvsat8xWjm9vAO3e67ABpKl7zvgB6S77w=; b=2OgPm+ocEFolD5WIi7RjcINx8
	rJRuRyi/SR8QUKHT98/yqlwCakHjqRUI9rflkrF/fsOeDSxe0tHIL4SMO8T/a+cDsDcdWBiWTqnIh
	gl4oT5qPtZHvy1Cg1dz2NAiSO1/iT9T/lkXKDUiD7eeGPHX3slk61n3kCi0SiQ8ByNwrqAbdKQnUW
	JFrOAD95WRYq7kso8VmUurku0lSBA4rMRjW+6MqwQioCf2R2mj84nNlNZ8qXJerxogcq7xPSZhnBG
	7JzwLNbNdABpzanqNw6EjnXgVggP5iRsni5BL3G7AXWcmPZtY7sLuquj8fl0jZZQcZQcUZqK6rG34
	q331ECtbA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1koWpJ-0004of-EW; Sun, 13 Dec 2020 19:14:37 +0000
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]
 helo=mx0b-0016f401.pphosted.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1koWpF-0004mt-L7
 for linux-nvme@lists.infradead.org; Sun, 13 Dec 2020 19:14:34 +0000
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 0BDJBWhu010924; Sun, 13 Dec 2020 11:14:25 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=Ik+PwFNXZyqYvrEeW3YEwIPFEtSXksbPzdn4r6HvmNw=;
 b=TXJwBgDDNkHq+PbqURPORtsoBlyfn8mFUvAIbf3oxgA2YqCGQ8uU/aLCykoEs+3CprkR
 TpsVAeRnpop/i/YbLlbzIWCaWfbAOohSwYTLTOmwco9rPUc3EMVlqqvmwVZNQ+koqZoB
 /x7pnzLMi3nSj9Mn3aKo1sFK6SoTK+50wuzew0CblLQrC4BhC4xCMCh+vBs9uCFn8xSS
 uiZlC3JIE2XEhHsHUAoX7e3qmD1LLgUaz5ValJ8FSiGfDot2JuEsCAJK1ydQpwka0aqn
 5272OR8lrwOslselQr8PRmAbG0/HIpWjjDjPeavCkUAnh5OovyudBdmISCOlyflYSF11 5g== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
 by mx0a-0016f401.pphosted.com with ESMTP id 35cv3stjkb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
 Sun, 13 Dec 2020 11:14:25 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Sun, 13 Dec 2020 11:14:24 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sun, 13 Dec 2020 11:14:24 -0800
Received: from lbtlvb-pcie154.il.qlogic.org (unknown [10.5.220.141])
 by maili.marvell.com (Postfix) with ESMTP id 5EE533F703F;
 Sun, 13 Dec 2020 11:14:21 -0800 (PST)
From: Shai Malin <smalin@marvell.com>
To: <linux-nvme@lists.infradead.org>, <sagi@grimberg.me>,
 <Erik.Smith@dell.com>, <Douglas.Farley@dell.com>, <liuw@vmware.com>
Subject: [RFC PATCH v2 4/7] nvme-tcp-offload: Add controller level
 implementation
Date: Sun, 13 Dec 2020 21:13:58 +0200
Message-ID: <20201213191401.22734-5-smalin@marvell.com>
X-Mailer: git-send-email 2.16.6
In-Reply-To: <20201213191401.22734-1-smalin@marvell.com>
References: <20201213191401.22734-1-smalin@marvell.com>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343, 18.0.737
 definitions=2020-12-13_06:2020-12-11,
 2020-12-13 signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201213_141433_905360_B814B473 
X-CRM114-Status: GOOD (  26.22  )
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

From: Arie Gershberg <agershberg@marvell.com>

In this patch we implement controller level functionality including:
- create_ctrl.
- delete_ctrl.
- free_ctrl.

The implementation is similar to other nvme fabrics modules, the main
difference being that the nvme-tcp-offload ULP calls the vendor specific
claim_dev() op with the given TCP/IP parameters to determine which device
will be used for this controller.
Once found, the vendor specific device and controller will be paired and
kept in a controller list managed by the ULP.

Signed-off-by: Arie Gershberg <agershberg@marvell.com>
Signed-off-by: Shai Malin <smalin@marvell.com>
Signed-off-by: Ariel Elior <aelior@marvell.com>
Signed-off-by: Michal Kalderon <mkalderon@marvell.com>
---
 drivers/nvme/host/tcp-offload.c | 437 +++++++++++++++++++++++++++++++-
 drivers/nvme/host/tcp-offload.h |   1 +
 2 files changed, 432 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/tcp-offload.c b/drivers/nvme/host/tcp-offload.c
index 6285f82cb948..0d25903d6832 100644
--- a/drivers/nvme/host/tcp-offload.c
+++ b/drivers/nvme/host/tcp-offload.c
@@ -12,6 +12,10 @@
 
 static LIST_HEAD(nvme_tcp_ofld_devices);
 static DECLARE_RWSEM(nvme_tcp_ofld_devices_rwsem);
+static LIST_HEAD(nvme_tcp_ofld_ctrl_list);
+static DECLARE_RWSEM(nvme_tcp_ofld_ctrl_rwsem);
+static struct blk_mq_ops nvme_tcp_ofld_admin_mq_ops;
+static struct blk_mq_ops nvme_tcp_ofld_mq_ops;
 
 static inline struct nvme_tcp_ofld_ctrl *
 to_tcp_ofld_ctrl(struct nvme_ctrl *nctrl)
@@ -127,13 +131,367 @@ nvme_tcp_ofld_lookup_dev(struct nvme_tcp_ofld_ctrl *ctrl)
 	return dev;
 }
 
+static struct blk_mq_tag_set *
+nvme_tcp_ofld_alloc_tagset(struct nvme_ctrl *nctrl, bool admin)
+{
+	struct nvme_tcp_ofld_ctrl *ctrl = to_tcp_ofld_ctrl(nctrl);
+	struct blk_mq_tag_set *set;
+	int rc;
+
+	if (admin) {
+		set = &ctrl->admin_tag_set;
+		memset(set, 0, sizeof(*set));
+		set->ops = &nvme_tcp_ofld_admin_mq_ops;
+		set->queue_depth = NVME_AQ_MQ_TAG_DEPTH;
+		set->reserved_tags = 2; /* connect + keep-alive */
+		set->numa_node = nctrl->numa_node;
+		set->flags = BLK_MQ_F_BLOCKING;
+		set->cmd_size = sizeof(struct nvme_tcp_ofld_req);
+		set->driver_data = ctrl;
+		set->nr_hw_queues = 1;
+		set->timeout = NVME_ADMIN_TIMEOUT;
+	} else {
+		set = &ctrl->tag_set;
+		memset(set, 0, sizeof(*set));
+		set->ops = &nvme_tcp_ofld_mq_ops;
+		set->queue_depth = nctrl->sqsize + 1;
+		set->reserved_tags = 1; /* fabric connect */
+		set->numa_node = nctrl->numa_node;
+		set->flags = BLK_MQ_F_SHOULD_MERGE | BLK_MQ_F_BLOCKING;
+		set->cmd_size = sizeof(struct nvme_tcp_ofld_req);
+		set->driver_data = ctrl;
+		set->nr_hw_queues = nctrl->queue_count - 1;
+		set->timeout = NVME_IO_TIMEOUT;
+		set->nr_maps = nctrl->opts->nr_poll_queues ?
+							HCTX_MAX_TYPES : 2;
+	}
+
+	rc = blk_mq_alloc_tag_set(set);
+	if (rc)
+		return ERR_PTR(rc);
+
+	return set;
+}
+
+static int nvme_tcp_ofld_start_queue(struct nvme_ctrl *nctrl, int qid)
+{
+	/* Placeholder - start_queue */
+	return 0;
+}
+
+static int nvme_tcp_ofld_configure_admin_queue(struct nvme_ctrl *nctrl,
+					       bool new)
+{
+	int rc;
+
+	/* Placeholder - alloc_admin_queue */
+	if (new) {
+		nctrl->admin_tagset =
+				nvme_tcp_ofld_alloc_tagset(nctrl, true);
+		if (IS_ERR(nctrl->admin_tagset)) {
+			rc = PTR_ERR(nctrl->admin_tagset);
+			nctrl->admin_tagset = NULL;
+			goto out_free_queue;
+		}
+
+		nctrl->fabrics_q = blk_mq_init_queue(nctrl->admin_tagset);
+		if (IS_ERR(nctrl->fabrics_q)) {
+			rc = PTR_ERR(nctrl->fabrics_q);
+			nctrl->fabrics_q = NULL;
+			goto out_free_tagset;
+		}
+
+		nctrl->admin_q = blk_mq_init_queue(nctrl->admin_tagset);
+		if (IS_ERR(nctrl->admin_q)) {
+			rc = PTR_ERR(nctrl->admin_q);
+			nctrl->admin_q = NULL;
+			goto out_cleanup_fabrics_q;
+		}
+	}
+
+	rc = nvme_tcp_ofld_start_queue(nctrl, 0);
+	if (rc)
+		goto out_cleanup_queue;
+
+	rc = nvme_enable_ctrl(nctrl);
+	if (rc)
+		goto out_stop_queue;
+
+	blk_mq_unquiesce_queue(nctrl->admin_q);
+
+	rc = nvme_init_identify(nctrl);
+	if (rc)
+		goto out_stop_queue;
+
+	return 0;
+
+out_stop_queue:
+	/* Placeholder - stop admin queue */
+out_cleanup_queue:
+	if (new)
+		blk_cleanup_queue(nctrl->admin_q);
+out_cleanup_fabrics_q:
+	if (new)
+		blk_cleanup_queue(nctrl->fabrics_q);
+out_free_tagset:
+	if (new)
+		blk_mq_free_tag_set(nctrl->admin_tagset);
+out_free_queue:
+	/* Placeholder - free admin queue */
+
+	return rc;
+}
+
+static int
+nvme_tcp_ofld_configure_io_queues(struct nvme_ctrl *nctrl, bool new)
+{
+	int rc;
+
+	/* Placeholder - alloc_io_queues */
+
+	if (new) {
+		nctrl->tagset = nvme_tcp_ofld_alloc_tagset(nctrl, false);
+		if (IS_ERR(nctrl->tagset)) {
+			rc = PTR_ERR(nctrl->tagset);
+			nctrl->tagset = NULL;
+			goto out_free_io_queues;
+		}
+
+		nctrl->connect_q = blk_mq_init_queue(nctrl->tagset);
+		if (IS_ERR(nctrl->connect_q)) {
+			rc = PTR_ERR(nctrl->connect_q);
+			nctrl->connect_q = NULL;
+			goto out_free_tag_set;
+		}
+	}
+
+	/* Placeholder - start_io_queues */
+
+	if (!new) {
+		nvme_start_queues(nctrl);
+		nvme_wait_freeze(nctrl);
+		blk_mq_update_nr_hw_queues(nctrl->tagset,
+					   nctrl->queue_count - 1);
+		nvme_unfreeze(nctrl);
+	}
+
+	return 0;
+
+out_free_tag_set:
+	if (new)
+		blk_mq_free_tag_set(nctrl->tagset);
+out_free_io_queues:
+	/* Placeholder - free_io_queues */
+
+	return rc;
+}
+
 static int nvme_tcp_ofld_setup_ctrl(struct nvme_ctrl *nctrl, bool new)
 {
-	/* Placeholder - validates inputs and creates admin and IO queues */
+	struct nvmf_ctrl_options *opts = nctrl->opts;
+	int rc;
+
+	rc = nvme_tcp_ofld_configure_admin_queue(nctrl, new);
+	if (rc)
+		goto destroy_admin;
+
+	if (nctrl->icdoff) {
+		dev_err(nctrl->device, "icdoff is not supported!\n");
+		rc = -EINVAL;
+		goto destroy_admin;
+	}
+
+	if (opts->queue_size > nctrl->sqsize + 1)
+		dev_warn(nctrl->device,
+			 "queue_size %zu > ctrl sqsize %u, clamping down\n",
+			 opts->queue_size, nctrl->sqsize + 1);
+
+	if (nctrl->sqsize + 1 > nctrl->maxcmd) {
+		dev_warn(nctrl->device,
+			 "sqsize %u > ctrl maxcmd %u, clamping down\n",
+			 nctrl->sqsize + 1, nctrl->maxcmd);
+		nctrl->sqsize = nctrl->maxcmd - 1;
+	}
+
+	if (nctrl->queue_count > 1) {
+		rc = nvme_tcp_ofld_configure_io_queues(nctrl, new);
+		if (rc)
+			goto destroy_admin;
+	}
+
+	if (!nvme_change_ctrl_state(nctrl, NVME_CTRL_LIVE)) {
+		/*
+		 * state change failure is ok if we started ctrl delete,
+		 * unless we're during creation of a new controller to
+		 * avoid races with teardown flow.
+		 */
+		WARN_ON_ONCE(nctrl->state != NVME_CTRL_DELETING &&
+			     nctrl->state != NVME_CTRL_DELETING_NOIO);
+		WARN_ON_ONCE(new);
+		rc = -EINVAL;
+		goto destroy_io;
+	}
+
+	nvme_start_ctrl(nctrl);
+	return 0;
+
+destroy_io:
+	/* Placeholder - stop and destroy io queues*/
+destroy_admin:
+	/* Placeholder - stop and destroy admin queue*/
+
+	return rc;
+}
+
+static int
+nvme_tcp_ofld_check_dev_opts(struct nvmf_ctrl_options *opts,
+			     struct nvme_tcp_ofld_ops *ofld_ops)
+{
+	unsigned int nvme_tcp_ofld_opt_mask = NVMF_ALLOWED_OPTS |
+			ofld_ops->allowed_opts | ofld_ops->required_opts;
+	if (opts->mask & ~nvme_tcp_ofld_opt_mask) {
+		pr_warn("One or more of the nvmf options isn't supported by %s.\n",
+			ofld_ops->name);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static void nvme_tcp_ofld_free_ctrl(struct nvme_ctrl *nctrl)
+{
+	struct nvme_tcp_ofld_ctrl *ctrl = to_tcp_ofld_ctrl(nctrl);
+	struct nvme_tcp_ofld_dev *dev = ctrl->dev;
+
+	if (list_empty(&ctrl->list))
+		goto free_ctrl;
+
+	down_write(&nvme_tcp_ofld_ctrl_rwsem);
+	list_del(&ctrl->list);
+	up_write(&nvme_tcp_ofld_ctrl_rwsem);
+
+	nvmf_free_options(nctrl->opts);
+free_ctrl:
+	module_put(dev->ops->module);
+	kfree(ctrl->queues);
+	kfree(ctrl);
+}
+
+static void nvme_tcp_ofld_submit_async_event(struct nvme_ctrl *arg)
+{
+	/* Placeholder - submit_async_event */
+}
+
+static void
+nvme_tcp_ofld_teardown_admin_queue(struct nvme_ctrl *ctrl, bool remove)
+{
+	/* Placeholder - teardown_admin_queue */
+}
+
+static void
+nvme_tcp_ofld_teardown_io_queues(struct nvme_ctrl *nctrl, bool remove)
+{
+	/* Placeholder - teardown_io_queues */
+}
+
+static void
+nvme_tcp_ofld_teardown_ctrl(struct nvme_ctrl *nctrl, bool shutdown)
+{
+	/* Placeholder - err_work and connect_work */
+	nvme_tcp_ofld_teardown_io_queues(nctrl, shutdown);
+	blk_mq_quiesce_queue(nctrl->admin_q);
+	if (shutdown)
+		nvme_shutdown_ctrl(nctrl);
+	else
+		nvme_disable_ctrl(nctrl);
+	nvme_tcp_ofld_teardown_admin_queue(nctrl, shutdown);
+}
+
+static void nvme_tcp_ofld_delete_ctrl(struct nvme_ctrl *nctrl)
+{
+	nvme_tcp_ofld_teardown_ctrl(nctrl, true);
+}
+
+static int
+nvme_tcp_ofld_init_request(struct blk_mq_tag_set *set,
+			   struct request *rq,
+			   unsigned int hctx_idx,
+			   unsigned int numa_node)
+{
+	struct nvme_tcp_ofld_req *req = blk_mq_rq_to_pdu(rq);
+	struct nvme_tcp_ofld_ctrl *ctrl = set->driver_data;
+
+	/* Placeholder - init request */
+
+	req->done = nvme_tcp_ofld_req_done;
+	ctrl->dev->ops->init_req(req);
 
 	return 0;
 }
 
+static blk_status_t
+nvme_tcp_ofld_queue_rq(struct blk_mq_hw_ctx *hctx,
+		       const struct blk_mq_queue_data *bd)
+{
+	struct nvme_tcp_ofld_req *req = blk_mq_rq_to_pdu(bd->rq);
+	struct nvme_tcp_ofld_queue *queue = hctx->driver_data;
+	struct nvme_tcp_ofld_ops *ops = queue->dev->ops;
+
+	/* Call nvme_setup_cmd(...) */
+
+	/* Call ops->map_sg(...) */
+
+	return BLK_STS_OK;
+}
+
+static struct blk_mq_ops nvme_tcp_ofld_mq_ops = {
+	.queue_rq	= nvme_tcp_ofld_queue_rq,
+	.init_request	= nvme_tcp_ofld_init_request,
+	/*
+	 * All additional ops will be also implemented and registered similar to
+	 * tcp.c
+	 */
+};
+
+static struct blk_mq_ops nvme_tcp_ofld_admin_mq_ops = {
+	.queue_rq	= nvme_tcp_ofld_queue_rq,
+	.init_request	= nvme_tcp_ofld_init_request,
+	/*
+	 * All additional ops will be also implemented and registered similar to
+	 * tcp.c
+	 */
+};
+
+static const struct nvme_ctrl_ops nvme_tcp_ofld_ctrl_ops = {
+	.name			= "tcp_offload",
+	.module			= THIS_MODULE,
+	.flags			= NVME_F_FABRICS,
+	.reg_read32		= nvmf_reg_read32,
+	.reg_read64		= nvmf_reg_read64,
+	.reg_write32		= nvmf_reg_write32,
+	.free_ctrl		= nvme_tcp_ofld_free_ctrl,
+	.submit_async_event	= nvme_tcp_ofld_submit_async_event,
+	.delete_ctrl		= nvme_tcp_ofld_delete_ctrl,
+	.get_address		= nvmf_get_address,
+};
+
+static bool
+nvme_tcp_ofld_existing_controller(struct nvmf_ctrl_options *opts)
+{
+	struct nvme_tcp_ofld_ctrl *ctrl;
+	bool found = false;
+
+	down_read(&nvme_tcp_ofld_ctrl_rwsem);
+	list_for_each_entry(ctrl, &nvme_tcp_ofld_ctrl_list, list) {
+		found = nvmf_ip_options_match(&ctrl->nctrl, opts);
+		if (found)
+			break;
+	}
+	up_read(&nvme_tcp_ofld_ctrl_rwsem);
+
+	return found;
+}
+
 static struct nvme_ctrl *
 nvme_tcp_ofld_create_ctrl(struct device *ndev, struct nvmf_ctrl_options *opts)
 {
@@ -147,10 +505,48 @@ nvme_tcp_ofld_create_ctrl(struct device *ndev, struct nvmf_ctrl_options *opts)
 	if (!ctrl)
 		return ERR_PTR(-ENOMEM);
 
-	/*
-	 * Init nvme_tcp_ofld_ctrl and nvme_ctrl params based on received
-	 * opts
-	 */
+	INIT_LIST_HEAD(&ctrl->list);
+	nctrl = &ctrl->nctrl;
+	nctrl->opts = opts;
+	nctrl->queue_count = opts->nr_io_queues + opts->nr_write_queues +
+			     opts->nr_poll_queues + 1;
+	nctrl->sqsize = opts->queue_size - 1;
+	nctrl->kato = opts->kato;
+	if (!(opts->mask & NVMF_OPT_TRSVCID)) {
+		opts->trsvcid =
+			kstrdup(__stringify(NVME_TCP_DISC_PORT), GFP_KERNEL);
+		if (!opts->trsvcid) {
+			rc = -ENOMEM;
+			goto out_free_ctrl;
+		}
+		opts->mask |= NVMF_OPT_TRSVCID;
+	}
+
+	rc = inet_pton_with_scope(&init_net, AF_UNSPEC, opts->traddr,
+				  opts->trsvcid,
+				  &ctrl->conn_params.remote_ip_addr);
+	if (rc) {
+		pr_err("malformed address passed: %s:%s\n",
+		       opts->traddr, opts->trsvcid);
+		goto out_free_ctrl;
+	}
+
+	if (opts->mask & NVMF_OPT_HOST_TRADDR) {
+		rc = inet_pton_with_scope(&init_net, AF_UNSPEC,
+					  opts->host_traddr, NULL,
+					  &ctrl->conn_params.local_ip_addr);
+		if (rc) {
+			pr_err("malformed src address passed: %s\n",
+			       opts->host_traddr);
+			goto out_free_ctrl;
+		}
+	}
+
+	if (!opts->duplicate_connect &&
+	    nvme_tcp_ofld_existing_controller(opts)) {
+		rc = -EALREADY;
+		goto out_free_ctrl;
+	}
 
 	/* Find device that can reach the dest addr */
 	dev = nvme_tcp_ofld_lookup_dev(ctrl);
@@ -161,6 +557,10 @@ nvme_tcp_ofld_create_ctrl(struct device *ndev, struct nvmf_ctrl_options *opts)
 		goto out_free_ctrl;
 	}
 
+	rc = nvme_tcp_ofld_check_dev_opts(opts, dev->ops);
+	if (rc)
+		goto out_module_put;
+
 	ctrl->dev = dev;
 	ctrl->queues = kcalloc(nctrl->queue_count,
 			       sizeof(struct nvme_tcp_ofld_queue),
@@ -177,12 +577,27 @@ nvme_tcp_ofld_create_ctrl(struct device *ndev, struct nvmf_ctrl_options *opts)
 		queue->report_err = nvme_tcp_ofld_report_queue_err;
 	}
 
-	/* Call nvme_init_ctrl */
+	rc = nvme_init_ctrl(nctrl, ndev, &nvme_tcp_ofld_ctrl_ops, 0);
+	if (rc)
+		goto out_free_queues;
+
+	if (!nvme_change_ctrl_state(nctrl, NVME_CTRL_CONNECTING)) {
+		WARN_ON_ONCE(1);
+		rc = -EINTR;
+		goto out_uninit_ctrl;
+	}
 
 	rc = nvme_tcp_ofld_setup_ctrl(nctrl, true);
 	if (rc)
 		goto out_uninit_ctrl;
 
+	dev_info(nctrl->device, "new ctrl: NQN \"%s\", addr %pISp\n",
+		 opts->subsysnqn, &ctrl->conn_params.remote_ip_addr);
+
+	down_write(&nvme_tcp_ofld_ctrl_rwsem);
+	list_add_tail(&ctrl->list, &nvme_tcp_ofld_ctrl_list);
+	up_write(&nvme_tcp_ofld_ctrl_rwsem);
+
 	return nctrl;
 
 out_uninit_ctrl:
@@ -192,6 +607,8 @@ nvme_tcp_ofld_create_ctrl(struct device *ndev, struct nvmf_ctrl_options *opts)
 		rc = -EIO;
 
 	return ERR_PTR(rc);
+out_free_queues:
+	kfree(ctrl->queues);
 out_module_put:
 	module_put(dev->ops->module);
 out_free_ctrl:
@@ -221,7 +638,15 @@ static int __init nvme_tcp_ofld_init_module(void)
 
 static void __exit nvme_tcp_ofld_cleanup_module(void)
 {
+	struct nvme_tcp_ofld_ctrl *ctrl;
+
 	nvmf_unregister_transport(&nvme_tcp_ofld_transport);
+
+	down_write(&nvme_tcp_ofld_ctrl_rwsem);
+	list_for_each_entry(ctrl, &nvme_tcp_ofld_ctrl_list, list)
+		nvme_delete_ctrl(&ctrl->nctrl);
+	up_write(&nvme_tcp_ofld_ctrl_rwsem);
+	flush_workqueue(nvme_delete_wq);
 }
 
 module_init(nvme_tcp_ofld_init_module);
diff --git a/drivers/nvme/host/tcp-offload.h b/drivers/nvme/host/tcp-offload.h
index 303e6aab8542..c8a93685fd2a 100644
--- a/drivers/nvme/host/tcp-offload.h
+++ b/drivers/nvme/host/tcp-offload.h
@@ -76,6 +76,7 @@ struct nvme_tcp_ofld_ctrl_con_params {
 /* Allocated by nvme_tcp_ofld */
 struct nvme_tcp_ofld_ctrl {
 	struct nvme_ctrl nctrl;
+	struct list_head list;
 	struct nvme_tcp_ofld_dev *dev;
 
 	/* admin and IO queues */
-- 
2.22.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

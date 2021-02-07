Return-Path: <SRS0=2jH7=HJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F394C433E6
	for <linux-nvme@archiver.kernel.org>; Sun,  7 Feb 2021 18:14:13 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17E0761606
	for <linux-nvme@archiver.kernel.org>; Sun,  7 Feb 2021 18:14:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17E0761606
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=marvell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-ID:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=38eXfNaCxBrAzpfX8DUsIl0g/Vb2ZkpQZ0S/vwWWMsM=; b=GNd0agRC0a2qSjafvuUgRk3iO
	3YOyGDNFU6XX9FGPnzFAmfM0sAcUQHKawFFzhrILk6/CTxxOfn0BOP4Q6vNHdgayzZwA+iIMdY3Ny
	xNLZYpcAIPoD178se5r2D7tCMQMavfqadoTwi1hCeWIEIOGWsTPsnT8sMYa3ZZiwvW7X2mXAj1BYR
	cwUst1pIWXK+Z6AV89HC3xMMxhXUsjLbRXnuwxf/o82sJL7n+ylndURZRCFMpcZyjUdbLe5PZPUX4
	X9Q8dHWPGDUXZ5jPSe4jEuqwvUfGcY1yhp3qveJo+g0X9koewJZVQWmrq3T5jl1rBVC0T+Lp7NaSE
	W7dELFDBg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l8oZT-0004yZ-CG; Sun, 07 Feb 2021 18:14:07 +0000
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l8oZJ-0004vB-4X
 for linux-nvme@lists.infradead.org; Sun, 07 Feb 2021 18:13:58 +0000
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 117I5cIq016215; Sun, 7 Feb 2021 10:13:52 -0800
Received: from dc5-exch01.marvell.com ([199.233.59.181])
 by mx0b-0016f401.pphosted.com with ESMTP id 36hugq2dn8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
 Sun, 07 Feb 2021 10:13:51 -0800
Received: from SC-EXCH03.marvell.com (10.93.176.83) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Sun, 7 Feb 2021 10:13:49 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Sun, 7 Feb 2021 10:13:49 -0800
Received: from lbtlvb-pcie154.il.qlogic.org (10.69.176.80) by
 DC5-EXCH02.marvell.com (10.69.176.39) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Sun, 7 Feb 2021 10:13:46 -0800
From: Shai Malin <smalin@marvell.com>
To: <netdev@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
 <sagi@grimberg.me>
Subject: [RFC PATCH v3 05/11] nvme-tcp-offload: Add controller level error
 recovery implementation
Date: Sun, 7 Feb 2021 20:13:18 +0200
Message-ID: <20210207181324.11429-6-smalin@marvell.com>
X-Mailer: git-send-email 2.16.6
In-Reply-To: <20210207181324.11429-1-smalin@marvell.com>
References: <20210207181324.11429-1-smalin@marvell.com>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369, 18.0.737
 definitions=2021-02-07_08:2021-02-05,
 2021-02-07 signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210207_131357_294454_CE25269E 
X-CRM114-Status: GOOD (  17.97  )
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
Cc: smalin@marvell.com, aelior@marvell.com,
 Arie Gershberg <agershberg@marvell.com>, mkalderon@marvell.com,
 nassa@marvell.com, malin1024@gmail.com, Douglas.Farley@dell.com,
 Erik.Smith@dell.com, kuba@kernel.org, pkushwaha@marvell.com,
 davem@davemloft.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Arie Gershberg <agershberg@marvell.com>

In this patch, we implement controller level error handling and recovery.
Upon an error discovered by the ULP or reset controller initiated by the
nvme-core (using reset_ctrl workqueue), the ULP will initiate a controller
recovery which includes teardown and re-connect of all queues.

Signed-off-by: Arie Gershberg <agershberg@marvell.com>
Signed-off-by: Michal Kalderon <mkalderon@marvell.com>
Signed-off-by: Ariel Elior <aelior@marvell.com>
Signed-off-by: Shai Malin <smalin@marvell.com>
---
 drivers/nvme/host/tcp-offload.c | 121 +++++++++++++++++++++++++++++++-
 drivers/nvme/host/tcp-offload.h |  10 +++
 2 files changed, 130 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp-offload.c b/drivers/nvme/host/tcp-offload.c
index da934c6fed9e..e3759c281927 100644
--- a/drivers/nvme/host/tcp-offload.c
+++ b/drivers/nvme/host/tcp-offload.c
@@ -73,6 +73,23 @@ void nvme_tcp_ofld_unregister_dev(struct nvme_tcp_ofld_dev *dev)
 }
 EXPORT_SYMBOL_GPL(nvme_tcp_ofld_unregister_dev);
 
+/**
+ * nvme_tcp_ofld_error_recovery() - NVMeTCP Offload Library error recovery.
+ * function.
+ * @nctrl:	NVMe controller instance to change to resetting.
+ *
+ * API function that change the controller state to resseting.
+ * Part of the overall controller reset sequence.
+ */
+void nvme_tcp_ofld_error_recovery(struct nvme_ctrl *nctrl)
+{
+	if (!nvme_change_ctrl_state(nctrl, NVME_CTRL_RESETTING))
+		return;
+
+	queue_work(nvme_reset_wq, &to_tcp_ofld_ctrl(nctrl)->err_work);
+}
+EXPORT_SYMBOL_GPL(nvme_tcp_ofld_error_recovery);
+
 /**
  * nvme_tcp_ofld_report_queue_err() - NVMeTCP Offload report error event
  * callback function. Pointed to by nvme_tcp_ofld_queue->report_err.
@@ -291,6 +308,27 @@ nvme_tcp_ofld_configure_io_queues(struct nvme_ctrl *nctrl, bool new)
 	return rc;
 }
 
+static void nvme_tcp_ofld_reconnect_or_remove(struct nvme_ctrl *nctrl)
+{
+	/* If we are resetting/deleting then do nothing */
+	if (nctrl->state != NVME_CTRL_CONNECTING) {
+		WARN_ON_ONCE(nctrl->state == NVME_CTRL_NEW ||
+			     nctrl->state == NVME_CTRL_LIVE);
+		return;
+	}
+
+	if (nvmf_should_reconnect(nctrl)) {
+		dev_info(nctrl->device, "Reconnecting in %d seconds...\n",
+			 nctrl->opts->reconnect_delay);
+		queue_delayed_work(nvme_wq,
+				   &to_tcp_ofld_ctrl(nctrl)->connect_work,
+				   nctrl->opts->reconnect_delay * HZ);
+	} else {
+		dev_info(nctrl->device, "Removing controller...\n");
+		nvme_delete_ctrl(nctrl);
+	}
+}
+
 static int nvme_tcp_ofld_setup_ctrl(struct nvme_ctrl *nctrl, bool new)
 {
 	struct nvmf_ctrl_options *opts = nctrl->opts;
@@ -399,10 +437,62 @@ nvme_tcp_ofld_teardown_io_queues(struct nvme_ctrl *nctrl, bool remove)
 	/* Placeholder - teardown_io_queues */
 }
 
+static void nvme_tcp_ofld_reconnect_ctrl_work(struct work_struct *work)
+{
+	struct nvme_tcp_ofld_ctrl *ctrl =
+				container_of(to_delayed_work(work),
+					     struct nvme_tcp_ofld_ctrl,
+					     connect_work);
+	struct nvme_ctrl *nctrl = &ctrl->nctrl;
+
+	++nctrl->nr_reconnects;
+
+	if (nvme_tcp_ofld_setup_ctrl(nctrl, false))
+		goto requeue;
+
+	dev_info(nctrl->device, "Successfully reconnected (%d attempt)\n",
+		 nctrl->nr_reconnects);
+
+	nctrl->nr_reconnects = 0;
+
+	return;
+
+requeue:
+	dev_info(nctrl->device, "Failed reconnect attempt %d\n",
+		 nctrl->nr_reconnects);
+	nvme_tcp_ofld_reconnect_or_remove(nctrl);
+}
+
+static void nvme_tcp_ofld_error_recovery_work(struct work_struct *work)
+{
+	struct nvme_tcp_ofld_ctrl *ctrl =
+		container_of(work, struct nvme_tcp_ofld_ctrl, err_work);
+	struct nvme_ctrl *nctrl = &ctrl->nctrl;
+
+	nvme_stop_keep_alive(nctrl);
+	nvme_tcp_ofld_teardown_io_queues(nctrl, false);
+	/* unquiesce to fail fast pending requests */
+	nvme_start_queues(nctrl);
+	nvme_tcp_ofld_teardown_admin_queue(nctrl, false);
+	blk_mq_unquiesce_queue(nctrl->admin_q);
+
+	if (!nvme_change_ctrl_state(nctrl, NVME_CTRL_CONNECTING)) {
+		/* state change failure is ok if we started nctrl delete */
+		WARN_ON_ONCE(nctrl->state != NVME_CTRL_DELETING &&
+			     nctrl->state != NVME_CTRL_DELETING_NOIO);
+		return;
+	}
+
+	nvme_tcp_ofld_reconnect_or_remove(nctrl);
+}
+
 static void
 nvme_tcp_ofld_teardown_ctrl(struct nvme_ctrl *nctrl, bool shutdown)
 {
-	/* Placeholder - err_work and connect_work */
+	struct nvme_tcp_ofld_ctrl *ctrl = to_tcp_ofld_ctrl(nctrl);
+
+	cancel_work_sync(&ctrl->err_work);
+	cancel_delayed_work_sync(&ctrl->connect_work);
 	nvme_tcp_ofld_teardown_io_queues(nctrl, shutdown);
 	blk_mq_quiesce_queue(nctrl->admin_q);
 	if (shutdown)
@@ -417,6 +507,31 @@ static void nvme_tcp_ofld_delete_ctrl(struct nvme_ctrl *nctrl)
 	nvme_tcp_ofld_teardown_ctrl(nctrl, true);
 }
 
+static void nvme_tcp_ofld_reset_ctrl_work(struct work_struct *work)
+{
+	struct nvme_ctrl *nctrl =
+		container_of(work, struct nvme_ctrl, reset_work);
+
+	nvme_stop_ctrl(nctrl);
+	nvme_tcp_ofld_teardown_ctrl(nctrl, false);
+
+	if (!nvme_change_ctrl_state(nctrl, NVME_CTRL_CONNECTING)) {
+		/* state change failure is ok if we started ctrl delete */
+		WARN_ON_ONCE(nctrl->state != NVME_CTRL_DELETING &&
+			     nctrl->state != NVME_CTRL_DELETING_NOIO);
+		return;
+	}
+
+	if (nvme_tcp_ofld_setup_ctrl(nctrl, false))
+		goto out_fail;
+
+	return;
+
+out_fail:
+	++nctrl->nr_reconnects;
+	nvme_tcp_ofld_reconnect_or_remove(nctrl);
+}
+
 static int
 nvme_tcp_ofld_init_request(struct blk_mq_tag_set *set,
 			   struct request *rq,
@@ -513,6 +628,10 @@ nvme_tcp_ofld_create_ctrl(struct device *ndev, struct nvmf_ctrl_options *opts)
 			     opts->nr_poll_queues + 1;
 	nctrl->sqsize = opts->queue_size - 1;
 	nctrl->kato = opts->kato;
+	INIT_DELAYED_WORK(&ctrl->connect_work,
+			  nvme_tcp_ofld_reconnect_ctrl_work);
+	INIT_WORK(&ctrl->err_work, nvme_tcp_ofld_error_recovery_work);
+	INIT_WORK(&nctrl->reset_work, nvme_tcp_ofld_reset_ctrl_work);
 	if (!(opts->mask & NVMF_OPT_TRSVCID)) {
 		opts->trsvcid =
 			kstrdup(__stringify(NVME_TCP_DISC_PORT), GFP_KERNEL);
diff --git a/drivers/nvme/host/tcp-offload.h b/drivers/nvme/host/tcp-offload.h
index a9bcd4f7d150..0fb212f9193a 100644
--- a/drivers/nvme/host/tcp-offload.h
+++ b/drivers/nvme/host/tcp-offload.h
@@ -84,6 +84,15 @@ struct nvme_tcp_ofld_ctrl {
 	struct blk_mq_tag_set admin_tag_set;
 	struct nvme_tcp_ofld_queue *queues;
 
+	struct work_struct err_work;
+	struct delayed_work connect_work;
+
+	/*
+	 * Each entry in the array indicates the number of queues of
+	 * corresponding type.
+	 */
+	u32 queue_type_mapping[HCTX_MAX_TYPES];
+
 	/* Connectivity params */
 	struct nvme_tcp_ofld_ctrl_con_params conn_params;
 
@@ -166,3 +175,4 @@ struct nvme_tcp_ofld_ops {
 /* Exported functions for lower vendor specific offload drivers */
 int nvme_tcp_ofld_register_dev(struct nvme_tcp_ofld_dev *dev);
 void nvme_tcp_ofld_unregister_dev(struct nvme_tcp_ofld_dev *dev);
+void nvme_tcp_ofld_error_recovery(struct nvme_ctrl *nctrl);
-- 
2.22.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

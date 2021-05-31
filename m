Return-Path: <SRS0=adoP=K2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDF31C47080
	for <linux-nvme@archiver.kernel.org>; Mon, 31 May 2021 22:55:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A87AE61186
	for <linux-nvme@archiver.kernel.org>; Mon, 31 May 2021 22:55:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A87AE61186
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=marvell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=J256GaY75EcuDCqVbx5QyW+DCm4tgsJEMjDEvceKzYk=; b=NWo0s8+39Deojf
	qKaaX3JqZOSZuVyAFMLKGc/rrBoP/bSv/CP4z05eVIYMbetuNE4C46hwikALAorQuqSCoCC1YxzMd
	mkCvDhRhk4M7XGT6HIRFgLh3LwiIV+GIV1yDicCtlC65D8NP5BtLYb5fuHy+EHStYcslRW3d4TaEY
	0E1K7n+/p0llw+UqXfCkrFj04QL+l4m0x0h5dUPRZWywSvJFDMwV6us8t65yzSN0O7yTlYca6wM9Z
	QiTHioaY6EUZDID7/aKFyPROUTp062V0kcehlVZdkv9b184OwRDyEGGJg/rRq6b7Ci1VHTS7Q7wq3
	KOE03lDpyPX/rsf07vmg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lnqoc-00Dhom-TM; Mon, 31 May 2021 22:55:22 +0000
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lnqnT-00DhTK-PH
 for linux-nvme@lists.infradead.org; Mon, 31 May 2021 22:54:13 +0000
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 14VMpTwg002182; Mon, 31 May 2021 15:54:05 -0700
Received: from dc5-exch01.marvell.com ([199.233.59.181])
 by mx0b-0016f401.pphosted.com with ESMTP id 38vtnja4n1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
 Mon, 31 May 2021 15:54:05 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Mon, 31 May 2021 15:54:03 -0700
Received: from lbtlvb-pcie154.il.qlogic.org (10.69.176.80) by
 DC5-EXCH02.marvell.com (10.69.176.39) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Mon, 31 May 2021 15:54:00 -0700
From: Shai Malin <smalin@marvell.com>
To: <netdev@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
 <davem@davemloft.net>, <kuba@kernel.org>, <sagi@grimberg.me>,
 <hch@lst.de>, <axboe@fb.com>, <kbusch@kernel.org>
CC: <aelior@marvell.com>, <mkalderon@marvell.com>, <okulkarni@marvell.com>,
 <pkushwaha@marvell.com>, <prabhakar.pkin@gmail.com>,
 <malin1024@gmail.com>, <smalin@marvell.com>,
 Arie Gershberg <agershberg@marvell.com>
Subject: [RFC PATCH v7 06/27] nvme-tcp-offload: Add controller level error
 recovery implementation
Date: Tue, 1 Jun 2021 01:52:01 +0300
Message-ID: <20210531225222.16992-7-smalin@marvell.com>
X-Mailer: git-send-email 2.16.6
In-Reply-To: <20210531225222.16992-1-smalin@marvell.com>
References: <20210531225222.16992-1-smalin@marvell.com>
MIME-Version: 1.0
X-Proofpoint-GUID: N1SpPen2S2ysjuDNgnlU50wT7UoS-M0T
X-Proofpoint-ORIG-GUID: N1SpPen2S2ysjuDNgnlU50wT7UoS-M0T
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391, 18.0.761
 definitions=2021-05-31_15:2021-05-31,
 2021-05-31 signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210531_155411_989399_950EFD58 
X-CRM114-Status: GOOD (  18.63  )
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

From: Arie Gershberg <agershberg@marvell.com>

In this patch, we implement controller level error handling and recovery.
Upon an error discovered by the ULP or reset controller initiated by the
nvme-core (using reset_ctrl workqueue), the ULP will initiate a controller
recovery which includes teardown and re-connect of all queues.

Acked-by: Igor Russkikh <irusskikh@marvell.com>
Signed-off-by: Arie Gershberg <agershberg@marvell.com>
Signed-off-by: Prabhakar Kushwaha <pkushwaha@marvell.com>
Signed-off-by: Omkar Kulkarni <okulkarni@marvell.com>
Signed-off-by: Michal Kalderon <mkalderon@marvell.com>
Signed-off-by: Ariel Elior <aelior@marvell.com>
Signed-off-by: Shai Malin <smalin@marvell.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
---
 drivers/nvme/host/tcp-offload.c | 127 +++++++++++++++++++++++++++++++-
 drivers/nvme/host/tcp-offload.h |   1 +
 2 files changed, 126 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/tcp-offload.c b/drivers/nvme/host/tcp-offload.c
index d05dec9c0add..97c1fd33adb9 100644
--- a/drivers/nvme/host/tcp-offload.c
+++ b/drivers/nvme/host/tcp-offload.c
@@ -72,6 +72,23 @@ void nvme_tcp_ofld_unregister_dev(struct nvme_tcp_ofld_dev *dev)
 }
 EXPORT_SYMBOL_GPL(nvme_tcp_ofld_unregister_dev);
 
+/**
+ * nvme_tcp_ofld_error_recovery() - NVMeTCP Offload library error recovery.
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
@@ -82,7 +99,8 @@ EXPORT_SYMBOL_GPL(nvme_tcp_ofld_unregister_dev);
  */
 int nvme_tcp_ofld_report_queue_err(struct nvme_tcp_ofld_queue *queue)
 {
-	/* Placeholder - invoke error recovery flow */
+	pr_err("nvme-tcp-offload queue error\n");
+	nvme_tcp_ofld_error_recovery(&queue->ctrl->nctrl);
 
 	return 0;
 }
@@ -287,6 +305,28 @@ nvme_tcp_ofld_configure_io_queues(struct nvme_ctrl *nctrl, bool new)
 	return rc;
 }
 
+static void nvme_tcp_ofld_reconnect_or_remove(struct nvme_ctrl *nctrl)
+{
+	/* If we are resetting/deleting then do nothing */
+	if (nctrl->state != NVME_CTRL_CONNECTING) {
+		WARN_ON_ONCE(nctrl->state == NVME_CTRL_NEW ||
+			     nctrl->state == NVME_CTRL_LIVE);
+
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
 	struct nvme_tcp_ofld_ctrl *ctrl = to_tcp_ofld_ctrl(nctrl);
@@ -410,10 +450,63 @@ nvme_tcp_ofld_teardown_io_queues(struct nvme_ctrl *nctrl, bool remove)
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
+
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
@@ -428,6 +521,32 @@ static void nvme_tcp_ofld_delete_ctrl(struct nvme_ctrl *nctrl)
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
+
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
@@ -521,6 +640,10 @@ nvme_tcp_ofld_create_ctrl(struct device *ndev, struct nvmf_ctrl_options *opts)
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
index 520a0ea6f4b8..4281d1dacc94 100644
--- a/drivers/nvme/host/tcp-offload.h
+++ b/drivers/nvme/host/tcp-offload.h
@@ -197,3 +197,4 @@ struct nvme_tcp_ofld_ops {
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

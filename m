Return-Path: <SRS0=ZzGD=FR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AE18C4361B
	for <linux-nvme@archiver.kernel.org>; Sun, 13 Dec 2020 19:14:46 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03B5F2395C
	for <linux-nvme@archiver.kernel.org>; Sun, 13 Dec 2020 19:14:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03B5F2395C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=marvell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-ID:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=I/lbTx/s56sAyc/YEauaax4VRdxOEXq9+42bO7YDT+M=; b=Xgi0JgDpIq41/voxLkY/6Wb/D
	MN3xDGdxsz7XMJShAX3oGlzECx1L+nd8zLEfjvvUiQYIFCU7V+nvkH2W7P8T+WXk8a0tw1YB1sMV+
	+OSO1QdUkRpuJsJyJJZBxyC7iyeLE/EQDCZ/lv3K7MoOSuG646yi74SaALx9pkMo/FtaWyph5+aMi
	AZsgROeTaxIG/OKrq2J9rNPqNJog5uAo+YGq9tGn6M5gx6ANMIU3eZh9rMDol7YtC0kSO4R3gEI0a
	tsnetsS7E3THG47UOzoGbaQjgri9zxeKBz1ZMw+x1qQyR4O4y74+WLY6t8qYyKEL1F2bxRdCGTRMp
	CIiv/qLPA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1koWpO-0004qC-Le; Sun, 13 Dec 2020 19:14:42 +0000
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1koWpM-0004pK-1V
 for linux-nvme@lists.infradead.org; Sun, 13 Dec 2020 19:14:41 +0000
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 0BDJAiE8032152; Sun, 13 Dec 2020 11:14:30 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=kq2fwSgw+SAfOs1hMjodXjGBZXDDzQdVm6olq76oe9E=;
 b=ExGW4aRrIu7uoRkJetV+e23V4mNqmuPZ/fq8EF1IuatoZh0YWlScAZOFLEU+z3DBKUWS
 Aposscuy57FTJe3IQ49HNELMyyWGrVi+v7A6nf7Zo7aJ6kXwdrYc6lJH0Chz2USA8CmN
 myEe1Z3N2WlwIF2Z/7jd69CIHQVX0xbF4FA7iDhIvr1eP2Vq/fMXrH/c++MG8ohFiCoe
 OtQKqCdi3Q8NhhrtvScfNHgczp4gDNInTmjVKpfgVL4VtkN6OR/sVTAOtx9yH+oKkHsQ
 7weHBK/yX71bUYEcSI3OWbrMq8FtkJ5z0r+Xr4PY+mrZfBaqFtQbi1Kr8Mh3aBMx80l9 gw== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
 by mx0b-0016f401.pphosted.com with ESMTP id 35cx8t28em-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
 Sun, 13 Dec 2020 11:14:30 -0800
Received: from SC-EXCH04.marvell.com (10.93.176.84) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sun, 13 Dec
 2020 11:14:28 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Sun, 13 Dec 2020 11:14:28 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sun, 13 Dec 2020 11:14:28 -0800
Received: from lbtlvb-pcie154.il.qlogic.org (unknown [10.5.220.141])
 by maili.marvell.com (Postfix) with ESMTP id 5557C3F703F;
 Sun, 13 Dec 2020 11:14:25 -0800 (PST)
From: Shai Malin <smalin@marvell.com>
To: <linux-nvme@lists.infradead.org>, <sagi@grimberg.me>,
 <Erik.Smith@dell.com>, <Douglas.Farley@dell.com>, <liuw@vmware.com>
Subject: [RFC PATCH v2 5/7] nvme-tcp-offload: Add controller level error
 recovery implementation
Date: Sun, 13 Dec 2020 21:13:59 +0200
Message-ID: <20201213191401.22734-6-smalin@marvell.com>
X-Mailer: git-send-email 2.16.6
In-Reply-To: <20201213191401.22734-1-smalin@marvell.com>
References: <20201213191401.22734-1-smalin@marvell.com>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343, 18.0.737
 definitions=2020-12-13_06:2020-12-11,
 2020-12-13 signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201213_141440_189083_93D90ABB 
X-CRM114-Status: GOOD (  22.70  )
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

In this patch, we implement controller level error handling and recovery.
Upon an error discovered by the ULP or reset controller initiated by the
nvme-core (using reset_ctrl workqueue), the ULP will initiate a controller
recovery which includes teardown and re-connect of all queues.

Signed-off-by: Arie Gershberg <agershberg@marvell.com>
Signed-off-by: Shai Malin <smalin@marvell.com>
Signed-off-by: Ariel Elior <aelior@marvell.com>
Signed-off-by: Michal Kalderon <mkalderon@marvell.com>
---
 drivers/nvme/host/tcp-offload.c | 121 +++++++++++++++++++++++++++++++-
 drivers/nvme/host/tcp-offload.h |   4 ++
 2 files changed, 124 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp-offload.c b/drivers/nvme/host/tcp-offload.c
index 0d25903d6832..d9da0fc5eb75 100644
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
@@ -286,6 +303,27 @@ nvme_tcp_ofld_configure_io_queues(struct nvme_ctrl *nctrl, bool new)
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
@@ -394,10 +432,62 @@ nvme_tcp_ofld_teardown_io_queues(struct nvme_ctrl *nctrl, bool remove)
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
@@ -412,6 +502,31 @@ static void nvme_tcp_ofld_delete_ctrl(struct nvme_ctrl *nctrl)
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
@@ -512,6 +627,10 @@ nvme_tcp_ofld_create_ctrl(struct device *ndev, struct nvmf_ctrl_options *opts)
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
index c8a93685fd2a..c3f74f700c6a 100644
--- a/drivers/nvme/host/tcp-offload.h
+++ b/drivers/nvme/host/tcp-offload.h
@@ -84,6 +84,9 @@ struct nvme_tcp_ofld_ctrl {
 	struct blk_mq_tag_set admin_tag_set;
 	struct nvme_tcp_ofld_queue *queues;
 
+	struct work_struct err_work;
+	struct delayed_work connect_work;
+
 	/*
 	 * Each entry in the array indicates the number of queues of
 	 * corresponding type.
@@ -172,3 +175,4 @@ struct nvme_tcp_ofld_ops {
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

Return-Path: <SRS0=xDof=EZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8F35C6369E
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Nov 2020 14:22:23 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6300B22226
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Nov 2020 14:22:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Yw4RH+Hj";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="gX69ItsQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6300B22226
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=marvell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-ID:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=wnqLCZ7WYvpwDsIplR5onLoreuH6IRQgEOgc0nIMOn4=; b=Yw4RH+HjKsysUAJ10Dadagw+r
	nppT/xGRUb5quTlir3BHFtHXfgmN9rQthDHZdmQ0noKPhDcUY2f/cTXyruWJSsTuu4hUImXwKw1MB
	0JPywlCYRknEHLUpQFXu0vYFY2bSE1Ca6Nq0N9mUVw/CDZoeoL0JHai58CUz2JGUNAxkt8u2gho7Y
	E9cTlBspY6seRqrKu0oCpahTdesJHRmRVgeik+VDhxtFdAOvqndwz9Wyt/a/bmKMunucgyYaI+CF7
	MU5yUmiIV4HKRpOsylcLrfx7A9O8yJBO14gzj60FRbw205emY3whL52OhfMaYMBy5gtOkMG1IoXVI
	gZ7gaLCUQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kfkpH-0004Nw-7I; Thu, 19 Nov 2020 14:22:19 +0000
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kfkoz-0004GV-Eb
 for linux-nvme@lists.infradead.org; Thu, 19 Nov 2020 14:22:10 +0000
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 0AJEJvhs007874; Thu, 19 Nov 2020 06:21:56 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=1ZUoeGEIxUW0yAH9m+40J681cGj6Xyr+aN4avy568y0=;
 b=gX69ItsQvYPdPb4yBv/xIII0PvdYJmfQj+Otnb4VTQEq5CVbwxbIXLP+8yJip2ej31ag
 r42ewJCUvZ8T8grIMlk6kVcyYWjHWS7hu1JH9cvz6lr+AY+biJxpLDttSQM0Xqw+v9UZ
 JrJZRywx2LriSVrC4p6/SIjUot1L0hL+kdx5yNnjEqq+i+q97vbQbq+pfHoS48M6x6sM
 MR8zNdOZ52SArsH91yJuMZyHF0QlGOHAhXVR3Uo8NWGKya61lYI8HO6WV7jFtiMPPg++
 IeRmbPOc/fcNWeHDfKXJDzoqQS8FeRSBa9XQYurGsNSwJ77gawJPIy5dMzNHLgQavJwE ew== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
 by mx0b-0016f401.pphosted.com with ESMTP id 34w7ncurgd-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
 Thu, 19 Nov 2020 06:21:56 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Thu, 19 Nov 2020 06:21:54 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 19 Nov 2020 06:21:54 -0800
Received: from lbtlvb-pcie154.il.qlogic.org (unknown [10.5.220.141])
 by maili.marvell.com (Postfix) with ESMTP id 732EB3F703F;
 Thu, 19 Nov 2020 06:21:51 -0800 (PST)
From: Shai Malin <smalin@marvell.com>
To: <linux-nvme@lists.infradead.org>, <sagi@grimberg.me>,
 <Erik.Smith@dell.com>, <Douglas.Farley@dell.com>, <liuw@vmware.com>
Subject: [PATCH 5/7] nvme-tcp-offload: Add controller level error recovery
 implementation
Date: Thu, 19 Nov 2020 16:21:05 +0200
Message-ID: <20201119142107.17429-6-smalin@marvell.com>
X-Mailer: git-send-email 2.16.6
In-Reply-To: <20201119142107.17429-1-smalin@marvell.com>
References: <20201119142107.17429-1-smalin@marvell.com>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312, 18.0.737
 definitions=2020-11-19_09:2020-11-19,
 2020-11-19 signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201119_092201_685861_F8DA9F27 
X-CRM114-Status: GOOD (  22.59  )
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
 drivers/nvme/host/tcp-offload.c | 113 +++++++++++++++++++++++++++++++-
 drivers/nvme/host/tcp-offload.h |   4 ++
 2 files changed, 116 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp-offload.c b/drivers/nvme/host/tcp-offload.c
index 4002354a8afe..74f708674345 100644
--- a/drivers/nvme/host/tcp-offload.c
+++ b/drivers/nvme/host/tcp-offload.c
@@ -72,6 +72,15 @@ void nvme_tcp_ofld_unregister_dev(struct nvme_tcp_ofld_dev *dev)
 }
 EXPORT_SYMBOL_GPL(nvme_tcp_ofld_unregister_dev);
 
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
@@ -282,6 +291,27 @@ nvme_tcp_ofld_configure_io_queues(struct nvme_ctrl *nctrl, bool new)
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
@@ -390,10 +420,62 @@ nvme_tcp_ofld_teardown_io_queues(struct nvme_ctrl *nctrl, bool remove)
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
@@ -408,6 +490,31 @@ static void nvme_tcp_ofld_delete_ctrl(struct nvme_ctrl *nctrl)
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
@@ -508,6 +615,10 @@ nvme_tcp_ofld_create_ctrl(struct device *ndev, struct nvmf_ctrl_options *opts)
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
index d465feeee957..d4eb62873de1 100644
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

Return-Path: <SRS0=ZzGD=FR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E76AC4167B
	for <linux-nvme@archiver.kernel.org>; Sun, 13 Dec 2020 19:14:37 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8293723406
	for <linux-nvme@archiver.kernel.org>; Sun, 13 Dec 2020 19:14:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8293723406
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=marvell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-ID:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=38RAdjttX4/R7k3x5etmJS2vKZ1BnWEDoSz9fifwwik=; b=zCUSqTI51rCKyHIyJIdBAdb1C
	T+zqINS8bhc7KQQOk9kWWki/MgGdTm9HUEvWHokatRoqSskmP6S4H/Sxete3Xh6MiPdxh2ayfPDFT
	O3C/UVvhLEnfAmLWFjWuSwr1HKDIajsZyC98JSHCgFK/Atyr3f3g26SN0jaeR6JYR7CYf4QPaqKk0
	DGvaT30dWetmD+GA6NbLTOOo4seMS+C2kFIr3o/Ll9NKq9/fVg+0ibHb3wGfB5fkYyWdtF3ctbfzw
	xUeqUzQxLyUDfRqFhQi7jXrD5TSezaUQVCFJQmCkqT1iK7e8wMkpPZV8h375/6lcD+c5g8nJ6C1wy
	aDL+hnO/w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1koWpE-0004mM-7B; Sun, 13 Dec 2020 19:14:32 +0000
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1koWpA-0004lN-Ah
 for linux-nvme@lists.infradead.org; Sun, 13 Dec 2020 19:14:29 +0000
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 0BDJA7Mj031517; Sun, 13 Dec 2020 11:14:23 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=p/jGqxDkSbo3hzlyfJPs4WNUuPQWPE7AiiN5iWvBG1M=;
 b=ZOLIAM73di+PLIOvl0qgM5ZfDjrTNa6ttxC1i1uHbas8JFnUDCBssS13p2FAgDlt/5ur
 0ij9/g+aB59fhteLY3qoiUhTQLK3Mz03hnsA3SzU7M80joJTjGod6+cGPHmUDufodM42
 w6sRQJ2kz91apdNqJGgC9+l1W9QuGuhinytcD1eindepnWXk/fKCzfRF1Kyw+1gCFyI0
 xsPOOawGcSVZvFuMIh6DB7qlvLR/cAuo390AtpyxFqM8Fq3Rfy/ajnX9S2DGAvmjFO8t
 ac0W2k86Q1bZFRSCgVWO4nBod3GUaiVtiEvAp5cak9/StY3ERxGn5CEOTk5UJX8xmSVG mA== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
 by mx0b-0016f401.pphosted.com with ESMTP id 35cx8t28ee-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
 Sun, 13 Dec 2020 11:14:22 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Sun, 13 Dec 2020 11:14:21 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Sun, 13 Dec 2020 11:14:20 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sun, 13 Dec 2020 11:14:20 -0800
Received: from lbtlvb-pcie154.il.qlogic.org (unknown [10.5.220.141])
 by maili.marvell.com (Postfix) with ESMTP id 607533F703F;
 Sun, 13 Dec 2020 11:14:17 -0800 (PST)
From: Shai Malin <smalin@marvell.com>
To: <linux-nvme@lists.infradead.org>, <sagi@grimberg.me>,
 <Erik.Smith@dell.com>, <Douglas.Farley@dell.com>, <liuw@vmware.com>
Subject: [RFC PATCH v2 3/7] nvme-tcp-offload: Add device scan implementation
Date: Sun, 13 Dec 2020 21:13:57 +0200
Message-ID: <20201213191401.22734-4-smalin@marvell.com>
X-Mailer: git-send-email 2.16.6
In-Reply-To: <20201213191401.22734-1-smalin@marvell.com>
References: <20201213191401.22734-1-smalin@marvell.com>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343, 18.0.737
 definitions=2020-12-13_06:2020-12-11,
 2020-12-13 signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201213_141428_511004_11BA2E79 
X-CRM114-Status: GOOD (  20.90  )
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

This patch implements the create_ctrl skeleton, specifcially to
demonstrate how the claim_dev op will be used.

The driver scans the registered devices and calls the claim_dev op on
each of them, to find the first devices that matches the connection
params. Once the correct devices is found (claim_dev returns true), we
raise the refcnt of that device and return that device as the device to
be used for ctrl currently being created.

Signed-off-by: Dean Balandin <dbalandin@marvell.com>
Signed-off-by: Shai Malin <smalin@marvell.com>
Signed-off-by: Ariel Elior <aelior@marvell.com>
Signed-off-by: Michal Kalderon <mkalderon@marvell.com>
---
 drivers/nvme/host/tcp-offload.c | 105 ++++++++++++++++++++++++++++++++
 1 file changed, 105 insertions(+)

diff --git a/drivers/nvme/host/tcp-offload.c b/drivers/nvme/host/tcp-offload.c
index 5e3e99b1273c..6285f82cb948 100644
--- a/drivers/nvme/host/tcp-offload.c
+++ b/drivers/nvme/host/tcp-offload.c
@@ -13,6 +13,12 @@
 static LIST_HEAD(nvme_tcp_ofld_devices);
 static DECLARE_RWSEM(nvme_tcp_ofld_devices_rwsem);
 
+static inline struct nvme_tcp_ofld_ctrl *
+to_tcp_ofld_ctrl(struct nvme_ctrl *nctrl)
+{
+	return container_of(nctrl, struct nvme_tcp_ofld_ctrl, nctrl);
+}
+
 /**
  * nvme_tcp_ofld_register_dev() - NVMeTCP Offload Library registration
  * function.
@@ -96,6 +102,104 @@ nvme_tcp_ofld_req_done(struct nvme_tcp_ofld_req *req,
 	/* Placeholder - complete request with/without error */
 }
 
+struct nvme_tcp_ofld_dev *
+nvme_tcp_ofld_lookup_dev(struct nvme_tcp_ofld_ctrl *ctrl)
+{
+	struct nvme_tcp_ofld_dev *dev;
+
+	down_read(&nvme_tcp_ofld_devices_rwsem);
+	list_for_each_entry(dev, &nvme_tcp_ofld_devices, entry) {
+		if (dev->ops->claim_dev(dev, &ctrl->conn_params)) {
+			/* Increase driver refcnt */
+			if (!try_module_get(dev->ops->module)) {
+				pr_err("try_module_get failed");
+				dev = NULL;
+			}
+
+			goto out;
+		}
+	}
+
+	dev = NULL;
+out:
+	up_read(&nvme_tcp_ofld_devices_rwsem);
+
+	return dev;
+}
+
+static int nvme_tcp_ofld_setup_ctrl(struct nvme_ctrl *nctrl, bool new)
+{
+	/* Placeholder - validates inputs and creates admin and IO queues */
+
+	return 0;
+}
+
+static struct nvme_ctrl *
+nvme_tcp_ofld_create_ctrl(struct device *ndev, struct nvmf_ctrl_options *opts)
+{
+	struct nvme_tcp_ofld_queue *queue;
+	struct nvme_tcp_ofld_ctrl *ctrl;
+	struct nvme_tcp_ofld_dev *dev;
+	struct nvme_ctrl *nctrl;
+	int i, rc = 0;
+
+	ctrl = kzalloc(sizeof(*ctrl), GFP_KERNEL);
+	if (!ctrl)
+		return ERR_PTR(-ENOMEM);
+
+	/*
+	 * Init nvme_tcp_ofld_ctrl and nvme_ctrl params based on received
+	 * opts
+	 */
+
+	/* Find device that can reach the dest addr */
+	dev = nvme_tcp_ofld_lookup_dev(ctrl);
+	if (!dev) {
+		pr_info("no device found for addr %s:%s.\n",
+			opts->traddr, opts->trsvcid);
+		rc = -EINVAL;
+		goto out_free_ctrl;
+	}
+
+	ctrl->dev = dev;
+	ctrl->queues = kcalloc(nctrl->queue_count,
+			       sizeof(struct nvme_tcp_ofld_queue),
+			       GFP_KERNEL);
+	if (!ctrl->queues) {
+		rc = -ENOMEM;
+		goto out_module_put;
+	}
+
+	for (i = 0; i < nctrl->queue_count; ++i) {
+		queue = &ctrl->queues[i];
+		queue->ctrl = ctrl;
+		queue->dev = dev;
+		queue->report_err = nvme_tcp_ofld_report_queue_err;
+	}
+
+	/* Call nvme_init_ctrl */
+
+	rc = nvme_tcp_ofld_setup_ctrl(nctrl, true);
+	if (rc)
+		goto out_uninit_ctrl;
+
+	return nctrl;
+
+out_uninit_ctrl:
+	nvme_uninit_ctrl(nctrl);
+	nvme_put_ctrl(nctrl);
+	if (rc > 0)
+		rc = -EIO;
+
+	return ERR_PTR(rc);
+out_module_put:
+	module_put(dev->ops->module);
+out_free_ctrl:
+	kfree(ctrl);
+
+	return ERR_PTR(rc);
+}
+
 static struct nvmf_transport_ops nvme_tcp_ofld_transport = {
 	.name		= "tcp_offload",
 	.module		= THIS_MODULE,
@@ -105,6 +209,7 @@ static struct nvmf_transport_ops nvme_tcp_ofld_transport = {
 			  NVMF_OPT_CTRL_LOSS_TMO | NVMF_OPT_RECONNECT_DELAY |
 			  NVMF_OPT_HDR_DIGEST | NVMF_OPT_DATA_DIGEST |
 			  NVMF_OPT_NR_POLL_QUEUES | NVMF_OPT_TOS,
+	.create_ctrl	= nvme_tcp_ofld_create_ctrl,
 };
 
 static int __init nvme_tcp_ofld_init_module(void)
-- 
2.22.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

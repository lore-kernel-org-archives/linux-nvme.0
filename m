Return-Path: <SRS0=xDof=EZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2B48C63798
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Nov 2020 14:22:04 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25DEC22256
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Nov 2020 14:22:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="2D1Eg1y9";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="NXBlMi1W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25DEC22256
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=marvell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-ID:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=XJDKMa+ymO/HySvP67tUj0uv+G+kgmcwrXaVScqr1A0=; b=2D1Eg1y9gfwOmCEKbiVGLhiET
	HuyEfVmT9AS54sdO9o+AOlOVOzyiVOCeCHREAcSimk8a9P12jDAyHs5hvA7o3QpG+arn3rw4ezjHQ
	SGEx9fHFfJ/hjDC0V3FhAgdlxw0+hOCRPDUk5UHTJQhp1mTirW+xVp/1mIyPWM3v1YIiNUrw+sYfu
	LiRTLkh8IGxfQ/FMPQNYRo8ueeQUgC6FIJaoq/9IrTygfkcHDh1ZC3uu5FCDroQ/zVlEVk7O+7aWH
	Zf2DWB+irwVEghiLChBJW5o0cSDxRs3cY9qqMXEzMPThhi1+M7GZEwqb4pNvCHibzzPwEKNiM9v1b
	4/iRHFBDQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kfkow-0004Fu-Bo; Thu, 19 Nov 2020 14:21:58 +0000
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]
 helo=mx0b-0016f401.pphosted.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kfkoq-0004DS-8b
 for linux-nvme@lists.infradead.org; Thu, 19 Nov 2020 14:21:53 +0000
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 0AJEEvL7030827; Thu, 19 Nov 2020 06:21:47 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=qo5RFbv+Yk42PKiD4jm90BYlihC1fItbCVNVk9EDbCM=;
 b=NXBlMi1W+RSB1IK2hnl7nYBuH+COqLI8mDZTwjdHAAY9n43leuV2xRl3l7jW6savyiCA
 0QhZ2Z4yWZVvt+UCSLu+UbiuYEyrod7/p2ZSQ+kZnhs6IzczwUPgp3twFHD7h+PclHc/
 QhxBNVZ9wQX/dvO1x/0vTIvvFljYdhUaRKJNBYY5C2qvcXtUdGKcGaClEGOqwcNGmi6j
 kn50lVHNZG3ERD6++gxrKTrP+hBQg2KexN+6E2ijifqOyW0/OcUv1Qe7JCyUKXHx9NmX
 pe8yw1TaDZ5vvBf5Hm17i5B9w77mkec1Wmax35r93Sn3f/5E4D+QpIB4B5kcEKOVSUi3 lQ== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
 by mx0a-0016f401.pphosted.com with ESMTP id 34vd2sj229-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
 Thu, 19 Nov 2020 06:21:47 -0800
Received: from SC-EXCH04.marvell.com (10.93.176.84) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 19 Nov
 2020 06:21:46 -0800
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Thu, 19 Nov 2020 06:21:45 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 19 Nov 2020 06:21:46 -0800
Received: from lbtlvb-pcie154.il.qlogic.org (unknown [10.5.220.141])
 by maili.marvell.com (Postfix) with ESMTP id 115E83F7040;
 Thu, 19 Nov 2020 06:21:42 -0800 (PST)
From: Shai Malin <smalin@marvell.com>
To: <linux-nvme@lists.infradead.org>, <sagi@grimberg.me>,
 <Erik.Smith@dell.com>, <Douglas.Farley@dell.com>, <liuw@vmware.com>
Subject: [PATCH 3/7] nvme-tcp-offload: Add device scan implementation
Date: Thu, 19 Nov 2020 16:21:03 +0200
Message-ID: <20201119142107.17429-4-smalin@marvell.com>
X-Mailer: git-send-email 2.16.6
In-Reply-To: <20201119142107.17429-1-smalin@marvell.com>
References: <20201119142107.17429-1-smalin@marvell.com>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312, 18.0.737
 definitions=2020-11-19_09:2020-11-19,
 2020-11-19 signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201119_092152_489785_5402D72D 
X-CRM114-Status: GOOD (  21.79  )
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

new
---
 drivers/nvme/host/tcp-offload.c | 105 ++++++++++++++++++++++++++++++++
 1 file changed, 105 insertions(+)

diff --git a/drivers/nvme/host/tcp-offload.c b/drivers/nvme/host/tcp-offload.c
index dfb25da7a564..f21cb2497ea7 100644
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
@@ -93,6 +99,104 @@ nvme_tcp_ofld_req_done(struct nvme_tcp_ofld_req *req,
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
@@ -102,6 +206,7 @@ static struct nvmf_transport_ops nvme_tcp_ofld_transport = {
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

Return-Path: <SRS0=2jH7=HJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E0B8C433E6
	for <linux-nvme@archiver.kernel.org>; Sun,  7 Feb 2021 18:14:06 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A5CA64D9C
	for <linux-nvme@archiver.kernel.org>; Sun,  7 Feb 2021 18:14:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A5CA64D9C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=marvell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-ID:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=RVZ+bWM0YRYh+bGLwSuriUwI1KS15RzAgkOI42KP7dg=; b=gWw81HELGshIfdf7+MgQUuHZu
	zTwqXbNJYCd6zVGOdF+ZBlOCcwWuT0Q/dfxWu9xO8ZX57WMwnQp4Z4ohUOf5jyEdv9ctW1if/xVxZ
	NZwuNnGOuOVrfL/1xJSN8K5Knv0Uv2lwdCvreJmdCobx15WF8SnKteNCW8ldKnHoB8G4XZAlHnmvU
	pGaifX+HtcbqVRKz/p2xQQgF7VZ3R2mkF003vwIX7/cGpNQHmUNyhb3U8bOC/d4dbSjrgeTfLBgnH
	tt/5N5rLtHTG6iv/c+D3yV6fAVwJ/REfpjvORY0Ww+70ZIU4OawWQUL2lbiKo6/3Bbgmx+bQOx5IC
	biYU3FTlQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l8oZH-0004uV-TO; Sun, 07 Feb 2021 18:13:55 +0000
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]
 helo=mx0b-0016f401.pphosted.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l8oZC-0004tD-Us
 for linux-nvme@lists.infradead.org; Sun, 07 Feb 2021 18:13:53 +0000
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 117I6xsC031068; Sun, 7 Feb 2021 10:13:43 -0800
Received: from dc5-exch02.marvell.com ([199.233.59.182])
 by mx0a-0016f401.pphosted.com with ESMTP id 36hsbrakm5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
 Sun, 07 Feb 2021 10:13:43 -0800
Received: from SC-EXCH03.marvell.com (10.93.176.83) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Sun, 7 Feb 2021 10:13:42 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Sun, 7 Feb 2021 10:13:41 -0800
Received: from lbtlvb-pcie154.il.qlogic.org (10.69.176.80) by
 DC5-EXCH02.marvell.com (10.69.176.39) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Sun, 7 Feb 2021 10:13:38 -0800
From: Shai Malin <smalin@marvell.com>
To: <netdev@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
 <sagi@grimberg.me>
Subject: [RFC PATCH v3 03/11] nvme-tcp-offload: Add device scan implementation
Date: Sun, 7 Feb 2021 20:13:16 +0200
Message-ID: <20210207181324.11429-4-smalin@marvell.com>
X-Mailer: git-send-email 2.16.6
In-Reply-To: <20210207181324.11429-1-smalin@marvell.com>
References: <20210207181324.11429-1-smalin@marvell.com>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369, 18.0.737
 definitions=2021-02-07_08:2021-02-05,
 2021-02-07 signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210207_131351_144144_6CE21439 
X-CRM114-Status: GOOD (  15.28  )
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
Cc: smalin@marvell.com, aelior@marvell.com, mkalderon@marvell.com,
 nassa@marvell.com, Dean Balandin <dbalandin@marvell.com>, malin1024@gmail.com,
 Douglas.Farley@dell.com, Erik.Smith@dell.com, kuba@kernel.org,
 pkushwaha@marvell.com, davem@davemloft.net
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
Signed-off-by: Michal Kalderon <mkalderon@marvell.com>
Signed-off-by: Ariel Elior <aelior@marvell.com>
Signed-off-by: Shai Malin <smalin@marvell.com>
---
 drivers/nvme/host/tcp-offload.c | 82 +++++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/drivers/nvme/host/tcp-offload.c b/drivers/nvme/host/tcp-offload.c
index ee3800250e47..49e11638b4fd 100644
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
@@ -96,6 +102,81 @@ nvme_tcp_ofld_req_done(struct nvme_tcp_ofld_req *req,
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
+				pr_err("try_module_get failed\n");
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
+	struct nvme_tcp_ofld_ctrl *ctrl;
+	struct nvme_tcp_ofld_dev *dev;
+	struct nvme_ctrl *nctrl;
+	int rc = 0;
+
+	ctrl = kzalloc(sizeof(*ctrl), GFP_KERNEL);
+	if (!ctrl)
+		return ERR_PTR(-ENOMEM);
+
+	/* Init nvme_tcp_ofld_ctrl and nvme_ctrl params based on received opts */
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
+
+	/* Init queues */
+
+	/* Call nvme_init_ctrl */
+
+	rc = nvme_tcp_ofld_setup_ctrl(nctrl, true);
+	if (rc)
+		goto out_module_put;
+
+	return nctrl;
+
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
@@ -105,6 +186,7 @@ static struct nvmf_transport_ops nvme_tcp_ofld_transport = {
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

Return-Path: <SRS0=q7uG=KO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92233C433ED
	for <linux-nvme@archiver.kernel.org>; Wed, 19 May 2021 11:15:46 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BCE6610A1
	for <linux-nvme@archiver.kernel.org>; Wed, 19 May 2021 11:15:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BCE6610A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=marvell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-ID:Date:
	Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=qqjQm9yzu5BoxjFb8O8wQntFPcc31YVrj4egH0pWrk4=; b=JizP19m4T256Vyo7hTr8Uw+pW
	sfCDupM/pyWI3WKQaeM6EtWrZFA1ywzpeQxZeoYZoG6XpL7k/wPV42oZLSZOqeWVRrJh3qRb5Z4fh
	5Ozam0K56Lv3OazD8EgTU5OiW9yurRfx1cg/4IZ2iKOXPo9tOFdl0mBBTFeP+5a3HX99aVsM1Mdkn
	6HxcmnKXkj56At4XqPUpR+jnRb0iW9YdLUAHP2QxFV+V/NfpGMBVUvqtO6z+mETPc02yP8GWqNyli
	DoT9nLCV2Td2pWR2dC38yeoH+Qu3j99ECYgpsoYASClQCVyZZg50hyvQ0TVhmgAgft2CoXgd2QU+i
	X6RkL3Syg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1ljKAW-003j53-1f; Wed, 19 May 2021 11:15:16 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ljKA7-003j22-6c
 for linux-nvme@desiato.infradead.org; Wed, 19 May 2021 11:14:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:CC:To:From:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=Gsln+n2pXwH6I1h7GT9fHqZlGPMAHQYY0ZN7kGT4y5A=; b=TQpiE7lZeOX+EK6kuV4/OoGr5d
 JEjcpwc9pj+1YQHodruxa4t6rd0Bc8EXq22FOO3HB6HM1dAivm7yBlAPVW9uXH98m5gHiukjwiebn
 sYiHs3q623GDcSdoGw8bgQGaLgrRfyKFgu0+Y6/+A47uOq5rDOxd6VJ/v2a3ErUjQ5r/G4+grKykk
 DzcoyaaTWRg0GS+j9nnUgfBAHZMZk07gPVkkEo4kZEgHcZA0E92ScdockHaNhTAZDomabqtxl/Fvi
 dbOXX43LKjeq1a3AeTy46WhNgMOouHCHjBoly4V7HssdS8Na7lA+q9xSShbN+FlWo6puyWBDIieko
 xOQsqoNA==;
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ljKA4-00FOMS-Eq
 for linux-nvme@lists.infradead.org; Wed, 19 May 2021 11:14:50 +0000
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 14JBAUKs007723; Wed, 19 May 2021 04:14:43 -0700
Received: from dc5-exch02.marvell.com ([199.233.59.182])
 by mx0b-0016f401.pphosted.com with ESMTP id 38mqcwhy2x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
 Wed, 19 May 2021 04:14:43 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Wed, 19 May 2021 04:14:40 -0700
Received: from lbtlvb-pcie154.il.qlogic.org (10.69.176.80) by
 DC5-EXCH01.marvell.com (10.69.176.38) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Wed, 19 May 2021 04:14:37 -0700
From: Shai Malin <smalin@marvell.com>
To: <netdev@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
 <davem@davemloft.net>, <kuba@kernel.org>, <sagi@grimberg.me>,
 <hch@lst.de>, <axboe@fb.com>, <kbusch@kernel.org>
CC: <aelior@marvell.com>, <mkalderon@marvell.com>, <okulkarni@marvell.com>,
 <pkushwaha@marvell.com>, <malin1024@gmail.com>, <smalin@marvell.com>, "Dean
 Balandin" <dbalandin@marvell.com>
Subject: [RFC PATCH v5 03/27] nvme-tcp-offload: Add device scan implementation
Date: Wed, 19 May 2021 14:13:16 +0300
Message-ID: <20210519111340.20613-4-smalin@marvell.com>
X-Mailer: git-send-email 2.16.6
In-Reply-To: <20210519111340.20613-1-smalin@marvell.com>
References: <20210519111340.20613-1-smalin@marvell.com>
MIME-Version: 1.0
X-Proofpoint-GUID: vd254cHf-8buSE3TmA0CsNoOBmKzbgTo
X-Proofpoint-ORIG-GUID: vd254cHf-8buSE3TmA0CsNoOBmKzbgTo
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391, 18.0.761
 definitions=2021-05-19_04:2021-05-19,
 2021-05-19 signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210519_041448_667702_06E32CC0 
X-CRM114-Status: GOOD (  16.26  )
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

From: Dean Balandin <dbalandin@marvell.com>

As part of create_ctrl(), it scans the registered devices and calls
the claim_dev op on each of them, to find the first devices that matches
the connection params. Once the correct devices is found (claim_dev
returns true), we raise the refcnt of that device and return that device
as the device to be used for ctrl currently being created.

Acked-by: Igor Russkikh <irusskikh@marvell.com>
Signed-off-by: Dean Balandin <dbalandin@marvell.com>
Signed-off-by: Prabhakar Kushwaha <pkushwaha@marvell.com>
Signed-off-by: Omkar Kulkarni <okulkarni@marvell.com>
Signed-off-by: Michal Kalderon <mkalderon@marvell.com>
Signed-off-by: Ariel Elior <aelior@marvell.com>
Signed-off-by: Shai Malin <smalin@marvell.com>
---
 drivers/nvme/host/tcp-offload.c | 94 +++++++++++++++++++++++++++++++++
 1 file changed, 94 insertions(+)

diff --git a/drivers/nvme/host/tcp-offload.c b/drivers/nvme/host/tcp-offload.c
index 711232eba339..aa7cc239abf2 100644
--- a/drivers/nvme/host/tcp-offload.c
+++ b/drivers/nvme/host/tcp-offload.c
@@ -13,6 +13,11 @@
 static LIST_HEAD(nvme_tcp_ofld_devices);
 static DECLARE_RWSEM(nvme_tcp_ofld_devices_rwsem);
 
+static inline struct nvme_tcp_ofld_ctrl *to_tcp_ofld_ctrl(struct nvme_ctrl *nctrl)
+{
+	return container_of(nctrl, struct nvme_tcp_ofld_ctrl, nctrl);
+}
+
 /**
  * nvme_tcp_ofld_register_dev() - NVMeTCP Offload Library registration
  * function.
@@ -98,6 +103,94 @@ void nvme_tcp_ofld_req_done(struct nvme_tcp_ofld_req *req,
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
+	nctrl = &ctrl->nctrl;
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
+	if (ctrl->dev->ops->max_hw_sectors)
+		nctrl->max_hw_sectors = ctrl->dev->ops->max_hw_sectors;
+	if (ctrl->dev->ops->max_segments)
+		nctrl->max_segments = ctrl->dev->ops->max_segments;
+
+	/* Init queues */
+
+	/* Call nvme_init_ctrl */
+
+	rc = ctrl->dev->ops->setup_ctrl(ctrl, true);
+	if (rc)
+		goto out_module_put;
+
+	rc = nvme_tcp_ofld_setup_ctrl(nctrl, true);
+	if (rc)
+		goto out_uninit_ctrl;
+
+	return nctrl;
+
+out_uninit_ctrl:
+	ctrl->dev->ops->release_ctrl(ctrl);
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
@@ -107,6 +200,7 @@ static struct nvmf_transport_ops nvme_tcp_ofld_transport = {
 			  NVMF_OPT_RECONNECT_DELAY | NVMF_OPT_HDR_DIGEST |
 			  NVMF_OPT_DATA_DIGEST | NVMF_OPT_NR_POLL_QUEUES |
 			  NVMF_OPT_TOS,
+	.create_ctrl	= nvme_tcp_ofld_create_ctrl,
 };
 
 static int __init nvme_tcp_ofld_init_module(void)
-- 
2.22.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

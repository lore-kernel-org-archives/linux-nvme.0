Return-Path: <SRS0=UYep=LX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9175C11F66
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Jun 2021 12:49:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7748861D06
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Jun 2021 12:49:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7748861D06
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=marvell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=I6fr+rlOumBRZ/kEdCe+xa8sQyklMmV08yDcrQ5aPgI=; b=esl7OKDMetEdSZ
	/SPkdutJm4C7Eo3nAp/DNzMglI43HIv2qnEK80Q/oogl9rPTqiX1NKAO+/jsuNJYvEy6j8/OvkW3g
	kfB2p1v0hcouMJBTzyUhE1J/dmdP4JXaiU3KTUNH+3MSSZv+kGpTEXkK0Nq9aeqyUkqlNHBTkYz2j
	/QO2dD1ISEv7wccn/zWHi8yROM91rFuLyWh2OtgOrQQ0U0dcHJBFppgpzwGWoo7sum6kzGItIrLGZ
	tgPDLKHVD1KKJRvGCM21112gPilPcfTFnIS5WBOnXUDAIvNtaxXLZFpz5UJYBfndc/EKPlTc1SFaL
	h2sRMuLrslAqJt6V5Gdg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lyDAm-00AsPM-6Y; Tue, 29 Jun 2021 12:49:04 +0000
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lyDA0-00AsDm-Er
 for linux-nvme@lists.infradead.org; Tue, 29 Jun 2021 12:48:18 +0000
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 15TCjMHd014042; Tue, 29 Jun 2021 05:48:11 -0700
Received: from dc5-exch01.marvell.com ([199.233.59.181])
 by mx0b-0016f401.pphosted.com with ESMTP id 39f964duke-3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
 Tue, 29 Jun 2021 05:48:11 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.18;
 Tue, 29 Jun 2021 05:48:08 -0700
Received: from lbtlvb-pcie154.il.qlogic.org (10.69.176.80) by
 DC5-EXCH02.marvell.com (10.69.176.39) with Microsoft SMTP Server id
 15.0.1497.18 via Frontend Transport; Tue, 29 Jun 2021 05:48:05 -0700
From: Prabhakar Kushwaha <pkushwaha@marvell.com>
To: <linux-nvme@lists.infradead.org>, <sagi@grimberg.me>, <hch@lst.de>,
 <axboe@fb.com>, <kbusch@kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <smalin@marvell.com>,
 <aelior@marvell.com>, <mkalderon@marvell.com>, <okulkarni@marvell.com>,
 <pkushwaha@marvell.com>, <prabhakar.pkin@gmail.com>,
 <malin1024@gmail.com>, Dean Balandin <dbalandin@marvell.com>
Subject: [PATCH v4 04/20] nvme-tcp-offload: Add device scan implementation
Date: Tue, 29 Jun 2021 15:47:27 +0300
Message-ID: <20210629124743.6898-5-pkushwaha@marvell.com>
X-Mailer: git-send-email 2.16.6
In-Reply-To: <20210629124743.6898-1-pkushwaha@marvell.com>
References: <20210629124743.6898-1-pkushwaha@marvell.com>
MIME-Version: 1.0
X-Proofpoint-ORIG-GUID: _YhIiMi04Mu2XIi6s732PlLO5bvO-l5v
X-Proofpoint-GUID: _YhIiMi04Mu2XIi6s732PlLO5bvO-l5v
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391, 18.0.790
 definitions=2021-06-29_06:2021-06-28,
 2021-06-29 signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210629_054816_660286_660AED44 
X-CRM114-Status: GOOD (  17.64  )
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
Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/host/tcp-offload.c | 91 +++++++++++++++++++++++++++++++++
 drivers/nvme/host/tcp-offload.h |  1 +
 2 files changed, 92 insertions(+)

diff --git a/drivers/nvme/host/tcp-offload.c b/drivers/nvme/host/tcp-offload.c
index 10b87f5b875b..d0f4b83549b9 100644
--- a/drivers/nvme/host/tcp-offload.c
+++ b/drivers/nvme/host/tcp-offload.c
@@ -13,6 +13,11 @@
 static LIST_HEAD(nvme_tcp_ofld_devices);
 static DEFINE_MUTEX(nvme_tcp_ofld_devices_mutex);
 
+static inline struct nvme_tcp_ofld_ctrl *to_tcp_ofld_ctrl(struct nvme_ctrl *nc)
+{
+	return container_of(nc, struct nvme_tcp_ofld_ctrl, nctrl);
+}
+
 /**
  * nvme_tcp_ofld_register_dev() - NVMeTCP Offload Library registration
  * function.
@@ -96,6 +101,91 @@ void nvme_tcp_ofld_req_done(struct nvme_tcp_ofld_req *req,
 	/* Placeholder - complete request with/without error */
 }
 
+static struct nvme_tcp_ofld_dev *
+nvme_tcp_ofld_lookup_dev(struct nvme_tcp_ofld_ctrl *ctrl)
+{
+	struct nvme_ctrl *nctrl = &ctrl->nctrl;
+	struct nvme_tcp_ofld_dev *dev;
+	char *iface;
+
+	if (nctrl->opts->mask & NVMF_OPT_HOST_IFACE) {
+		iface = nctrl->opts->host_iface;
+		ctrl->ndev = __dev_get_by_name(&init_net, iface);
+		if (!ctrl->ndev) {
+			pr_err("invalid interface passed: %s\n", iface);
+			return NULL;
+		}
+	}
+
+	mutex_lock(&nvme_tcp_ofld_devices_mutex);
+	list_for_each_entry(dev, &nvme_tcp_ofld_devices, entry) {
+	/* ctrl includes the destination ip, source ip (if provided) and
+	 * network interface (if provided).
+	 */
+		if (dev->ops->claim_dev(dev, ctrl))
+			goto out;
+	}
+
+	dev = NULL;
+out:
+	mutex_unlock(&nvme_tcp_ofld_devices_mutex);
+
+	return dev;
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
+	/* Init nvme_tcp_ofld_ctrl & nvme_ctrl params based on received opts */
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
+	/* Increase driver refcnt */
+	if (!try_module_get(dev->ops->module)) {
+		pr_err("try_module_get failed\n");
+		rc = -ENODEV;
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
+	/* Setup ctrl */
+
+	return nctrl;
+
+out_free_ctrl:
+	kfree(ctrl);
+
+	return ERR_PTR(rc);
+}
+
 static struct nvmf_transport_ops nvme_tcp_ofld_transport = {
 	.name		= "tcp_offload",
 	.module		= THIS_MODULE,
@@ -105,6 +195,7 @@ static struct nvmf_transport_ops nvme_tcp_ofld_transport = {
 			  NVMF_OPT_RECONNECT_DELAY | NVMF_OPT_HDR_DIGEST |
 			  NVMF_OPT_DATA_DIGEST | NVMF_OPT_NR_POLL_QUEUES |
 			  NVMF_OPT_TOS | NVMF_OPT_HOST_IFACE,
+	.create_ctrl	= nvme_tcp_ofld_create_ctrl,
 };
 
 static int __init nvme_tcp_ofld_init_module(void)
diff --git a/drivers/nvme/host/tcp-offload.h b/drivers/nvme/host/tcp-offload.h
index bfa759177a07..d1c2c6171897 100644
--- a/drivers/nvme/host/tcp-offload.h
+++ b/drivers/nvme/host/tcp-offload.h
@@ -8,6 +8,7 @@
 #include <linux/scatterlist.h>
 #include <linux/types.h>
 #include <linux/nvme-tcp.h>
+#include <linux/netdevice.h>
 
 /* Driver includes */
 #include "nvme.h"
-- 
2.24.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

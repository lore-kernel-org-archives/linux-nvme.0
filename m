Return-Path: <SRS0=nO+g=NO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7EFEC4338F
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Aug 2021 12:58:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85FF5613AD
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Aug 2021 12:58:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 85FF5613AD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=marvell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=KFjP0QfSLdhaWkB7AzZywTXBqMkSokwp+kBrBc7Lews=; b=NAjjRKWprYbISq
	kjTuYD/t5qUUAueNVXN/+mTpj2NraaZWgKH64d+qxfvM3W8Ly3x8ATciTKovputi54RVxMSer/D9Z
	dAzwRkrUhk+QQnplGnZo0UEktDkQlF/cKwJk5GtQQKFeDE9iGQ1owBe85up3fomaDpZWSkHAaEpgW
	pjt21a+F9y+IkrwRBKj04Jvh39LDcsWwbUw8jiqR97CeRTz1A8swUCg+D6IlC85rGNBT1Q/IphtO5
	IsE2aBWtCC1qMUM88j8Onsjr++mACApdBl3A1AFuLwueOiD++fYQRzh4eq3fck2wtftZMDATICTDH
	NNpwTNlfkdQUEhM2Ok4Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mI9Wa-00GshM-Lk; Mon, 23 Aug 2021 12:58:00 +0000
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]
 helo=mx0b-0016f401.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mI9W1-00GsOi-Mi
 for linux-nvme@lists.infradead.org; Mon, 23 Aug 2021 12:57:27 +0000
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 17N4Z5qj013368;
 Mon, 23 Aug 2021 05:57:23 -0700
Received: from dc5-exch02.marvell.com ([199.233.59.182])
 by mx0a-0016f401.pphosted.com with ESMTP id 3am4s0hj0t-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
 Mon, 23 Aug 2021 05:57:23 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.18;
 Mon, 23 Aug 2021 05:57:22 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Mon, 23 Aug 2021 05:57:22 -0700
Received: from dut1171.mv.qlogic.com (unknown [10.112.88.18])
 by maili.marvell.com (Postfix) with ESMTP id 9599E3F707E;
 Mon, 23 Aug 2021 05:57:22 -0700 (PDT)
Received: from dut1171.mv.qlogic.com (localhost [127.0.0.1])
 by dut1171.mv.qlogic.com (8.14.7/8.14.7) with ESMTP id 17NCvJvn016108;
 Mon, 23 Aug 2021 05:57:19 -0700
Received: (from root@localhost)
 by dut1171.mv.qlogic.com (8.14.7/8.14.7/Submit) id 17NCvE8H016099;
 Mon, 23 Aug 2021 05:57:14 -0700
From: Nilesh Javali <njavali@marvell.com>
To: <martin.petersen@oracle.com>, <linux-nvme@lists.infradead.org>
CC: <linux-scsi@vger.kernel.org>, <GR-QLogic-Storage-Upstream@marvell.com>
Subject: [PATCH 1/2] nvme-fc: Add support for map_queues.
Date: Mon, 23 Aug 2021 05:56:48 -0700
Message-ID: <20210823125649.16061-2-njavali@marvell.com>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20210823125649.16061-1-njavali@marvell.com>
References: <20210823125649.16061-1-njavali@marvell.com>
MIME-Version: 1.0
X-Proofpoint-GUID: 8dogB9C3hbCGCWmHQhlVhpkrlnVRU9yY
X-Proofpoint-ORIG-GUID: 8dogB9C3hbCGCWmHQhlVhpkrlnVRU9yY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-08-23_02,2021-08-23_01,2020-04-07_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210823_055725_817207_A81CDFCB 
X-CRM114-Status: GOOD (  21.00  )
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

From: Saurav Kashyap <skashyap@marvell.com>

NVMe FC don't have support for map queues as compared
to pci, rdma and tcp. It doesn't provide a provision to
LLDs to change the queue mapping like scsi layer. This
patch adds an option for LLDs to change the queue mapping.

Signed-off-by: Saurav Kashyap <skashyap@marvell.com>
Signed-off-by: Nilesh Javali <njavali@marvell.com>
---
 drivers/nvme/host/fc.c         | 25 +++++++++++++++++++++++++
 include/linux/nvme-fc-driver.h |  7 +++++++
 2 files changed, 32 insertions(+)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index b08a61ca283f..078895809098 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -16,6 +16,7 @@
 #include <linux/nvme-fc.h>
 #include "fc.h"
 #include <scsi/scsi_transport_fc.h>
+#include <linux/blk-mq-pci.h>
 
 /* *************************** Data Structures/Defines ****************** */
 
@@ -2839,6 +2840,29 @@ nvme_fc_complete_rq(struct request *rq)
 	nvme_fc_ctrl_put(ctrl);
 }
 
+static int nvme_fc_map_queues(struct blk_mq_tag_set *set)
+{
+	int i;
+	struct nvme_fc_ctrl *ctrl;
+	struct blk_mq_queue_map *map = NULL;
+
+	ctrl = set->driver_data;
+	for (i = 0; i < set->nr_maps; i++) {
+		map = &set->map[i];
+
+		if (!map->nr_queues) {
+			WARN_ON(i == HCTX_TYPE_DEFAULT);
+			continue;
+		}
+
+		/* Call LLDD map queue functionality if defined */
+		if (ctrl->lport->ops->map_queues)
+			ctrl->lport->ops->map_queues(&ctrl->lport->localport, map);
+		else
+			blk_mq_map_queues(map);
+	}
+	return 0;
+}
 
 static const struct blk_mq_ops nvme_fc_mq_ops = {
 	.queue_rq	= nvme_fc_queue_rq,
@@ -2847,6 +2871,7 @@ static const struct blk_mq_ops nvme_fc_mq_ops = {
 	.exit_request	= nvme_fc_exit_request,
 	.init_hctx	= nvme_fc_init_hctx,
 	.timeout	= nvme_fc_timeout,
+	.map_queues	= nvme_fc_map_queues,
 };
 
 static int
diff --git a/include/linux/nvme-fc-driver.h b/include/linux/nvme-fc-driver.h
index 2a38f2b477a5..cb909edb76c4 100644
--- a/include/linux/nvme-fc-driver.h
+++ b/include/linux/nvme-fc-driver.h
@@ -7,6 +7,7 @@
 #define _NVME_FC_DRIVER_H 1
 
 #include <linux/scatterlist.h>
+#include <linux/blk-mq.h>
 
 
 /*
@@ -497,6 +498,8 @@ struct nvme_fc_port_template {
 	int	(*xmt_ls_rsp)(struct nvme_fc_local_port *localport,
 				struct nvme_fc_remote_port *rport,
 				struct nvmefc_ls_rsp *ls_rsp);
+	void	(*map_queues)(struct nvme_fc_local_port *localport,
+			      struct blk_mq_queue_map *map);
 
 	u32	max_hw_queues;
 	u16	max_sgl_segments;
@@ -779,6 +782,10 @@ struct nvmet_fc_target_port {
  *       LS received.
  *       Entrypoint is Mandatory.
  *
+ * @map_queues: This functions lets the driver expose the queue mapping
+ *	 to the block layer.
+ *       Entrypoint is Optional.
+ *
  * @fcp_op:  Called to perform a data transfer or transmit a response.
  *       The nvmefc_tgt_fcp_req structure is the same LLDD-supplied
  *       exchange structure specified in the nvmet_fc_rcv_fcp_req() call
-- 
2.23.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

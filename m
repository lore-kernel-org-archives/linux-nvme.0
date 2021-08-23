Return-Path: <SRS0=nO+g=NO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35227C4338F
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Aug 2021 12:58:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00A11613AD
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Aug 2021 12:58:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 00A11613AD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=marvell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=x90dmRAvMf8wN6S/ds4dD+9msB6XzJHxQEtsu2qYN90=; b=wEj5scySo45J/C
	A1xI79TR6WMHRIucZC1qIxSbsrBJPUNKLw9AO5+ahFefd6y86zE3Ra7qBM9stitL4ymn+s+qPjN3J
	p5ugsgftwxBLwRBM3VR+Er34wLS+SwXbJuQHj3cFeDdWQo1d/ksBSykXxT4mzZ4r9tkDgMfRCD0Lw
	qsJOy38gr/2ZOb6kqnNwzPYQJgaarFpaljCBQcALZnm9fCShCf2YuNReVqCImheo3jgrbCpzrEKcV
	/PvJ3UxUFhZfhik7VT3TEIZlHX0hXgx32BhAexXBYR9xmhF7OJFTS2c/yFyek4arBQ/f6xxfJQs5O
	v+dXhbafdBPyXKLkYnUg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mI9WF-00GsWL-9e; Mon, 23 Aug 2021 12:57:39 +0000
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]
 helo=mx0b-0016f401.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mI9W1-00GsOr-Mj
 for linux-nvme@lists.infradead.org; Mon, 23 Aug 2021 12:57:27 +0000
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 17N4Z5qk013368;
 Mon, 23 Aug 2021 05:57:24 -0700
Received: from dc5-exch02.marvell.com ([199.233.59.182])
 by mx0a-0016f401.pphosted.com with ESMTP id 3am4s0hj0t-3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
 Mon, 23 Aug 2021 05:57:24 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.18;
 Mon, 23 Aug 2021 05:57:22 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Mon, 23 Aug 2021 05:57:22 -0700
Received: from dut1171.mv.qlogic.com (unknown [10.112.88.18])
 by maili.marvell.com (Postfix) with ESMTP id AE6AB3F7080;
 Mon, 23 Aug 2021 05:57:22 -0700 (PDT)
Received: from dut1171.mv.qlogic.com (localhost [127.0.0.1])
 by dut1171.mv.qlogic.com (8.14.7/8.14.7) with ESMTP id 17NCvM2Z016112;
 Mon, 23 Aug 2021 05:57:22 -0700
Received: (from root@localhost)
 by dut1171.mv.qlogic.com (8.14.7/8.14.7/Submit) id 17NCvMST016111;
 Mon, 23 Aug 2021 05:57:22 -0700
From: Nilesh Javali <njavali@marvell.com>
To: <martin.petersen@oracle.com>, <linux-nvme@lists.infradead.org>
CC: <linux-scsi@vger.kernel.org>, <GR-QLogic-Storage-Upstream@marvell.com>
Subject: [PATCH 2/2] qla2xxx: Add map_queues support to nvme.
Date: Mon, 23 Aug 2021 05:56:49 -0700
Message-ID: <20210823125649.16061-3-njavali@marvell.com>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20210823125649.16061-1-njavali@marvell.com>
References: <20210823125649.16061-1-njavali@marvell.com>
MIME-Version: 1.0
X-Proofpoint-GUID: Z-NaljyEBQGNdZO0dsVzpq_XZgWuFzne
X-Proofpoint-ORIG-GUID: Z-NaljyEBQGNdZO0dsVzpq_XZgWuFzne
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-08-23_02,2021-08-23_01,2020-04-07_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210823_055725_820741_C0C0C798 
X-CRM114-Status: GOOD (  12.96  )
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

Add callback for map queues and use block layer
blk_mq_pci_map_queues for mapping. With this mapping
minimum 10% increase in performance is noticed.

Signed-off-by: Saurav Kashyap <skashyap@marvell.com>
Signed-off-by: Nilesh Javali <njavali@marvell.com>
---
 drivers/scsi/qla2xxx/qla_nvme.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/scsi/qla2xxx/qla_nvme.c b/drivers/scsi/qla2xxx/qla_nvme.c
index 05cad06ff165..7f9a7abc615b 100644
--- a/drivers/scsi/qla2xxx/qla_nvme.c
+++ b/drivers/scsi/qla2xxx/qla_nvme.c
@@ -8,6 +8,8 @@
 #include <linux/delay.h>
 #include <linux/nvme.h>
 #include <linux/nvme-fc.h>
+#include <linux/blk-mq-pci.h>
+#include <linux/blk-mq.h>
 
 static struct nvme_fc_port_template qla_nvme_fc_transport;
 
@@ -634,6 +636,17 @@ static int qla_nvme_post_cmd(struct nvme_fc_local_port *lport,
 	return rval;
 }
 
+static void qla_nvme_map_queues(struct nvme_fc_local_port *lport, struct blk_mq_queue_map *map)
+{
+	int rc;
+	struct scsi_qla_host *vha = lport->private;
+
+	rc = blk_mq_pci_map_queues(map, vha->hw->pdev, vha->irq_offset);
+	if (rc)
+		ql_log(ql_log_warn, vha, 0x21de,
+		       "pci map queue failed 0x%x", rc);
+}
+
 static void qla_nvme_localport_delete(struct nvme_fc_local_port *lport)
 {
 	struct scsi_qla_host *vha = lport->private;
@@ -668,6 +681,7 @@ static struct nvme_fc_port_template qla_nvme_fc_transport = {
 	.ls_abort	= qla_nvme_ls_abort,
 	.fcp_io		= qla_nvme_post_cmd,
 	.fcp_abort	= qla_nvme_fcp_abort,
+	.map_queues	= qla_nvme_map_queues,
 	.max_hw_queues  = 8,
 	.max_sgl_segments = 1024,
 	.max_dif_sgl_segments = 64,
-- 
2.23.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

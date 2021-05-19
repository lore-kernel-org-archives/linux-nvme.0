Return-Path: <SRS0=q7uG=KO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7A33C433B4
	for <linux-nvme@archiver.kernel.org>; Wed, 19 May 2021 12:36:43 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63A02601FA
	for <linux-nvme@archiver.kernel.org>; Wed, 19 May 2021 12:36:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63A02601FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=marvell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-ID:Date:
	Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=2q4vs+NLho5tIoMfgpwE/Nm5xulhJAjZCt/9jBaeU+Q=; b=LFbttyGDcxnYRyRthOIWHdCQ0
	G7pXPvSCafB7U0S9ujbWUFVYlYN9iZ9/PFigDwXqqFP8DLNaPNUaMeD31V82R6iPEzWhILaf+vklC
	0xsjWGl47Bx0ouG40/DWZxk9kq3UqBqFivbICXw7/P+mb6gKHIDB4SYgrD7BHiAG4pTsitkjCDq0L
	KqRLVdxKvih0acRBfutuGsLbXa0b0lWHjr5vMXEFEkhkNi/K14kzJxorPJPxyLmFy69knjHy/Njkz
	eof0OfrNx/zkSNKmjYJ5zNPyjEpMVhtC58tMWG9Q0LvVBZ8e2nCzwPtPY5++q/Fcz2cvJlu9W3o+2
	43u4dg8mQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1ljLQf-003vXR-37; Wed, 19 May 2021 12:36:01 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ljKBG-003jGP-1o
 for linux-nvme@desiato.infradead.org; Wed, 19 May 2021 11:16:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:CC:To:From:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=X5AFeL3kQeJwRFdc1HvvUkyAtpzX9Yo2T2LB+SdR5io=; b=m9TqfzA63j0+vAD0ruve+rh0t0
 r5y4XusEQLtjjxtNK1kIyF+t68O458S1q1lm+qKLEPU7gEoizfX/mh7vuO4WcOSwNErm/+z48b5Qe
 RgWY1reQAUep1H1Q7Gy8rIZcIDjqGgLKGFmgjv0X6BhKpKmW/oNre/eD9IYMpT7PW1NfiwYRHtrJr
 +r6/wQXK1wwpdOSzNlocU7+U+YGGN2c23rzeggAMS95bwkHwhhExeobgaNTMMxKd0q8yUo83nh2Fk
 blcnenEurk3VPquB1p6gPAjrMlN6mukBTO59iEHuFKwiG/VMouGooDIOFN+mtnD0SOipWjLnEC+jS
 K/D66cYA==;
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]
 helo=mx0b-0016f401.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ljKBC-00FOSr-Lw
 for linux-nvme@lists.infradead.org; Wed, 19 May 2021 11:16:00 +0000
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 14JB9dFn020134; Wed, 19 May 2021 04:15:55 -0700
Received: from dc5-exch01.marvell.com ([199.233.59.181])
 by mx0a-0016f401.pphosted.com with ESMTP id 38mqc1hyvt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
 Wed, 19 May 2021 04:15:55 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Wed, 19 May 2021 04:15:53 -0700
Received: from lbtlvb-pcie154.il.qlogic.org (10.69.176.80) by
 DC5-EXCH01.marvell.com (10.69.176.38) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Wed, 19 May 2021 04:15:50 -0700
From: Shai Malin <smalin@marvell.com>
To: <netdev@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
 <davem@davemloft.net>, <kuba@kernel.org>, <sagi@grimberg.me>,
 <hch@lst.de>, <axboe@fb.com>, <kbusch@kernel.org>
CC: <aelior@marvell.com>, <mkalderon@marvell.com>, <okulkarni@marvell.com>,
 <pkushwaha@marvell.com>, <malin1024@gmail.com>, <smalin@marvell.com>
Subject: [RFC PATCH v5 19/27] qedn: Add IRQ and fast-path resources
 initializations
Date: Wed, 19 May 2021 14:13:32 +0300
Message-ID: <20210519111340.20613-20-smalin@marvell.com>
X-Mailer: git-send-email 2.16.6
In-Reply-To: <20210519111340.20613-1-smalin@marvell.com>
References: <20210519111340.20613-1-smalin@marvell.com>
MIME-Version: 1.0
X-Proofpoint-GUID: z5OYoCIckHFjojMN4Zakd97W7VBCsXye
X-Proofpoint-ORIG-GUID: z5OYoCIckHFjojMN4Zakd97W7VBCsXye
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391, 18.0.761
 definitions=2021-05-19_04:2021-05-19,
 2021-05-19 signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210519_041558_754924_338CA1BD 
X-CRM114-Status: GOOD (  28.77  )
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

This patch will present the adding of qedn_fp_queue - this is a per cpu
core element which handles all of the connections on that cpu core.
The qedn_fp_queue will handle a group of connections (NVMeoF QPs) which
are handled on the same cpu core, and will only use the same FW-driver
resources with no need to be related to the same NVMeoF controller.

The per qedn_fq_queue resources are the FW CQ and FW status block:
- The FW CQ will be used for the FW to notify the driver that the
  the exchange has ended and the FW will pass the incoming NVMeoF CQE
  (if exist) to the driver.
- FW status block - which is used for the FW to notify the driver with
  the producer update of the FW CQE chain.

The FW fast-path queues are based on qed_chain.h

Acked-by: Igor Russkikh <irusskikh@marvell.com>
Signed-off-by: Prabhakar Kushwaha <pkushwaha@marvell.com>
Signed-off-by: Omkar Kulkarni <okulkarni@marvell.com>
Signed-off-by: Michal Kalderon <mkalderon@marvell.com>
Signed-off-by: Ariel Elior <aelior@marvell.com>
Signed-off-by: Shai Malin <smalin@marvell.com>
---
 drivers/nvme/hw/qedn/qedn.h      |  25 +++
 drivers/nvme/hw/qedn/qedn_main.c | 288 ++++++++++++++++++++++++++++++-
 2 files changed, 310 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/hw/qedn/qedn.h b/drivers/nvme/hw/qedn/qedn.h
index f49ae2dcb8fe..4d70c34bcb0b 100644
--- a/drivers/nvme/hw/qedn/qedn.h
+++ b/drivers/nvme/hw/qedn/qedn.h
@@ -33,17 +33,39 @@
 #define QEDN_PROTO_CQ_PROD_IDX	0
 #define QEDN_NVMETCP_NUM_FW_CONN_QUEUE_PAGES 2
 
+#define QEDN_PAGE_SIZE	4096 /* FW page size - Configurable */
+#define QEDN_IRQ_NAME_LEN 24
+#define QEDN_IRQ_NO_FLAGS 0
+
+#define QEDN_TCP_RTO_DEFAULT 280
+
 enum qedn_state {
 	QEDN_STATE_CORE_PROBED = 0,
 	QEDN_STATE_CORE_OPEN,
 	QEDN_STATE_MFW_STATE,
+	QEDN_STATE_NVMETCP_OPEN,
+	QEDN_STATE_IRQ_SET,
+	QEDN_STATE_FP_WORK_THREAD_SET,
 	QEDN_STATE_REGISTERED_OFFLOAD_DEV,
 	QEDN_STATE_MODULE_REMOVE_ONGOING,
 };
 
+/* Per CPU core params */
+struct qedn_fp_queue {
+	struct qed_chain cq_chain;
+	u16 *cq_prod;
+	struct mutex cq_mutex; /* cq handler mutex */
+	struct qedn_ctx	*qedn;
+	struct qed_sb_info *sb_info;
+	unsigned int cpu;
+	u16 sb_id;
+	char irqname[QEDN_IRQ_NAME_LEN];
+};
+
 struct qedn_ctx {
 	struct pci_dev *pdev;
 	struct qed_dev *cdev;
+	struct qed_int_info int_info;
 	struct qed_dev_nvmetcp_info dev_info;
 	struct nvme_tcp_ofld_dev qedn_ofld_dev;
 	struct qed_pf_params pf_params;
@@ -53,6 +75,9 @@ struct qedn_ctx {
 
 	/* Fast path queues */
 	u8 num_fw_cqs;
+	struct qedn_fp_queue *fp_q_arr;
+	struct nvmetcp_glbl_queue_entry *fw_cq_array_virt;
+	dma_addr_t fw_cq_array_phy; /* Physical address of fw_cq_array_virt */
 };
 
 #endif /* _QEDN_H_ */
diff --git a/drivers/nvme/hw/qedn/qedn_main.c b/drivers/nvme/hw/qedn/qedn_main.c
index c2e5263cfb46..b3a9022bf643 100644
--- a/drivers/nvme/hw/qedn/qedn_main.c
+++ b/drivers/nvme/hw/qedn/qedn_main.c
@@ -155,6 +155,104 @@ static struct nvme_tcp_ofld_ops qedn_ofld_ops = {
 	.commit_rqs = qedn_commit_rqs,
 };
 
+/* Fastpath IRQ handler */
+static irqreturn_t qedn_irq_handler(int irq, void *dev_id)
+{
+	/* Placeholder */
+
+	return IRQ_HANDLED;
+}
+
+static void qedn_sync_free_irqs(struct qedn_ctx *qedn)
+{
+	u16 vector_idx;
+	int i;
+
+	for (i = 0; i < qedn->num_fw_cqs; i++) {
+		vector_idx = i * qedn->dev_info.common.num_hwfns +
+			     qed_ops->common->get_affin_hwfn_idx(qedn->cdev);
+		synchronize_irq(qedn->int_info.msix[vector_idx].vector);
+		irq_set_affinity_hint(qedn->int_info.msix[vector_idx].vector,
+				      NULL);
+		free_irq(qedn->int_info.msix[vector_idx].vector,
+			 &qedn->fp_q_arr[i]);
+	}
+
+	qedn->int_info.used_cnt = 0;
+	qed_ops->common->set_fp_int(qedn->cdev, 0);
+}
+
+static int qedn_request_msix_irq(struct qedn_ctx *qedn)
+{
+	struct pci_dev *pdev = qedn->pdev;
+	struct qedn_fp_queue *fp_q = NULL;
+	int i, rc, cpu;
+	u16 vector_idx;
+	u32 vector;
+
+	/* numa-awareness will be added in future enhancements */
+	cpu = cpumask_first(cpu_online_mask);
+	for (i = 0; i < qedn->num_fw_cqs; i++) {
+		fp_q = &qedn->fp_q_arr[i];
+		vector_idx = i * qedn->dev_info.common.num_hwfns +
+			     qed_ops->common->get_affin_hwfn_idx(qedn->cdev);
+		vector = qedn->int_info.msix[vector_idx].vector;
+		sprintf(fp_q->irqname, "qedn_queue_%x.%x.%x_%d",
+			pdev->bus->number, PCI_SLOT(pdev->devfn),
+			PCI_FUNC(pdev->devfn), i);
+		rc = request_irq(vector, qedn_irq_handler, QEDN_IRQ_NO_FLAGS,
+				 fp_q->irqname, fp_q);
+		if (rc) {
+			pr_err("request_irq failed.\n");
+			qedn_sync_free_irqs(qedn);
+
+			return rc;
+		}
+
+		fp_q->cpu = cpu;
+		qedn->int_info.used_cnt++;
+		rc = irq_set_affinity_hint(vector, get_cpu_mask(cpu));
+		cpu = cpumask_next_wrap(cpu, cpu_online_mask, -1, false);
+	}
+
+	return 0;
+}
+
+static int qedn_setup_irq(struct qedn_ctx *qedn)
+{
+	int rc = 0;
+	u8 rval;
+
+	rval = qed_ops->common->set_fp_int(qedn->cdev, qedn->num_fw_cqs);
+	if (rval < qedn->num_fw_cqs) {
+		qedn->num_fw_cqs = rval;
+		if (rval == 0) {
+			pr_err("set_fp_int return 0 IRQs\n");
+
+			return -ENODEV;
+		}
+	}
+
+	rc = qed_ops->common->get_fp_int(qedn->cdev, &qedn->int_info);
+	if (rc) {
+		pr_err("get_fp_int failed\n");
+		goto exit_setup_int;
+	}
+
+	if (qedn->int_info.msix_cnt) {
+		rc = qedn_request_msix_irq(qedn);
+		goto exit_setup_int;
+	} else {
+		pr_err("msix_cnt = 0\n");
+		rc = -EINVAL;
+		goto exit_setup_int;
+	}
+
+exit_setup_int:
+
+	return rc;
+}
+
 static inline void qedn_init_pf_struct(struct qedn_ctx *qedn)
 {
 	/* Placeholder - Initialize qedn fields */
@@ -185,21 +283,173 @@ static inline int qedn_core_probe(struct qedn_ctx *qedn)
 	return rc;
 }
 
+static void qedn_free_function_queues(struct qedn_ctx *qedn)
+{
+	struct qed_sb_info *sb_info = NULL;
+	struct qedn_fp_queue *fp_q;
+	int i;
+
+	/* Free workqueues */
+
+	/* Free the fast path queues*/
+	for (i = 0; i < qedn->num_fw_cqs; i++) {
+		fp_q = &qedn->fp_q_arr[i];
+
+		/* Free SB */
+		sb_info = fp_q->sb_info;
+		if (sb_info->sb_virt) {
+			qed_ops->common->sb_release(qedn->cdev, sb_info,
+						    fp_q->sb_id,
+						    QED_SB_TYPE_STORAGE);
+			dma_free_coherent(&qedn->pdev->dev,
+					  sizeof(*sb_info->sb_virt),
+					  (void *)sb_info->sb_virt,
+					  sb_info->sb_phys);
+			memset(sb_info, 0, sizeof(*sb_info));
+			kfree(sb_info);
+			fp_q->sb_info = NULL;
+		}
+
+		qed_ops->common->chain_free(qedn->cdev, &fp_q->cq_chain);
+	}
+
+	if (qedn->fw_cq_array_virt)
+		dma_free_coherent(&qedn->pdev->dev,
+				  qedn->num_fw_cqs * sizeof(u64),
+				  qedn->fw_cq_array_virt,
+				  qedn->fw_cq_array_phy);
+	kfree(qedn->fp_q_arr);
+	qedn->fp_q_arr = NULL;
+}
+
+static int qedn_alloc_and_init_sb(struct qedn_ctx *qedn,
+				  struct qed_sb_info *sb_info, u16 sb_id)
+{
+	int rc = 0;
+
+	sb_info->sb_virt = dma_alloc_coherent(&qedn->pdev->dev,
+					      sizeof(struct status_block_e4),
+					      &sb_info->sb_phys, GFP_KERNEL);
+	if (!sb_info->sb_virt) {
+		pr_err("Status block allocation failed\n");
+
+		return -ENOMEM;
+	}
+
+	rc = qed_ops->common->sb_init(qedn->cdev, sb_info, sb_info->sb_virt,
+				      sb_info->sb_phys, sb_id,
+				      QED_SB_TYPE_STORAGE);
+	if (rc) {
+		pr_err("Status block initialization failed\n");
+
+		return rc;
+	}
+
+	return 0;
+}
+
+static int qedn_alloc_function_queues(struct qedn_ctx *qedn)
+{
+	struct qed_chain_init_params chain_params = {};
+	struct status_block_e4 *sb = NULL;
+	struct qedn_fp_queue *fp_q = NULL;
+	int rc = 0, arr_size;
+	u64 cq_phy_addr;
+	int i;
+
+	/* Place holder - IO-path workqueues */
+
+	qedn->fp_q_arr = kcalloc(qedn->num_fw_cqs,
+				 sizeof(struct qedn_fp_queue), GFP_KERNEL);
+	if (!qedn->fp_q_arr)
+		return -ENOMEM;
+
+	arr_size = qedn->num_fw_cqs * sizeof(struct nvmetcp_glbl_queue_entry);
+	qedn->fw_cq_array_virt = dma_alloc_coherent(&qedn->pdev->dev,
+						    arr_size,
+						    &qedn->fw_cq_array_phy,
+						    GFP_KERNEL);
+	if (!qedn->fw_cq_array_virt) {
+		rc = -ENOMEM;
+		goto mem_alloc_failure;
+	}
+
+	/* placeholder - create task pools */
+
+	for (i = 0; i < qedn->num_fw_cqs; i++) {
+		fp_q = &qedn->fp_q_arr[i];
+		mutex_init(&fp_q->cq_mutex);
+
+		/* FW CQ */
+		chain_params.intended_use = QED_CHAIN_USE_TO_CONSUME,
+		chain_params.mode = QED_CHAIN_MODE_PBL,
+		chain_params.cnt_type = QED_CHAIN_CNT_TYPE_U16,
+		chain_params.num_elems = QEDN_FW_CQ_SIZE;
+		chain_params.elem_size = 64; /*Placeholder - sizeof(struct nvmetcp_fw_cqe)*/
+
+		rc = qed_ops->common->chain_alloc(qedn->cdev,
+						  &fp_q->cq_chain,
+						  &chain_params);
+		if (rc) {
+			pr_err("CQ chain pci_alloc_consistent fail\n");
+			goto mem_alloc_failure;
+		}
+
+		cq_phy_addr = qed_chain_get_pbl_phys(&fp_q->cq_chain);
+		qedn->fw_cq_array_virt[i].cq_pbl_addr.hi = PTR_HI(cq_phy_addr);
+		qedn->fw_cq_array_virt[i].cq_pbl_addr.lo = PTR_LO(cq_phy_addr);
+
+		/* SB */
+		fp_q->sb_info = kzalloc(sizeof(*fp_q->sb_info), GFP_KERNEL);
+		if (!fp_q->sb_info)
+			goto mem_alloc_failure;
+
+		fp_q->sb_id = i;
+		rc = qedn_alloc_and_init_sb(qedn, fp_q->sb_info, fp_q->sb_id);
+		if (rc) {
+			pr_err("SB allocation and initialization failed.\n");
+			goto mem_alloc_failure;
+		}
+
+		sb = fp_q->sb_info->sb_virt;
+		fp_q->cq_prod = (u16 *)&sb->pi_array[QEDN_PROTO_CQ_PROD_IDX];
+		fp_q->qedn = qedn;
+
+		/* Placeholder - Init IO-path workqueue */
+
+		/* Placeholder - Init IO-path resources */
+	}
+
+	return 0;
+
+mem_alloc_failure:
+	pr_err("Function allocation failed\n");
+	qedn_free_function_queues(qedn);
+
+	return rc;
+}
+
 static int qedn_set_nvmetcp_pf_param(struct qedn_ctx *qedn)
 {
 	u32 fw_conn_queue_pages = QEDN_NVMETCP_NUM_FW_CONN_QUEUE_PAGES;
 	struct qed_nvmetcp_pf_params *pf_params;
+	int rc;
 
 	pf_params = &qedn->pf_params.nvmetcp_pf_params;
 	memset(pf_params, 0, sizeof(*pf_params));
 	qedn->num_fw_cqs = min_t(u8, qedn->dev_info.num_cqs, num_online_cpus());
+	pr_info("Num qedn FW CQs %u\n", qedn->num_fw_cqs);
 
 	pf_params->num_cons = QEDN_MAX_CONNS_PER_PF;
 	pf_params->num_tasks = QEDN_MAX_TASKS_PER_PF;
 
-	/* Placeholder - Initialize function level queues */
+	rc = qedn_alloc_function_queues(qedn);
+	if (rc) {
+		pr_err("Global queue allocation failed.\n");
+		goto err_alloc_mem;
+	}
 
-	/* Placeholder - Initialize TCP params */
+	set_bit(QEDN_STATE_FP_WORK_THREAD_SET, &qedn->state);
 
 	/* Queues */
 	pf_params->num_sq_pages_in_ring = fw_conn_queue_pages;
@@ -207,11 +457,14 @@ static int qedn_set_nvmetcp_pf_param(struct qedn_ctx *qedn)
 	pf_params->num_uhq_pages_in_ring = fw_conn_queue_pages;
 	pf_params->num_queues = qedn->num_fw_cqs;
 	pf_params->cq_num_entries = QEDN_FW_CQ_SIZE;
+	pf_params->glbl_q_params_addr = qedn->fw_cq_array_phy;
 
 	/* the CQ SB pi */
 	pf_params->gl_rq_pi = QEDN_PROTO_CQ_PROD_IDX;
 
-	return 0;
+err_alloc_mem:
+
+	return rc;
 }
 
 static inline int qedn_slowpath_start(struct qedn_ctx *qedn)
@@ -250,6 +503,12 @@ static void __qedn_remove(struct pci_dev *pdev)
 	if (test_and_clear_bit(QEDN_STATE_REGISTERED_OFFLOAD_DEV, &qedn->state))
 		nvme_tcp_ofld_unregister_dev(&qedn->qedn_ofld_dev);
 
+	if (test_and_clear_bit(QEDN_STATE_IRQ_SET, &qedn->state))
+		qedn_sync_free_irqs(qedn);
+
+	if (test_and_clear_bit(QEDN_STATE_NVMETCP_OPEN, &qedn->state))
+		qed_ops->stop(qedn->cdev);
+
 	if (test_and_clear_bit(QEDN_STATE_MFW_STATE, &qedn->state)) {
 		rc = qed_ops->common->update_drv_state(qedn->cdev, false);
 		if (rc)
@@ -259,6 +518,9 @@ static void __qedn_remove(struct pci_dev *pdev)
 	if (test_and_clear_bit(QEDN_STATE_CORE_OPEN, &qedn->state))
 		qed_ops->common->slowpath_stop(qedn->cdev);
 
+	if (test_and_clear_bit(QEDN_STATE_FP_WORK_THREAD_SET, &qedn->state))
+		qedn_free_function_queues(qedn);
+
 	if (test_and_clear_bit(QEDN_STATE_CORE_PROBED, &qedn->state))
 		qed_ops->common->remove(qedn->cdev);
 
@@ -327,6 +589,25 @@ static int __qedn_probe(struct pci_dev *pdev)
 
 	set_bit(QEDN_STATE_CORE_OPEN, &qedn->state);
 
+	rc = qedn_setup_irq(qedn);
+	if (rc)
+		goto exit_probe_and_release_mem;
+
+	set_bit(QEDN_STATE_IRQ_SET, &qedn->state);
+
+	/* NVMeTCP start HW PF */
+	rc = qed_ops->start(qedn->cdev,
+			    NULL /* Placeholder for FW IO-path resources */,
+			    qedn,
+			    NULL /* Placeholder for FW Event callback */);
+	if (rc) {
+		rc = -ENODEV;
+		pr_err("Cannot start NVMeTCP Function\n");
+		goto exit_probe_and_release_mem;
+	}
+
+	set_bit(QEDN_STATE_NVMETCP_OPEN, &qedn->state);
+
 	rc = qed_ops->common->update_drv_state(qedn->cdev, true);
 	if (rc) {
 		pr_err("Failed to send drv state to MFW\n");
@@ -335,6 +616,7 @@ static int __qedn_probe(struct pci_dev *pdev)
 
 	set_bit(QEDN_STATE_MFW_STATE, &qedn->state);
 
+	qedn->qedn_ofld_dev.num_hw_vectors = qedn->num_fw_cqs;
 	qedn->qedn_ofld_dev.private_data = (void *)qedn;
 	qedn->qedn_ofld_dev.ops = &qedn_ofld_ops;
 	INIT_LIST_HEAD(&qedn->qedn_ofld_dev.entry);
-- 
2.22.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

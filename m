Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81792C25B10
	for <linux-nvme@archiver.kernel.org>; Fri, 10 May 2024 17:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=F97wz8C0TeguvWtBXp0VXOyA2SQ/hF60SKY4cOrjw4Y=; b=uKj9+D7m71UPTJ0duhADwhkF2R
	+Acs7FT8DKe1DeXpGigViYf3gJC0Jum/g0DpSk+jbRdOQj6iSgXnVtp0Bk0QqkZbAlO8qOOmHepkx
	+KipNKhTyho549ROOzguAhw6KlvJPNgkW9CLLNdpReNAByEhy8VNMETxtvlBd24K1Q99dSyJdAAn+
	TU+41iDdmfPKQrIAOXjEcT2rmvhqOEG45qwyXfzcMhvagFR+/yP2ghfsqnqL1HD1PyqPYRIDbOQe2
	9kW7l9xSZM2WKQsCOYs/Po8XgPCm+AIJ0X3sIjU+ZArpmbhbG0gnnTMzjpzKrju2GM2CV42FKpjvP
	ivc2pBaQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s5UKq-000000063NK-2Ed1;
	Fri, 10 May 2024 17:47:08 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s5UKm-000000063Mi-3Fup
	for linux-nvme@lists.infradead.org;
	Fri, 10 May 2024 17:47:06 +0000
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44AHhbIi002086
	for <linux-nvme@lists.infradead.org>; Fri, 10 May 2024 10:47:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=s2048-2021-q4;
 bh=F97wz8C0TeguvWtBXp0VXOyA2SQ/hF60SKY4cOrjw4Y=;
 b=TM53L/KI6IwzjQhHIak8ZE6XH9bYRZITHRnWdJfsrQHWs3bFygJwPYkdseTo4SMehHMx
 QTDjtRcOGGl8acm6qNzNDtsPNPA2e3UBXwIQnnCWvs+q/GCG2Qfp1cNnvAHLkR7NUwSk
 CgPKdL0ccYbvZrCod7wM7Nnnf6K5lYY5JPZU6xYb4VbryzEhFJoHDwZvorkX8iUPA1o7
 vPyY+fZDza0tRof4G/dtUs6FcxWXvg3Q6W2zPCKl4xA4EMhQupYtYoGQjUsPaX1gan3q
 WWV+0KD76pRR6OrtYL14YUgiKTaBn3a97Z5AxaCnybGX6Mrq4pLNR2c8Opq0DlZ7IVTP aw== 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3y1mf89ky4-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Fri, 10 May 2024 10:47:02 -0700
Received: from twshared7646.08.ash8.facebook.com (2620:10d:c0a8:1b::8e35) by
 mail.thefacebook.com (2620:10d:c0a8:83::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 10 May 2024 17:47:00 +0000
Received: by devbig032.nao3.facebook.com (Postfix, from userid 544533)
	id 26FBD264BB06; Fri, 10 May 2024 10:46:53 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <ming.lei@redhat.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv2] nvme-pci: allow unmanaged interrupts
Date: Fri, 10 May 2024 10:46:45 -0700
Message-ID: <20240510174645.3987951-1-kbusch@meta.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: ittBTy2_KW0DUEwFksrGPMZQRKA2cREL
X-Proofpoint-ORIG-GUID: ittBTy2_KW0DUEwFksrGPMZQRKA2cREL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-10_12,2024-05-10_02,2023-05-22_02
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240510_104705_018398_7B08BD53 
X-CRM114-Status: GOOD (  19.60  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Keith Busch <kbusch@kernel.org>

Some people _really_ want to control their interrupt affinity,
preferring to sacrafice storage performance for scheduling
predicatability on some other subset of CPUs.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
Sorry for the rapid fire v2, and I know some are still aginst this; I'm
just getting v2 out because v1 breaks a different use case.

And as far as acceptance goes, this doesn't look like it carries any
longterm maintenance overhead. It's an opt-in feature, and you're own
your own if you turn it on.

v1->v2: skip the the AFFINITY vector allocation if the parameter is
provided instead trying to make the vector code handle all post_vectors.

 drivers/nvme/host/pci.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 8e0bb9692685d..def1a295284bb 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -63,6 +63,11 @@ MODULE_PARM_DESC(sgl_threshold,
 		"Use SGLs when average request segment size is larger or equal to "
 		"this size. Use 0 to disable SGLs.");
=20
+static bool managed_irqs =3D true;
+module_param(managed_irqs, bool, 0444);
+MODULE_PARM_DESC(managed_irqs,
+		 "set to false for user controlled irq affinity");
+
 #define NVME_PCI_MIN_QUEUE_SIZE 2
 #define NVME_PCI_MAX_QUEUE_SIZE 4095
 static int io_queue_depth_set(const char *val, const struct kernel_param=
 *kp);
@@ -456,7 +461,7 @@ static void nvme_pci_map_queues(struct blk_mq_tag_set=
 *set)
 		 * affinity), so use the regular blk-mq cpu mapping
 		 */
 		map->queue_offset =3D qoff;
-		if (i !=3D HCTX_TYPE_POLL && offset)
+		if (managed_irqs && i !=3D HCTX_TYPE_POLL && offset)
 			blk_mq_pci_map_queues(map, to_pci_dev(dev->dev), offset);
 		else
 			blk_mq_map_queues(map);
@@ -2218,6 +2223,7 @@ static int nvme_setup_irqs(struct nvme_dev *dev, un=
signed int nr_io_queues)
 		.priv		=3D dev,
 	};
 	unsigned int irq_queues, poll_queues;
+	int ret;
=20
 	/*
 	 * Poll queues don't need interrupts, but we need at least one I/O queu=
e
@@ -2241,8 +2247,15 @@ static int nvme_setup_irqs(struct nvme_dev *dev, u=
nsigned int nr_io_queues)
 	irq_queues =3D 1;
 	if (!(dev->ctrl.quirks & NVME_QUIRK_SINGLE_VECTOR))
 		irq_queues +=3D (nr_io_queues - poll_queues);
-	return pci_alloc_irq_vectors_affinity(pdev, 1, irq_queues,
+
+	if (managed_irqs)
+		return pci_alloc_irq_vectors_affinity(pdev, 1, irq_queues,
 			      PCI_IRQ_ALL_TYPES | PCI_IRQ_AFFINITY, &affd);
+
+	ret =3D pci_alloc_irq_vectors(pdev, 1, irq_queues, PCI_IRQ_ALL_TYPES);
+	if (ret > 0)
+		nvme_calc_irq_sets(&affd, ret - 1);
+	return ret;
 }
=20
 static unsigned int nvme_max_io_queues(struct nvme_dev *dev)
--=20
2.43.0



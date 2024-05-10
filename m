Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1D98C25B5F
	for <linux-nvme@archiver.kernel.org>; Fri, 10 May 2024 14:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Nm6THcMHLzSQGtzts3MDymgxIqVwbrbSsGjVJ9k2GdE=; b=oTCV9MhiD/SILLlnIJcahfNbHM
	nexLMhZz2rmb3rpGA9R2ZtAa9utk+ZbxObNPvnbDgLTlqUpjGBH1CRYslSwuR8fMu/LS9b18BbcKS
	17WIbttonf6+ibusvDN96aS87FRKD0bLPw0cf+5QcBEOmUtWko123+vpaXHtuWO5AYdFFOT2fnt8q
	xpAgzd5iG1vhSC1UgvGFFdZJwRoz0K0mHCdcVu5MgDWWLSVTaUcSeKBeIYbeBZOiqpbgN6hwq1RZY
	joOS4HUVOY21LAlE5APTV59P6r6Hfll7K1181hXxvSio0Ly73EzxVCbf1CHCh624J1VYxlyEJxO1W
	h0ivK6ew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s5R27-00000005WMN-2p3L;
	Fri, 10 May 2024 14:15:35 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s5R24-00000005WHM-2UDG
	for linux-nvme@lists.infradead.org;
	Fri, 10 May 2024 14:15:34 +0000
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44A0Pv80003998
	for <linux-nvme@lists.infradead.org>; Fri, 10 May 2024 07:15:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=s2048-2021-q4;
 bh=Nm6THcMHLzSQGtzts3MDymgxIqVwbrbSsGjVJ9k2GdE=;
 b=HXVHKJp5AsJ00vAZSpg0krVekTXebYAxzlFwi2GBYstG2q+JkLmwFI9m3mWtDkVgBPm+
 52+IHUef+qRvZZhKowdkeZzsM+bgEmgdTZ/EG8sKk8PKetPhmBc7xOel1nVHyGmyEKhS
 8cSE5DLO/67wAw2MyuKOsDwgcNJePGAYU4sUN6iySU/ErrEIPp5JAKu4D5KwzDl2YYbT
 xlHyeA5CCrMp/xWu4pHg5ZI8vOc4RlLkomgBEI5MacUytpqcJoAPedfH0lN02iMUR7lf
 bla4e0VbA//L5ex2XWHmf+lZ6rx48r830ddEcfnih8ijwi9mxohrK/sAdoDcRO2LYqPf LQ== 
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3y16pwbkpw-11
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Fri, 10 May 2024 07:15:20 -0700
Received: from twshared8926.02.ash9.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:21d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 10 May 2024 07:15:08 -0700
Received: by devbig032.nao3.facebook.com (Postfix, from userid 544533)
	id 8393F2633F53; Fri, 10 May 2024 07:15:06 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <hch@lst.de>, <tglx@linutronix.de>, <ming.lei@redhat.com>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCH 2/2] nvme-pci: allow unmanaged interrupts
Date: Fri, 10 May 2024 07:14:59 -0700
Message-ID: <20240510141459.3207725-2-kbusch@meta.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240510141459.3207725-1-kbusch@meta.com>
References: <20240510141459.3207725-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 36IrxD7G2hg63QFoNX6Zh5iYRGlGL5Ci
X-Proofpoint-ORIG-GUID: 36IrxD7G2hg63QFoNX6Zh5iYRGlGL5Ci
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-10_10,2024-05-10_02,2023-05-22_02
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240510_071532_671893_119AA1BD 
X-CRM114-Status: GOOD (  18.27  )
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

Some people _really_ want to control their interrupt affinity.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/pci.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 8e0bb9692685d..4c2799c3f45f5 100644
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
@@ -2180,6 +2185,9 @@ static void nvme_calc_irq_sets(struct irq_affinity =
*affd, unsigned int nrirqs)
 	struct nvme_dev *dev =3D affd->priv;
 	unsigned int nr_read_queues, nr_write_queues =3D dev->nr_write_queues;
=20
+	if (!nrirqs)
+		nrirqs =3D affd->post_vectors;
+
 	/*
 	 * If there is no interrupt available for queues, ensure that
 	 * the default queue is set to 1. The affinity set size is
@@ -2226,6 +2234,9 @@ static int nvme_setup_irqs(struct nvme_dev *dev, un=
signed int nr_io_queues)
 	poll_queues =3D min(dev->nr_poll_queues, nr_io_queues - 1);
 	dev->io_queues[HCTX_TYPE_POLL] =3D poll_queues;
=20
+	if (!managed_irqs)
+		affd.post_vectors =3D nr_io_queues - poll_queues;
+
 	/*
 	 * Initialize for the single interrupt case, will be updated in
 	 * nvme_calc_irq_sets().
--=20
2.43.0



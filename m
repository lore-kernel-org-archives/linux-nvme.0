Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFD73C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jun 2022 19:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-ID:Date:Subject:CC
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yOqmbYHBO8gpbKtdMH3tdiSGxVZAyj/ZxxBgca9rUUs=; b=M9Wo0MQ2zncVgHxLmXuLyrXmsK
	NKM4nDNmcaaiZIg/JeZOmTvZR1IJ2wRV8o8Bh96YahqlgCAazFKPUprG0zfiz8hdxljarPRDCqMP8
	EakLrJeZsIMUIGnDTvZ1NHkLbNT8sXaC5WBKxEFwHV0oEDw/9Erx6BnqVnjrnIw9zudYfB7wX5pdo
	fSwEedVHbBLlL4m+Fa+Mu/Jsw52V88z6xSVJYFfpLUTmKTCUp/NkUgFWLPJY7IGaLNCzFigwaIJm7
	37x/PjH0KbInA8RSCeBPWk24RUVKWyWQxPh69kETSyOzQ9rfnRR6MYV6s6Rw2wgpH+XK3XBNOC8SE
	WhnZAQhA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o6GeE-007n29-QL; Tue, 28 Jun 2022 19:13:18 +0000
Received: from mailout1.w1.samsung.com ([210.118.77.11])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o6Ge0-007muA-S2
	for linux-nvme@lists.infradead.org; Tue, 28 Jun 2022 19:13:10 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220628191258euoutp010bda090359c6a22f3fe37892e22dcb42~83qiK39J43036130361euoutp01O
	for <linux-nvme@lists.infradead.org>; Tue, 28 Jun 2022 19:12:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220628191258euoutp010bda090359c6a22f3fe37892e22dcb42~83qiK39J43036130361euoutp01O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1656443578;
	bh=yOqmbYHBO8gpbKtdMH3tdiSGxVZAyj/ZxxBgca9rUUs=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=U8RhU9rlkcDbn+Yr62BmIFDy6T2Ofni6hleyV6AqOCTNM8RWsnGnQkeNr2/jIscLX
	 jaXo2Vi9DFF7i8ctysEQ+NmmlrqVOyd3WfpHmIBFmSHCa7jpRiA+JWunvwhP5mzjFc
	 X5yGQ3Ku971iVx//5P2e69Ir2ajdMdUuezsXMHEM=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20220628191258eucas1p17539f7bca74f9cd89039a975d938c870~83qh2GNpo2508525085eucas1p19;
	Tue, 28 Jun 2022 19:12:58 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 9C.68.09664.9B25BB26; Tue, 28
	Jun 2022 20:12:57 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20220628191257eucas1p222ee04ca7e25bb96a7705bb7c07083db~83qhXpiQp2071420714eucas1p2L;
	Tue, 28 Jun 2022 19:12:57 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20220628191257eusmtrp19a72753b296cc705035abe4f614827ad~83qhXFIE12062620626eusmtrp1h;
	Tue, 28 Jun 2022 19:12:57 +0000 (GMT)
X-AuditID: cbfec7f2-d97ff700000025c0-87-62bb52b9a7a0
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 35.6F.09095.9B25BB26; Tue, 28
	Jun 2022 20:12:57 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20220628191257eusmtip27adf86f9bf72a04d6f64523ec2f338c4~83qhLCN4r1650616506eusmtip2U;
	Tue, 28 Jun 2022 19:12:57 +0000 (GMT)
Received: from localhost (106.110.32.33) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Tue, 28 Jun 2022 20:12:56 +0100
From: Joel Granados <j.granados@samsung.com>
To: <hch@lst.de>, <sagi@grimberg.me>, <kbusch@kernel.org>
CC: <joshi.k@samsung.com>, <k.jensen@samsung.com>,
	<linux-nvme@lists.infradead.org>, <gost.dev@samsung.com>
Subject: [PATCH v4 2/2] nvme: enable generic interface (/dev/ngXnY) for
 unknown command sets
Date: Tue, 28 Jun 2022 21:10:16 +0200
Message-ID: <20220628191016.291935-3-j.granados@samsung.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220628191016.291935-1-j.granados@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [106.110.32.33]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrHIsWRmVeSWpSXmKPExsWy7djP87o7g3YnGSzeY2WxcvVRJotJh64x
	Wsxf9pTdYt3r9ywOLB7n721k8di0qpPNY/OSeo/dNxvYAliiuGxSUnMyy1KL9O0SuDJ2975n
	LtjmXvHrzhTWBsaJVl2MnBwSAiYSE2b+YO1i5OIQEljBKLFv1k12COcLo8TZSxegMp8ZJX79
	bGWDabn2YxkTRGI5o8SWhgPMcFWzeudA9W9mlHg99SI7SAubgI7E+Td3mEFsEQFLid4Pt8Bs
	ZoFcic3bdrCC2MICcRLnti8Ci7MIqEqs/vCCEcTmFbCRaDjZyQSxWl6i7fp0sDingK3E/S2P
	2SBqBCVOznzCAjFTXqJ562yo+RISB1+8YIboVZTYMuc7K4RdK3Fqyy2omRc4JHb2h0PYLhIb
	f82CigtLvDq+hR3ClpE4PbmHBcLOltg5ZRfUzAKJWSenAt3AAWRbS/SdyYEIO0o8/zeJCSLM
	J3HjrSDENXwSk7ZNZ4YI80p0tAlNYFSZheT+WUjun4Xk/gWMzKsYxVNLi3PTU4sN81LL9YoT
	c4tL89L1kvNzNzECk8jpf8c/7WCc++qj3iFGJg7GQ4wSHMxKIrwLz+xMEuJNSaysSi3Kjy8q
	zUktPsQozcGiJM6bnLkhUUggPbEkNTs1tSC1CCbLxMEp1cCk37+jbbrrxUKDwDT1mqXPf360
	PJI179Pt5VV1oSf/JHQ3fj8+5XtjgMyBGg9P2bZtqtdbW15V7zRxdZeP7lspnq/fflRJqCI+
	sadp/9Lug3/3y9oop7qpxHNsL/r6P/vYQdbDlx99rJkUZaW/e9Wb9b9e/a6OWzmtwur3PusP
	UVU/LU4FLjcSmKT6jHGR+u5N5UsDe1QbdJeYeG0UmLvQwDrSbtvrn82Pt8Ztf20Q29iReMMx
	XD3x4z/f9yx38s4u+rSZT4CVJeXC0wcRAhblJ5KTTgSEVvV8iI/dOe1W2/PpRl/YFfft4vhy
	PVDPk8k7fzvv0wzu3H/LzLSveuQv9bT77Vne5D6DY//U1dlKLMUZiYZazEXFiQAyI9g4kQMA
	AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJIsWRmVeSWpSXmKPExsVy+t/xe7o7g3YnGUycK22xcvVRJotJh64x
	Wsxf9pTdYt3r9ywOLB7n721k8di0qpPNY/OSeo/dNxvYAlii9GyK8ktLUhUy8otLbJWiDS2M
	9AwtLfSMTCz1DI3NY62MTJX07WxSUnMyy1KL9O0S9DJ2975nLtjmXvHrzhTWBsaJVl2MnBwS
	AiYS134sY+pi5OIQEljKKPH9221WiISMxKcrH9khbGGJP9e62CCKPjJKdDdvYIFwNjNKbNrZ
	xwRSxSagI3H+zR1mEFtEwFKi98MtMJtZIFdi87YdYFOFBWIklu24ygJiswioSqz+8IIRxOYV
	sJFoONnJBLFNXqLt+nSwOKeArcT9LY/ZQGwhoJplm28wQdQLSpyc+YQFYr68RPPW2VC7JCQO
	vnjBDDFHUWLLnO9Q39RKfP77jHECo8gsJO2zkLTPQtK+gJF5FaNIamlxbnpusaFecWJucWle
	ul5yfu4mRmCcbTv2c/MOxnmvPuodYmTiYDzEKMHBrCTCu/DMziQh3pTEyqrUovz4otKc1OJD
	jKZAf05klhJNzgdGel5JvKGZgamhiZmlgamlmbGSOK9nQUeikEB6YklqdmpqQWoRTB8TB6dU
	A1Pm2dorkvvjVt+7NnnzHg2JL1Mszysu3v6345aKQbjuRPWW729dDnjW7z7Y/dd5demXS84B
	dSUOzgw3N18VyT40iZfj0I6129cdnOvkyH2KRclb+EW2ouze26FmRnOfxfGeya3a0LV7aWKz
	jeBR9kDNi7H1DTbrWRxkNyusCWScdFHiTt7DH5m2AseuCjg/lkv1X5LeZ7LvhlGH+BqTRb9b
	kicWbeUR2bi8V/J8d0L08dmSemU/p07YZOLuKHd844542cg7N24ov591d5k1w5K8hOxalqI9
	Tt3eMmLaqidy/6yesXNj38UVd/y13myuk1i3vyzhqVJezbHzDBMnpAmJ1EzXZIjUKp+9W99+
	u6QSS3FGoqEWc1FxIgBkb/9tPAMAAA==
X-CMS-MailID: 20220628191257eucas1p222ee04ca7e25bb96a7705bb7c07083db
X-Msg-Generator: CA
X-RootMTR: 20220628191257eucas1p222ee04ca7e25bb96a7705bb7c07083db
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220628191257eucas1p222ee04ca7e25bb96a7705bb7c07083db
References: <20220628191016.291935-1-j.granados@samsung.com>
	<CGME20220628191257eucas1p222ee04ca7e25bb96a7705bb7c07083db@eucas1p2.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220628_121305_376850_1DC5A322 
X-CRM114-Status: GOOD (  23.52  )
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

Extend nvme_alloc_ns() and nvme_validate_ns() for unknown command-set as
well. Both are made to use a new helper (nvme_update_ns_info_cs_indep)
which is similar to nvme_update_ns_info but performs fewer operations
to get the generic interface up.

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Joel Granados <j.granados@samsung.com>
Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
---
 drivers/nvme/host/core.c | 164 +++++++++++++++++++++++++++------------
 1 file changed, 115 insertions(+), 49 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 0fd6127da8d1..45ad1bbe0c33 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1425,28 +1425,30 @@ static int nvme_identify_ns(struct nvme_ctrl *ctrl, unsigned nsid,
 }
 
 static int nvme_identify_ns_cs_indep(struct nvme_ctrl *ctrl, unsigned nsid,
-			struct nvme_id_ns_cs_indep **id)
+			struct nvme_id_ns_cs_indep **indep_id)
 {
 	struct nvme_command c = {
 		.identify.opcode	= nvme_admin_identify,
 		.identify.nsid		= cpu_to_le32(nsid),
 		.identify.cns		= NVME_ID_CNS_NS_CS_INDEP,
 	};
+	struct nvme_id_ns_cs_indep *id;
 	int ret;
 
-	*id = kmalloc(sizeof(**id), GFP_KERNEL);
-	if (!*id)
+	id = kmalloc(sizeof(**indep_id), GFP_KERNEL);
+	if (!id)
 		return -ENOMEM;
 
-	ret = nvme_submit_sync_cmd(ctrl->admin_q, &c, *id, sizeof(**id));
+	ret = nvme_submit_sync_cmd(ctrl->admin_q, &c, id, sizeof(**indep_id));
 	if (ret) {
 		dev_warn(ctrl->device,
 			 "Identify namespace (CS independent) failed (%d)\n",
 			 ret);
-		kfree(*id);
+		kfree(id);
 		return ret;
 	}
 
+	*indep_id = id;
 	return 0;
 }
 
@@ -1908,6 +1910,39 @@ static void nvme_set_chunk_sectors(struct nvme_ns *ns, struct nvme_id_ns *id)
 	blk_queue_chunk_sectors(ns->queue, iob);
 }
 
+static void nvme_update_ns_mpath_info_general(struct nvme_ns *ns, __u8 nsattr)
+{
+	set_disk_ro(ns->head->disk,
+		    (nsattr & NVME_NS_ATTR_RO) ||
+			    test_bit(NVME_NS_FORCE_RO, &ns->flags));
+	nvme_mpath_revalidate_paths(ns);
+	blk_stack_limits(&ns->head->disk->queue->limits,
+			 &ns->queue->limits, 0);
+}
+
+static int nvme_update_ns_info_cs_indep(struct nvme_ns *ns,
+					struct nvme_id_ns_cs_indep *id)
+{
+	blk_mq_freeze_queue(ns->disk->queue);
+	nvme_set_queue_limits(ns->ctrl, ns->queue);
+	set_disk_ro(ns->disk, (id->nsattr & NVME_NS_ATTR_RO) ||
+		test_bit(NVME_NS_FORCE_RO, &ns->flags));
+	blk_mq_unfreeze_queue(ns->disk->queue);
+
+	if (nvme_ns_head_multipath(ns->head)) {
+		blk_mq_freeze_queue(ns->head->disk->queue);
+		nvme_update_ns_mpath_info_general(ns, id->nsattr);
+		ns->head->disk->flags |= GENHD_FL_HIDDEN;
+		blk_mq_unfreeze_queue(ns->head->disk->queue);
+	}
+
+	/* Hide the block-interface for these devices */
+	ns->disk->flags |= GENHD_FL_HIDDEN;
+	set_bit(NVME_NS_READY, &ns->flags);
+
+	return 0;
+}
+
 static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_id_ns *id)
 {
 	unsigned lbaf = nvme_lbaf_index(id->flbas);
@@ -1941,12 +1976,7 @@ static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_id_ns *id)
 	if (nvme_ns_head_multipath(ns->head)) {
 		blk_mq_freeze_queue(ns->head->disk->queue);
 		nvme_update_disk_info(ns->head->disk, ns, id);
-		set_disk_ro(ns->head->disk,
-			    (id->nsattr & NVME_NS_ATTR_RO) ||
-				    test_bit(NVME_NS_FORCE_RO, &ns->flags));
-		nvme_mpath_revalidate_paths(ns);
-		blk_stack_limits(&ns->head->disk->queue->limits,
-				 &ns->queue->limits, 0);
+		nvme_update_ns_mpath_info_general(ns, id->nsattr);
 		disk_update_readahead(ns->head->disk);
 		blk_mq_unfreeze_queue(ns->head->disk->queue);
 	}
@@ -3951,15 +3981,31 @@ static void nvme_ns_add_to_ctrl_list(struct nvme_ns *ns)
 }
 
 static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid,
-		struct nvme_ns_ids *ids)
+		struct nvme_ns_ids *ids, struct nvme_id_ns_cs_indep *indep_id)
 {
+	int ret = 0;
 	struct nvme_ns *ns;
 	struct gendisk *disk;
-	struct nvme_id_ns *id;
+	struct nvme_id_ns *id = NULL;
 	int node = ctrl->numa_node;
+	__u8 nmic;
+	__le32 anagrpid;
 
-	if (nvme_identify_ns(ctrl, nsid, ids, &id))
-		return;
+	switch (ids->csi) {
+	case NVME_CSI_NVM:
+	case NVME_CSI_ZNS:
+		if (nvme_identify_ns(ctrl, nsid, ids, &id))
+			return;
+		nmic = id->nmic;
+		anagrpid = id->anagrpid;
+		break;
+	default:
+		if (!indep_id)
+			return;
+		nmic = indep_id->nmic;
+		anagrpid = indep_id->anagrpid;
+		break;
+	}
 
 	ns = kzalloc_node(sizeof(*ns), GFP_KERNEL, node);
 	if (!ns)
@@ -3984,7 +4030,7 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid,
 	ns->ctrl = ctrl;
 	kref_init(&ns->kref);
 
-	if (nvme_init_ns_head(ns, nsid, ids, id->nmic & NVME_NS_NMIC_SHARED))
+	if (nvme_init_ns_head(ns, nsid, ids, nmic & NVME_NS_NMIC_SHARED))
 		goto out_cleanup_disk;
 
 	/*
@@ -4010,7 +4056,16 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid,
 			ns->head->instance);
 	}
 
-	if (nvme_update_ns_info(ns, id))
+	switch (ids->csi) {
+	case NVME_CSI_NVM:
+	case NVME_CSI_ZNS:
+		ret = nvme_update_ns_info(ns, id);
+		break;
+	default:
+		ret = nvme_update_ns_info_cs_indep(ns, indep_id);
+		break;
+	}
+	if (ret)
 		goto out_unlink_ns;
 
 	down_write(&ctrl->namespaces_rwsem);
@@ -4024,11 +4079,10 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid,
 	if (!nvme_ns_head_multipath(ns->head))
 		nvme_add_ns_cdev(ns);
 
-	nvme_mpath_add_disk(ns, id->anagrpid);
+	nvme_mpath_add_disk(ns, anagrpid);
 	nvme_fault_inject_init(&ns->fault_inject, ns->disk->disk_name);
-	kfree(id);
 
-	return;
+	goto out_free_id;
 
  out_cleanup_ns_from_list:
 	nvme_put_ctrl(ctrl);
@@ -4106,29 +4160,34 @@ static void nvme_ns_remove_by_nsid(struct nvme_ctrl *ctrl, u32 nsid)
 	}
 }
 
-static void nvme_validate_ns(struct nvme_ns *ns, struct nvme_ns_ids *ids)
+static void nvme_validate_ns(struct nvme_ns *ns, struct nvme_ns_ids *ids,
+			     struct nvme_id_ns_cs_indep *indep_id)
 {
-	struct nvme_id_ns *id;
+	struct nvme_id_ns *id = NULL;
 	int ret = NVME_SC_INVALID_NS | NVME_SC_DNR;
 
 	if (test_bit(NVME_NS_DEAD, &ns->flags))
 		goto out;
 
-	ret = nvme_identify_ns(ns->ctrl, ns->head->ns_id, ids, &id);
-	if (ret)
-		goto out;
-
-	ret = NVME_SC_INVALID_NS | NVME_SC_DNR;
-	if (!nvme_ns_ids_equal(&ns->head->ids, ids)) {
-		dev_err(ns->ctrl->device,
-			"identifiers changed for nsid %d\n", ns->head->ns_id);
-		goto out_free_id;
+	switch (ids->csi) {
+	case NVME_CSI_NVM:
+	case NVME_CSI_ZNS:
+		if (nvme_identify_ns(ns->ctrl, ns->head->ns_id, ids, &id))
+			goto out;
+		if (!nvme_ns_ids_equal(&ns->head->ids, ids))
+			dev_err(ns->ctrl->device,
+				"identifiers changed for nsid %d\n",
+				ns->head->ns_id);
+		else
+			ret = nvme_update_ns_info(ns, id);
+		kfree(id);
+		break;
+	default:
+		if (indep_id)
+			ret = nvme_update_ns_info_cs_indep(ns, indep_id);
+		break;
 	}
 
-	ret = nvme_update_ns_info(ns, id);
-
-out_free_id:
-	kfree(id);
 out:
 	/*
 	 * Only remove the namespace if we got a fatal error back from the
@@ -4143,36 +4202,34 @@ static void nvme_validate_ns(struct nvme_ns *ns, struct nvme_ns_ids *ids)
 static void nvme_validate_or_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 {
 	struct nvme_ns_ids ids = { };
-	struct nvme_id_ns_cs_indep *id;
+	struct nvme_id_ns_cs_indep *indep_id = NULL;
 	struct nvme_ns *ns;
-	bool ready = true;
+	int ret;
 
 	if (nvme_identify_ns_descs(ctrl, nsid, &ids))
 		return;
 
+	ret = nvme_identify_ns_cs_indep(ctrl, nsid, &indep_id);
+
 	/*
 	 * Check if the namespace is ready.  If not ignore it, we will get an
 	 * AEN once it becomes ready and restart the scan.
 	 */
-	if ((ctrl->cap & NVME_CAP_CRMS_CRIMS) &&
-	    !nvme_identify_ns_cs_indep(ctrl, nsid, &id)) {
-		ready = id->nstat & NVME_NSTAT_NRDY;
-		kfree(id);
+	if ((ctrl->cap & NVME_CAP_CRMS_CRIMS) && !ret) {
+		if (!(indep_id->nstat & NVME_NSTAT_NRDY))
+			goto free_indep_id;
 	}
 
-	if (!ready)
-		return;
-
 	ns = nvme_find_get_ns(ctrl, nsid);
 	if (ns) {
-		nvme_validate_ns(ns, &ids);
+		nvme_validate_ns(ns, &ids, indep_id);
 		nvme_put_ns(ns);
-		return;
+		goto free_indep_id;
 	}
 
 	switch (ids.csi) {
 	case NVME_CSI_NVM:
-		nvme_alloc_ns(ctrl, nsid, &ids);
+		nvme_alloc_ns(ctrl, nsid, &ids, indep_id);
 		break;
 	case NVME_CSI_ZNS:
 		if (!IS_ENABLED(CONFIG_BLK_DEV_ZONED)) {
@@ -4187,13 +4244,22 @@ static void nvme_validate_or_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 				nsid);
 			break;
 		}
-		nvme_alloc_ns(ctrl, nsid, &ids);
+		nvme_alloc_ns(ctrl, nsid, &ids, indep_id);
 		break;
 	default:
-		dev_warn(ctrl->device, "unknown csi %u for nsid %u\n",
+		/* enable char-interface for unknown command sets*/
+		if (!ret) {
+			nvme_alloc_ns(ctrl, nsid, &ids, indep_id);
+			break;
+		}
+		dev_warn(ctrl->device,
+			"unknown csi %u for nsid %u not supported\n",
 			ids.csi, nsid);
 		break;
 	}
+
+free_indep_id:
+	kfree(indep_id);
 }
 
 static void nvme_remove_invalid_namespaces(struct nvme_ctrl *ctrl,
-- 
2.30.2



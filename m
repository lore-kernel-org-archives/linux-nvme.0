Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DCD9CCA482
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Jun 2022 13:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-ID:Date:Subject:CC
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/k8M4M4vMU8bMitVLyTG2WRgLGODmSNhwgbc5E8gDMA=; b=ilw5R3hYrsQEfvLrYNCSgn1ktn
	uJkcIx4QCHZdBxlCgGEOL6WG8MH6EoWs3dApo863bZOXNfkzNUzzPEqu1qWrCNCX8AG5lknJy8iSz
	9t5pw1KvNC+ZnL4lH0tx2/yKBPrZTImSY92N/JeQIGb+o/EvP7cN67+KnKfcVZCbyKwNVyXQq4i15
	gPh9DYFq9TRlFRsefw6vlUKQeX8qOxXjCjEtI/Ujht5BmX3Crf2xTX2fUKe0ylR6i1HnORkP1I3pA
	7k0vezzZvoTmHZk4CewMDRYo8zW0ffvjimJ33cYpFieleZomM9Ns54QsTLxrjmm8s+BgOC4GczokS
	cTfw28Cg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o40sv-00AkhX-4C; Wed, 22 Jun 2022 13:59:09 +0000
Received: from mailout1.w1.samsung.com ([210.118.77.11])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o40sf-00AkcV-Im
	for linux-nvme@lists.infradead.org; Wed, 22 Jun 2022 13:58:59 +0000
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220622135845euoutp01960d712335ae158bd38f99a0b667790c~69geeHK4f2215322153euoutp01A
	for <linux-nvme@lists.infradead.org>; Wed, 22 Jun 2022 13:58:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220622135845euoutp01960d712335ae158bd38f99a0b667790c~69geeHK4f2215322153euoutp01A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1655906325;
	bh=/k8M4M4vMU8bMitVLyTG2WRgLGODmSNhwgbc5E8gDMA=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=StH9SF4Tp/6kMdSfc3Ew/FHRn7V+kVI67evaSXQL/RHrzGbzI1CzVEu5B3T50jN44
	 FBeRQn5UiqPil+z3LI6ltg3t7X5pcpRkQkUqR+xKGj3c76gbv5ayklVdtDRT3ftOX+
	 obNkEidpu7jDglu6ZYJaZ8uCHs6v+tz40/1fqSHU=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20220622135845eucas1p12e969cc397aefe086c205e4934f00b5e~69geCliZE2417824178eucas1p1U;
	Wed, 22 Jun 2022 13:58:45 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id 41.04.09580.51023B26; Wed, 22
	Jun 2022 14:58:45 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20220622135844eucas1p1c224ccf50c43f722cc228c59d8c395a7~69gdwi6SP2417824178eucas1p1T;
	Wed, 22 Jun 2022 13:58:44 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20220622135844eusmtrp14e79e4f371cfbed890735824b9253a8e~69gdv6r6r2588525885eusmtrp1N;
	Wed, 22 Jun 2022 13:58:44 +0000 (GMT)
X-AuditID: cbfec7f5-9c3ff7000000256c-97-62b3201515ae
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id BF.7C.09095.41023B26; Wed, 22
	Jun 2022 14:58:44 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20220622135844eusmtip1ddb1d5ad8b12061e034496133b38f5ab~69gdneBqq0250302503eusmtip1E;
	Wed, 22 Jun 2022 13:58:44 +0000 (GMT)
Received: from localhost (106.110.32.33) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Wed, 22 Jun 2022 14:58:43 +0100
From: Joel Granados <j.granados@samsung.com>
To: <hch@lst.de>, <kbusch@kernel.org>
CC: <linux-nvme@lists.infradead.org>, <joshi.k@samsung.com>,
	<gost.dev@samsung.com>, <k.jensen@samsung.com>
Subject: [PATCH v3 2/2] nvme: enable generic interface (/dev/ngXnY) for
 unknown command sets
Date: Wed, 22 Jun 2022 15:55:56 +0200
Message-ID: <20220622135556.2185991-3-j.granados@samsung.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220622135556.2185991-1-j.granados@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [106.110.32.33]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMIsWRmVeSWpSXmKPExsWy7djPc7qiCpuTDJrns1qsXH2UyWLSoWuM
	FvOXPWV3YPbYtKqTzWPzknqP3Tcb2AKYo7hsUlJzMstSi/TtErgyHv6awFKwy6Li95Iz7A2M
	LXpdjBwcEgImEnNWyncxcnEICaxglHi77TgThPOFUeLez4/sEM5nRonNFx4zdzFygnV83fgI
	KrGcUeLznKsIVd1H/kL1b2aU2PelgR2khU1AR+L8mzvMIAtFBFQl9rXYgoSZBXIlGue9AZsq
	LBAnsf3EdDCbBajkxfpjLCA2r4CtxNQjt1ghNstLtF2fzghicwrYSTzYtYsJokZQ4uTMJywQ
	M+UlmrfOZoawJSQOvngBdbWixJY536Hm1Eqc2nIL7E4JgQMcEj/WLGWBSLhIPLnxmR3CFpZ4
	dXwLlC0jcXpyD1RNtsTOKbughhZIzDo5lQ0SkNYSfWdyIMKOEitvPWKCCPNJ3HgrCHEOn8Sk
	bdOZIcK8Eh1tQhMYVWYheWAWkgdmIXlgASPzKkbx1NLi3PTUYuO81HK94sTc4tK8dL3k/NxN
	jMB0cfrf8a87GFe8+qh3iJGJg/EQowQHs5IIrw33hiQh3pTEyqrUovz4otKc1OJDjNIcLEri
	vMmZGxKFBNITS1KzU1MLUotgskwcnFINTAGm695KyObfPtnynPnFS5X3EzyDtG8b/5v4iT13
	66dtOnwlzKvX7Q3YJCl7u+yf3YHWB3X1ezUPWQm88G8sfX1zsuKC87Ypx8K2XmZ+cUD00rv0
	wzETxW95m4XzqcXcD+xrPrCp1uyW3q+TL62bVxi7afyV3yvhmlvz9vfDuSm3t1z6E/nE9ldn
	Pcez0Kz6Xx0HJgSrPnfeMmeL9WRP0f/1UfFvHk9/eyrh8GzWhGvqi350J74QVnsfne67d0vh
	/Kcqm4xutfTMcNk8PVDRU8Zx6s9zNfkeEb2v5Ew6XjMdfzG5/IPnMnOfxqCG7gdHvonl7Xqz
	dYZp5NQpa+OU5ka2h3yXCPbevK/6WW7IiQYlluKMREMt5qLiRACpuXQyhgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLIsWRmVeSWpSXmKPExsVy+t/xu7oiCpuTDG536VmsXH2UyWLSoWuM
	FvOXPWV3YPbYtKqTzWPzknqP3Tcb2AKYo/RsivJLS1IVMvKLS2yVog0tjPQMLS30jEws9QyN
	zWOtjEyV9O1sUlJzMstSi/TtEvQyHv6awFKwy6Li95Iz7A2MLXpdjJwcEgImEl83PmLvYuTi
	EBJYyigxbWcLG0RCRuLTlY/sELawxJ9rXWBxIYGPjBL/HxZDNGxmlFh+6AYzSIJNQEfi/Js7
	QDYHh4iAqsS+FluQMLNArkTjvDdgJcICMRLT194Fm8kCVPJi/TEWEJtXwFZi6pFbrBC75CXa
	rk9nBLE5BewkHuzaxQSx11aicf8mdoh6QYmTM5+wQMyXl2jeOpsZwpaQOPjiBTPEHEWJLXO+
	Q82slfj89xnjBEaRWUjaZyFpn4WkfQEj8ypGkdTS4tz03GJDveLE3OLSvHS95PzcTYzAeNp2
	7OfmHYzzXn3UO8TIxMF4iFGCg1lJhNeGe0OSEG9KYmVValF+fFFpTmrxIUZToD8nMkuJJucD
	IzqvJN7QzMDU0MTM0sDU0sxYSZzXs6AjUUggPbEkNTs1tSC1CKaPiYNTqoFJNfrbnm9CUb/Z
	vyz1u+lbV9Nfq+z33E5++WfZUKam1YsefKxz4xUrX7KNmVVaevnP2/MS5Hbdea6e31Soxfyp
	ONry54+2XR8inrBYTvuofOXfmfDdKROto9eal3/3cOay57kVKKc/I+9Z1fqThzTmC7cvuTaP
	RfrW2WPBfn5vUwLOvCosWRtzc95ul8SYuGchXD8PRl38XRzpqXnw0aelxT9fNLd/8912Quzl
	fq/U3M3duxb5yPOIHjuz66j5z9Q0GS+mlj2vNq/b3yVfuiQv9ee26Zmp1+xPu7GH3m2WXPhd
	0/jP5aPHus5O2rr1yLsLiS9rS9TatVxnSL7UzsgU8DrTL7vO8M6yRo/4DQz8SizFGYmGWsxF
	xYkAAMvc5zADAAA=
X-CMS-MailID: 20220622135844eucas1p1c224ccf50c43f722cc228c59d8c395a7
X-Msg-Generator: CA
X-RootMTR: 20220622135844eucas1p1c224ccf50c43f722cc228c59d8c395a7
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220622135844eucas1p1c224ccf50c43f722cc228c59d8c395a7
References: <20220622135556.2185991-1-j.granados@samsung.com>
	<CGME20220622135844eucas1p1c224ccf50c43f722cc228c59d8c395a7@eucas1p1.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220622_065854_309888_C9DEA425 
X-CRM114-Status: GOOD (  22.59  )
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
 drivers/nvme/host/core.c | 132 +++++++++++++++++++++++++++------------
 1 file changed, 93 insertions(+), 39 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 0fd6127da8d1..03ba3d0f4d3a 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1908,6 +1908,34 @@ static void nvme_set_chunk_sectors(struct nvme_ns *ns, struct nvme_id_ns *id)
 	blk_queue_chunk_sectors(ns->queue, iob);
 }
 
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
+		set_disk_ro(ns->head->disk,
+			    (id->nsattr & NVME_NS_ATTR_RO) ||
+				    test_bit(NVME_NS_FORCE_RO, &ns->flags));
+		nvme_mpath_revalidate_paths(ns);
+		blk_stack_limits(&ns->head->disk->queue->limits,
+				 &ns->queue->limits, 0);
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
@@ -3951,15 +3979,29 @@ static void nvme_ns_add_to_ctrl_list(struct nvme_ns *ns)
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
+	__u8 *nmic;
+	__le32 *anagrpid;
 
-	if (nvme_identify_ns(ctrl, nsid, ids, &id))
-		return;
+	switch (ids->csi) {
+	case NVME_CSI_NVM:
+	case NVME_CSI_ZNS:
+		if (nvme_identify_ns(ctrl, nsid, ids, &id))
+			return;
+		nmic = &id->nmic;
+		anagrpid = &id->anagrpid;
+		break;
+	default:
+		nmic = &indep_id->nmic;
+		anagrpid = &indep_id->anagrpid;
+		break;
+	}
 
 	ns = kzalloc_node(sizeof(*ns), GFP_KERNEL, node);
 	if (!ns)
@@ -3984,7 +4026,7 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid,
 	ns->ctrl = ctrl;
 	kref_init(&ns->kref);
 
-	if (nvme_init_ns_head(ns, nsid, ids, id->nmic & NVME_NS_NMIC_SHARED))
+	if (nvme_init_ns_head(ns, nsid, ids, *nmic & NVME_NS_NMIC_SHARED))
 		goto out_cleanup_disk;
 
 	/*
@@ -4010,7 +4052,16 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid,
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
@@ -4024,11 +4075,10 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid,
 	if (!nvme_ns_head_multipath(ns->head))
 		nvme_add_ns_cdev(ns);
 
-	nvme_mpath_add_disk(ns, id->anagrpid);
+	nvme_mpath_add_disk(ns, *anagrpid);
 	nvme_fault_inject_init(&ns->fault_inject, ns->disk->disk_name);
-	kfree(id);
 
-	return;
+	goto out_free_id;
 
  out_cleanup_ns_from_list:
 	nvme_put_ctrl(ctrl);
@@ -4106,29 +4156,32 @@ static void nvme_ns_remove_by_nsid(struct nvme_ctrl *ctrl, u32 nsid)
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
+				"identifiers changed for nsid %d\n", ns->head->ns_id);
+		else
+			ret = nvme_update_ns_info(ns, id);
+		kfree(id);
+		break;
+	default:
+		ret = nvme_update_ns_info_cs_indep(ns, indep_id);
+		break;
 	}
 
-	ret = nvme_update_ns_info(ns, id);
-
-out_free_id:
-	kfree(id);
 out:
 	/*
 	 * Only remove the namespace if we got a fatal error back from the
@@ -4143,36 +4196,34 @@ static void nvme_validate_ns(struct nvme_ns *ns, struct nvme_ns_ids *ids)
 static void nvme_validate_or_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 {
 	struct nvme_ns_ids ids = { };
-	struct nvme_id_ns_cs_indep *id;
+	struct nvme_id_ns_cs_indep *id_indep;
 	struct nvme_ns *ns;
-	bool ready = true;
 
 	if (nvme_identify_ns_descs(ctrl, nsid, &ids))
 		return;
 
+	if (nvme_identify_ns_cs_indep(ctrl, nsid, &id_indep))
+		return;
+
 	/*
 	 * Check if the namespace is ready.  If not ignore it, we will get an
 	 * AEN once it becomes ready and restart the scan.
 	 */
-	if ((ctrl->cap & NVME_CAP_CRMS_CRIMS) &&
-	    !nvme_identify_ns_cs_indep(ctrl, nsid, &id)) {
-		ready = id->nstat & NVME_NSTAT_NRDY;
-		kfree(id);
+	if (ctrl->cap & NVME_CAP_CRMS_CRIMS) {
+		if (!(id_indep->nstat & NVME_NSTAT_NRDY))
+			goto free_id_indep;
 	}
 
-	if (!ready)
-		return;
-
 	ns = nvme_find_get_ns(ctrl, nsid);
 	if (ns) {
-		nvme_validate_ns(ns, &ids);
+		nvme_validate_ns(ns, &ids, id_indep);
 		nvme_put_ns(ns);
-		return;
+		goto free_id_indep;
 	}
 
 	switch (ids.csi) {
 	case NVME_CSI_NVM:
-		nvme_alloc_ns(ctrl, nsid, &ids);
+		nvme_alloc_ns(ctrl, nsid, &ids, id_indep);
 		break;
 	case NVME_CSI_ZNS:
 		if (!IS_ENABLED(CONFIG_BLK_DEV_ZONED)) {
@@ -4187,13 +4238,16 @@ static void nvme_validate_or_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 				nsid);
 			break;
 		}
-		nvme_alloc_ns(ctrl, nsid, &ids);
+		nvme_alloc_ns(ctrl, nsid, &ids, id_indep);
 		break;
 	default:
-		dev_warn(ctrl->device, "unknown csi %u for nsid %u\n",
-			ids.csi, nsid);
+		/* required to enable char-interface for unknown command sets*/
+		nvme_alloc_ns(ctrl, nsid, &ids, id_indep);
 		break;
 	}
+
+free_id_indep:
+	kfree(id_indep);
 }
 
 static void nvme_remove_invalid_namespaces(struct nvme_ctrl *ctrl,
-- 
2.30.2



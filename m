Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17BB7C433EF
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Jun 2022 13:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-ID:Date:Subject:CC
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BMiGL/WKrW+qGP3wWxg5BsVERD0rA/eGogGigcqeEwI=; b=mzqzbY25Mu4XkobeU+RioJFyzz
	J6JGf+zzSfQ/0QtzRfsRuFGKBiW71/pgyUFWzmMLId5Xx/YFxbtJPFq+KPDGgNoYYYoCwnQjIfMt0
	MYvlSqkwqKMhtFiF5OF2pbVp7uwpzkaoKH66oEOgI1agU9fi0Mueoexu7026/yrtuUOxl3d8OZFnX
	EexeKY9jGylasS5l+wbf5/WDl7DrYgy9tFl1w+EdL8KrTQEd/1RoMsrBh0jPO3qSczrksi0x0+rrs
	tPhJ7idaXpfk91PMsB4v3zgYgSjUoarBjtYm4W8L8edDSf7wTx9JrN5BHYSyr4gxnX2s0unzJQkcT
	rjWqC+9Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nyZUf-007pBu-Ej; Tue, 07 Jun 2022 13:43:37 +0000
Received: from mailout2.w1.samsung.com ([210.118.77.12])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nyZUR-007p8v-GK
	for linux-nvme@lists.infradead.org; Tue, 07 Jun 2022 13:43:28 +0000
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220607134313euoutp025bb1d5f9c0ab0664eaad7067401cf871~2WnoCmewR0189301893euoutp02f
	for <linux-nvme@lists.infradead.org>; Tue,  7 Jun 2022 13:43:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220607134313euoutp025bb1d5f9c0ab0664eaad7067401cf871~2WnoCmewR0189301893euoutp02f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1654609393;
	bh=BMiGL/WKrW+qGP3wWxg5BsVERD0rA/eGogGigcqeEwI=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=R5HUTWi54Hf2D6YTuPrAdEaE7iyYS/dKzVNezhggHqAVDi7p+dWG0dL7RzsZjSEZU
	 l4JaEu+nloJrFTVjixLsiHdK4oWyd4mLQtJjNrybBzFztdEAFnjHQcU9HqaeCFVMEK
	 lQ+16BpRrbOj/b1ebWw0eutGZCMmJnjXTfaY4VZk=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20220607134312eucas1p14688b26970a452da99bc7f08a2a558d8~2WnnmD03x1686916869eucas1p18;
	Tue,  7 Jun 2022 13:43:12 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id FF.AF.10067.0F55F926; Tue,  7
	Jun 2022 14:43:12 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20220607134312eucas1p1a66a21581dc64344f21c03a26e540fb7~2WnnMoKqr0879608796eucas1p1J;
	Tue,  7 Jun 2022 13:43:12 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20220607134312eusmtrp188370e9bd1daeef4e63143bfe5a65bfa~2WnnLXPxp3255732557eusmtrp1X;
	Tue,  7 Jun 2022 13:43:12 +0000 (GMT)
X-AuditID: cbfec7f4-5ce7da8000002753-37-629f55f06713
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 65.9A.09038.0F55F926; Tue,  7
	Jun 2022 14:43:12 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20220607134312eusmtip18bc5fbb21c2b50aefcad120919ed6692~2WnnCqrZA0573305733eusmtip1J;
	Tue,  7 Jun 2022 13:43:12 +0000 (GMT)
Received: from localhost (106.110.32.33) by CAMSVWEXC01.scsc.local
	(2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Tue, 7 Jun 2022 14:43:11 +0100
From: Joel Granados <j.granados@samsung.com>
To: <hch@lst.de>, <kbusch@kernel.org>
CC: <joshi.k@samsung.com>, <linux-nvme@lists.infradead.org>,
	<gost.dev@samsung.com>, <k.jensen@samsung.com>
Subject: [PATCH v2 2/2] nvme: enable generic interface (/dev/ngXnY) for
 unknown command sets
Date: Tue, 7 Jun 2022 15:40:55 +0200
Message-ID: <20220607134055.1742162-3-j.granados@samsung.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220607134055.1742162-1-j.granados@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [106.110.32.33]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrIIsWRmVeSWpSXmKPExsWy7djPc7ofQucnGSx8qGaxcvVRJotJh64x
	Wsxf9pTdgdlj06pONo/NS+o9dt9sYAtgjuKySUnNySxLLdK3S+DK+PH2A2PBN+2KzjWHGBsY
	F6h0MXJySAiYSLw9e5Cpi5GLQ0hgBaNE18UvbBDOF0aJKa9XQmU+M0rcnjuFHabl7uPXYLaQ
	wHJGiTvPpOGKVr96CdW+iVGip6uNBaSKTUBH4vybO8xdjBwcIgKqEvtabEFMZoFciRPzfEAq
	hAXiJE4sv8IIYrMIqEi8+HmaFcTmFbCV2PfvGivEXnmJtuvTwWo4BewkOq+8YYSoEZQ4OfMJ
	2CZmoJrmrbOZIWwJiYMvXjBD9CpKbJnzHWpOrcTaY2fYQc6UEDjCIbH7fz9UkYvEmfvr2SBs
	YYlXx7dAPSwjcXpyDwuEnS2xc8ouqPoCiVknp7KB/CIhYC3RdyYHwnSUWLC3FsLkk7jxVhDi
	Gj6JSdumM0OEeSU62oQmMKrMQnL/LCT3z0Jy/wJG5lWM4qmlxbnpqcVGeanlesWJucWleel6
	yfm5mxiBqeL0v+NfdjAuf/VR7xAjEwfjIUYJDmYlEV7/yXOThHhTEiurUovy44tKc1KLDzFK
	c7AoifMmZ25IFBJITyxJzU5NLUgtgskycXBKNTAt61D3emfx6cN5xucsuTsdffIthB5wvTps
	oPP57bKSQ3dK1M6GuuyIKdzz6kvU5ZTFSaUTTsqtnxY8XcjydvhK8Q2x6V/vXN1TclnHR+nR
	DV3xH9w+EQVCrI0Ovxbp27Zd6+F1fKfCdiLhjezD3ppVxxr/z3lf9nTfzrv6696ZRmx8oOGs
	/KDuzMyLr4sehNxes8Xf/UOBrqjgH13RxUGB6xR/F0/5fe/ybnvOKS6fS5VW7v/8Lsm1weao
	3rKzp04qibJ+Uy+YuM49de0ln11/ylmnBkp/MFF7Lsl/aWvLzNXtE+/2zQqR1p7kv1HwZlZx
	6eMN7JlTPH5OigvuWW/V1uanaey24I6Jsl15xUtnJZbijERDLeai4kQA1zc2vYQDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLIsWRmVeSWpSXmKPExsVy+t/xu7ofQucnGfQd47ZYufook8WkQ9cY
	LeYve8ruwOyxaVUnm8fmJfUeu282sAUwR+nZFOWXlqQqZOQXl9gqRRtaGOkZWlroGZlY6hka
	m8daGZkq6dvZpKTmZJalFunbJehl/Hj7gbHgm3ZF55pDjA2MC1S6GDk5JARMJO4+fs3excjF
	ISSwlFHiTctkNoiEjMSnKx/ZIWxhiT/Xutggij4ySrw82swM4WxilDjXeg+sik1AR+L8mztA
	CQ4OEQFViX0ttiAms0CuxIl5PiAVwgIxEid+LWYGsVkEVCRe/DzNCmLzCthK7Pt3jRVil7xE
	2/XpjCA2p4CdROeVN2C2EFDNickr2CHqBSVOznzCAmIzA9U3b53NDGFLSBx88YIZYo6ixJY5
	36Fm1kq8ur+bcQKjyCwk7bOQtM9C0r6AkXkVo0hqaXFuem6xkV5xYm5xaV66XnJ+7iZGYDxt
	O/Zzyw7Gla8+6h1iZOJgPMQowcGsJMLrP3lukhBvSmJlVWpRfnxRaU5q8SFGU6A/JzJLiSbn
	AyM6ryTe0MzA1NDEzNLA1NLMWEmc17OgI1FIID2xJDU7NbUgtQimj4mDU6qBKShsdkTB/jvL
	/ulyS11wnfXOmFl3VflWdulaE74/cetefg3+Y+udFv2RpVv8w72rBeU2cyoXai2J3++2Uvrs
	l6b9mRkPrwq6+d0v+CDguM3DVeh6yvaAsAlhX/XKTmpdVKkM4M9U7/l+7/XV7Y5S8g0H/nx8
	uz2Gu13G9ML8v4/97u77M0l31Q+VJ4f0ciafbGneI7bhfmL42lYujVs6R5pjjhsu+7L2Z+VO
	hUmX2bNjD5338dk2rcjTZkXx3Y+aV0TZSz/9ba7NO3F12q11WxU1H38QeqDTOO/V4o9X5txI
	FmoL5Xn48/EXsRWZtYYu3s/cjFSOP1nsxPH0rhiD0debrrprfwp4b7Q425fe1KPEUpyRaKjF
	XFScCABkQM3vMAMAAA==
X-CMS-MailID: 20220607134312eucas1p1a66a21581dc64344f21c03a26e540fb7
X-Msg-Generator: CA
X-RootMTR: 20220607134312eucas1p1a66a21581dc64344f21c03a26e540fb7
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220607134312eucas1p1a66a21581dc64344f21c03a26e540fb7
References: <20220607134055.1742162-1-j.granados@samsung.com>
	<CGME20220607134312eucas1p1a66a21581dc64344f21c03a26e540fb7@eucas1p1.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220607_064324_008664_7B080AAB 
X-CRM114-Status: GOOD (  20.17  )
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
 drivers/nvme/host/core.c | 83 ++++++++++++++++++++++++++++++++++------
 1 file changed, 72 insertions(+), 11 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 06b9718b0540..c7eb92480fad 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1912,6 +1912,33 @@ static void nvme_set_chunk_sectors(struct nvme_ns *ns, struct nvme_id_ns *id)
 	blk_queue_chunk_sectors(ns->queue, iob);
 }
 
+static int nvme_update_ns_info_cs_indep(struct nvme_ns *ns,
+				struct nvme_id_ns_cs_indep *id)
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
@@ -3953,15 +3980,27 @@ static void nvme_ns_add_to_ctrl_list(struct nvme_ns *ns)
 	list_add(&ns->list, &ns->ctrl->namespaces);
 }
 
+static inline bool nvme_ns_indep(struct nvme_ns_ids *ids)
+{
+	return ids->csi != NVME_CSI_NVM && ids->csi != NVME_CSI_ZNS;
+}
+
 static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid,
 		struct nvme_ns_ids *ids)
 {
+	int ret = 0;
 	struct nvme_ns *ns;
 	struct gendisk *disk;
 	struct nvme_id_ns *id;
+	struct nvme_id_ns_cs_indep *indep_id;
 	int node = ctrl->numa_node;
+	bool cs_indep = nvme_ns_indep(ids);
 
-	if (nvme_identify_ns(ctrl, nsid, ids, &id))
+	if (cs_indep)
+		ret = nvme_identify_ns_cs_indep(ctrl, nsid, &indep_id);
+	else
+		ret = nvme_identify_ns(ctrl, nsid, ids, &id);
+	if (ret)
 		return;
 
 	ns = kzalloc_node(sizeof(*ns), GFP_KERNEL, node);
@@ -3987,7 +4026,8 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid,
 	ns->ctrl = ctrl;
 	kref_init(&ns->kref);
 
-	if (nvme_init_ns_head(ns, nsid, ids, id->nmic & NVME_NS_NMIC_SHARED))
+	if (nvme_init_ns_head(ns, nsid, ids,
+			      (cs_indep ? indep_id->nmic : id->nmic) & NVME_NS_NMIC_SHARED))
 		goto out_cleanup_disk;
 
 	/*
@@ -4013,7 +4053,11 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid,
 			ns->head->instance);
 	}
 
-	if (nvme_update_ns_info(ns, id))
+	if (cs_indep)
+		ret = nvme_update_ns_info_cs_indep(ns, indep_id);
+	else
+		ret = nvme_update_ns_info(ns, id);
+	if (ret)
 		goto out_unlink_ns;
 
 	down_write(&ctrl->namespaces_rwsem);
@@ -4027,9 +4071,12 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid,
 	if (!nvme_ns_head_multipath(ns->head))
 		nvme_add_ns_cdev(ns);
 
-	nvme_mpath_add_disk(ns, id->anagrpid);
+	nvme_mpath_add_disk(ns, cs_indep ? indep_id->anagrpid : id->anagrpid);
 	nvme_fault_inject_init(&ns->fault_inject, ns->disk->disk_name);
-	kfree(id);
+	if (cs_indep)
+		kfree(indep_id);
+	else
+		kfree(id);
 
 	return;
 
@@ -4050,7 +4097,10 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid,
  out_free_ns:
 	kfree(ns);
  out_free_id:
-	kfree(id);
+	if (cs_indep)
+		kfree(indep_id);
+	else
+		kfree(id);
 }
 
 static void nvme_ns_remove(struct nvme_ns *ns)
@@ -4112,12 +4162,17 @@ static void nvme_ns_remove_by_nsid(struct nvme_ctrl *ctrl, u32 nsid)
 static void nvme_validate_ns(struct nvme_ns *ns, struct nvme_ns_ids *ids)
 {
 	struct nvme_id_ns *id;
+	struct nvme_id_ns_cs_indep *indep_id;
 	int ret = NVME_SC_INVALID_NS | NVME_SC_DNR;
+	bool cs_indep = nvme_ns_indep(ids);
 
 	if (test_bit(NVME_NS_DEAD, &ns->flags))
 		goto out;
 
-	ret = nvme_identify_ns(ns->ctrl, ns->head->ns_id, ids, &id);
+	if (cs_indep)
+		ret = nvme_identify_ns_cs_indep(ns->ctrl, ns->head->ns_id, &indep_id);
+	else
+		ret = nvme_identify_ns(ns->ctrl, ns->head->ns_id, ids, &id);
 	if (ret)
 		goto out;
 
@@ -4128,10 +4183,16 @@ static void nvme_validate_ns(struct nvme_ns *ns, struct nvme_ns_ids *ids)
 		goto out_free_id;
 	}
 
-	ret = nvme_update_ns_info(ns, id);
+	if (cs_indep)
+		ret = nvme_update_ns_info_cs_indep(ns, indep_id);
+	else
+		ret = nvme_update_ns_info(ns, id);
 
 out_free_id:
-	kfree(id);
+	if (cs_indep)
+		kfree(indep_id);
+	else
+		kfree(id);
 out:
 	/*
 	 * Only remove the namespace if we got a fatal error back from the
@@ -4193,8 +4254,8 @@ static void nvme_validate_or_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 		nvme_alloc_ns(ctrl, nsid, &ids);
 		break;
 	default:
-		dev_warn(ctrl->device, "unknown csi %u for nsid %u\n",
-			ids.csi, nsid);
+		/* required to enable char-interface for unknown command sets*/
+		nvme_alloc_ns(ctrl, nsid, &ids);
 		break;
 	}
 }
-- 
2.30.2



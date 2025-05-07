Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 853E0C3ABBF
	for <linux-nvme@archiver.kernel.org>; Wed,  7 May 2025 23:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=z8StnEDDtSSohZ7zTqdWy4fKxLadoPebbrEvNMEq1ic=; b=KotgAUj7WVYkMtWI5nr1vU+1el
	DOTt40yrugx+HQ2GKlbHN505cgl3a+EztpLFsjXz+jywz6vYCseY5s4DV4QFZJv0XigdCEsYaWlC9
	t/b5rZlHulWTdVCpsZrx3Ci1qA9r42/YHqDJTq8Pfadm7lpYCgwoEOwklZNXiu5LhMvLeFpAB7RAf
	Ckx8Im/MuhLvNHNrHN4g04Mi8RTvxosarDzwSPDIsYhao/qMf6xSI+w+uKATFdNuBUJ8RKaVhmIdh
	76gRsw8RX50VperUnFukDadIbI37cZgOtuYT7qkxoEp674idX7rVgpjiUfn9KT6JROdAUPQ4ONDY/
	NArvjWng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCoF3-0000000GxAA-0DbT;
	Wed, 07 May 2025 23:31:57 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCoF0-0000000Gx8q-41jh
	for linux-nvme@lists.infradead.org;
	Wed, 07 May 2025 23:31:56 +0000
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 547NS6bc003133;
	Wed, 7 May 2025 23:31:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=z8Stn
	EDDtSSohZ7zTqdWy4fKxLadoPebbrEvNMEq1ic=; b=rh+FlR1pvw8iaOmSCv7FJ
	F+1nqpylplNj90YUlIHWhh2W6DhwxAu2o5JGn2oDZTtEJ2KpioysyI+3OV3I4ORe
	+e6OQnTV4U4cu6WCBLrXOaqNGhABywt7o1xhEVzNA0xqC0DyN6fJx7COBTH/0moH
	PIbETHiTd9PhrgswsjC/FMBzUnrbQkg6GzbEkiWBrEol4VQlnzD6QlxkAux+GYTq
	Ct3eg4D2HCes/K5wy20qfOYu4tmzoa5TjyXEUWbdSBO1RIaITaOiUSs/revwzAdK
	Rvp5QvYE2lgDyekTP7TFpKQ8V7ioFBSWbMn43XAwkg/7LfRZs2wg+sQTGKAGp9ZU
	A==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46gh6xr05e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 07 May 2025 23:31:42 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 547NJS2W035563;
	Wed, 7 May 2025 23:31:41 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46d9kbshad-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 07 May 2025 23:31:41 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 547NVdmO037479;
	Wed, 7 May 2025 23:31:41 GMT
Received: from ca-dev94.us.oracle.com (ca-dev94.us.oracle.com [10.129.136.30])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 46d9kbsh91-3;
	Wed, 07 May 2025 23:31:41 +0000
From: Alan Adamson <alan.adamson@oracle.com>
To: linux-nvme@lists.infradead.org
Cc: alan.adamson@oracle.com, kch@nvidia.com, kbusch@kernel.org, hch@lst.de,
        sagi@grimberg.me
Subject: [PATCH v2 2/2] nvme: all namespaces in a subsystem must adhere to a common atomic write size
Date: Wed,  7 May 2025 16:41:35 -0700
Message-ID: <20250507234137.1609876-3-alan.adamson@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250507234137.1609876-1-alan.adamson@oracle.com>
References: <20250507234137.1609876-1-alan.adamson@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-07_07,2025-05-07_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 phishscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505070219
X-Proofpoint-GUID: Qhed2xFa0qUMjo-CZdU-jhdSk91DvUrm
X-Authority-Analysis: v=2.4 cv=MdRsu4/f c=1 sm=1 tr=0 ts=681bed5e cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=dt9VzEwgFbYA:10 a=yPCof4ZbAAAA:8 a=AxTn6yeNWgif7ez6_GcA:9
X-Proofpoint-ORIG-GUID: Qhed2xFa0qUMjo-CZdU-jhdSk91DvUrm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA3MDIyMCBTYWx0ZWRfX2NqEw8GI0+P2 +Wp1WF0I+i07IM3hv7s0ufhQ9AqK9wXw9Gb4KBXm8iEzYEuAH69QSL3hGRjQ7iZb68QqLhx2C+C SApf7euc/st1Qud5yZQv8I20zJJUbP4i76+XT+PujovHNxwYsdQuV+CNImw4rGAMJHqDoX89Vrp
 FN6MUgQL7VgK/69znano23wLUiOipbdRhB6K6EPRudQvmyNUik0DolUDcWYXCTLjqCWbmPeBDef qSH+q1e/Wnz64Lzfcybrspso45LMxPfUSFk2v8zzbYQpRPCYspyExWius8ZHaSRvmfLQb/Ly6bY g5KDBkmbhGuLuAms6u9u2RojlFaPacL49a7uoZQ4sNSHZW45IaMNMmH17Nvpp2nz4KNlvdrFiVM
 6CvNF2bALxJWbJiLvUIA15cDjjw93owS5jf1MRZfI0OjBndjwR6YIOaZHbb0LZLfS+XVpUzi
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250507_163155_003108_63E38BD5 
X-CRM114-Status: GOOD (  15.84  )
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

The first namespace configured in a subsystem sets the subsystem's
atomic write size based on its AWUPF or NAWUPF. Subsequent namespaces
must have an atomic write size (per their AWUPF or NAWUPF) less than or
equal to the subsystem's atomic write size, or their probing will be
rejected.

Signed-off-by: Alan Adamson <alan.adamson@oracle.com>
---
 drivers/nvme/host/core.c | 25 ++++++++++++++++++++++---
 drivers/nvme/host/nvme.h |  3 ++-
 2 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index eb6ea8acb3cc..f098329ed869 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2059,7 +2059,20 @@ static bool nvme_update_disk_info(struct nvme_ns *ns, struct nvme_id_ns *id,
 		if (id->nsfeat & NVME_NS_FEAT_ATOMICS && id->nawupf)
 			atomic_bs = (1 + le16_to_cpu(id->nawupf)) * bs;
 		else
-			atomic_bs = (1 + ns->ctrl->subsys->awupf) * bs;
+			atomic_bs = (1 + ns->ctrl->awupf) * bs;
+
+		/*
+		 * Set subsystem atomic bs.
+		 */
+		if (ns->ctrl->subsys->atomic_bs) {
+			if (atomic_bs > ns->ctrl->subsys->atomic_bs) {
+				pr_err_ratelimited("%s: Inconsistent Atomic Write Size: Subsystem=%d bytes, Controller/Namespace=%d bytes\n",
+					ns->disk ? ns->disk->disk_name : "?",
+					ns->ctrl->subsys->atomic_bs,
+					atomic_bs);
+			}
+		} else
+			ns->ctrl->subsys->atomic_bs = atomic_bs;
 
 		nvme_update_atomic_write_disk_info(ns, id, lim, bs, atomic_bs);
 	}
@@ -2201,6 +2214,13 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
 	nvme_set_chunk_sectors(ns, id, &lim);
 	if (!nvme_update_disk_info(ns, id, &lim))
 		capacity = 0;
+
+	if (lim.atomic_write_hw_max > ns->ctrl->subsys->atomic_bs) {
+		blk_mq_unfreeze_queue(ns->disk->queue, memflags);
+		ret = -ENXIO;
+		goto out;
+	}
+
 	nvme_config_discard(ns, &lim);
 	if (IS_ENABLED(CONFIG_BLK_DEV_ZONED) &&
 	    ns->head->ids.csi == NVME_CSI_ZNS)
@@ -3031,7 +3051,6 @@ static int nvme_init_subsystem(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 		kfree(subsys);
 		return -EINVAL;
 	}
-	subsys->awupf = le16_to_cpu(id->awupf);
 	nvme_mpath_default_iopolicy(subsys);
 
 	subsys->dev.class = &nvme_subsys_class;
@@ -3441,7 +3460,7 @@ static int nvme_init_identify(struct nvme_ctrl *ctrl)
 		dev_pm_qos_expose_latency_tolerance(ctrl->device);
 	else if (!ctrl->apst_enabled && prev_apst_enabled)
 		dev_pm_qos_hide_latency_tolerance(ctrl->device);
-
+	ctrl->awupf = le16_to_cpu(id->awupf);
 out_free:
 	kfree(id);
 	return ret;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 51e078642127..ff1d94468613 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -410,6 +410,7 @@ struct nvme_ctrl {
 
 	enum nvme_ctrl_type cntrltype;
 	enum nvme_dctype dctype;
+	u16 awupf;
 };
 
 static inline enum nvme_ctrl_state nvme_ctrl_state(struct nvme_ctrl *ctrl)
@@ -442,11 +443,11 @@ struct nvme_subsystem {
 	u8			cmic;
 	enum nvme_subsys_type	subtype;
 	u16			vendor_id;
-	u16			awupf;	/* 0's based awupf value. */
 	struct ida		ns_ida;
 #ifdef CONFIG_NVME_MULTIPATH
 	enum nvme_iopolicy	iopolicy;
 #endif
+	u32			atomic_bs;
 };
 
 /*
-- 
2.43.5



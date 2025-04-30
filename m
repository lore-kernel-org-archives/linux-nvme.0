Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 556EAC369D9
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Apr 2025 17:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YkV2RlXO3P9NrTiTXoXq/ulhEyki8O6fo6En8yZI1eM=; b=UksTu1s6XEGUtFrpOYO98MkBsA
	JaGvS4/H17oV1/C2BOo9bI4m9vthu4xhHt3kA5CzraURwOMo2lS+eLAFAsudwYKCZQlFopM6V3qnx
	29XjZVWhHnae4ACBRl/wqZiH8iSoLTNJ0p2I9qUprrLwGiat/lySdzvnuIvTvGUd4ZEezFqIXKuY7
	cO5m0vfTMHIvLoU+kBk78K2g6wvUuPof+XDqs0vlBh0sdhtvj2ndlrsS8AOgVPbov3NEJclQ3mzQJ
	InIgAGWTV3sCWHYp2h3c9zkdWBSywtMBGTuwaZRW5qufAuAOeWgZEjgo6AOzQgIaq4y4Oz5oxmXIU
	c6mlT8GA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uAAvR-0000000DWPy-3Waa;
	Wed, 30 Apr 2025 17:08:49 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uAAvO-0000000DWOl-3G4U
	for linux-nvme@lists.infradead.org;
	Wed, 30 Apr 2025 17:08:48 +0000
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53UFMu6k021230;
	Wed, 30 Apr 2025 17:08:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=YkV2R
	lXO3P9NrTiTXoXq/ulhEyki8O6fo6En8yZI1eM=; b=IG0AF0wGGOQDS7FgCiwTG
	+LWp0w7RAr9uJKXGuWiAmdxQF2xjM4Km6v68q8GHQPnGA1BryfxXCvEPTzn+mfRC
	6wyn/YC8kfwAiAdrU0jP6BcCYzlbhy0NfvxDj7wUsC8bI8bh0JHdqHOY99WLTBcA
	y31iNQeOybViG6Y5Ye2IQyJs0j5u6eUYPLbEhJEs7e4Qal9KQ/aOj3jQ97Gx8wYN
	i/vU9uMLTvriY/EktTOVZX9CsdNRWamsgyow3Uy4/Z1PIIkW9dT6ONV+irEyvnQ3
	6vizGEPsGfXCFSIqFN9HeMyy7y7BbzNACSb4A3uJEif+4jQ6X8hhd/JC388qbId7
	Q==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46b6um9p1m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Apr 2025 17:08:38 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53UGDaIM001521;
	Wed, 30 Apr 2025 17:08:37 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 468nxbk59g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Apr 2025 17:08:37 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 53UH8Y2R039653;
	Wed, 30 Apr 2025 17:08:36 GMT
Received: from ca-dev94.us.oracle.com (ca-dev94.us.oracle.com [10.129.136.30])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 468nxbk587-3;
	Wed, 30 Apr 2025 17:08:36 +0000
From: Alan Adamson <alan.adamson@oracle.com>
To: linux-nvme@lists.infradead.org
Cc: alan.adamson@oracle.com, kch@nvidia.com, kbusch@kernel.org, hch@lst.de,
        sagi@grimberg.me
Subject: [PATCH 2/2] nvme: all namespaces in a subsystem must adhere to a common atomic write size
Date: Wed, 30 Apr 2025 10:18:30 -0700
Message-ID: <20250430171830.1494033-3-alan.adamson@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250430171830.1494033-1-alan.adamson@oracle.com>
References: <20250430171830.1494033-1-alan.adamson@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-30_05,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2504300124
X-Authority-Analysis: v=2.4 cv=dfSA3WXe c=1 sm=1 tr=0 ts=68125916 b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=XR8D0OoHHMoA:10 a=yPCof4ZbAAAA:8 a=BlVjgIUVm_Q3PvKB96IA:9 cc=ntf awl=host:13129
X-Proofpoint-GUID: pOQ47v8eMQ4rrJutXM0UHzl50FKJwnrU
X-Proofpoint-ORIG-GUID: pOQ47v8eMQ4rrJutXM0UHzl50FKJwnrU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDMwMDEyMyBTYWx0ZWRfX6r/prRHQ0wuu 8C1yjoJ2bLVd2hro8bcoNys/pZRRWJWZAT+vFM1BFw+mvInvLK5kQ3vQdf82Wnw6tKoBv6GFVOj CRHD2AzwrF0pvCUy0/PKctkQFWHTYHqcEAHjuj6rD0OUX0B/X2Nl3nIPfG/WE3KFox8Hn/+v/hi
 2RU42yaMKycRJiVyt3YjpRGQIvR4N0XBQsIH+pYOQQ7m4Hvr4lFTGvThHUB5vx7DuPg4gloEC9A Jr3pjOmmcmwdyk5dgy8xNhQC8FscZPjKXEZXF1BHpw7PcCBFzhyBlJJmSiLdmB2QaAukWVpQC2P 4E/yVadgGpCyULJXJ6BfWi0wax7ZfoJTQIR7bQu2AtFXt8UID/p7tkRTTDulr2tT4+IV+x4lskL
 k/l+kw7rHfsGuyIIK1mRSH+XRpp4SuT8qlP7FovSDldIBvFYxYFQlsZN/9tuld4poNOhFb1h
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250430_100846_936892_9B5B8ECF 
X-CRM114-Status: GOOD (  16.94  )
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

The first namespace that is configured in a subsystem will define the
subsystem's atomic write size.  This will be based on either AWUPF or
NAWUPF. Configuring subsequent namespaces in the subsystem requires its
atomic write size as defined by its AWUPF or NAWUPF to match the
subsystem's atomic write size. If a namespace doesn't adhere to the
subsystem's atomic write size, its atomic queue limits will be based on an
atomic write size of 512 bytes and an error message will be logged.

Signed-off-by: Alan Adamson <alan.adamson@oracle.com>
---
 drivers/nvme/host/core.c | 20 +++++++++++++++++---
 drivers/nvme/host/nvme.h |  3 ++-
 2 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index eb6ea8acb3cc..e0fe53b919a8 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2059,7 +2058,21 @@ static bool nvme_update_disk_info(struct nvme_ns *ns, struct nvme_id_ns *id,
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
+			if (atomic_bs != ns->ctrl->subsys->atomic_bs) {
+				pr_err_ratelimited("%s: Inconsistent Atomic Write Size: Subsystem=%d bytes, Controller/Namespace=%d bytes\n",
+					ns->disk ? ns->disk->disk_name : "?",
+					ns->ctrl->subsys->atomic_bs,
+					atomic_bs);
+				atomic_bs = bs;
+			}
+		} else
+			ns->ctrl->subsys->atomic_bs = atomic_bs;
 
 		nvme_update_atomic_write_disk_info(ns, id, lim, bs, atomic_bs);
 	}
@@ -3031,7 +3045,6 @@ static int nvme_init_subsystem(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 		kfree(subsys);
 		return -EINVAL;
 	}
-	subsys->awupf = le16_to_cpu(id->awupf);
 	nvme_mpath_default_iopolicy(subsys);
 
 	subsys->dev.class = &nvme_subsys_class;
@@ -3441,7 +3454,7 @@ static int nvme_init_identify(struct nvme_ctrl *ctrl)
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



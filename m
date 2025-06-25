Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AB91C77B7C
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Jun 2025 04:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SvGZhiUYui8KbGx47ihhr8pF1NSZfJJcOgsix8Qx1ac=; b=RVhvdte3Wr5TGg13DJMPCE3nm1
	fsBUi7p0aL5T6bkwF7DSVtEffmDG/dyiaHgfUzACrjPqN0MP/OJnps4vNCdD5itjDbQlgsrqVH5LB
	DWITbotCbyp8EkJfT22v3+Mp8HkmVdQpfYTHG7xvJsURTJiUvsoeIITp9pvuU3ud1UGjXI5wSqQdF
	WwbC9IbB74sCoHG2g61Al7PJc5HtcdYJfaMCuxq+l7dwra5H8MMeEeoJAQLZWgkfyVJa2xjmXQ9GB
	qqoIMRojYauTxoe8YsYQ+0uj1qKfed85zz2fRWgW+5P1hyCihoNq5kxlzSceE6nLmCvkiQPSCuBgu
	55adrxiA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUHZj-00000007T0q-3mIm;
	Wed, 25 Jun 2025 04:17:31 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUHZi-00000007T0A-1gdI
	for linux-nvme@lists.infradead.org;
	Wed, 25 Jun 2025 04:17:31 +0000
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55OMiveR005149;
	Wed, 25 Jun 2025 04:17:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=SvGZh
	iUYui8KbGx47ihhr8pF1NSZfJJcOgsix8Qx1ac=; b=hRIjSz28X8/wKkPsTbiT3
	VmpkS0XbElHxJCs3uCw4e5vDEapShUg5PRsxGqV/B6k0rRFneN7B+SiETIOCkFkY
	x3eeAEVLjW07zG7bypnRz2j7Wz5xGXHLRnCu9YXSg7ZarYanyS/68yPDQ6bH4X70
	vMS/yF9DGNX7DAERQVSA67JOc2x4px//8D4xIQspp/JyTtvG7M5qKoEe/NkBMbK3
	LXzXmi3n6bMH4n4CHWRRtaYhKZy2EpHaOLtL7UW6UbbHXCfDO8IdRsqeMlWGUiGD
	naCkpIX5RaTJsZQ+mOPQUSrI8+TpNURk7Dly70rFHgj0/gnXS/PvEAnE3lJWAkf7
	Q==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47egt7dd07-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Jun 2025 04:17:21 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55P1fYqV024212;
	Wed, 25 Jun 2025 04:17:21 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ehkrhfgv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Jun 2025 04:17:21 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 55P4HGqe029022;
	Wed, 25 Jun 2025 04:17:20 GMT
Received: from ca-dev110.us.oracle.com (ca-dev110.us.oracle.com [10.129.136.45])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 47ehkrhfem-4;
	Wed, 25 Jun 2025 04:17:20 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: linux-nvme@lists.infradead.org, rdunlap@infradead.org, kbusch@kernel.org,
        axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, kch@nvidia.com,
        nilay@linux.ibm.com, corbet@lwn.net
Cc: alok.a.tiwari@oracle.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/5] nvmet: Remove redundant assignment of error code in nvmet_ns_enable()
Date: Tue, 24 Jun 2025 21:16:32 -0700
Message-ID: <20250625041643.174110-4-alok.a.tiwari@oracle.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250625041643.174110-1-alok.a.tiwari@oracle.com>
References: <20250625041643.174110-1-alok.a.tiwari@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-25_01,2025-06-23_07,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 adultscore=0 malwarescore=0 mlxscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506250029
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI1MDAzMCBTYWx0ZWRfX75lhb/iGGSBV 19j0x2GsWJyN4FSuaQORWyUI8Vt2ryiyeKXEw9TNot7NrKTAXvEDJP60p+7kf6/qGY7ozI/vLU8 hLGybdKgx8Kdmi3+YVMuT/O01uA15XFxaqIsMi8MzILKZTsdawlEQ0dMmur9PbIauRv/qinaJ8e
 0Btr72QgdJIqmhU+mgnMLhzZQ2Ea+ZIwo67YL2jYnxZgSOz9e4a2b/23y1+VcqEbO2WkiABNAN7 /epkErt26oUAyLJ8KNRYCRulQmQ2IAzfynHL2yXqyYZVXGE3nlyuxXDyzdHTzv54ratAp/qEQ+i QN5Jjr8Bzsu7/dzvt654xCGqq0SxR43/XJXqDDU+9TnT9oNCzSLuBRyzcDbJMitDDS12ANMRfQV
 oK2/LAXOwtWWkL9p8617A1Nf/n+w/P6TrpbJx7kYD7/xZ3bxm74WgCYP7GGwOK4jPQx0kTt+
X-Proofpoint-GUID: L7LC2VHGr2DSRg6mxJ2BMUYGzwtydKYa
X-Authority-Analysis: v=2.4 cv=QNpoRhLL c=1 sm=1 tr=0 ts=685b7852 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=6IFa9wvqVegA:10 a=yPCof4ZbAAAA:8 a=JfrnYn6hAAAA:8 a=hQNXMjqaqMWDSZxnGksA:9 a=1CNFftbPRP8L7MoqJWF3:22 cc=ntf
 awl=host:13207
X-Proofpoint-ORIG-GUID: L7LC2VHGr2DSRg6mxJ2BMUYGzwtydKYa
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250624_211730_548333_D39A90EE 
X-CRM114-Status: GOOD (  13.03  )
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

removing the unnecessary ret = -EMFILE; assignment since it is
immediately overwritten by the result of nvmet_bdev_ns_enable()
The initial value(-EMFILE) is redundant because it has no effect
on the code logic or outcome.

Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
---
v2
no changes only added Reviewed-by
---
 drivers/nvme/target/core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 175c5b6d4dd58..884286f90688a 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -581,8 +581,6 @@ int nvmet_ns_enable(struct nvmet_ns *ns)
 	if (ns->enabled)
 		goto out_unlock;
 
-	ret = -EMFILE;
-
 	ret = nvmet_bdev_ns_enable(ns);
 	if (ret == -ENOTBLK)
 		ret = nvmet_file_ns_enable(ns);
-- 
2.46.0



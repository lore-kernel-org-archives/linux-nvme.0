Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54154C3ABBF
	for <linux-nvme@archiver.kernel.org>; Wed,  7 May 2025 23:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rE7H7z1mHjAfCt0TbMssELpXoZ3AcI537uH9J6IVgOc=; b=T02CV4HkmovHA0RYZMe39iRzPU
	7+BitCWdHUEVh+k3pgL+EivLOkIM63Cg5HpBZg8Pi1PJ5N31VCxqxPrYuZ8yfjTfNk/EnR62Tue7/
	fGOLvMsjNQXHhqiDr58/tHs6L09hJxypZYte+uwlbGQSrJ70LsAR9fgcMN2zyblrKbTzRlqsWxoEE
	27IWOBlbdT9/a3tWd1+MPYR7kWa8BjuFHqnbcl5WghsEAvSmFkXIy7bPNTtUH10a6i1lsocDbM1AJ
	IIrCzBtCgQQKeiyVuH80tyPBF1Yw2IujPkXAxGroXI79pjmFxOE/dASkQ9vjg8YNANoPZSJ5Ts7eP
	08NGwLkw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCoF2-0000000GxA0-1vpF;
	Wed, 07 May 2025 23:31:56 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCoF0-0000000Gx8P-2mWK
	for linux-nvme@lists.infradead.org;
	Wed, 07 May 2025 23:31:55 +0000
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 547NMmnV002522;
	Wed, 7 May 2025 23:31:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=rE7H7
	z1mHjAfCt0TbMssELpXoZ3AcI537uH9J6IVgOc=; b=ghgsQGEgFnV3LI6SESTnv
	CdL8SxCQprwpDWKpYmO3HkwXUo6a+HGLpu0ydvxwjfrWHljIY2orc485Gnmd9edH
	dBuehQE4q/hzkfc1Vo6ZyHyYAoAu9HbSHRMmYMJyIiNmi53Q+/44oaj/WS9o1Vx5
	7FPdFKqg6YiIFtdDoQtm1pAWQJeRMbHllzxT7Qd20dg90TrkuWfY8IudeYutkYb2
	5xw0ltYUAkohvlPU7Ri7EdjTK4FlPgHXOjJo/VzHHg6Yrm1i6arhrgfEAmcDpJER
	mr+WVIh49VI5j6PSa6+BwwkPPIwl6Q/j8iATxhfsc76+KMYJASqiqAC+kbs059vb
	Q==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46gh4ng08k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 07 May 2025 23:31:44 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 547NPBpT035964;
	Wed, 7 May 2025 23:31:41 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46d9kbsha1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 07 May 2025 23:31:41 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 547NVdmM037479;
	Wed, 7 May 2025 23:31:40 GMT
Received: from ca-dev94.us.oracle.com (ca-dev94.us.oracle.com [10.129.136.30])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 46d9kbsh91-2;
	Wed, 07 May 2025 23:31:40 +0000
From: Alan Adamson <alan.adamson@oracle.com>
To: linux-nvme@lists.infradead.org
Cc: alan.adamson@oracle.com, kch@nvidia.com, kbusch@kernel.org, hch@lst.de,
        sagi@grimberg.me
Subject: [PATCH v2 1/2] nvme: multipath: enable BLK_FEAT_ATOMIC_WRITES for multipathing
Date: Wed,  7 May 2025 16:41:34 -0700
Message-ID: <20250507234137.1609876-2-alan.adamson@oracle.com>
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
X-Authority-Analysis: v=2.4 cv=VZf3PEp9 c=1 sm=1 tr=0 ts=681bed60 cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=dt9VzEwgFbYA:10 a=yPCof4ZbAAAA:8 a=Nvds8rB5A7c_BiNOhtwA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA3MDIyMCBTYWx0ZWRfX+lcaSlWJxg++ Sil6SIU9cqyOUq/7c8Gg5LsDhIVxdQLfbRarFlgp+TXMGfMnkdGvU0akBefnZV0Kzdperc7nLGK a6nP4LtncNk1CI35A9dnuXeP//S4OH8hPCVNLv7v61qcjli+NAktgh0TjKCUE7Yn1/S6FWcqFgT
 B8MOTZx6OwEuCy4WTj0+pG9se+3d6zxNZbhMuEl/+CaX8BZw70XNR9qnhqps2wOvt5tFJTKLQia ifnFGqT4km27GZYxqzZG0nbFlmgwp8DRY909C0k3FGkGUDZWNkLgrITZ62LfaeBlAuF9ohAThMb jWvmDJM8QPhYdyzCbBPxlU1RE5VcUzNLovpQvLT7Defr6XjC42XkiLBYofBJa7VvTrWSbDUosyT
 Dx9PoUNnZL7mhCyXOYlDjoliCIWXHWxboxe/uWs4cTY7jj2J81SW8N46276pZVyxpip9UoSP
X-Proofpoint-GUID: fcoB62uc4V_DCRxiBAjuhAWqbUWToSu0
X-Proofpoint-ORIG-GUID: fcoB62uc4V_DCRxiBAjuhAWqbUWToSu0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250507_163154_707065_D18BAEC0 
X-CRM114-Status: GOOD (  14.77  )
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

A change to QEMU resulted in all nvme controllers (single and
multi-controller subsystems) to have its CMIC.MCTRS bit set which indicates
the subsystem supports multiple controllers and it is possible a namespace
can be shared between those multiple controllers in a multipathed
configuration.

When a namespace of a CMIC.MCTRS enabled subsystem is allocated, a
multipath node is created.  The queue limits for this node are inherited
from the namespace being allocated. When inheriting queue limits, the
features being inherited need to be specified. The atomic write feature
(BLK_FEAT_ATOMIC_WRITES) was not specified so the atomic queue limits
were not inherited by the multipath disk node which resulted in the sysfs
atomic write attributes being zeroed. The fix is to include
BLK_FEAT_ATOMIC_WRITES in the list of features to be inherited.

Signed-off-by: Alan Adamson <alan.adamson@oracle.com>
Reviewed-by: John Garry <john.g.garry@oracle.com>
---
 drivers/nvme/host/multipath.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 250f3da67cc9..cf0ef4745564 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -638,7 +638,8 @@ int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, struct nvme_ns_head *head)
 
 	blk_set_stacking_limits(&lim);
 	lim.dma_alignment = 3;
-	lim.features |= BLK_FEAT_IO_STAT | BLK_FEAT_NOWAIT | BLK_FEAT_POLL;
+	lim.features |= BLK_FEAT_IO_STAT | BLK_FEAT_NOWAIT |
+		BLK_FEAT_POLL | BLK_FEAT_ATOMIC_WRITES;
 	if (head->ids.csi == NVME_CSI_ZNS)
 		lim.features |= BLK_FEAT_ZONED;
 
-- 
2.43.5



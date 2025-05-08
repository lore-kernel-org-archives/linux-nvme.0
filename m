Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB178C3ABBE
	for <linux-nvme@archiver.kernel.org>; Thu,  8 May 2025 22:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rE7H7z1mHjAfCt0TbMssELpXoZ3AcI537uH9J6IVgOc=; b=O/mHC3dFIiY/isVBUVlaziXQkb
	rKD1QAbD82MQoemDp78DSV0xTH2oCVdc8WldRQYkSBoVCOgJsDq24PLj3OQDoOwcLJW1R65SqlUsB
	vdN2QD0tRZLywj65umomK/oioRLMPs/wGMXxvbL/cN8jyB2h3vl/tN3mwPynSajiD6oHi2mNfIj3S
	ocy1utjOgfl5b9ygQmlr0RlsX2d4N6I7XW2JQf8NiCKy1ivVQk7HnoGPA3GYJnxAzvoRb0DsoEY/E
	jJ5S9ea8QoGmekYNFcdoj7JTexPRCoYE6uSVNk1whaCrD7S5VleonyykknVM5ZFhrAMufO0kjIcoD
	Kdiv0XjQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uD9j4-00000001tx7-3clW;
	Thu, 08 May 2025 22:28:22 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uD9j1-00000001tw6-0KON
	for linux-nvme@lists.infradead.org;
	Thu, 08 May 2025 22:28:20 +0000
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 548MM5IQ032458;
	Thu, 8 May 2025 22:28:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=rE7H7
	z1mHjAfCt0TbMssELpXoZ3AcI537uH9J6IVgOc=; b=HuZTIwfVilDiuVmDLP782
	q169Y0FwL2ZtXh1kuQV0gXpNrBKlaf5CguxkYOeaXBpa/fym6ef7Tk3G3MvUsjsH
	EJKjnR1X2bFAGxL39/uIlWHDPCF+LHJpesokg9zgnkAGL8XMjQCUN5OPoNG8gII0
	biUGdpqqWUT74i5ii+i6vRvNk6Rl0qMHP2HFRwRoP38MH8L88/OLVZWy6uYabB4x
	o4eXI/sitblXePa6jzALYCKxY75MO5pMsIrey4E5vV5MaKYLZubgOpOlc+NL5JHD
	zw8sHsESXe74JjXfMc5ugwU9TaQx6zhEildBE86MsTPTlmxvSkJK/VFXiFexxmqK
	Q==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46h5be007f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 May 2025 22:28:07 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 548MInFJ002657;
	Thu, 8 May 2025 22:28:07 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46gmccaksq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 May 2025 22:28:07 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 548MS5hX030993;
	Thu, 8 May 2025 22:28:06 GMT
Received: from ca-dev94.us.oracle.com (ca-dev94.us.oracle.com [10.129.136.30])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 46gmccaks4-2;
	Thu, 08 May 2025 22:28:06 +0000
From: Alan Adamson <alan.adamson@oracle.com>
To: linux-nvme@lists.infradead.org
Cc: alan.adamson@oracle.com, kch@nvidia.com, kbusch@kernel.org, hch@lst.de,
        sagi@grimberg.me
Subject: [PATCH v3 1/2] nvme: multipath: enable BLK_FEAT_ATOMIC_WRITES for multipathing
Date: Thu,  8 May 2025 15:38:00 -0700
Message-ID: <20250508223802.277311-2-alan.adamson@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250508223802.277311-1-alan.adamson@oracle.com>
References: <20250508223802.277311-1-alan.adamson@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-08_07,2025-05-08_04,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 malwarescore=0 bulkscore=0 suspectscore=0 adultscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2505080203
X-Proofpoint-GUID: M7OMVqux5KIw7guoWsWCIexIYxzCjBZc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA4MDIwNCBTYWx0ZWRfX4sJoWaOpdieD RrIi0LpDytaU398LOhOSgQ42DBzv9asNyzVRfT3+00NzItO6pt8JRL7uHSJij89lWw982rJ3wSU gykB4dExoqMWgGsmq9AUxsWhxfRdfqrfytiBHfqidlclFOA+hayqOcXyxWQIGUc/FuNRdsGUzLW
 uuH616RLo8aIsfApc6wT6+5ZeT/PCIaZA37xvwt5V5fJcCWEIwVTrb/42YncsxKSN9BvRYRvoJE bKCB1JQmfMw7LAbM6XntFofZ2ZLzJKWqx68S5rmC3bRtkUo6P9kd0S/iTlAdavjSZir4VXxNIqg lvMSSG6MnvNMSON+JOz+NqhgPgIk0Z4FVf7Oc0QNcynyMP2DGQzFI6KzU+xq51UPQT4jpDm5ykf
 5ccFlFgCgTEx+PT29UDAH73d00hvABhOGxTXebeOGGrv4ZncIiureDG2YnHRtdX9WnWoGUp7
X-Authority-Analysis: v=2.4 cv=DPWP4zNb c=1 sm=1 tr=0 ts=681d2ff7 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=dt9VzEwgFbYA:10 a=yPCof4ZbAAAA:8 a=Nvds8rB5A7c_BiNOhtwA:9 cc=ntf awl=host:13186
X-Proofpoint-ORIG-GUID: M7OMVqux5KIw7guoWsWCIexIYxzCjBZc
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250508_152819_299595_6D2090A0 
X-CRM114-Status: GOOD (  14.54  )
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



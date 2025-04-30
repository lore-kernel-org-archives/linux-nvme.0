Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAD43C3ABAC
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Apr 2025 17:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SsOlB0zby7LF+j4nzEPYEQCQD8YxAndq0/glXWbDC6s=; b=sLGueIYbvDRDWS9VAhJls06pM/
	lV7ipyXVuqaFGXebeWNhpn8jUFbUPLaV2JrgSpwSPQLxTxIE4W/bjmmaOHPPXh3gY+EV6nVEZB9og
	JLRgtPNJt99tpPJ6SUIzcFjfid5bv99i+YTZD2BEZCF/OaFZ0DoIoWaTNh8DH7kLBIXPxIlHDM6m0
	FjEnTf8w3Fde7LdUsAvvsPidq8ZTUQqOoM2lS2CG2xPx7Ko4/X+FurVJm/0na0s8zUkyCfhtduOnn
	gXox3oLrm8X41LKxWBKGreAhYw4oXA7QwuXFbMjXR01+UbtBz8pY8SYbsTOHF5F4j3HK/48HC2ZjL
	ZZcIf9Ug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uAAvU-0000000DWRT-0WHz;
	Wed, 30 Apr 2025 17:08:52 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uAAvP-0000000DWOz-0ZFz
	for linux-nvme@lists.infradead.org;
	Wed, 30 Apr 2025 17:08:48 +0000
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53UFMvOO012495;
	Wed, 30 Apr 2025 17:08:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=SsOlB
	0zby7LF+j4nzEPYEQCQD8YxAndq0/glXWbDC6s=; b=CP9TJTPQppzDhekCdmY0e
	9sRDCV2KRbCoQUt6zNCtgpQooobwCQjY5N24rUMbMyaPI75lR3U3LC6fAbPxUGyy
	8ejPXqmwlCLqDH9Os9xmoGjJC6Gf6VTfioxTNfNtfX6S+r7r5v7MrKaawrC8OSAT
	FV8CqLEnquEMyds9eLdvs+6RFiQoK2b0ESq1SaaPTe89XPrbMA2G/b9+ji71F7VC
	3Zlyjm20C/jxZHHPLTelP7rqGckrVinxzrtaveMbNklHtEMAur6VxLI1wpo9hhOY
	vMefaCWWdPf5nvDOt9/TX3h/Q5CtnBQGZC6erV1yEP7XjVEZ6PI8f9cnUwAVgCdX
	A==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46b6ukhpcm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Apr 2025 17:08:37 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53UGSZa2001309;
	Wed, 30 Apr 2025 17:08:36 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 468nxbk594-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Apr 2025 17:08:36 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 53UH8Y2P039653;
	Wed, 30 Apr 2025 17:08:35 GMT
Received: from ca-dev94.us.oracle.com (ca-dev94.us.oracle.com [10.129.136.30])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 468nxbk587-2;
	Wed, 30 Apr 2025 17:08:35 +0000
From: Alan Adamson <alan.adamson@oracle.com>
To: linux-nvme@lists.infradead.org
Cc: alan.adamson@oracle.com, kch@nvidia.com, kbusch@kernel.org, hch@lst.de,
        sagi@grimberg.me
Subject: [PATCH 1/2] nvme: multipath: atomic queue limits need to be inherited
Date: Wed, 30 Apr 2025 10:18:29 -0700
Message-ID: <20250430171830.1494033-2-alan.adamson@oracle.com>
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
X-Authority-Analysis: v=2.4 cv=MIZgmNZl c=1 sm=1 tr=0 ts=68125915 b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=XR8D0OoHHMoA:10 a=yPCof4ZbAAAA:8 a=Nvds8rB5A7c_BiNOhtwA:9 cc=ntf awl=host:13129
X-Proofpoint-GUID: hf8_IITC881eH4-nkDglAn2B96PRZJ2K
X-Proofpoint-ORIG-GUID: hf8_IITC881eH4-nkDglAn2B96PRZJ2K
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDMwMDEyMyBTYWx0ZWRfX8chpIk8aOPq1 D7mMam9HnHEu7XRv9Px7bXsiCWu+aDFecQKhiBZUlz+1q+kchlPxpdhlEf+qrMMBU1KF3KS7McL iBkVB7wGyRQqG7YLaT8qz3dB+xnJhG6uMmWSvi61N00lmpieP0d66aKsCtsBVhWnjUYL86irmYv
 laJedwmEyaj67pxtxWF/3jKJ67szY/FoVkRegjIU7FbmyCRVTVAi9hGEy32bBd2bG5YCHEIaGyF LaKedGeNzoAgLcinf9SzW4y48nhspagGxmrmNIumf+kRogutf+bf6JJ4E9U3KHKecbpOVVefqOp 0I4J2vAQVdgzoRGKKdv/Y8CvHmoqktKKC230OXs56tyFFpwxa5xJqmDo1J8SVAUf5U9zhc1o7XT
 TxkQ1pXwoIH7oIjhs7a9fiygfOIgiAdMgl0IBDRa43IKbwrgeOuACh5eC31GpaWOwSOYL8uG
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250430_100847_293782_8EC8C179 
X-CRM114-Status: GOOD (  14.76  )
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

When a controller is attached that has the CMIC.MCTRS bit set, it indicates
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
Signed-off-by: John Garry <john.g.garry@oracle.com>
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



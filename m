Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59115C5AD5A
	for <linux-nvme@archiver.kernel.org>; Sat, 15 Aug 2026 17:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IP1tUanOIgptNCza6W9geu0/e/cvU2f3mTkYrLVSCOI=; b=R6E9gu3hesno5jM+6IKKeQ0nrP
	0RWtZxmjrhZkloguHwy2deesxT49jzQ+iBud1/HHj4Kn4U5c3yv7M6ms9TvY5EjrCDGK4UyRNvvzj
	s1ddeaH12jxqpBdIkDgKziIHnMiuJplMH1FbMD2hCi3QmWzpMj8WsJbPphnpeqzK3T7KUmnM917JD
	XnHiw9B0OzyqfjZ3cPczhewExNcKZMFLitR0Foss370iGtH8CfQIy5lWQEijoysxRtNzF1hvG0Ntt
	B6nVeSupvOVRgxyAXXjpDgpITGkjzjzfC8bHs/vE3/XiYYWe+R+HvSyuz1UCS2rtIP6KouROhexgn
	unkO5CZg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wvIJ8-0000000404M-02Cg;
	Sat, 15 Aug 2026 17:36:34 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wvIJ5-0000000401J-0RiE
	for linux-nvme@lists.infradead.org;
	Sat, 15 Aug 2026 17:36:32 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67FGW3mf2640390;
	Sat, 15 Aug 2026 17:36:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=IP1tUanOIgptNCza6
	W9geu0/e/cvU2f3mTkYrLVSCOI=; b=CWayot5RfHYYYI0f7kirRBOG2H3WFrYHG
	R2oUu2KZHJxAYo0Tlv5LGo1Ml2sLDoEi4NHNa6SnguYw3ARSRg+kyt43GyCEgboH
	+JDgn1IzvlYIwSmBw/KdqdIBcYNGg/epiv1uQZWiBWHya2dkHCh543hoME/dF9KL
	+cPmzSLvi2/h1yiwNns3wqIddvz9YfQTUMSpKFBTdBhRq7nFxcTceqNBz5znWe3n
	JCdxJAEVl/L9t+j1FI+CjaMzeZWQnAZlvHxIpdfyCSCL+IqkIyfACtHpY1yIZefT
	Orl/DgZVV+oW3XL/hyPr/1M4Nc9upv4Q9PFLDzvmE72Fyxo1S9afA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2fsqa7k4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 15 Aug 2026 17:36:26 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67FHQQXa005873;
	Sat, 15 Aug 2026 17:36:25 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g1rpvesrf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 15 Aug 2026 17:36:25 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67FHaNSg45482454
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 15 Aug 2026 17:36:23 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 780F820040;
	Sat, 15 Aug 2026 17:36:23 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 77EE520043;
	Sat, 15 Aug 2026 17:36:18 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.61.9.204])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 15 Aug 2026 17:36:18 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: hare@suse.de, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        dwagner@suse.de, kanie@linux.alibaba.com, jmeneghi@redhat.com,
        randyj@purestorage.com, martin.petersen@oracle.com,
        john.g.garry@oracle.com, gjoyce@linux.ibm.com
Subject: [PATCH v8 10/10] nvme-multipath: add documentation for latency I/O policy
Date: Sat, 15 Aug 2026 23:04:32 +0530
Message-ID: <20260815173502.1185929-11-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260815173502.1185929-1-nilay@linux.ibm.com>
References: <20260815173502.1185929-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE1MDEzMCBTYWx0ZWRfX+tMN9Wx7/Yjh
 rUj7ZC05bQTPNx9IWgAMTbhpJPcI7lzUjA0QHhIEW0GqkPqbMJyfD8WoNDj+1jnOwBvkURJdD40
 RMTjIjaHU1KYLLklRybGWwvpbhtck3gUr2+vU9rof6Dbrfj2pw/qiLbeHbefwJD+U/9I4fw/WMh
 OjAAKyU8oPVEg//NKDU05u1h/3+XIrTkAvlFjKiZPcSZToPyrkUqaT9DVFSbPm7hJynh142HwIO
 7uTHRyLVj85UUtD5dkpH1QO9iTBCXmZA+F+x357XJtCpvj1LbEGem8z4FqKTh7ImGWC6IU2PXQu
 qM+ePc2pPL6PF04cPJjG2H7k52oBcNbZkFtyQ5Qg/R/xXOYUEOGGKCI3F8VlsRsJd9NxH5fYDgj
 AFqMNrBtijN0dV+F2jULOg23byJSQGwCgrHoHMl6uhM7VImhjp7hXLgyGgoyC96bVLKbsGfuZx5
 qyKgEmgIJUVMCUcno+Q==
X-Proofpoint-ORIG-GUID: PjirTeRtYnFURWknmAOUNHfeqohb15v1
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE1MDEzMCBTYWx0ZWRfX8qwN3zseZkzW
 4mX1NffphzRFA+IeqF4NdhetNeJQtqjp3P4ziP+8MNMlxA4ZUL60LJk1UrK0bcL4xgIH2L0kk3W
 nuJSEJW+gsWh56b7KIqXUlMT1q1NY2g=
X-Authority-Analysis: v=2.4 cv=DJe/JSNb c=1 sm=1 tr=0 ts=6a80a39a cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=SRrdq9N9AAAA:8 a=VnNF1IyMAAAA:8
 a=5c6VxMoH-_C0Ghh2t7EA:9
X-Proofpoint-GUID: qa-lLIftvBr-qxiouW0Fbx_1CZ2eGN0I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-15_05,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 spamscore=0 clxscore=1015 bulkscore=0
 suspectscore=0 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608150130
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260815_103631_167734_D4C9FF1F 
X-CRM114-Status: GOOD (  11.83  )
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

Update the nvme-multipath documentation to describe the latency I/O
policy, its behavior, and when it is suitable for use.

Suggested-by: Guixin Liu <kanie@linux.alibaba.com>
Reviewed-by: Guixin Liu <kanie@linux.alibaba.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 Documentation/admin-guide/nvme-multipath.rst | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/Documentation/admin-guide/nvme-multipath.rst b/Documentation/admin-guide/nvme-multipath.rst
index 97ca1ccef459..41a8054638ff 100644
--- a/Documentation/admin-guide/nvme-multipath.rst
+++ b/Documentation/admin-guide/nvme-multipath.rst
@@ -70,3 +70,22 @@ When to use the queue-depth policy:
   1. High load with small I/Os: Effectively balances load across paths when
      the load is high, and I/O operations consist of small, relatively
      fixed-sized requests.
+
+Latency
+--------
+
+The latency policy manages I/O requests based on path latency. It periodically
+calculates a weight for each path and distributes I/O accordingly. Paths with
+higher latency receive lower weights, resulting in fewer I/O requests being sent
+to them, while paths with lower latency handle a proportionally larger share of
+the I/O load.
+
+When to use the latency policy
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+1. Homogeneous Path Performance: Utilizes all available paths efficiently when
+   their performance characteristics (e.g., latency, bandwidth) are similar.
+
+2. Heterogeneous Path Performance: Dynamically distributes I/O based on per-path
+   performance characteristics. Paths with lower latency receive a higher share
+   of I/O compared to those with higher latency.
-- 
2.53.0



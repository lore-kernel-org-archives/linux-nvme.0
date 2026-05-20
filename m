Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D46C4CD4F3D
	for <linux-nvme@archiver.kernel.org>; Wed, 20 May 2026 18:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lWnNaFayhn3wE4L0m1Hw4a6/ZNOJzasM9erMdCrpD64=; b=Vb3mPHQKJ6a0MiRG/I/KDgxWnS
	mI47I8xHTDXe2rE4ejJ4TTtSDcRIBknSpYV+2K/errw4RQl6S+eH+ZZlyOSxCqvxhJd5quGkJrvRI
	iu3x22OFucFFKG22rtoOOyluCshjh1E68UQYRDEt9yhkFnCl3EzuEPs6j0G35dOsH9uvqg8x8eo86
	XS05kqjm47Q3qIMuj3/WEb9WgJehwkYhZhBw9VFw1hQTLOH0JdpSnujmxBMOefskjVLE+iIpPtEU2
	ITYOOiIODh59Lwbo1vzsCILTw0K3XwrUga0gQ5H4dQuS0IaXb9UpCuvO38S3oumN3gUZQCV7jodB+
	41lYntpA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPlYr-00000005Qfu-0VQp;
	Wed, 20 May 2026 18:22:29 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPlYn-00000005QdU-3P9Z
	for linux-nvme@bombadil.infradead.org;
	Wed, 20 May 2026 18:22:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=lWnNaFayhn3wE4L0m1Hw4a6/ZNOJzasM9erMdCrpD64=; b=AKi6wbug8gkpvTyfoJUzi5Twlk
	vZ8DVnCJIFvgbi+fZyWuOv9aDtVjrKZB/zXw4vy+W9TDXuN4KThdPHo2KQlsqabZJckO3DIUmFR5F
	LOtBfL4LGsSDM0YjZz5N8KnPgqV9cj/knkxuN4Rc0EOnAMWxtRx2UVsy8zBEfHPChXIECA/XH6jp+
	UFPbnpEMM2EN6scqqY9sxGUamRQQash4GUav8YQeaHf5xXjAigqtTdP90rNhMWL48hTxpwtwGCNiz
	ZXEZ1tOa/9vLGZpNgqqupM61YzUwGpqChsrNK22fmF+E/F2oNG16Cue+0jId7fbZ7HxE65xivVbZv
	ezIBNR2g==;
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by desiato.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPlYj-0000000007u-3pkI
	for linux-nvme@lists.infradead.org;
	Wed, 20 May 2026 18:22:24 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64KDjwfx3464297;
	Wed, 20 May 2026 18:22:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=lWnNaFayhn3wE4L0m
	1Hw4a6/ZNOJzasM9erMdCrpD64=; b=qlxGN20zuPnqd18wMQLq0WOPLHY/ZsgB3
	+8RMP1h66yRktIrXKgTL3ysthB1YmgVsixlkR+6qX6E1i15nsJX5fMDYsKnBcKN6
	l/cL1UvX2SQ6/40MhaH3bfFTwQGwpbDiF7KakGZHhB7QWZdSvmc3RixFAAZBGxay
	bT+JQBAelQ5cSAuEiUyO6VXOS4Cf1pvTp4NwfPBzxoymd73DhrLeCyRJp2SW9Tl4
	UXu1jhJ6bw+hQL2HAPq19mwcBFxbszB50nwfaEuVABFGho1xvRVSCmOs4X0Rfq/u
	+TtWFG5t2EiMpQn9cKyCn7OMPWWggBphAcucW2k1Iw6rvAernQUTw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h753c9d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 May 2026 18:22:13 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64KI9A8h009522;
	Wed, 20 May 2026 18:22:12 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e74dhrfv0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 May 2026 18:22:11 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64KIMAUR26214744
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 May 2026 18:22:10 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EBE942004B;
	Wed, 20 May 2026 18:22:09 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2BF1420040;
	Wed, 20 May 2026 18:22:03 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.61.40.237])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 20 May 2026 18:22:01 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: hare@suse.de, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        dwagner@suse.de, kanie@linux.alibaba.com, jmeneghi@redhat.com,
        randyj@purestorage.com, martin.petersen@oracle.com,
        john.g.garry@oracle.com, gjoyce@linux.ibm.com
Subject: [PATCHv6 8/8] nvme-multipath: add documentation for latency I/O policy
Date: Wed, 20 May 2026 23:51:04 +0530
Message-ID: <20260520182112.863076-9-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260520182112.863076-1-nilay@linux.ibm.com>
References: <20260520182112.863076-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=ffCdDUQF c=1 sm=1 tr=0 ts=6a0dfbd5 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=SRrdq9N9AAAA:8 a=VnNF1IyMAAAA:8
 a=5c6VxMoH-_C0Ghh2t7EA:9
X-Proofpoint-ORIG-GUID: wVqHx_Rn61dwoqZ02Dao0urWbGZqEFZs
X-Proofpoint-GUID: k_0pqB2hKMEmxqH24NcO6OTZziIk_o8X
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDE3NyBTYWx0ZWRfX3SwFB4xzEPJY
 HCZgDVPnzsW1BnySrqJzE4VeDGOlLB55eH4wWQ4vwuqAARoZ0vrubSbqdDRhvPrJ/+nmyN+KowD
 JtnYxrNeOWhNvlVjnf7XU2tNorOivR2cvuQvOB09ICg+H1U6s+3ikVFXAFn12ZZHBGuBT4jt3lr
 9xJLeo8oBn6cIdWnWcEc3e/3PtB7Eh+TgdMCmfUogmuY7DC6Mwfqi1bOxcpM99icsA3OLfUGPNV
 OOgLEJAWmLYBsNDJ1kpTCdyR8fTILbH1QPPsUe1U4QIOf+2Y45G0TZx7Kth99WtjbiyEUWhDLXs
 vgcXOzEmTiGkx3UWNPWKuJRwMps3Y9EF/2R6PXRAqh270ZQgaecpEmPFyfQf49KoGPL4bF3gAjl
 yh/baWec7GgAWrZARbcPxrufEby2HXiY3obVqxSGp8EcJpQKkCCtVZsBoSpB58MDB1q8U/2eGEB
 jvevoG4NK+h60XH8lQw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 suspectscore=0 adultscore=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200177
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260520_192222_786021_50896B8F 
X-CRM114-Status: GOOD (  12.23  )
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



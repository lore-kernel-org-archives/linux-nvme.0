Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 204B2C44507
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Jul 2026 11:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=prWyQO7az6EdCikSbm7PyvCS6DCv1GEBSeh5RqzSMGw=; b=eL8P9RyeoXYyhdcoPJChiHzt7n
	cju4d2dGXMyYX8SKvmJCJoDhQjC0WfSA+LdqDUfi5gOCpae1jIHuw5JneytTITOT8Rve/kQi6BXDt
	bfuUV9JasLfX0H1XLIEepmTZ2CK1lqC/5672+oNm9UMWTTqoSvz9LU035YhKnCf2ppmiSRcpMclE+
	1ir/ncu/4LEtx+ZVAvWcVAOEFqIqkS9b7E5sUAzG3+hNSwx3QnrFM15OXr3m3z6vN6aCLSOJbW/Jx
	tmSn0xRgJ9nUs3E1hWXq0NEpCAscV+8HZWQid7DpHU/4WA9j5K/olxk+HGzv6S3Y5FfjwB6uPqnEm
	79wRZZ4Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjFG1-000000094d7-2adu;
	Mon, 13 Jul 2026 11:55:33 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjFFz-000000094au-19V1
	for linux-nvme@lists.infradead.org;
	Mon, 13 Jul 2026 11:55:32 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66D6gD2e1672711;
	Mon, 13 Jul 2026 11:55:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=prWyQO7az6EdCikSb
	m7PyvCS6DCv1GEBSeh5RqzSMGw=; b=keLa06CZCXV73bWxpadEPldWZZfXChaGD
	fyG9zyyUOwGxCDM3VJ4bo0bgs0ApsZrD1PJOVtF0KP1fg4V0yaGb8JcnEv/ovUXl
	aw1/+DdLGS+PFQ9aslW6TDX0DOco6u2XiVoz/AhgsK2/Lbvpsw5YcIIV0adOd/7a
	0zxJdpURDI5f4/mOt2eE7d8ZKq1JfxlxvpGCrHbSSzXMex8swsC4JzimpfC9J05x
	GyJI46t90jwKAywVpduC1ASi57m79+AXH1v2Q7BxcJPzyEbs2sR1AIg2uWRHKEUS
	v7r+7AM3Q7RPcLuAHLJXClQg+A4xOgSBdzIrHoZQimUH+MRIIbT5Q==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbf2a01wm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 11:55:23 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66DBnc37012359;
	Mon, 13 Jul 2026 11:55:23 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fc0hvwk5g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 11:55:22 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66DBtIeY56820060
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Jul 2026 11:55:19 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DC9372004B;
	Mon, 13 Jul 2026 11:55:18 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 143C020040;
	Mon, 13 Jul 2026 11:55:17 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.bl1-in.ibm.com (unknown [9.123.7.57])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 13 Jul 2026 11:55:16 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: hch@lst.de, elver@google.com, kbusch@kernel.org, sagi@grimberg.me,
        axboe@fb.com, bvanassche@acm.org, gjoyce@linux.ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH v4 10/20] nvme: remove redundant initialization of delayed_removal_secs
Date: Mon, 13 Jul 2026 17:24:11 +0530
Message-ID: <20260713115444.465704-11-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260713115444.465704-1-nilay@linux.ibm.com>
References: <20260713115444.465704-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDEyMiBTYWx0ZWRfX4EOzd6A2jAs7
 jeZ3HG04MYU4w9Uqeyz7VVt0ZtQ+a3TVngviN5AfvOQPLrabocotKBIjPV3iyujZe6tJMrIw7pc
 AV+Np22LmoeqqyvKyP6+63WDPbPqQ24=
X-Proofpoint-GUID: toPQ4cB3a5E-m2TSjqKF5Oyw3iaKtHiY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDEyMiBTYWx0ZWRfXwHDggB8ALPbR
 7D4V8+tFkUm0chGzLsr0fcQN1kRbbHx0EYx7lidmH4TeZNfPhvf8hpRHXzG65woxeR8I2LnIjws
 YK84wQc4hBheADvppz6567kUUuSktrlAvzF+O07U8p22ktBoDmGYYE/j/yJ86+GAhfxWuMOiEoh
 weFLk03g7Giqo3LkQXNlQ2Sx0o+Sv4HljRLEUw8cL8NTJmubxyPBhVmnUKlA80bKu/oQuXhNRqU
 br2L+OCndsg5aconSKHxEyicSNWOEdDRp3i08MXGADqBn1HYeACN3oj/g64mtxG3fqOa+FhArB4
 PTPWZpadxkVnja3/oBh0D3a7oFtW3wRoABWFHKn37QCaMVom4xaWeKnP1PrUycFGmiz3/LzIU31
 G1FK3Im0u7C/p5UO+K8ZopHQXtr2vz4qfnUP9n0M6TSaM+UwZoSIaAJfdnpMnxMU79KcZMVnA1X
 WlTk1cBBZMN279xRYWA==
X-Proofpoint-ORIG-GUID: kgCZpnVN6fTjgFia82pTRKiHv4kHvxJs
X-Authority-Analysis: v=2.4 cv=PvajqQM3 c=1 sm=1 tr=0 ts=6a54d22c cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=ZXaoojwfDXdfg_wq30kA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 impostorscore=0 adultscore=0
 clxscore=1015 lowpriorityscore=0 spamscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130122
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260713_045531_434035_CF657A10 
X-CRM114-Status: GOOD (  13.73  )
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

nvme_ns_head is allocated with kzalloc(), so explicitly initializing
nvme_ns_head::delayed_removal_secs to 0 in nvme_mpath_alloc_disk() is
redundant.

Removing the redundant initialization also avoids a false positive from
Clang's context analysis once nvme_ns_head::delayed_removal_secs is
annotated with __guarded_by(nvme_subsystem::lock).

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/host/multipath.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 282cd8abd0b7..698d79a97045 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -738,7 +738,6 @@ int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, struct nvme_ns_head *head)
 	INIT_WORK(&head->requeue_work, nvme_requeue_work);
 	INIT_WORK(&head->partition_scan_work, nvme_partition_scan_work);
 	INIT_DELAYED_WORK(&head->remove_work, nvme_remove_head_work);
-	head->delayed_removal_secs = 0;
 
 	/*
 	 * If "multipath_always_on" is enabled, a multipath node is added
-- 
2.53.0



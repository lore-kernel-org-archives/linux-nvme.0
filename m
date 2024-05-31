Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E235C25B75
	for <linux-nvme@archiver.kernel.org>; Fri, 31 May 2024 05:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:CC:To:Message-ID:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=TB351GK1yk9ksnTo9pyYUFIaEZ/tPZBjG4F83Nt1RJw=; b=ule0Lf2T+mrwNEw9ie8RLpQwkW
	Qalbve4KHxACHa3pRg2Qp7sMMk9Q6/Glq+Lkb/xfQEBQF8cfTz2/9Inwr+hwDMMgydIDdhA0Sk/Mz
	8N/1TqNIjoPWt77UG6WdTcU8YQ+AKOkoTCV6Kga0rYLDE/Otk+wy/C+qD62iulN+G7MisNb1qVzbg
	fiR8Y7IDWfxewCZSjOhrYhagE2JKgLOe+inKCZhOZZSiUkRNkFdvjb0aeMGvguIKXFZBFcjMq7AhN
	igB31RAwEDognRLP1RvtbsVSdRfL1ej0dwW1545tjSDuPdB7B2avvwc+yh96APMBUyITLvCECV4YQ
	O5FFro+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCuct-00000009GaW-2OlB;
	Fri, 31 May 2024 05:16:27 +0000
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCucm-00000009GZk-2sH1;
	Fri, 31 May 2024 05:16:25 +0000
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44UGrmlB019268;
	Fri, 31 May 2024 05:16:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=TB351GK1yk9ksnTo9pyYUF
	IaEZ/tPZBjG4F83Nt1RJw=; b=RR5iUIL0zxd/MJJt4HLuaanWfAB/R2BaeMU707
	E2qvrczFGdyRImVtS55yQ8IVd0EMWHw5vEw61Qhto351dFkLcaOnX97je18+WL5L
	A8kebgv6/B8GKdnUd1C5OguKDWQmc+KSetd3jfiLV5nflT5agrI+JxH8ocduUjBs
	HxZICfu4aiznPVbOlV4xmYnFCyzqGZjumFyl2NT+70TtSy434criub9tw+MhZDUH
	fPvnc+sh5Ycltzpt7p1IvEEGyM35HMXp4O3PvacTr6eTNVMi3h0rowGHQa/6IBwJ
	9LPbQrSb04HF4u2k54oSYYPKLLjV+tVtFfaZbpjBVOdN6Ihg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yba0ge3jv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 May 2024 05:16:08 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44V5G6n2003381
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 May 2024 05:16:06 GMT
Received: from [169.254.0.1] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 30 May
 2024 22:16:05 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Thu, 30 May 2024 22:16:04 -0700
Subject: [PATCH] nvme-apple: add missing MODULE_DESCRIPTION()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240530-md-nvme-apple-v1-1-b8b7ca569660@quicinc.com>
X-B4-Tracking: v=1; b=H4sIABNdWWYC/x3MywqDMBBG4VeRWXcgtQrqq5QucvlbB0waJlYE8
 d2bdvktzjmoQAWFpuYgxSZF3qniemnIzza9wBKqqTVtZ/qb4Rg4bRFsc17AMAhudOPgu55qkxV
 P2f+/+6Pa2QJ2apOff5dF0mfnaMsKpfP8Auu9pCt+AAAA
To: Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        "Alyssa
 Rosenzweig" <alyssa@rosenzweig.io>,
        Keith Busch <kbusch@kernel.org>, "Jens
 Axboe" <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>, Sagi Grimberg
	<sagi@grimberg.me>
CC: <asahi@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
        <linux-nvme@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: mP3ETysDdDj1tLBnR_cxY8-ywO1_2p3-
X-Proofpoint-ORIG-GUID: mP3ETysDdDj1tLBnR_cxY8-ywO1_2p3-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-31_02,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 adultscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 lowpriorityscore=0 clxscore=1011
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2405310039
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240530_221620_983873_706F57DB 
X-CRM114-Status: GOOD (  10.39  )
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

make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/nvme/host/nvme-apple.o

Add the missing invocation of the MODULE_DESCRIPTION() macro.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/nvme/host/apple.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
index dd6ec0865141..0cfa39361d3b 100644
--- a/drivers/nvme/host/apple.c
+++ b/drivers/nvme/host/apple.c
@@ -1602,4 +1602,5 @@ static struct platform_driver apple_nvme_driver = {
 module_platform_driver(apple_nvme_driver);
 
 MODULE_AUTHOR("Sven Peter <sven@svenpeter.dev>");
+MODULE_DESCRIPTION("Apple ANS NVM Express device driver");
 MODULE_LICENSE("GPL");

---
base-commit: 4a4be1ad3a6efea16c56615f31117590fd881358
change-id: 20240530-md-nvme-apple-e0edb9b98c45



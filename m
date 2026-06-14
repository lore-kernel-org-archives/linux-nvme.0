Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 905C2CD98DA
	for <linux-nvme@archiver.kernel.org>; Sun, 14 Jun 2026 13:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZDOuf+17wYcDr5PsyvzgD2sagqVvJYl3zxrieacw8BU=; b=qkvTH1b4dYC8X4Jp5lctOQx92v
	psOIZexIva7gAMxuWJGWv10gkh5voRxambJ0PZxk9IwD+Pqg9jm9n14RL3gSNvzbrwKVwiwgMenzh
	OFUGEe2p1rU6w/4/p/FauEnfJDEOPvSm/aa+49U7FDJanholxumtIk+cz1CwdKvUfdRM6Wv6m1BUC
	8D64V8UqX2zIoR+QwGWAVAp2Hmj5LsP1xWuNXTGEB+7gTVpEywhw232VqgLY5zVl5lEgR0SgIh3/t
	vtJUirdFpPM8K9VWVjPGkO9SY/K2W43b2jW9sts1kpgKRCWJUgl7cL/QMD4bOarZ/j3JplwXb0vv/
	Bz//LR6w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wYkhu-0000000D1Nh-16Pb;
	Sun, 14 Jun 2026 13:16:58 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wYkhr-0000000D1Kb-4ADh
	for linux-nvme@lists.infradead.org;
	Sun, 14 Jun 2026 13:16:57 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65ECmRYV3531299;
	Sun, 14 Jun 2026 13:16:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=ZDOuf+17wYcDr5Psy
	vzgD2sagqVvJYl3zxrieacw8BU=; b=QrIvniV06+/LU5WnS41GHOPcTOuGGZMbE
	NbaIJlXLSG8+fFRtdN6t0yKCbydEGZloMoiPwByUiGOjAQqzXhCjBMzXVC3coERa
	ixvZaU30kvg1f3ZvTD0KK0IIsCKhzgyME4MQcVUw1zfCsuen+Mxz7gHqxiciIMkF
	NNqzRw9mdcJiNwtKc1tvGT98nePYQttpTU/cvEAmpXn4SLh+vA5/zuPojKn0KTdK
	FboBV2WyDUcjsQIPB6h5lqKrCau4zod4mDwerP4pA0ix4aUVvWwdZ6aH0G4YT6TH
	hxXjR5SrKcxU58v0FiflJ66jgJhdiMwxsQR5EMgzPVkmFUZS7SryQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4es1h7us3k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 14 Jun 2026 13:16:47 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65ED4fOW018183;
	Sun, 14 Jun 2026 13:16:46 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4eshwvsrk6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 14 Jun 2026 13:16:46 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65EDGgw752953586
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 14 Jun 2026 13:16:42 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A66912004B;
	Sun, 14 Jun 2026 13:16:42 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D597620040;
	Sun, 14 Jun 2026 13:16:39 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.43.80.1])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 14 Jun 2026 13:16:39 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com,
        bvanassche@acm.org, elver@google.com, gjoyce@linux.ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCHv2 17/17] nvme: enable Clang context analysis support for nvme host driver
Date: Sun, 14 Jun 2026 18:45:32 +0530
Message-ID: <20260614131541.2017845-18-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260614131541.2017845-1-nilay@linux.ibm.com>
References: <20260614131541.2017845-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE0MDEzMCBTYWx0ZWRfX9H/iqFZ+IOz6
 +LlhfA4wPsBaIn2W8oshN8U9Udp3RZAN+T1Z3GXr1g+ytX3EGdyHx48VSUZaxejEDwhnv7fu9Bz
 Mtc6uSna4k83Mj0HKkU57rGRz1Hw6nQ=
X-Proofpoint-ORIG-GUID: 1nlvpXy5j53Ctvnb9qQc-Ini-iw-eBWd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE0MDEzMCBTYWx0ZWRfX3OgbUMfr1PxI
 6CDTSqUA4b6kR9TnIIbPdzQvE5byBHlWk69rS//hZlXCIsPED8Jcp8vBkfm0ltHTou82xggAwBK
 5CyGbhptNmcfFYRQJMl62jYQyjs8lxC2+AolOdDfIdGDY+kB2Gp4/f1LX2lUSAiY/0lb5byxBRI
 mkKlx9AyPs8QZqzAjuGA8VRGda2W3erhbotEsascW51NMknhonIl3ZOqmSpp8STVkWDw5FyFNl+
 VUGqcsDcdwJLE3AUFwiAvtPeIWvXBmuCA4SZEPr/WET1xb1TGfvCD+BqqgBY6VqJOPcH2dQfyV9
 kUFa62jTK2WtDx2lFoul9wVOnrlU5cPBB1Gwv82hWs9kMPeRkpUHpwWOuNzj1Gtcrevus/y1IBm
 kGZGKP/4ofTXn3Jz1eqnbY3nSyjKIofY3uw6lyzDbVmHiZNCv/g+PMKlEjos1mrv20yYWa3B6B7
 W/sTqduBrY1/TisMkoA==
X-Authority-Analysis: v=2.4 cv=U9uiy+ru c=1 sm=1 tr=0 ts=6a2ea9bf cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=GVzyxF2uuL8LOb_S8PgA:9
X-Proofpoint-GUID: HEGS1jbz1k_H3jk-Zn-5lXeGozlypr5m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-14_03,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 phishscore=0
 priorityscore=1501 clxscore=1015 adultscore=0 malwarescore=0 suspectscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606140130
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260614_061656_059312_402834A0 
X-CRM114-Status: GOOD (  10.85  )
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

Update nvme host driver makefile to enable support for the Clang's
context anaysis.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/host/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/Makefile b/drivers/nvme/host/Makefile
index 6414ec968f99..67563a69f7dc 100644
--- a/drivers/nvme/host/Makefile
+++ b/drivers/nvme/host/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 
+CONTEXT_ANALYSIS			:= y
 ccflags-y				+= -I$(src)
 
 obj-$(CONFIG_NVME_CORE)			+= nvme-core.o
-- 
2.53.0



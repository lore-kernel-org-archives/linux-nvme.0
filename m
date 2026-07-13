Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44B5DC43458
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Jul 2026 11:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZDOuf+17wYcDr5PsyvzgD2sagqVvJYl3zxrieacw8BU=; b=UddFl4I7fGG1n9fz8KSOsaFWbG
	T1wJxktFZ6ruYZV8jUHA1OZv3QDQ0AFhGj/3Q1m7Q/VmjcXg9UV62+F0WFBfMA1XDjcVwuTEQZjF2
	oYHvvcTA2WdSwwPDu1pyqUDzBfUeAfSI9JWDWHKGOAhn0P/mg1VjdhNIKi91VfQ7LIuFpYxYxeH85
	jc1gkvh8bSMk1Jqkv7FB0ndNM+AVbOZirJ2MFgggt6cLHROvs8J5LS1qPBU6oJuVARuCkCGkyWU5M
	2ZyHaaOLuB9G5F2wZbzoQ42uGK1RKKtvViu3iORnOfMnfLhFeL/F7cqWDsXZ4b5+VaG1CtsmMJw3W
	LmV/tQxw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjFGU-000000095QK-0FYL;
	Mon, 13 Jul 2026 11:56:02 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjFGS-000000095Nb-21Vr
	for linux-nvme@bombadil.infradead.org;
	Mon, 13 Jul 2026 11:56:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=ZDOuf+17wYcDr5PsyvzgD2sagqVvJYl3zxrieacw8BU=; b=Y+6IqPOaFJ8BpXxFnB9DkN4Psq
	CAGluFFWR27fMFavL4cKiwOKeytYtnDLR9+GIWIYB8RyycwbRbDxtWtHurBym1zlr+8BasU70MRHu
	WtewT7s/xKFNMUteCFp+sDmExoEG2vPkvF9W1DGarc226xSYBbIm/LpXuFeJyUj1TJn0dfUr2f/at
	ihtBv+tOXDf3SKj40jzA5St41H9KDty6IdemlZKGGGb8YLp+1BrsYem32QVz5oKq9IpSYdlrL77oF
	JrOMFPWuxjtMr6nRjfILnFeRt5SZ2KTx5pErWV3+DuMSvnBhR89Bkfyke4Gtnbhc7OHiMu8tEdbwn
	9sQKOixg==;
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by desiato.infradead.org with esmtps (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wjFGP-0000000BZgD-1B9M
	for linux-nvme@lists.infradead.org;
	Mon, 13 Jul 2026 11:55:59 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66D6gCbv1672687;
	Mon, 13 Jul 2026 11:55:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=ZDOuf+17wYcDr5Psy
	vzgD2sagqVvJYl3zxrieacw8BU=; b=sP40s3h0PJ1UnRfI+GutCcXb7unTi6I5Z
	fiM65EzCFVqZFK9JSggFsOf49zqp1vULnz4fMiXUNawZgIWqhC2ncF71/hENFkmW
	+gvK1rKSWj9XcN8vOfNZrqH/z6681WjMISPtmT8UUuKQe9KxaT6kndfSgFI1Wwl4
	FsuLS4IA5bMluOZ5y+IIDUy8KqC4pEN3loDahj6zuUFTHLo68KtIp2bh2JGdfEV7
	m1Bmj0HGmH9+RSONWBVidSG2NLW+7mPA6c3ORLE0T4+Wcu22WH3qyXu+Xe0gsw59
	gUfhgbLT1kgiStQ7NPyjitcRHhEhRq4YodqtPXD4voKB4qu2suDWg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbf2a01y5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 11:55:45 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66DBnbMa012342;
	Mon, 13 Jul 2026 11:55:44 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fc0hvwk6c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 11:55:44 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66DBtewD31326598
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Jul 2026 11:55:40 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 911FA20043;
	Mon, 13 Jul 2026 11:55:40 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7F2CC20040;
	Mon, 13 Jul 2026 11:55:38 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.bl1-in.ibm.com (unknown [9.123.7.57])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 13 Jul 2026 11:55:38 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: hch@lst.de, elver@google.com, kbusch@kernel.org, sagi@grimberg.me,
        axboe@fb.com, bvanassche@acm.org, gjoyce@linux.ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH v4 20/20] nvme: enable context analysis support for nvme host driver
Date: Mon, 13 Jul 2026 17:24:21 +0530
Message-ID: <20260713115444.465704-21-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260713115444.465704-1-nilay@linux.ibm.com>
References: <20260713115444.465704-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDEyMiBTYWx0ZWRfX2MsIQXfZDzaI
 JyFZYMjzTtFYBqz0DZTUXyeQ8jIOj7t/GXDXp1TlIaoy5qOCaOnrHVMTEMOAsIDtvUkzhPVtcoM
 4sngP95MmCXbZ1LWGGpNM7CvO/HSOHQ=
X-Proofpoint-GUID: tI3GHZRU6j72kCTiIFFlCACHr952gzcP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDEyMiBTYWx0ZWRfX67lkLwzkfbPU
 L/+xoXkbqRRAvasXwzbg/+WxFZ1ALPjDsLkrV2ji9TA5MIoiMuGTfjUTImlrtp2Rzx80rD6jP6C
 md+Cw6Nq+O2mFpAHTU7sTAcBxld52J0DbA0Od3y5aMVPnGhgAtArtQVbm910AF2RugStrbKY5Cz
 35uJcYE/Adsa+F7ou0Pm/4esNJmwhOvtNkbQ7W7wR/ZKPq6WuFZj61PDuJ6/MJiJtUjmnsjmqqh
 ITR2jMsG0Ca38uCOOP3RRiHbYLFtLXi0G5qT9vmWkB/4t0n0BCFdy/svFvGBa2FIeY+h6tulvKZ
 yBou179nivDOVqzWdSDRc41oNmxZP7rYPGtH0ToQYA+xIA1AmVjIk4+aMUJkD8CihqhN6sgl2Ia
 UoVi7tSwfZwz9Vr87dx+N7yRJJyPkZs9d1sX+iTDERF/GOeOwAVKDABgx6LJTgVeyKYtHdRr89F
 oi1IYfppUveBMFFJdww==
X-Proofpoint-ORIG-GUID: pgEtUyCXozLtzFKhFCOgzL7pfTw6p54h
X-Authority-Analysis: v=2.4 cv=PvajqQM3 c=1 sm=1 tr=0 ts=6a54d241 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=GVzyxF2uuL8LOb_S8PgA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 impostorscore=0 adultscore=0
 clxscore=1015 lowpriorityscore=0 spamscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130122
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260713_125557_582518_94EEE89E 
X-CRM114-Status: GOOD (  13.19  )
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



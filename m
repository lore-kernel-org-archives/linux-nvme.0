Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0A00C43458
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Jul 2026 14:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=p0JzCFoY0vvbKIbWUhPVOnRAunhGxTKpi9Q0EX2i2g8=; b=UHbLTeV4AXbyZ7YEtqpKS5v3Af
	VAGAIGopHNtQ2cTl/qULjSAkFCL72DijfF/gOhxOoxh3NiBZTObpYgYnJxwnBo5cOd5SfMtJNGYz/
	Qh460/tJRG2opO6nDGmmwFnzVF9MrDaGqTyXmU/SXZvmdrQBEbC8x38Vll7AvReqDGcsm7GGfq9n/
	YokA4JzmWI2TW4hvBvoMyIAk2Wca6hUT92WDLvKFgnpPm5s//q2r1QGdl3Iblf/mYk/38//mGGHFA
	oDGHs12zbRpNxk7Q/szH4Gh5flJV9meVhB0U3i+n/3x/YuNCPwobhMECLvrsJ8x0ZXuZUNw/wt/rZ
	0Xk/qh2w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wgk7O-0000000CiDC-3uX1;
	Mon, 06 Jul 2026 14:16:18 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wgk7M-0000000Ci8I-0biX
	for linux-nvme@lists.infradead.org;
	Mon, 06 Jul 2026 14:16:17 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666BIO3O4094107;
	Mon, 6 Jul 2026 14:16:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=p0JzCFoY0vvbKIbWU
	hPVOnRAunhGxTKpi9Q0EX2i2g8=; b=Lvp6fp5qocpCpqz1vFovWcaS5ZKbSmGpT
	N99f8ZRzZwXrFK9JTI9agei8vgqXeTBL+xVNe/avJsQdqtOgBl67539LCPhRBNRg
	POQT5m3Xv+jF9SPObhHnaZRub3e+vdJyxc6UDZUVGZIo5ijpHB9LmOGhOXcAfn9d
	Wh9k4qlZoXb0QWt69EnGJ0hv81zGVcQwaE2D8HtFG39Gs0/+a04OxK7XbbkfI4tQ
	XfEcGpcFpWEMKbC1q/S7sjwARpEjSopSlE86FLk82kHeltmuzNRWwKLiNvNIiw+t
	WW6zM03M7cfzM8c3DFDfnxj7ppPjLBRKT7pujuj9iUHDvD2bO4bwQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6sw4hstd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 14:16:07 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 666E4dTe018969;
	Mon, 6 Jul 2026 14:16:07 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7cgpx44f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 14:16:06 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 666EG3u138601000
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 6 Jul 2026 14:16:03 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6781E20043;
	Mon,  6 Jul 2026 14:16:03 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 23BCC20040;
	Mon,  6 Jul 2026 14:16:01 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.bl1-in.ibm.com (unknown [9.123.7.57])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  6 Jul 2026 14:16:00 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: hch@lst.de, elver@google.com, kbusch@kernel.org, sagi@grimberg.me,
        axboe@fb.com, bvanassche@acm.org, gjoyce@linux.ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH v3 11/18] nvme: add context annotations in fabric.c
Date: Mon,  6 Jul 2026 19:44:13 +0530
Message-ID: <20260706141452.3008233-12-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260706141452.3008233-1-nilay@linux.ibm.com>
References: <20260706141452.3008233-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: j1qmRqfyhtuo4hpxCtpTpDvkViafyyvv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE0MSBTYWx0ZWRfX19NRrLHeggFr
 jIGqUf0kFFw3ZEEgGpA0V3CgsCGZ+yTyYfB48Qf9kGRt6p1Yo1zEtMHsugwJyXWWjh5S3rsQSKi
 CcpBiP3KoV7HSlWyJIfpwV+uCQKQ5I853qTmYiKW/3FED7rHVOVcqXN5MCajVKGlu8KmsJrC0nX
 WxsY32ShGpiZ9OPu7krRioF431cZU3sjHlwpqOi5dDo0cfZxaXY5pB9Ko5oJ0I840ZJBBKV4LHs
 xVONr1fSJ69fHX4I4pMoEsBTi8xaMvaMIASEAYQFZ7m3Y3pIqfwkqnWwo7dU9eGKaPNO7W+Zlc/
 xz+7ma05SqWfDDg54tl1EzxuZk0qiisLN23I6c8shKcezgHE92Z3yzz/yWRiQu8a4uWMybFsPsb
 HiRfAujYDfHj/lsdDNHiRMAtGr+CyUX8YLhuImRif0Foz8FPjPSjLMBndCM9k+amOVQXW7ziYzO
 JtFKW3f21vVS55UB2TA==
X-Proofpoint-ORIG-GUID: KpmGvOa0oyLsFyg1TY1bWcI6FnfLjBWP
X-Authority-Analysis: v=2.4 cv=FqQ1OWrq c=1 sm=1 tr=0 ts=6a4bb8a8 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=-W7SLkP_sVXSNSbjlKUA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE0MSBTYWx0ZWRfX9wIeeywBnuRO
 c3MOiml+zW0mfC2P4EFwCpfKpie3zqFQG+echInrqt/oQ+DeVsyTzDyh5phMEW1ZXtgrd9bNbry
 Zg+9XNcqB99NB/+XEw61HML5IHpmRVE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060141
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260706_071616_191303_DB79C704 
X-CRM114-Status: GOOD (  13.16  )
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

The global nvmf_transports list is protected by nvmf_transports_rwsem
and the global nvmf_hosts list is protected by nvmf_hosts_mutex.

Define both lists using INIT_LIST_GUARDED() so that Clang's context
analysis can validate accesses to the lists against the corresponding
locking requirements.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/host/fabrics.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index ac3d4f400601..fd5abd04e080 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -14,11 +14,11 @@
 #include "fabrics.h"
 #include <linux/nvme-keyring.h>
 
-static LIST_HEAD(nvmf_transports);
 static DECLARE_RWSEM(nvmf_transports_rwsem);
+static LIST_HEAD_GUARDED(nvmf_transports, nvmf_transports_rwsem);
 
-static LIST_HEAD(nvmf_hosts);
 static DEFINE_MUTEX(nvmf_hosts_mutex);
+static LIST_HEAD_GUARDED(nvmf_hosts, nvmf_hosts_mutex);
 
 static struct nvmf_host *nvmf_default_host;
 
-- 
2.53.0



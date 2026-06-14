Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1044DCD98D2
	for <linux-nvme@archiver.kernel.org>; Sun, 14 Jun 2026 13:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Dz9ssXISrSOFWSnZhMpXU2EXfaea4HSwpS4Oza/YZIg=; b=ETmD/DuQmOzvx0mnFyXmyDzBp0
	oV7sTXF/2d8E/7UdZsM1W5GdJKXhYneCosS2WU3XGTf+enXW7+T8m9/P15jYnCWgqkK12I4zFk3oP
	k/FRWdiNUOLlsBmiSORjKpKAKgxL9h3bMp1fNE3dD5BemVyz+U93Vvovrri5qUbfLDYE3+sM5v8bE
	+UhoWOoabIXF5sIMN9ZzkHNX0durorg3MaRdtrKTvb5rUHQfyvnUZClkrsNbholVRIkqs0pr8DzzN
	yjY8JdAhK6mn+DpNL3bIfydTEw419t3eUhes4yF0V4G5BMLt1/zuxue8p322rQwgNLWKU9o8UT0K7
	Zgcup4Cg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wYkhm-0000000D1Ev-2r2Z;
	Sun, 14 Jun 2026 13:16:50 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wYkhh-0000000D175-1mS1
	for linux-nvme@lists.infradead.org;
	Sun, 14 Jun 2026 13:16:49 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65ECmcmu3531397;
	Sun, 14 Jun 2026 13:16:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Dz9ssXISrSOFWSnZh
	MpXU2EXfaea4HSwpS4Oza/YZIg=; b=h+YuTonKUsOO8t879j5FoQiwhjRE72w+f
	HSfQGCJD6mezbsnEN6R0GHQ2rhzKTF0Bpwau6tP0pTePE5V0/9yB0xMORMmjkhH7
	dIHPGA8r3ckdfewhXkotP8JxeG230wkzFG/ugmYHIZXD73DkjN8fYSWZLPJeYA6f
	2m8arTvUWDiQQxq8sRtSwCDJZ6PkHCplsz7xlAor/bEwEaoveA+woYxteIgwN196
	LzCAKdjoo7SRbcebX5giFyTZXJstCg0K5fgWeQ2DiHdUpJKESsflLRnaazbWGoNx
	nYu2WiP5CKz88/lfz5lP5XPaisJUdjUqRq665LQBaIEHph6crcbQQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4es1h7us37-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 14 Jun 2026 13:16:38 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65ED4ZX5013173;
	Sun, 14 Jun 2026 13:16:37 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4esjhjsn12-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 14 Jun 2026 13:16:37 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65EDGXku49611168
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 14 Jun 2026 13:16:33 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 51AAA20043;
	Sun, 14 Jun 2026 13:16:33 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9478B20040;
	Sun, 14 Jun 2026 13:16:30 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.43.80.1])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 14 Jun 2026 13:16:30 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com,
        bvanassche@acm.org, elver@google.com, gjoyce@linux.ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCHv2 14/17] nvme: fix Clang context analysis warning in rdma.c
Date: Sun, 14 Jun 2026 18:45:29 +0530
Message-ID: <20260614131541.2017845-15-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260614131541.2017845-1-nilay@linux.ibm.com>
References: <20260614131541.2017845-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE0MDEzMCBTYWx0ZWRfX28FZK3t6rL/s
 inObtg8AJHrryRYmcTd0Qf2X4oHKtblDnSskZ/+CHhJsMXl6hSEjZ3T7XFOEmEpaT39SGtDMKxb
 BTk3GZbmyak2fle2pkcIq6O4jMijZZ4=
X-Proofpoint-ORIG-GUID: h4O6-4MA252bpZ8TbrRVLqGXoAZyorN_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE0MDEzMCBTYWx0ZWRfXx3JAC5G+38mG
 vrAumVJowUXW0uz7w9aq+4ur58NbAB5cbSsSXfdRPFFodVw1UlkyaTwwZKGjnWYD8vE+QwzJ3Sx
 0w6FGYPs7TA2aDlhaZEVzvHTGokGrvHPvPwLM1rM+n+zqvbplAowtHMxYYmGuk49qKMrO3T7qLJ
 PpIsJo4f/uHDYTOKrBkC9zPq5omp7WdgzKZ3PCrO9yONBx6IU35zRmKQaLW7eXPvUhJ13RF6JjX
 TKKEFTo8wPsauKzbq3slssP5K2YxNIyMgbMpkFjUh6akKNG3nOZD1+pJ5QG06e+q/epU4uyRYks
 QpXmuBoGbQR9pGUuICa0a/pw3JJ5ixcw2+mXIzKL7xJ61I2dfkuKhmfLLdkfUlWMH8mJCjBUG1v
 0ceDydu1pSp+ATPJWQTNBWyk1SE0We8lbm0KN5m0k2siqB+S7/3L1ksdoo2Jix6yz5NLLwzv85g
 ncr8acUwddcOFjh8urg==
X-Authority-Analysis: v=2.4 cv=U9uiy+ru c=1 sm=1 tr=0 ts=6a2ea9b6 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=Po-eUfe_3Zh2qMAXCUQA:9
X-Proofpoint-GUID: s2fzShC1FPdxF_H1AXkqn2PxStox3Taf
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
X-CRM114-CacheID: sfid-20260614_061645_466955_97B0120B 
X-CRM114-Status: GOOD (  13.30  )
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

After adding Clang lock context annotations in rdma.c, Clang reports
the following warning when context analysis is enabled:

drivers/nvme/host/rdma.c:972:24: warning: passing pointer to variable 'list' requires holding mutex 'nvme_rdma_ctrl_mutex'
	  [-Wthread-safety-pointer]
  972 |         if (list_empty(&ctrl->list))
	  |                               ^

The warning is triggered because ctrl->list is annotated as being
protected by nvme_rdma_ctrl_mutex, but list_empty(&ctrl->list) is
invoked without holding that mutex.

Fix the warning by performing the list_empty(&ctrl->list) check while
holding nvme_rdma_ctrl_mutex.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/host/rdma.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 2c55f05f7550..da7770025059 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -969,10 +969,11 @@ static void nvme_rdma_free_ctrl(struct nvme_ctrl *nctrl)
 {
 	struct nvme_rdma_ctrl *ctrl = to_rdma_ctrl(nctrl);
 
-	if (list_empty(&ctrl->list))
-		goto free_ctrl;
-
 	mutex_lock(&nvme_rdma_ctrl_mutex);
+	if (list_empty(&ctrl->list)) {
+		mutex_unlock(&nvme_rdma_ctrl_mutex);
+		goto free_ctrl;
+	}
 	list_del(&ctrl->list);
 	mutex_unlock(&nvme_rdma_ctrl_mutex);
 
-- 
2.53.0



Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E60E7CD4F3D
	for <linux-nvme@archiver.kernel.org>; Wed, 20 May 2026 18:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lzSDyVP60X22MY71IQ8y53mJFtDryR1BHGa5iB8LkeY=; b=suMmloohQHizGZGnSyP26ktxmO
	D/+vfwK5F/AiVLpTyjplJoJIXxVfIY939GkEBgmxtM9IUMu30xA2/+PZ3/gmqPNhiM6npNm3BMv9N
	dmcGLUc5hFNgrsUBg0kSH4ARHq63snpfDkIV4HU/3Ick+Z7GUq67xt9WhvQXdSlbYtSjlOLMu+j3X
	nFKwmLUiJZI7zNM9C2I9NJwEvCyMDmUbM4Z1kp1q5W7FthF/j1HEgY0puOC6HpuKWQmbygnlCTT4X
	ctWedBRQlT3JG41+imAqS23TZHRAVwGem9B2bUgbtxz8uK5PNJ8LT0nL2O0Lq5qDjWHnNIXl/M20j
	OaCROkqQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPlY5-00000005Q9e-0NYc;
	Wed, 20 May 2026 18:21:41 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPlY0-00000005Q7y-0joV
	for linux-nvme@lists.infradead.org;
	Wed, 20 May 2026 18:21:38 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64K8GPnY1495254;
	Wed, 20 May 2026 18:21:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=lzSDyVP60X22MY71I
	Q8y53mJFtDryR1BHGa5iB8LkeY=; b=o/uirM8y8GoLlzaxVI5k+PUjqTWdvoMsw
	SXA6439aZt5SLbU8PJN2abvnKmsBHQ7uwDgDTyKE10oGh6jeMWQHfR6nAAvtzgIm
	sZWmZCHrjOP8nbR4lMmDjp9pYlHcTbOglCKJ6cyOmf1wxBwvK54zN+UuiGR2EqEZ
	QxWMdUGuBEG2wEgPsBofu6tlGnRqRKV+SK1k77jDVmxREebtf7H+P238g5yynhvC
	Y/WqimV5ibw47PjxPI8iQNTwd/nOgVPqIc7npZxHzRKoUUEWhNFLVPva743eWt2E
	TgACHTtKYN6qCAzmBXSnRh8IjpzcR1Xq6uG4Vy5ofyUEgygf/wpng==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6hb8jb7c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 May 2026 18:21:28 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64KI9B8l028814;
	Wed, 20 May 2026 18:21:27 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e73wk8j85-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 May 2026 18:21:27 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64KILPpA14877132
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 May 2026 18:21:25 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6BB522004B;
	Wed, 20 May 2026 18:21:25 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6B1EC20040;
	Wed, 20 May 2026 18:21:20 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.61.40.237])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 20 May 2026 18:21:20 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: hare@suse.de, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        dwagner@suse.de, kanie@linux.alibaba.com, jmeneghi@redhat.com,
        randyj@purestorage.com, martin.petersen@oracle.com,
        john.g.garry@oracle.com, gjoyce@linux.ibm.com
Subject: [PATCHv6 1/8] block: expose blk_stat_{enable,disable}_accounting() to drivers
Date: Wed, 20 May 2026 23:50:57 +0530
Message-ID: <20260520182112.863076-2-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260520182112.863076-1-nilay@linux.ibm.com>
References: <20260520182112.863076-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDE3NyBTYWx0ZWRfX9niKtUGUkrcA
 tKR2LAzyBk0ANMh8FkgLG9/VaTGcH1iyiONCkBvSa5yejzXGUBKSUhYSRDlk/Xef7KNE44MXUIq
 d8+EhfeHqZpQYbsAxBuunBaHUlUUv2tN3TKQT0VmY+Q9U2id5PMcbKeY9P4bOSn3u6cLVmpNAmQ
 ZnKP1PnPM/rkdeFpll5FKOml2uUf06SNhxWRTnlcagdnI0vA32d7q06UU6L4pLBEvc+kubKHEv0
 9YgnMqahRWAJgvR44ppDsp3wRQyoHQ17y4DSxYElnoc9nWFo/GcmkfjS0z0ClSs86PD/kRZIqlR
 RaLt+RKJkyrnDzePcV04e4OWJAb30mosr5qA15GEHcSXBLTkPCG0GIWdMncBfT0I9/zWPvt+v8l
 mLM8s4T/RNTL/3Bobkl9bFgq668WEY0tcKHOmeGUJDCe56Fi5ynmW6pNhlaIwvkof7co0I/360D
 4/hZ6dbr05Hnsefj91A==
X-Proofpoint-GUID: QGIseDlpBulDnA0lKGqc4a6jKURBYpVN
X-Proofpoint-ORIG-GUID: CAOLOc8Vxmn8xqPbC2PIOoNWchxvdWrQ
X-Authority-Analysis: v=2.4 cv=aYBRWxot c=1 sm=1 tr=0 ts=6a0dfba8 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=SifjupJSLTu-I8RqnBoA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1015 spamscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200177
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260520_112136_333659_9478D3F5 
X-CRM114-Status: GOOD (  13.90  )
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

The functions blk_stat_enable_accounting() and
blk_stat_disable_accounting() are currently exported, but their
prototypes are only defined in a private header. Move these prototypes
into a common header so that block drivers can directly use these APIs.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 block/blk-stat.h       | 4 ----
 include/linux/blk-mq.h | 4 ++++
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/block/blk-stat.h b/block/blk-stat.h
index cc5b66e7ee60..b1614a1ef4ad 100644
--- a/block/blk-stat.h
+++ b/block/blk-stat.h
@@ -70,10 +70,6 @@ void blk_free_queue_stats(struct blk_queue_stats *);
 
 void blk_stat_add(struct request *rq, u64 now);
 
-/* record time/size info in request but not add a callback */
-void blk_stat_enable_accounting(struct request_queue *q);
-void blk_stat_disable_accounting(struct request_queue *q);
-
 /**
  * blk_stat_alloc_callback() - Allocate a block statistics callback.
  * @timer_fn: Timer callback function.
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 18a2388ba581..88aabc2dd738 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -753,6 +753,10 @@ int blk_rq_poll(struct request *rq, struct io_comp_batch *iob,
 
 bool blk_mq_queue_inflight(struct request_queue *q);
 
+/* record time/size info in request but not add a callback */
+void blk_stat_enable_accounting(struct request_queue *q);
+void blk_stat_disable_accounting(struct request_queue *q);
+
 enum {
 	/* return when out of requests */
 	BLK_MQ_REQ_NOWAIT	= (__force blk_mq_req_flags_t)(1 << 0),
-- 
2.53.0



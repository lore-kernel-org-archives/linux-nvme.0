Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56A8BCAC5A7
	for <linux-nvme@archiver.kernel.org>; Sun, 21 Sep 2025 11:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0bt2EwD50HocxNMEAhRty0GZkrRtmjkbeJvc5Jt3Rok=; b=BzKTLQ1dfSUjm2L2nXPRKdpfbe
	vx//xRWkZuYqmw3libirO19Uf5z55WhIRQPQw9lMnC60OXyQdasyTB/yYNddYb4MqWyPJT1tb9Hir
	m0KIhLJ+JwdIqCyeIxYGE0L9h8GrOr+BsMKqbb/kdMhCF5SecFJTWykhyfj7ACwXYgGG+1/A1uaJP
	/9HOthDeqBHxRAf6a2AgPfqyJnFX8EdRa7fYazekvSeZ6kC/vyIfTLE/xc0/diAZsf1Zb8foANWSx
	mxWLmUgsEgBclgCNSlu8IAF/OyEKzceje1Qv/4y9UM4saXKBjNg8aJ1JByS5MOyoMyB2HxlkHduHU
	+dCivA/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0I09-00000007MRd-0C66;
	Sun, 21 Sep 2025 11:13:05 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0I06-00000007MPy-0fZn
	for linux-nvme@lists.infradead.org;
	Sun, 21 Sep 2025 11:13:03 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58LAQ7Gk027349;
	Sun, 21 Sep 2025 11:12:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=0bt2EwD50HocxNMEA
	hRty0GZkrRtmjkbeJvc5Jt3Rok=; b=btA0rWjOGV2kT97yu3k7+hX4m99VumQNO
	r8Jb1O+20qnx2/WmsWGCOFT9DqnLqdJOelQ8hvAPkAuC9glpyChlaunkYR5TTpRz
	0Hcv3fFRrMZgy6F6n86FGugz99LPSQcVX9o16e4sLkQKeWXA9pruxXcIg9OyLHMH
	Qb5FCZtq3o5fi5FmGVBiH/eVo1g5T1bF9J1ZyfO22mSp+HP7gA1MqN8ehdKUWkSh
	cSozl+KVueV40FMdUahNopdPDe4ZgR2W+4/s1mc49u3CxDPorCgbG7I1DM57n+Wy
	1p+gR8njHpzjEkzpHr7QQXhyr24m9HcWHaEtBXveAesDh68FXUzsQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 499kwy556k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 21 Sep 2025 11:12:44 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58L8t3gu030359;
	Sun, 21 Sep 2025 11:12:43 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 49a9a0s79j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 21 Sep 2025 11:12:43 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58LBCfA137355894
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 21 Sep 2025 11:12:42 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D490D2004D;
	Sun, 21 Sep 2025 11:12:41 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 64D9A20040;
	Sun, 21 Sep 2025 11:12:39 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.43.45.7])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 21 Sep 2025 11:12:39 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, axboe@kernel.dk,
        hare@suse.de, dwagner@suse.de, gjoyce@ibm.com
Subject: [RFC PATCH 1/5] block: expose blk_stat_{enable,disable}_accounting() to drivers
Date: Sun, 21 Sep 2025 16:42:21 +0530
Message-ID: <20250921111234.863853-2-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250921111234.863853-1-nilay@linux.ibm.com>
References: <20250921111234.863853-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=J5Cq7BnS c=1 sm=1 tr=0 ts=68cfddac cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=SifjupJSLTu-I8RqnBoA:9
X-Proofpoint-GUID: w8Xhv9U8aaGSTkWJiPnqJZkmJM8DNxgV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAxNSBTYWx0ZWRfX7ML1CAFBIoHl
 o0DO+F+ks6pxmc19ZSVoUddcRRwwlYDqQ5lyOnt328q+FjAxdjbGVMqHHrIjZ7/T+6VfqNnlCL7
 dTjzpbq+hdc2fhBi4tOgHVYpahBk62apn+JoPDmFHZ5gh4j8gx52l4xE+g/WcgN3N/50IcFXI32
 uvmDNv9c21jiI1PlPxqi1T/tZvC6MAvOF6rf6GXbcnnjwCzoDNXPk5sSeyOhgjoNFiLGOUnFPCG
 nMsX5lkmnWxUpRCzWO9tpoZ5ubO5TrCMRBb/tDVSkZkulSp+NgelMCBrqPoyyLk8Or244eRwxQ2
 UJ8rbBGleOtfioQ4ydfmzGgv+9BdpovJ3Ik1rHjZgQVQ3ldwmKc5+ScnghRyiNGLduEnF0evKYY
 SoSSyoNj
X-Proofpoint-ORIG-GUID: w8Xhv9U8aaGSTkWJiPnqJZkmJM8DNxgV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-21_03,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 spamscore=0 bulkscore=0
 phishscore=0 clxscore=1015 adultscore=0 suspectscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509200015
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250921_041302_320152_8A5F4073 
X-CRM114-Status: GOOD (  14.47  )
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

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 block/blk-stat.h       | 4 ----
 include/linux/blk-mq.h | 4 ++++
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/block/blk-stat.h b/block/blk-stat.h
index 9e05bf18d1be..f5d95dd8c0e9 100644
--- a/block/blk-stat.h
+++ b/block/blk-stat.h
@@ -67,10 +67,6 @@ void blk_free_queue_stats(struct blk_queue_stats *);
 
 void blk_stat_add(struct request *rq, u64 now);
 
-/* record time/size info in request but not add a callback */
-void blk_stat_enable_accounting(struct request_queue *q);
-void blk_stat_disable_accounting(struct request_queue *q);
-
 /**
  * blk_stat_alloc_callback() - Allocate a block statistics callback.
  * @timer_fn: Timer callback function.
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 2a5a828f19a0..e35e91ca2284 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -732,6 +732,10 @@ int blk_rq_poll(struct request *rq, struct io_comp_batch *iob,
 
 bool blk_mq_queue_inflight(struct request_queue *q);
 
+/* record time/size info in request but not add a callback */
+void blk_stat_enable_accounting(struct request_queue *q);
+void blk_stat_disable_accounting(struct request_queue *q);
+
 enum {
 	/* return when out of requests */
 	BLK_MQ_REQ_NOWAIT	= (__force blk_mq_req_flags_t)(1 << 0),
-- 
2.51.0



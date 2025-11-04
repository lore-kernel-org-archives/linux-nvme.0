Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08265CCF9E3
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Nov 2025 10:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qxaa2JVRO5iqXs34BoMCLiqKIKAlpIXCahAH4vhqm8A=; b=eMdjkLwnPGX2b7dseT5h7eC9dj
	U4zK/O/5s1cXBcBosY0QJpwXuHhE57ts05n45wMyQa32QwcREBUjjB0mQR5flTAKiZB5m1zZX2GR2
	R2mYpl6Pn9tSThkjVQzeoGyPzg1WThD+KDUrAD4P8F+rDrmviCbfdVXAA/deWIyY1Y6CGqKaNOR0A
	zlb0RcxyDGw1zpmMQUkTVeo8Ekb7hrjmqzifuGmGRsL7QT+8xaCN4QlKDf7BSEBUZKJuK2CnteNB+
	A5zoSrVuQobc+i4xC8Xu4Kl4jaWR6eMP1n3cTo/+/S3MkCjaeNtJgwUEYPQqc0JPTqW/OzAVqY6Va
	opAMNAQA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGEXx-0000000Bdq7-1ymU;
	Tue, 04 Nov 2025 10:45:53 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGEXs-0000000Bdnw-3TdS
	for linux-nvme@lists.infradead.org;
	Tue, 04 Nov 2025 10:45:50 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A4AeCiG030835;
	Tue, 4 Nov 2025 10:45:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=qxaa2JVRO5iqXs34B
	oMCLiqKIKAlpIXCahAH4vhqm8A=; b=qteNokWc4WTA2ovRMDLFzLqxRDt6i3otO
	W9GuG+4Wdn97syoRVjdrFjAdC1PCKEzHXwbDPB9H6IzUuMBzRIjuQ1csMmSfV1xc
	3RV0fE6Vi1UCp+UsP3tREBGpoknzlAFD/tUORuvcLJGS2mS6nTFByNXeVJq4g24J
	8vFr2rqtRPSJCBo9YQkPT50d1ZLlHQ9o0BXfQ+ZzJspxiTintGIIz7yP3XcDQgtm
	tyGAvYOvsxTzDcPtIf8p5DZAKoWLDZDFRUBxiGCNdb2b+msIfmTaWjPbUoh+Qz+I
	kvFg2f0GbfziqdBJix9ovuGumIiqShTzRqJT4XTZIGQP7ZGmRwA+A==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a59xbuc7a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Nov 2025 10:45:43 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5A46cFUj009903;
	Tue, 4 Nov 2025 10:45:42 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4a5x1kahbk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Nov 2025 10:45:42 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5A4AjdYk7733592
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Nov 2025 10:45:39 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2A74A2004B;
	Tue,  4 Nov 2025 10:45:39 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 200802004E;
	Tue,  4 Nov 2025 10:45:37 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.in.ibm.com (unknown [9.109.198.245])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  4 Nov 2025 10:45:36 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: hare@suse.de, hch@lst.de, kbusch@kernel.org, sagi@grimberg.me,
        dwagner@suse.de, axboe@kernel.dk, gjoyce@ibm.com
Subject: [RFC PATCHv4 1/6] block: expose blk_stat_{enable,disable}_accounting() to drivers
Date: Tue,  4 Nov 2025 16:15:16 +0530
Message-ID: <20251104104533.138481-2-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251104104533.138481-1-nilay@linux.ibm.com>
References: <20251104104533.138481-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAxMDAyMSBTYWx0ZWRfX76M6QKTVpghh
 gnPM2qh4mvqRZ8kYVIrp3Lw4IkBXZbEfEwO2vWUKn3zGsAvThjz5mJldvgZiSRUXCQskgrX4rJq
 9gcT6N8l57FdJsJtiqcAhz1N2EjHCikmdJojb7zElpAQkC1Arou6YQd+rEMCRPvLKekm+bcNaEh
 oYk7iD5QUTpweAzs6qCmqkQ508hCMVPJ6TDdEe6DTolACwHCPloeqHvC56f+DfD1kCST7TsV1lu
 Z4GFlx4Duo0Oy5eweMuzY8e8B5j5Om5bfEgrX4ATlnNKtPBU9snNNZyDdxviHyP3H8DC/T1O3/1
 8yBNjM84sIi/HyIO8rwc3CjRqrmkdAxd6nmDfkov32tPeeB6Q81joxN9jL1LbNcKd+SXO1/Qd7W
 GU4ToYqLlHTeecufcgN/3OJrz0wlRA==
X-Proofpoint-GUID: Tvz6IglVKV7DCiCb1Mzfo0M9wP8Xu-fl
X-Authority-Analysis: v=2.4 cv=OdCVzxTY c=1 sm=1 tr=0 ts=6909d957 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=SifjupJSLTu-I8RqnBoA:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: Tvz6IglVKV7DCiCb1Mzfo0M9wP8Xu-fl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_06,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 spamscore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511010021
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251104_024548_868152_4A326F48 
X-CRM114-Status: GOOD (  13.95  )
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
index b25d12545f46..f647444643b8 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -735,6 +735,10 @@ int blk_rq_poll(struct request *rq, struct io_comp_batch *iob,
 
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



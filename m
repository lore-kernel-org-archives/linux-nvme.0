Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F31DC5AD4E
	for <linux-nvme@archiver.kernel.org>; Sun,  9 Aug 2026 10:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rXbluvkMmqQ0sY+i4QYG1XV68XNczpFUBKTsvAJatTQ=; b=ynnwpuLi9hEOOWRuyqQ511dx2t
	NQTRvwQmb85794VGrBVZD6mBY4pUOh7vc4KjPAOcz9PHgO6brhZaeOPfQJLlQtFw6t5yn0c1XJA/R
	hDTZCz317M1VBLqENRhB4KRF2Ui8ceoQeIPg191IKiHAXxESVt6Teh3GuZY+t8FucofIuEYsPdJYB
	Pxcw3Ubw2UWjaMfeXth0vCiP0wYF0TRSIxsrJGeFKXH5agHqmRMfrqdietFOgJJ5M+uOrFUOS504K
	Cucf2GE1mK52HAn7s8/A4Lm8LZf9g+d6DCyRoSA4RBYRg2eoO+WXtnICC8fcdWl1O4TQgLbLxJRsW
	eSV7BgOQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wt0Sk-0000000AAdy-47k8;
	Sun, 09 Aug 2026 10:09:02 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wt0Sj-0000000AAd3-07IC
	for linux-nvme@lists.infradead.org;
	Sun, 09 Aug 2026 10:09:02 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67992Bed2445086;
	Sun, 9 Aug 2026 10:08:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=rXbluvkMmqQ0sY+i4
	QYG1XV68XNczpFUBKTsvAJatTQ=; b=FwtEJcE656OEwwyjss+By3b+jBS9lhE2j
	4KrbUZe5d96ZnC+HZxDxbcR+bQB96Fr8seOm+3xQdiofc6jQreSzr1m43j8TElZ8
	95nI/1EPm2oIEsXIZjyl7sl9683XcZhQ5BL9fKYqoni9I3gpvWOVID4Pt1HnVu8G
	WW68xTwDju0frLBZYGst21pCwZ6+g+/3NV2dqweP+2QvFMWWSd7o5z2AR6JzJ/20
	tVOTnbHaKyF2HlHNHSQjkXrFHjlHn6u2dVI4lQQHmwATldCcdRRuclX756NjDlxQ
	NweFcT8/rF9UmFil4ACODGOLL8V82bYXgWZ6TUVColQ/GWWnLbJyg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvkckmk6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 09 Aug 2026 10:08:57 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6799uGmK003668;
	Sun, 9 Aug 2026 10:08:56 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxg9grxwk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 09 Aug 2026 10:08:56 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 679A8q6829229540
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 9 Aug 2026 10:08:52 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 549E520043;
	Sun,  9 Aug 2026 10:08:52 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 50C7E20040;
	Sun,  9 Aug 2026 10:08:49 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.43.73.213])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun,  9 Aug 2026 10:08:49 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: hare@suse.de, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        dwagner@suse.de, kanie@linux.alibaba.com, jmeneghi@redhat.com,
        randyj@purestorage.com, martin.petersen@oracle.com,
        john.g.garry@oracle.com, gjoyce@linux.ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH v7 2/9] block: record I/O request start time for passthru request
Date: Sun,  9 Aug 2026 15:37:57 +0530
Message-ID: <20260809100825.2014133-3-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260809100825.2014133-1-nilay@linux.ibm.com>
References: <20260809100825.2014133-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: IvmBCgIFaPzYoDptnTXRDF_M59emCIO5
X-Authority-Analysis: v=2.4 cv=J86aKgnS c=1 sm=1 tr=0 ts=6a7851b9 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=errQwHFKQF1M0CpB8HMA:9
X-Proofpoint-ORIG-GUID: KBQezQmebJIe4OVLwD-4bL2cxqdzPfKn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA5MDA4OCBTYWx0ZWRfX3HnnmtX8LFQW
 ypBods/7X7Hie97oYeO8vcukMMk4PZcFAhaiKR5cZBYBJiYidrRfQtA7pqK/fJ01cuwTngnqoPp
 SJ8G7SLNApTBX1Ue0rw+/Mg3dyaAc0iPHklpXJiefX/8BC9I+Kj766ecuH07HWuIGrV/ucpuQvK
 CSZZk5aTcPpHbZW8RO78z9lpWV1RFpCuem1xTqetJ/ioUrQYSS/5BEPheBeA05gXT/LgswaqYOE
 KpqhIQ7jj+m8fBU2FwwCZZrHYguaE7OSI73KEnKVVR92gS1wFanWKtPr+VDrmMSuX4n2qCRsfJR
 ztnHDnugjCsA/KDaa2gFAXTxhkFLvny013nJjC/Uo6htLtY7kL/j/wss39uTmwGY/PFMd4Yevwf
 6ZkILXUgkix/V3CscRLsmvSrYH0KA1c7xlmSjoO6Gjyxa3s/SMLvK3TdpogbnsOdriUfoHQG7l8
 GSOV35g0U3UguWlpxJQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA5MDA4OCBTYWx0ZWRfX3ri88l39cue2
 93icAOIetJ6PQRPz4IYRB2CMUskJJPzzZW32b/hxIRbIAVkX9XgOf+Wq39x/TVmG/ogT0QGwNTC
 bUvRahSL5EjNoUNxwAQL8BVycTt0QRY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-09_03,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 suspectscore=0 malwarescore=0 adultscore=0
 phishscore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608090088
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260809_030901_181455_C87169E5 
X-CRM114-Status: GOOD (  13.71  )
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

While starting an I/O request, blk_mq_start_request() records the
request start timestamp only for non-passthrough requests when
QUEUE_FLAG_STATS is enabled.

However, the latency based multipath policy uses request completion
latency to evaluate path performance, and I/O is issued as passthrough
requests. Since passthru requests never initialize rq->io_start_time_ns,
their latency cannot be computed.

Record io_start_time_ns for all requests whenever QUEUE_FLAG_STATS is
enabled.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 block/blk-mq.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 2c850330a32b..38922209a24f 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1340,12 +1340,14 @@ void blk_mq_start_request(struct request *rq)
 
 	trace_block_rq_issue(rq);
 
-	if (test_bit(QUEUE_FLAG_STATS, &q->queue_flags) &&
-	    !blk_rq_is_passthrough(rq)) {
+	if (test_bit(QUEUE_FLAG_STATS, &q->queue_flags)) {
 		rq->io_start_time_ns = blk_time_get_ns();
-		rq->stats_sectors = blk_rq_sectors(rq);
-		rq->rq_flags |= RQF_STATS;
-		rq_qos_issue(q, rq);
+
+		if (!blk_rq_is_passthrough(rq)) {
+			rq->stats_sectors = blk_rq_sectors(rq);
+			rq->rq_flags |= RQF_STATS;
+			rq_qos_issue(q, rq);
+		}
 	}
 
 	WARN_ON_ONCE(blk_mq_rq_state(rq) != MQ_RQ_IDLE);
-- 
2.53.0



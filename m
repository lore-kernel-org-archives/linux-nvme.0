Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F3AACCF9E0
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Oct 2025 09:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qxaa2JVRO5iqXs34BoMCLiqKIKAlpIXCahAH4vhqm8A=; b=IlrkON19lbq5YDclnVdknsjfuo
	QE99z+y7wcM4/2X4oQZ184nUfBWQZuus/Z6YaKtjJnGV2Yd+F3aRFDxs8ItTN50smQG/K1mOjoLB+
	ZdNszJrJCjtl+u2XBJPmEHXhaxblnImyH2TuY1PRgLwSSj9GLqut6m7BSJk3vMTZHqgPd1tglRp8A
	kqZ3+EpG/XlWyZS0HSwdgu7KH4yMI0iszg0Azg4vllCZgma4z2PZfD5xvSDeI1tSTJd8JmFRb/AdC
	HXZJhNTKThWQZzvjFMbgT4dlFUaiK/Ed6238lSY3obP07dkD749QWaQT+pJXduInzIEQA2VTztyer
	DPyk2fqw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDJYM-0000000DX0f-2K46;
	Mon, 27 Oct 2025 09:30:14 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDJYK-0000000DWzA-1sTx
	for linux-nvme@lists.infradead.org;
	Mon, 27 Oct 2025 09:30:13 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59QMtBCf019381;
	Mon, 27 Oct 2025 09:30:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=qxaa2JVRO5iqXs34B
	oMCLiqKIKAlpIXCahAH4vhqm8A=; b=V0w5W7ZmpEH7bzAcSV1new2kHgiYhUInP
	XuntCxRzavZUJKr18OqGUZ3Ee9TSGSyM8xjtlARjazml4gjtc0SMWcDxdJxBTBB0
	5GH5IlC/dNvwEwXLkMfKRyr3s2Z3JnIxkWjCIp5nRS1BzCP5gkYjh3KQCkpCaJ2a
	QyzbDghMzxjoLZ/UnlE5PRgOsA//JXsCHdPYtFLA596asE7694yvxdpxrgb4+xnW
	jXK4lSZmL2JfWcUwjbmaJMbtFRX7FrTpPmkos9lAYCiMacRJ25pWuTQsQ/0Srck+
	uzNbA2j1zkNvllXpRqp6Kq5aOlnRqjvmHM0qYHpYY6nIIhVJDe3EQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a0myrx27e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Oct 2025 09:30:02 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59R6vC6s023418;
	Mon, 27 Oct 2025 09:30:02 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4a198xcwmw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Oct 2025 09:30:02 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59R9U0B737093848
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Oct 2025 09:30:00 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 203252004B;
	Mon, 27 Oct 2025 09:30:00 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3061220040;
	Mon, 27 Oct 2025 09:29:56 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.61.186.32])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 27 Oct 2025 09:29:55 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: hare@suse.de, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        dwagner@suse.de, axboe@kernel.dk, gjoyce@ibm.com
Subject: [RFC PATCHv3 1/6] block: expose blk_stat_{enable,disable}_accounting() to drivers
Date: Mon, 27 Oct 2025 14:59:35 +0530
Message-ID: <20251027092949.961287-2-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251027092949.961287-1-nilay@linux.ibm.com>
References: <20251027092949.961287-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: U41VYaUAFd4kPE4IWdQucwZV59YrUCd6
X-Authority-Analysis: v=2.4 cv=ct2WUl4i c=1 sm=1 tr=0 ts=68ff3b9a cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=SifjupJSLTu-I8RqnBoA:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI1MDAxMCBTYWx0ZWRfXwG3rqGkWEfWL
 68fhNWXvlpK7mJPy8wVp0vvvL8oL56B5Lh4EqHqyvhbZnjru1GAxhi3GWK8WehcMXWl95SECzMe
 ZBEu1jBXFX/mxYDF6FynNdW1h50ufpRSnTn2PGi4iQi8i5KWSQDKVQrasDzNKGfWNnKraHLTMj7
 3f5hOni+l0ORrdxlrsd1DhxWacDcTZYviF5tlzKiSmz9PazmDMimASSSZB4YiX8s8wNsFll9B4u
 Dh3y7rs2cmf+Cj6Vzng3BLqylpwSQmLxsHfLqrhvIVWLzoV2wEutKcwjIEKRPrhpZPeT61Y2BYs
 sJjHMHNbrOXTaZ6MH5GdsxW1tMr+mQkDXVczqZRdcvXO8EmHvJnDjIcUjVAvDzb5FVf3KReEBvo
 +uxLSyFCZ2pHHdMYVA5MrK0e07TdbA==
X-Proofpoint-GUID: U41VYaUAFd4kPE4IWdQucwZV59YrUCd6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-27_04,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 spamscore=0 adultscore=0 priorityscore=1501 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510250010
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251027_023012_609798_967A7DCF 
X-CRM114-Status: GOOD (  13.23  )
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



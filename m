Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CD10C5AD5A
	for <linux-nvme@archiver.kernel.org>; Sat, 15 Aug 2026 17:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AwbqCBl3uGJec4OXh3Pp4jWrw2Kb3XKbGDyTx6eNiRI=; b=o3ee6jYXZ0yO5znYZNkj5ZjcYz
	b5Y/i4YCuz2ppvHTgQrh8ONs9skISAFmE02dkmi06aYPLfDBTawmgpjZG7RZbaEQu09gezOBtC5I2
	WEGsVjYItbDZWeoMK6LNoQkqQ71Eu1/ih8ocl8eJwJexbIa4WqUbe1P+frlTLpUab5Ehc9CmZiKPC
	qzmDSEGyVNFcsXt+g3t1Nb/fZz0V1dwWIskT+d+cJchoYGSIEHSxLwdOetVwdnIG6lsDJRPISVzpv
	2uAslhTHjpbn8J7d+bOgboBvWacyywBLsV8Qikib8DovzeOdSnhPwyiFxx2AcG0HsYTnPYtMSdHuU
	oPxCa7qg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wvIIN-00000003zba-1Scl;
	Sat, 15 Aug 2026 17:35:47 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wvIIJ-00000003zai-2BHk
	for linux-nvme@lists.infradead.org;
	Sat, 15 Aug 2026 17:35:44 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67FGVskS3397331;
	Sat, 15 Aug 2026 17:35:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=AwbqCBl3uGJec4OXh
	3Pp4jWrw2Kb3XKbGDyTx6eNiRI=; b=i2MI+c931+T0WJ7rvQQQZ3a2Qo5m3Oxk8
	5GsjbcnIcqlpTaogLbVbkJwpQRVK5aoEAuFMJZN/C/LZDd0G8HQnG2XYPUcFmdmf
	iuwoPbEhadOIcW3jvc/W0m2NZpbKT/IsFP1bujxlifjhew+jduxubAgg12PeovBO
	NTGTM+CGfbZDiDmF3Coca8NPbXVADjkwvpW0Uu4ILx79+fcs71Oe+5fC/q8m6T7F
	okNHS+120h5hZGUDI0jXtfToPMtScZn4V8susVWITRWb/0FlpuaoabzujLsHFkAB
	3swn4kOMh4n+UhRyaVdJjXsuLRNF9TeS4zEjKeSkhJBaumR1NQGXw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2ehdtaxe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 15 Aug 2026 17:35:38 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67FHQHTJ024850;
	Sat, 15 Aug 2026 17:35:38 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxesqm75p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 15 Aug 2026 17:35:37 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67FHZaGC14025154
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 15 Aug 2026 17:35:36 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 327D120043;
	Sat, 15 Aug 2026 17:35:36 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 144C920040;
	Sat, 15 Aug 2026 17:35:31 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.61.9.204])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 15 Aug 2026 17:35:30 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: hare@suse.de, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        dwagner@suse.de, kanie@linux.alibaba.com, jmeneghi@redhat.com,
        randyj@purestorage.com, martin.petersen@oracle.com,
        john.g.garry@oracle.com, gjoyce@linux.ibm.com
Subject: [PATCH v8 02/10] block: record I/O request start time for passthru request
Date: Sat, 15 Aug 2026 23:04:24 +0530
Message-ID: <20260815173502.1185929-3-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260815173502.1185929-1-nilay@linux.ibm.com>
References: <20260815173502.1185929-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE1MDEzMCBTYWx0ZWRfX8pUZnz8ZJA5x
 6jKrCrMXNRFqMZJIc0SgvV8dZqykdc3L355dUZNOw9t3m7rjuCkYaPZLZxtSqZulg1xL6vTXVP1
 paUFEUtwwpSzDJoAJlgHHhZe0dAcl3gpsSC/Wgt6030oUORW/7Tciq7hRvLbc2d9hGS3rRK4YBw
 idRdcgO/Vu/ix7cvm3DU56G9eZ9Kw4n3ZqWOiucg5yiwgo3sfBoT7IewEPpKoxqT5X+YBoFEcVt
 vI4huT3wxbHr21RbuhgtJPB/v8lDiU0doR4Rky6y035PsNIzLtR+ZytiYXgSoYa7nrE5Y4YV6Ne
 RaSEN3g+6w1qFGdqSkxKVF1aDkBskxw6XrBAE8piT3CyTKIrh80lH7NwN1egiL4RIh1C8LDaw05
 qOSdjQKkZxQkPw8LP9s/rtSdGaP7Fms9dOXo2OSm9QLR5o+4lXvJxikiGMuXDSHf6Iz5ylYs0tP
 7v70LxJ+nyX6Xl914zw==
X-Authority-Analysis: v=2.4 cv=DY8nbPtW c=1 sm=1 tr=0 ts=6a80a36b cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=SRrdq9N9AAAA:8 a=VnNF1IyMAAAA:8
 a=errQwHFKQF1M0CpB8HMA:9
X-Proofpoint-ORIG-GUID: Sk5yRtZz51aRCxYqS_dcAzXSbbgqSHsH
X-Proofpoint-GUID: cIn4CplRHnU_PLyUbKEXlxlKDnE-XvnW
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE1MDEzMCBTYWx0ZWRfX+W25ezBdcPsH
 sxFRoi36x4tyPwIegK8LQP+BIPqc6cXXE/BsN60rcUUFkI4d3n94s5XHxPdVInZv0fc18/awcKt
 o83BzO1ClPs8noVLPuhjj3eEw+ZBcvU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-15_05,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 spamscore=0 malwarescore=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608150130
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260815_103543_675807_876A1C2A 
X-CRM114-Status: GOOD (  13.04  )
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

Reviewed-by: Guixin Liu <kanie@linux.alibaba.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
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



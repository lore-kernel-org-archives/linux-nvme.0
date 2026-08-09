Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C117FC5AD4E
	for <linux-nvme@archiver.kernel.org>; Sun,  9 Aug 2026 10:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KQt0BwDgh+9+I6kK2e6cjK0vOqB5O0nUjTOmrmdSPJQ=; b=PTzeY0EtzqSUjl8ncHc1J8aKzM
	jvEjVX8dekcEnvaJFnH0omelW+0/vw1iMhEYsyVsyL5q5r13K1q/nzgbuUFwiePFp1Yk7peBSmKMD
	ipNRg29pdEkimdsn7Cr8qx52JuuJFkF9kyl+hQyCLYT9qLR03cwP0pC4nM2DH0rlWtJqUkMksNBwy
	de9j2hYSJf/sD2S24OxQ15zHfZXGA1YdpZ4zUeso9y88N5ghZEyD/JUScXB5Khqh94vL8lBgMyZAy
	zxRV2SMbTzkuR9WipJOPEY6Ex+4nEYJZpMJ0jKHegLgJTcGUBBoJyftjstgXk5VoRiLj3fLdlTHTb
	CjjFnMHA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wt0Sm-0000000AAeE-0XAn;
	Sun, 09 Aug 2026 10:09:04 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wt0Sj-0000000AAdN-3igL
	for linux-nvme@lists.infradead.org;
	Sun, 09 Aug 2026 10:09:03 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67991YWe2604939;
	Sun, 9 Aug 2026 10:08:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=KQt0BwDgh+9+I6kK2
	e6cjK0vOqB5O0nUjTOmrmdSPJQ=; b=hqKAoXK2JimPFh+CSkR//wWacYPS8oeaL
	pi7mkNOJcPJj0+dLAcAzEuL718i++wwOEHEIyA3rNYEgmpmbUdQQHyQROOww26Eo
	F2DQxkhe5V4r6A8XPSvDzj0xReOEmPOI7inB61vWoCn8veIy0WsS3aQ5OjmWZeL7
	s/8g6elOlmW2ZTSknpiCeWa6ZYy/tUG5aFcwNADkyZDpgVhVAkrNzuAocDnvUgu3
	YfuHTcTvGPOCa+Vz6geMYY/isZvvOfpb1oxYGvnhlhF71X4oRKxBUxBvUVFgHuro
	HNZjvQGVUTnbON0BUb/OKrmeAypnJUVecOyx9EUJF2YgxhQKnpGtQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvnvump9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 09 Aug 2026 10:08:53 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6799ubS6011583;
	Sun, 9 Aug 2026 10:08:52 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxh0g0v0q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 09 Aug 2026 10:08:52 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 679A8mKc45154628
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 9 Aug 2026 10:08:49 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DD38E20043;
	Sun,  9 Aug 2026 10:08:48 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E6C4C20040;
	Sun,  9 Aug 2026 10:08:45 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.43.73.213])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun,  9 Aug 2026 10:08:45 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: hare@suse.de, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        dwagner@suse.de, kanie@linux.alibaba.com, jmeneghi@redhat.com,
        randyj@purestorage.com, martin.petersen@oracle.com,
        john.g.garry@oracle.com, gjoyce@linux.ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH v7 1/9] block: expose blk_stat_{enable,disable}_accounting() to drivers
Date: Sun,  9 Aug 2026 15:37:56 +0530
Message-ID: <20260809100825.2014133-2-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260809100825.2014133-1-nilay@linux.ibm.com>
References: <20260809100825.2014133-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=RsP16imK c=1 sm=1 tr=0 ts=6a7851b5 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=SifjupJSLTu-I8RqnBoA:9
X-Proofpoint-GUID: DffRmsDUCYK6hhmMYOr5IKj01NWaWiLY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA5MDA4OCBTYWx0ZWRfXwbFYSuUHnR7l
 ggqdnOXQCGHvJjkQMc8927dYBdmMVNpBSgo6J0CdnLDPZ6+VuFFzab9GdWyjvT0zrXonaPOK4Yc
 HtA+jjeViusO1kNZfKCQy3HLIIpcKm0QwY6b+jPa9iNy4FHguCN0E1M0Aysk5K82dXzwZ2v2Xai
 RkcDzc5CSQnWdInMHLAk+VzMgCzoKx6ee5L7qU61feepw63yX+lvw1iddKh/SQrMFbIH+Xh6kP8
 BTC23qirb26TY2aVe63PascV6L/SffX5sRH0ghSfH81UVcquN1Hi5qfCJU4S5DhozKdvEEOwA0z
 s4bmljofNtv6Bk2dnwlrhCJTVSpl+QJWc6wo7DCdTDhOJqC0nOBAMaOzGg+Um+GSMlOF3Tm9kPk
 jsdKXIh4060MJMxbi5LQanpcFbX2fpzUPTI0q6BkNzHZtUQFTVaEe00TeyKitKTdOnT0Qw2Zq1l
 ZvfDcGe46ngoUEBwHvA==
X-Proofpoint-ORIG-GUID: Vi67jberbjqk06alhn3FHC6y-14_EvO0
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA5MDA4OCBTYWx0ZWRfXwJzWgTSknG/s
 5amFIOLXXz8ceQtCLuXB/O94cgmFSJNEl2Dup2oDsqrLNvypWTORj8xcryNILvZsA/6HlHSu2Dg
 ZkMyfVd/krsGVNWa2OsHCEpK1TKHMwg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-09_03,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 clxscore=1011 malwarescore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608090088
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260809_030902_042002_D525ABA9 
X-CRM114-Status: GOOD (  13.86  )
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
index af878597afb8..3956909764bf 100644
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



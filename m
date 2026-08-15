Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CB01C5CFDB
	for <linux-nvme@archiver.kernel.org>; Sat, 15 Aug 2026 17:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5YVvF4C4FlCa3VKGeH2tzeJerWk8S6jQOqWP69oluwM=; b=yfuJfUjzAd6HB2gohczYOVI3Te
	9YJBMlmMF836wjTX0+jtcst4aDaqhR5rRSUC8UofFB/PmNN9LNa2PBfqRmC+jqde8tn4S//LWd/9O
	MMJPS9L4x1aTl4pLffLHgtdvhMJHGiJGPiYsbOovK/Ns2N4g8mNgUGxdu5EOJmzAvfU1itHqggfY+
	942J7DlBy+EOoPoTUY82AHhQ0BX/QkV+i6uwSESgpYiKet0cEusK2wuBpVY/p5C4wFwvGDrgmmYt+
	6ZpYPP2J7KST2gFhffSNPzdfcjICVGBn6tca8+cVk5rV1lgPmWQUPj2CBWXeEyze9Bc+/rGsxYRHU
	t+dTMKVQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wvIIM-00000003zbE-12aW;
	Sat, 15 Aug 2026 17:35:46 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wvIII-00000003zaT-2MJO
	for linux-nvme@lists.infradead.org;
	Sat, 15 Aug 2026 17:35:44 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67FGVbWm349814;
	Sat, 15 Aug 2026 17:35:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=5YVvF4C4FlCa3VKGe
	H2tzeJerWk8S6jQOqWP69oluwM=; b=FQ08gUkhUkG8F1NPe8EUrbi6r6GlWCW5/
	QgTPk/ioLlDo8mlg9zH1zfLn6XuwjMDs/FxH+dE5km4a1WNqgCJqJCDEfoPoPdfF
	ILmaBicQ6SKeN33axK54usGj6ooUjS2TAbgeNpejh1Qz2kYr7e1nHFKsmsiP8ETH
	kMJudRO6Q2qE9fXBbqPh4nc8kjFIq0caCDNLFinXoJVZEQwdlNqxXdUjlgO7WOMe
	HYXQFF2eQ5u3C2RhZxfkgAQNsPmgyu9tXZiAiykVQoY+q/voM+3KUa8fmI5FqojA
	AUwz5GhGPFxr7YZ11pzrHunzar2IqzD+oFqgbLD50RmHUYyhCPaVQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2frst541-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 15 Aug 2026 17:35:31 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67FHQLNt005828;
	Sat, 15 Aug 2026 17:35:30 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g1rpvesmy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 15 Aug 2026 17:35:30 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67FHZSUO30278042
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 15 Aug 2026 17:35:28 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B594920040;
	Sat, 15 Aug 2026 17:35:28 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A1BFC2004E;
	Sat, 15 Aug 2026 17:35:23 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.61.9.204])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 15 Aug 2026 17:35:23 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: hare@suse.de, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        dwagner@suse.de, kanie@linux.alibaba.com, jmeneghi@redhat.com,
        randyj@purestorage.com, martin.petersen@oracle.com,
        john.g.garry@oracle.com, gjoyce@linux.ibm.com
Subject: [PATCH v8 01/10] block: expose blk_stat_{enable,disable}_accounting() to drivers
Date: Sat, 15 Aug 2026 23:04:23 +0530
Message-ID: <20260815173502.1185929-2-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260815173502.1185929-1-nilay@linux.ibm.com>
References: <20260815173502.1185929-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=OfaoyBTY c=1 sm=1 tr=0 ts=6a80a363 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=yPCof4ZbAAAA:8 a=SRrdq9N9AAAA:8 a=VnNF1IyMAAAA:8
 a=SifjupJSLTu-I8RqnBoA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE1MDEzMCBTYWx0ZWRfX/BeUIRrzFyl1
 N7GikGdaOrhMpZUBc0Tq1eQeAW8zx8L35oBYc1M2LAnsL6fkBKE/KLzyFOXL8g7YlK3gqFFsGWX
 fJRDIKT3DIZ1IDwzKUeFUwzJL8LmpdI=
X-Proofpoint-GUID: v9yW-RJOUblsU1N80hz5PTyMQ8C1JYL4
X-Proofpoint-ORIG-GUID: fcwLWinTqm9DEN3mK2RPTBP4__03JQyB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE1MDEzMCBTYWx0ZWRfXzovWuORb5bec
 kaA7IutCqatJUkUosvIP0y5kGk2Qhn0Uc8rKrLmoMYdDU4dthWZ/xmCPAx7yy3auRYAi2phUbhU
 HqFVmfCWxxvUSSv2mJLZXhPZJiqF+bAcCf/9ExC9qo2LXN887N1d0pjNknOTfEPwbz/o1ylKp/e
 EIOAtyojlJAzNYNUrA6nSI2jj+X267Tq64HPSsMUhVptpZQRJxB2SntdkUBO4vS7nqeeTQ0X5wS
 2vPvitEDax/EpzDD7xcYsJHU2hez9PofQv0bqBhNvn4hurkZ16mVVESV2DioJFrdad0kdnJmfxh
 GEbp3C+Gu7PxzNryo0rUaZAkwE6udnmmygDQA/V1X59ciJfuCuCV5wNrNgOActrcP+GZuzFi81T
 q0IuJmBCBmSn9Ytt3n7t4qNf1qRlE7wvOyIuEwOLpO+VihR3GEb0y2xrT07S+4bAJSK/KcVhba8
 ghGd7JobqOfC7+XmwkQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-15_05,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 phishscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608150130
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260815_103542_725395_2D693B63 
X-CRM114-Status: GOOD (  13.64  )
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

Reviewed-by: John Garry <john.g.garry@oracle.com>
Reviewed-by: Guixin Liu <kanie@linux.alibaba.com>
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



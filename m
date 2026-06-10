Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EEE4CD98C6
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Jun 2026 14:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5cmeyOhPncIrY2bgFeq55noE41lUpwCGVV22pKgaRnA=; b=HvjrCs05LNuSe8tJv7ueBCQdeR
	ZnvNsWAx61LabIWGma1s2+kRqmY38Ch4eVYunYbi+EzA3WoXqIwpLis0We23HskLdPuA5AK1QobPV
	UBtm1jSf8VgNsuPEgEO0F+t6t9nlbuLO/MEIQAeydoDoV45fYH1wI9Eslo5jB7KGs0iY6AIM53XWM
	rQ2x2M47JrXuwL3OjeyaaFnVlAP+Z2HwR745gnu+t17/UcET+a0nGk+F2wFBd0okClRLO31D6dUoJ
	k2mgdSm1yzec2ieFGd0KeU+/0+bUOj9z8Wa8jMLye3vmNBFkmFAvrLKFMsqj+2nphw8H+CMoYyecF
	fG86ko3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXJv0-00000007sZ7-2GoA;
	Wed, 10 Jun 2026 14:28:34 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXJuy-00000007sVj-0SLp
	for linux-nvme@lists.infradead.org;
	Wed, 10 Jun 2026 14:28:33 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65AAm2vS139779;
	Wed, 10 Jun 2026 14:28:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=5cmeyOhPncIrY2bgF
	eq55noE41lUpwCGVV22pKgaRnA=; b=jveslKWoJ+VjvYOhgkE1+jFapxZUodw0a
	vvqlpyjdhpfIteEB5k53GkgB01PlJoUYqumXxpISFq8D850UNaT0wgWYvt2sb6el
	YpW74PKSTa618U0FRtk2CaqEJY5cOS/nfrfRF23u8L9MqDXG/Nk0mjeUpBu9rZo/
	f2V/QwNjdfB+AMMY9NwkMSHq5aFczuX8GIt+MlOcyuKq+zLEkt17fDV0rF/fWvZH
	E2L5VO31T2NZ663KGnheOiuMnNHmSUD4dMvzl88sLyaeJx3K6fyRwrypZi+Y+wu6
	FOxUtwDTTzqED/j0wATNNcqXr/ycd5K3+F+qwM7iHeaF4EafnJ8lQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4emb241kp2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jun 2026 14:28:23 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65AE4aFf009694;
	Wed, 10 Jun 2026 14:28:22 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4emx8w74e5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jun 2026 14:28:22 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65AESI5e31064700
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jun 2026 14:28:18 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 88E1820040;
	Wed, 10 Jun 2026 14:28:18 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 12F5020049;
	Wed, 10 Jun 2026 14:28:16 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.43.34.89])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 10 Jun 2026 14:28:15 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com,
        bvanassche@acm.org, elver@google.com, gjoyce@linux.ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH 04/15] nvme: add Clang context annotations for nvme_ns_head::requeue_list
Date: Wed, 10 Jun 2026 19:57:24 +0530
Message-ID: <20260610142743.115898-5-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260610142743.115898-1-nilay@linux.ibm.com>
References: <20260610142743.115898-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=b4uCJNGx c=1 sm=1 tr=0 ts=6a297488 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=gCGRpEvQKZDurPVkv08A:9
X-Proofpoint-ORIG-GUID: 96nP4ecYW88mE8Kue_yc5iTwWYBr39dD
X-Proofpoint-GUID: uXfKPIILkPzY-x6ANAcMiMQUAlNIMGYV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDEzNSBTYWx0ZWRfX43gNke0UQIAo
 Twmnyj3FIVWttjaJTsQwvIC2nWrPT2VvFQtM5aoz0q2jR3g/x3kHBSys8ZtiEaF94YZmY+x1Soz
 KSitCFOEPAYITQOYkQLGXvboKW0m+7TQc2oLsYVSotW9QI9IttFeOwA7EwdhA9O/4QSI4gwM7kj
 tuqDBvHC/0AkkkfD+2UrUYtf1hkB2FIz7n8E6nwdFX32Vox0h01i+BKAqDRf1qa5/KQXqA6Ngg3
 RJ5lW8TcYbcVoPEuZDV+xmONhafvAsVmdzf4+DbLMxdaS8Y2BzPVW3BS0hHfJ4XRAqvCZ1HEJaT
 2Mztk4cQzxlGRFuQcbIjn2taPqFhmpk+qLXDz4Bm65jhwQAw+ZTw2rX2Ch8LCzt3nXgoakm2KTG
 PiMlq46B0oA1w5+bWiTvenTyEcSSuIb9eOcl6tntY4/KXFEYb/lLzkn+mS86ickapsiSaOKCh2r
 qr1QZUKmlbmQVTEVTjw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_03,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606100135
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260610_072832_166977_8E7390FA 
X-CRM114-Status: GOOD (  13.74  )
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

nvme_ns_head::requeue_list is protected by
nvme_ns_head::requeue_lock. Annotate requeue_list with
__guarded_by(&requeue_lock) so that Clang's context analysis can
validate accesses to the list.

Replace spin_lock_init(&head->requeue_lock) with
guard(spinlock_init)(&head->requeue_lock). The guard-based
initialization generates synthetic lock acquire and release events
visible to Clang's context analysis, allowing initialization of the
guarded requeue_list in nvme_mpath_alloc_disk() without triggering
context analysis warnings.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/host/multipath.c | 2 +-
 drivers/nvme/host/nvme.h      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index a275c03e7c59..985a8c693c6f 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -706,8 +706,8 @@ int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, struct nvme_ns_head *head)
 	struct queue_limits lim;
 
 	mutex_init(&head->lock);
+	guard(spinlock_init)(&head->requeue_lock);
 	bio_list_init(&head->requeue_list);
-	spin_lock_init(&head->requeue_lock);
 	INIT_WORK(&head->requeue_work, nvme_requeue_work);
 	INIT_WORK(&head->partition_scan_work, nvme_partition_scan_work);
 	INIT_DELAYED_WORK(&head->remove_work, nvme_remove_head_work);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 6bea0947eeb0..f60852944709 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -555,7 +555,7 @@ struct nvme_ns_head {
 	u16			nr_plids;
 	u16			*plids;
 #ifdef CONFIG_NVME_MULTIPATH
-	struct bio_list		requeue_list;
+	struct bio_list		requeue_list __guarded_by(&requeue_lock);
 	spinlock_t		requeue_lock;
 	struct work_struct	requeue_work;
 	struct work_struct	partition_scan_work;
-- 
2.53.0



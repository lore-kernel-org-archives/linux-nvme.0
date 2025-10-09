Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B412CCA470
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Oct 2025 10:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eHMPKD4zvd5Iw3+mu7XPBr0MW6kfwTY4qKChgQLUxFY=; b=HJ2w3pZdyPAwm99j7Ytbwq32ie
	kuYm21uw0E4Reql+snZewCtTAmFbuCGWhQtU+MSak+O7eP6Rqs+y9s5Sr5z+RfSy9xAAUDmAjELor
	N0SGGWFXemwXD8MCQBig7iqY0fARrSj+msgCJdvJamUUkzbY+zBUJFSv8NQ0VDJLFFP7HqyxKxo0P
	1I5NN/vY522swoeC2jLiVdmRmlZpDtdCXtNETjynzJRCDwb0FbzxZLNiySAsXQJIE4X6HC+JOzNEG
	uGmsBwJN7bSzMSqLOLdkp3Py2eAbs3+M7cr1R4jtl51qXHt8212T0CK5fz8fkgzTGZNRGqpQCnkS6
	jgyHCqUg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v6nXS-00000005jYx-2nYA;
	Thu, 09 Oct 2025 10:06:22 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v6nXQ-00000005jY3-0aFY
	for linux-nvme@lists.infradead.org;
	Thu, 09 Oct 2025 10:06:21 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5994G408031615;
	Thu, 9 Oct 2025 10:06:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=eHMPKD4zvd5Iw3+mu
	7XPBr0MW6kfwTY4qKChgQLUxFY=; b=mq00xeULSBACnbwEBN9sxVDBDfJ5N4M4K
	P7K6eFnvTHP18opyIS4uqSZ/60y4MwVMn2QfHdDQuMsZDIGyfHnog6lwFb0+AxVk
	/t2jxQfIayhukLKhG/MwTcXW3ZdF+TbX23vfiARzuzwIDB8TocPbIBxXMy9p+v0a
	8mz2bpj3jXtdd7EzN7UMmcWhZyZjn0oxXLZLjncLmpfVJyOjva/CZ2LQHzeTvID8
	dBvzyFUx1/KqOjOygGJo0vYMFoTHyokZUtC9RLKTEgYmuZfarTccQQ5dLTr24AsK
	ge776zU1AMhkvjaJB/FdlybPvZYQxK/jcGRfGTQnKK0sdKPRp3M+g==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49nv8243wf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Oct 2025 10:06:17 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5998FFaa021035;
	Thu, 9 Oct 2025 10:06:16 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 49nv8skx97-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Oct 2025 10:06:16 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 599A6Esq54788404
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 9 Oct 2025 10:06:14 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 80A2720088;
	Thu,  9 Oct 2025 10:06:14 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DC85320087;
	Thu,  9 Oct 2025 10:06:12 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.in.ibm.com (unknown [9.109.198.200])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  9 Oct 2025 10:06:12 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: hare@suse.de, kbusch@kernel.org, hch@lst.de, axboe@kernel.dk,
        dwagner@suse.de, gjoyce@ibm.com
Subject: [RFC PATCHv2 1/4] block: expose blk_stat_{enable,disable}_accounting() to drivers
Date: Thu,  9 Oct 2025 15:35:23 +0530
Message-ID: <20251009100608.1699550-2-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251009100608.1699550-1-nilay@linux.ibm.com>
References: <20251009100608.1699550-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=KrpAGGWN c=1 sm=1 tr=0 ts=68e78919 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=x6icFKpwvdMA:10 a=VnNF1IyMAAAA:8 a=SifjupJSLTu-I8RqnBoA:9
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: RgG_jJ_jWh5PZZicxETSXz7Nvl2w7qsM
X-Proofpoint-ORIG-GUID: RgG_jJ_jWh5PZZicxETSXz7Nvl2w7qsM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfX6LiVsM/uTVGS
 4i1HHZEjRqWAU1/5QsFjafGJCG0tuLp0RLpL2n/ApprKEGIfWJoaTsHF2Bu/8hV/tMOgLsPwvZv
 yQwsQUQ2/3qMx9IoRSB9voP4RQ/SdbufyTi5mDiAFFfQDDOxJ4Rax78LBfUjYbVl27mXGsjP7Yu
 mcplvtD40j7u/QpvB75IRjs60uInZmf4LYoKriNxPLzgnFLumdKHlac6zsUPSrfG/oS7N3JqyKN
 XO6RjyyiwXYM7Rvd6hWuQLNZSZnRb2sOgpOsTesh+Qr0JYkbabHd9FCwM8KkflXLZ6kQjQKrhkQ
 g9TsWQ2iT5AWku+jDOVw3XxNVHSgg2URDvtweGF0sCALHxazcDJfS1M5h6z4FCI0pEHV2BcIiW5
 h+vbaC+JrXAYYsxrfX8OlFTJtYuFaA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-09_03,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 bulkscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251009_030620_180930_F12CB930 
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



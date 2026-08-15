Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ADA6C5AD5A
	for <linux-nvme@archiver.kernel.org>; Sat, 15 Aug 2026 17:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UWqvxkjEi6d8K/1l/pCNCxK7ep7a+ggGE3sOZ9T3Eb4=; b=ivVcxrk1gZeANkRT2MOwKlHtyj
	lSNXOP4DVA0FwWp6szZrfuI4TJDuxXj+USJqmQFyiSQHp8iieATrWP04s2xiv4pVGOckLxL7dlibr
	GCbCSRAYwT6pPCdg2/appoNYZc9SEcoKciQ3YslLbvbYvpfDS3+mn4zwKdC+irZ4M6VppuIt0sWDU
	0ptRwzD+MHSq2quavvbcJuJaL4xLriQ1dZajc+THxaZFml3X6/vnyMCvXH3f1U54/OHN6jLpgPmIk
	zIDAuLNcLQT7Pnu11jxZUDbioek6Ou+PZNLLWu9gAb7y25Ca5hK0/ShC6rN23bkPBqNkwy6Wlr20S
	9gPH7tdw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wvIIe-00000003zgx-2yJZ;
	Sat, 15 Aug 2026 17:36:04 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wvIIb-00000003zfh-3CBO
	for linux-nvme@lists.infradead.org;
	Sat, 15 Aug 2026 17:36:02 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67FGVW9m265017;
	Sat, 15 Aug 2026 17:35:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=UWqvxkjEi6d8K/1l/
	pCNCxK7ep7a+ggGE3sOZ9T3Eb4=; b=bUqqXsMA68DPjFJZltXL7EnlG4gyYNPfv
	j2Bziia9vx1r+rZk8iVoI5CgjG8Mm/SN5p9cqKa8KXsItbaxyjHqQzvPIcW0/6E0
	SdNiSVOykufL8DWVU+UPJt3Uv6mjq37Hmddh9g972u48+R3Q1pRupZ0R1uTc59A4
	BAXYgXAuGJHbHjr3gE3SAEUUKZyifOOccgonRtV3v8QD342RoucdH9civmcbQWYf
	yVzObOqSo186axzaoAlRH52zA3qp4hwyYsxEd5XAp2c6AICuNEhUWrPSpvi5aGIL
	QVG6gmZy/hOAdZ7t1l1E5MdpLrxMxLA26yLPWQGfOK5YZC4PlPnRQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2fm3a8a6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 15 Aug 2026 17:35:46 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67FHQKSk009527;
	Sat, 15 Aug 2026 17:35:45 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxf5wm4h4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 15 Aug 2026 17:35:44 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67FHZgwS33095958
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 15 Aug 2026 17:35:42 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C058C20043;
	Sat, 15 Aug 2026 17:35:42 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E06F320040;
	Sat, 15 Aug 2026 17:35:36 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.61.9.204])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 15 Aug 2026 17:35:36 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: hare@suse.de, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        dwagner@suse.de, kanie@linux.alibaba.com, jmeneghi@redhat.com,
        randyj@purestorage.com, martin.petersen@oracle.com,
        john.g.garry@oracle.com, gjoyce@linux.ibm.com
Subject: [PATCH v8 03/10] block: support nesting for blk-mq flag QUEUE_FLAG_SAME_FORCE
Date: Sat, 15 Aug 2026 23:04:25 +0530
Message-ID: <20260815173502.1185929-4-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260815173502.1185929-1-nilay@linux.ibm.com>
References: <20260815173502.1185929-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: m0TfLiUSkgikoHPHKN4pVbCyJO2vR9Oi
X-Proofpoint-ORIG-GUID: zKjM91UepFKquZqyh7_H3pn1GPy-cs7Y
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE1MDEzMCBTYWx0ZWRfX19PNFX7o9GPn
 1GR+VRPhATcLxx67VYh5CTFiTgmQGbe3kDskKO4ScKOgqQaU2V5BYZcBbKxh7uoTQamrUHQFRHG
 uEPhLdqR7k/2HDYwfQVi5eqiy5mIMcA=
X-Authority-Analysis: v=2.4 cv=WtQb99fv c=1 sm=1 tr=0 ts=6a80a372 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=mpaa-ttXAAAA:8 a=pGLkceISAAAA:8 a=JfrnYn6hAAAA:8
 a=VnNF1IyMAAAA:8 a=bo3KGjI-o93pdA2gvwcA:9 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE1MDEzMCBTYWx0ZWRfXxsDfmmRmoNQ9
 UY4UgYvmVwBMOuU6/CwNifrWxPdgIwtHf6Bu7atuEbRATFUHogv0wg5wIVnkduCOIcPUtp5wtEu
 QbFiRjyWNEhP2ah5sUjG4THOIz/O3k5Z8qkpo9XhJOoF9U9zBMVSJDN+SO4IEjcnuhLpEcpWIJP
 S2gT6LxzO04IYxik23Wkhh+FQDaPGgtZsQirfV/VyDY/gliuzSbKPFohy+Ufp7woCg4fYamxdfi
 iqXWNeXl8rn8UNuEykL1fAuginZW8QunQvUvA7yaBW7QQMozA+wWkCd/Ospfu5ARZbKUtPr1Jvs
 THiBCBJYAwUhFmp9g1xdC0VF3bkVVSMEwRbP/8Q7mAgumQTEVBAdub/dqGl6UfkrjUNpwdLPw8q
 GonB2JUIneiu5ZNCQk3MAC9af5Eyfl/blk6373lSmb4b+UV7DF37doWdcgxGPZ8yMqYQE/HkywM
 Ys9C/VePlfEWcD0i+uA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-15_05,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608150130
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260815_103601_816518_93A2E2FB 
X-CRM114-Status: GOOD (  20.80  )
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

QUEUE_FLAG_SAME_FORCE is currently used when setting rq_affinity
through sysfs as well as by UFS mediatek driver while configuring scsi
parameters. A subsequent patch adding a latency-based I/O policy
for NVMe multipath will also use this flag.

With multiple users able to set and clear QUEUE_FLAG_SAME_FORCE, the
flag needs to support nesting so that one user clearing the flag does
not inadvertently disable it for another user.

Add a nesting counter, q->same_force_depth, for QUEUE_FLAG_SAME_FORCE.
The flag is set when the first user acquires it and the nesting counter
is incremented for each subsequent user. Similarly, each user releases
its reference by decrementing the counter. The flag is cleared only 
when the last user releases it and the counter reaches zero.

Preserve the existing sysfs rq_affinity semantics with a new
q->same_force_sysfs flag. When userspace enables QUEUE_FLAG_SAME_FORCE
by writing 2 to rq_affinity, mark q->same_force_sysfs as set and
increment q->same_force_depth by one. Subsequent writes of 2 to
rq_affinity while q->same_force_sysfs is already set are ignored, so
repeated writes of 2 from userspace do not increase q->same_force_depth.
Similarly, writing 0 or 1 decrements the q->same_force_depth and if
nesting counter reached to 0 then clears the QUEUE_FLAG_SAME_FORCE.
This ensures that multiple writes of 2 to rq_affinity do not require
multiple writes of 0 or 1.

This change ensures that sysfs interface retains its existing set/clear
semantics while also allowing other kernel users to hold or release
QUEUE_FLAG_SAME_FORCE.

Added two new APIs blk_mq_same_force_set() and blk_mq_same_force_clear()
to set and clear QUEUE_FLAG_SAME_FORCE respectively. Also, updated
existing call paths using these new APIs which toggles
QUEUE_FLAG_SAME_FORCE.

Cc: Peter Wang <peter.wang@mediatek.com>
Cc: Chaotian Jing <chaotian.jing@mediatek.com>
Cc: Stanley Jhu <chu.stanley@gmail.com> 
Cc: linux-mediatek@lists.infradead.org
Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 block/blk-mq.c                  | 41 +++++++++++++++++++++++++++++++++
 block/blk-sysfs.c               |  6 ++---
 drivers/ufs/host/ufs-mediatek.c |  2 +-
 include/linux/blk-mq.h          |  2 ++
 include/linux/blkdev.h          |  3 +++
 5 files changed, 50 insertions(+), 4 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 38922209a24f..17e8befb02bc 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -360,6 +360,47 @@ void blk_mq_unquiesce_tagset(struct blk_mq_tag_set *set)
 }
 EXPORT_SYMBOL_GPL(blk_mq_unquiesce_tagset);
 
+void blk_mq_same_force_set(struct request_queue *q, bool from_sysfs)
+{
+	unsigned long flags = 0;
+
+	spin_lock_irqsave(&q->queue_lock, flags);
+
+	if (from_sysfs) {
+		if (q->same_force_sysfs)
+			goto unlock;
+		q->same_force_sysfs = true;
+	}
+
+	if (!q->same_force_depth++)
+		blk_queue_flag_set(QUEUE_FLAG_SAME_FORCE, q);
+unlock:
+	spin_unlock_irqrestore(&q->queue_lock, flags);
+}
+EXPORT_SYMBOL_GPL(blk_mq_same_force_set);
+
+void blk_mq_same_force_clear(struct request_queue *q, bool from_sysfs)
+{
+	unsigned long flags = 0;
+
+	spin_lock_irqsave(&q->queue_lock, flags);
+
+	if (from_sysfs) {
+		if (!q->same_force_sysfs)
+			goto unlock;
+		q->same_force_sysfs = false;
+	}
+
+	if (WARN_ON_ONCE(q->same_force_depth <= 0))
+		goto unlock;
+
+	if (!--q->same_force_depth)
+		blk_queue_flag_clear(QUEUE_FLAG_SAME_FORCE, q);
+unlock:
+	spin_unlock_irqrestore(&q->queue_lock, flags);
+}
+EXPORT_SYMBOL_GPL(blk_mq_same_force_clear);
+
 void blk_mq_wake_waiters(struct request_queue *q)
 {
 	struct blk_mq_hw_ctx *hctx;
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 520972676ab4..a3ec8ffab1ee 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -497,13 +497,13 @@ queue_rq_affinity_store(struct gendisk *disk, const char *page, size_t count)
 	 */
 	if (val == 2) {
 		blk_queue_flag_set(QUEUE_FLAG_SAME_COMP, q);
-		blk_queue_flag_set(QUEUE_FLAG_SAME_FORCE, q);
+		blk_mq_same_force_set(q, true);
 	} else if (val == 1) {
 		blk_queue_flag_set(QUEUE_FLAG_SAME_COMP, q);
-		blk_queue_flag_clear(QUEUE_FLAG_SAME_FORCE, q);
+		blk_mq_same_force_clear(q, true);
 	} else if (val == 0) {
 		blk_queue_flag_clear(QUEUE_FLAG_SAME_COMP, q);
-		blk_queue_flag_clear(QUEUE_FLAG_SAME_FORCE, q);
+		blk_mq_same_force_clear(q, true);
 	}
 #endif
 	return ret;
diff --git a/drivers/ufs/host/ufs-mediatek.c b/drivers/ufs/host/ufs-mediatek.c
index 3991a51263a6..8d80ac6fb5d2 100644
--- a/drivers/ufs/host/ufs-mediatek.c
+++ b/drivers/ufs/host/ufs-mediatek.c
@@ -2311,7 +2311,7 @@ static void ufs_mtk_config_scsi_dev(struct scsi_device *sdev)
 
 	dev_dbg(hba->dev, "lu %llu scsi device configured", sdev->lun);
 	if (sdev->lun == 2)
-		blk_queue_flag_set(QUEUE_FLAG_SAME_FORCE, sdev->request_queue);
+		blk_mq_same_force_set(sdev->request_queue, false);
 }
 
 /*
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 3956909764bf..30be3eb5a37b 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -943,6 +943,8 @@ void blk_mq_wait_quiesce_done(struct blk_mq_tag_set *set);
 void blk_mq_quiesce_tagset(struct blk_mq_tag_set *set);
 void blk_mq_unquiesce_tagset(struct blk_mq_tag_set *set);
 void blk_mq_unquiesce_queue(struct request_queue *q);
+void blk_mq_same_force_set(struct request_queue *q, bool from_sysfs);
+void blk_mq_same_force_clear(struct request_queue *q, bool from_sysfs);
 void blk_mq_delay_run_hw_queue(struct blk_mq_hw_ctx *hctx, unsigned long msecs);
 void blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async);
 void blk_mq_run_hw_queues(struct request_queue *q, bool async);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 9213a5716f95..32d0fb47d73c 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -529,6 +529,9 @@ struct request_queue {
 
 	int			quiesce_depth;
 
+	int			same_force_depth;
+	bool			same_force_sysfs;
+
 	struct gendisk		*disk;
 
 	/*
-- 
2.53.0



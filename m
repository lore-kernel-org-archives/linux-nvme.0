Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D4C8CED271
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Oct 2024 06:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=X9e41XAu4gVnf3ePdeAJL9cFfEO/ICG2xVW+k0vG8Q0=; b=Xj6lqUMS7BT4JZq7Re2lnPylLJ
	AF68c1uyANLiUX6WA6UFQdzhjNJcN+GeGSVmTjcfg8uykjahECkg6B7dSdhZOJGHPmMYYYPEn+7GU
	JyUUVe+KTHE7YWD1AsnAwnw9beSYwRWPFlmtMpTNdaLTkLfw8yxfYl/9vi6UIVkz4FTX7yhlCHELf
	0tiLyHm1pYjz+U29pUFRP+i/psCIYwIPzr9W3rEiWxvfzWc2YITsbIBlqNqRAGJNzw0qjOMyP2Ypx
	ROe7UYHyVDU0mM2E981YrmXAlbEKO0AfQ9R0ARlTBi3yuWI7m6JaKE/DFghGPqpoksIgjN84wyTlv
	XA1HatzQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sy3d7-00000004dfy-16L3;
	Tue, 08 Oct 2024 06:23:33 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sy3c7-00000004dS5-0bgz
	for linux-nvme@lists.infradead.org;
	Tue, 08 Oct 2024 06:22:32 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4986J2vA020153;
	Tue, 8 Oct 2024 06:22:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=X9e41XAu4gVnf
	3ePdeAJL9cFfEO/ICG2xVW+k0vG8Q0=; b=DjImUN+sW2JlIOTzEKVHywuwI/5Y+
	azhLIJ8Ix6e/x5hXjbzo/9iB6YmBmz4jLhqZAURb+fq7L7QYB45G8lLUXELs9Kj+
	lNv9jt9nN36qyRwGuUK1UZLqnqjBQDq4NKqO0Ov9KwcZszZCoS5KQL+Vl5a4BCFs
	kLcTn/MgtyggZWn9Unu0L/zj1HAGT4/fMJl0joz8Ubg7egih71AC7HRhV+TJQQsf
	yauAZ6VAno1vAG2iv4ZXy8YuqHuUlOUD3aFLK43LCQ8U1ag9Qyx3zPWw6gvzXCi+
	f+++I5P03tqjkC3HCaducghTB7T2WOS5chjmTGDKfEzHxjtRTRZZA8oqw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 424ybug0g8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Oct 2024 06:22:24 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4985RIdN011535;
	Tue, 8 Oct 2024 06:22:23 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 423g5xjp08-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Oct 2024 06:22:23 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4986MJgi48300526
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 8 Oct 2024 06:22:19 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A344D20043;
	Tue,  8 Oct 2024 06:22:19 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5C4FC20040;
	Tue,  8 Oct 2024 06:22:17 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.171.23.125])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  8 Oct 2024 06:22:17 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, axboe@fb.com,
        chaitanyak@nvidia.com, dlemoal@kernel.org, gjoyce@linux.ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH v3 2/3] nvme: make keep-alive synchronous operation
Date: Tue,  8 Oct 2024 11:51:51 +0530
Message-ID: <20241008062210.1094083-3-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241008062210.1094083-1-nilay@linux.ibm.com>
References: <20241008062210.1094083-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 4YI-hLXZU9DfFHIEpOM_F88ogO0sHAMP
X-Proofpoint-GUID: 4YI-hLXZU9DfFHIEpOM_F88ogO0sHAMP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-08_04,2024-10-08_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 malwarescore=0 mlxscore=0 spamscore=0 impostorscore=0
 clxscore=1015 suspectscore=0 mlxlogscore=999 priorityscore=1501
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410080039
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241007_232231_419218_6D7EAB50 
X-CRM114-Status: GOOD (  14.66  )
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

The nvme keep-alive operation, which executes at a periodic interval,
could potentially sneak in while shutting down a fabric controller.
This may lead to a race between the fabric controller admin queue
destroy code path (while shutting down controller) and the blk-mq
hw/hctx queuing from the keep-alive thread.

This fix helps avoid race by implementing keep-alive as a synchronous
operation so that admin queue-usage ref counter is decremented only
after keep-alive command finish execution and returns its status. This
would ensure that we don't inadvertently destroy the fabric admin queue
until we finish processing of nvme keep-alive request and its status and
hence it's safe to delete the queue.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/host/core.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 02897f0564a3..736adbf65ef5 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1292,10 +1292,10 @@ static void nvme_queue_keep_alive_work(struct nvme_ctrl *ctrl)
 	queue_delayed_work(nvme_wq, &ctrl->ka_work, delay);
 }
 
-static enum rq_end_io_ret nvme_keep_alive_end_io(struct request *rq,
-						 blk_status_t status)
+static void nvme_keep_alive_finish(struct request *rq,
+				blk_status_t status,
+				struct nvme_ctrl *ctrl)
 {
-	struct nvme_ctrl *ctrl = rq->end_io_data;
 	unsigned long flags;
 	bool startka = false;
 	unsigned long rtt = jiffies - (rq->deadline - rq->timeout);
@@ -1313,13 +1313,11 @@ static enum rq_end_io_ret nvme_keep_alive_end_io(struct request *rq,
 		delay = 0;
 	}
 
-	blk_mq_free_request(rq);
-
 	if (status) {
 		dev_err(ctrl->device,
 			"failed nvme_keep_alive_end_io error=%d\n",
 				status);
-		return RQ_END_IO_NONE;
+		return;
 	}
 
 	ctrl->ka_last_check_time = jiffies;
@@ -1331,7 +1329,6 @@ static enum rq_end_io_ret nvme_keep_alive_end_io(struct request *rq,
 	spin_unlock_irqrestore(&ctrl->lock, flags);
 	if (startka)
 		queue_delayed_work(nvme_wq, &ctrl->ka_work, delay);
-	return RQ_END_IO_NONE;
 }
 
 static void nvme_keep_alive_work(struct work_struct *work)
@@ -1340,6 +1337,7 @@ static void nvme_keep_alive_work(struct work_struct *work)
 			struct nvme_ctrl, ka_work);
 	bool comp_seen = ctrl->comp_seen;
 	struct request *rq;
+	blk_status_t status;
 
 	ctrl->ka_last_check_time = jiffies;
 
@@ -1362,9 +1360,9 @@ static void nvme_keep_alive_work(struct work_struct *work)
 	nvme_init_request(rq, &ctrl->ka_cmd);
 
 	rq->timeout = ctrl->kato * HZ;
-	rq->end_io = nvme_keep_alive_end_io;
-	rq->end_io_data = ctrl;
-	blk_execute_rq_nowait(rq, false);
+	status = blk_execute_rq(rq, false);
+	nvme_keep_alive_finish(rq, status, ctrl);
+	blk_mq_free_request(rq);
 }
 
 static void nvme_start_keep_alive(struct nvme_ctrl *ctrl)
-- 
2.45.2



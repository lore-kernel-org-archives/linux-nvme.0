Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4F7FD13572
	for <linux-nvme@archiver.kernel.org>; Sun, 27 Oct 2024 17:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qGJ5xYx/qkIOGOE8HDvQM/JyEcDZpTlhYy763412R/E=; b=PrnYJfQs4y1AmxVLp6oWvDVQwA
	11wLykStKtEs3v0xREmfN2E1J3RYcf2NS0CUVGY6Yf/sWDVUVD0o5hjGsacbmCYV204a2h2Ywcj2+
	pcdH1vFNQyIj7posPNAOtMjZSTG3qGxtJEsYuKlk5m5u4Ra9EGmZErpk3QAqhwvXpwdVbAh7oFrvL
	ZDnbaK1AQx2wANzlzeunHcnltxyofWeIqulfWRWouqnMOOUxgPXRjvZsfq1/5aEPTEzl+cOUpSU7d
	FwuOzK62yrTEKo7nVkTB9yqFJx7tXl5dBG7O4nqddgW0d31Py04XpcZPk2n7ENcwyKfj6gTwXGqDD
	xMBwxTGQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t56fF-00000008Zqr-3zo2;
	Sun, 27 Oct 2024 17:02:53 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t56fC-00000008ZpV-1rkE
	for linux-nvme@lists.infradead.org;
	Sun, 27 Oct 2024 17:02:52 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49RACa9L016021;
	Sun, 27 Oct 2024 17:02:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=qGJ5xYx/qkIOGOE8H
	DvQM/JyEcDZpTlhYy763412R/E=; b=mJym1mR54LeGW7EE6GR4CvsMZRk78+ICl
	T8njZXH+9WuQMyHx+1d82IYuaJVK6g29Vl/oQfD2O1FaS6qK6+iRpaXoMYDVsOVA
	uczZoX7ov/xKKunIn/KT3u59Hm69oFOKQxHVlpD3Mc1mb6HwUX6iSUas2sWiFPae
	iXMPYIuIlMnE6n2oOfaV6fUzvmkpLCq6dQT/3gyGPhci7dYempQIzni1S5yauq6t
	jRs1+8QCMn54VzIyzAn+wlcir3kfRFOglG5EGT78TsnkTBjzzFIQmatQ8mwbEiUY
	11cfbopE8ome5yD2ZSsb19mdNcegSTUgDAN13dYRB0Pwbe0DzWjJw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42grwg5ad5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 27 Oct 2024 17:02:31 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49RDc1Ln024726;
	Sun, 27 Oct 2024 17:02:30 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 42hcyj2bmv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 27 Oct 2024 17:02:30 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49RH2RpV52429114
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 27 Oct 2024 17:02:27 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 430F620043;
	Sun, 27 Oct 2024 17:02:27 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E094A20040;
	Sun, 27 Oct 2024 17:02:24 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.179.2.58])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 27 Oct 2024 17:02:24 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, axboe@fb.com,
        chaitanyak@nvidia.com, dlemoal@kernel.org, gjoyce@linux.ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH 1/3] Revert "nvme: make keep-alive synchronous operation"
Date: Sun, 27 Oct 2024 22:32:04 +0530
Message-ID: <20241027170209.440776-2-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241027170209.440776-1-nilay@linux.ibm.com>
References: <20241027170209.440776-1-nilay@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: qwpsYyiYPavhQHO2VMiUgloPa84O3ztv
X-Proofpoint-ORIG-GUID: qwpsYyiYPavhQHO2VMiUgloPa84O3ztv
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 phishscore=0 suspectscore=0
 priorityscore=1501 mlxlogscore=999 mlxscore=0 spamscore=0 impostorscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410270144
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241027_100250_510512_945E16F5 
X-CRM114-Status: GOOD (  16.38  )
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

This reverts commit d06923670b5a5f609603d4a9fee4dec02d38de9c.
This reverts commit 599d9f3a10eec69ef28a90161763e4bd7c9c02bf.

It was realized that the fix implemented to avoid the race
condition between keep alive task and the fabric shutdown code
path in the commit d06923670b5ia ("nvme: make keep-alive
synchronous operation") is not optimal.

We also found that the above race condition is regression caused
due to the changes implemented in commit a54a93d0e359 ("nvme: move
stopping keep-alive into nvme_uninit_ctrl()"). So we decided to
first revert the commit d06923670b5a ("nvme: make keep-alive
synchronous operation") and commit 599d9f3a10ee ("nvme: use helper
nvme_ctrl_state in nvme_keep_alive_finish function") and then fix
the regression.

Link: https://lore.kernel.org/all/196f4013-3bbf-43ff-98b4-9cb2a96c20c2@grimberg.me/
Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/host/core.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 84cb859a911d..5016f69e9a15 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1292,12 +1292,14 @@ static void nvme_queue_keep_alive_work(struct nvme_ctrl *ctrl)
 	queue_delayed_work(nvme_wq, &ctrl->ka_work, delay);
 }
 
-static void nvme_keep_alive_finish(struct request *rq,
-		blk_status_t status, struct nvme_ctrl *ctrl)
+static enum rq_end_io_ret nvme_keep_alive_end_io(struct request *rq,
+						 blk_status_t status)
 {
+	struct nvme_ctrl *ctrl = rq->end_io_data;
+	unsigned long flags;
+	bool startka = false;
 	unsigned long rtt = jiffies - (rq->deadline - rq->timeout);
 	unsigned long delay = nvme_keep_alive_work_period(ctrl);
-	enum nvme_ctrl_state state = nvme_ctrl_state(ctrl);
 
 	/*
 	 * Subtract off the keepalive RTT so nvme_keep_alive_work runs
@@ -1311,17 +1313,25 @@ static void nvme_keep_alive_finish(struct request *rq,
 		delay = 0;
 	}
 
+	blk_mq_free_request(rq);
+
 	if (status) {
 		dev_err(ctrl->device,
 			"failed nvme_keep_alive_end_io error=%d\n",
 				status);
-		return;
+		return RQ_END_IO_NONE;
 	}
 
 	ctrl->ka_last_check_time = jiffies;
 	ctrl->comp_seen = false;
-	if (state == NVME_CTRL_LIVE || state == NVME_CTRL_CONNECTING)
+	spin_lock_irqsave(&ctrl->lock, flags);
+	if (ctrl->state == NVME_CTRL_LIVE ||
+	    ctrl->state == NVME_CTRL_CONNECTING)
+		startka = true;
+	spin_unlock_irqrestore(&ctrl->lock, flags);
+	if (startka)
 		queue_delayed_work(nvme_wq, &ctrl->ka_work, delay);
+	return RQ_END_IO_NONE;
 }
 
 static void nvme_keep_alive_work(struct work_struct *work)
@@ -1330,7 +1340,6 @@ static void nvme_keep_alive_work(struct work_struct *work)
 			struct nvme_ctrl, ka_work);
 	bool comp_seen = ctrl->comp_seen;
 	struct request *rq;
-	blk_status_t status;
 
 	ctrl->ka_last_check_time = jiffies;
 
@@ -1353,9 +1362,9 @@ static void nvme_keep_alive_work(struct work_struct *work)
 	nvme_init_request(rq, &ctrl->ka_cmd);
 
 	rq->timeout = ctrl->kato * HZ;
-	status = blk_execute_rq(rq, false);
-	nvme_keep_alive_finish(rq, status, ctrl);
-	blk_mq_free_request(rq);
+	rq->end_io = nvme_keep_alive_end_io;
+	rq->end_io_data = ctrl;
+	blk_execute_rq_nowait(rq, false);
 }
 
 static void nvme_start_keep_alive(struct nvme_ctrl *ctrl)
-- 
2.45.2



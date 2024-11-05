Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEE74D1CA37
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Nov 2024 06:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PcOSH0DDaj4/l5H10+PDkzvMTLLwsf46X0woj7f1Rdo=; b=GZVPti8IZnDnfCX4wh3NnIf3Fq
	3YK7X9GsqNkyr32Cc723YF9ISeL9YoRANbfPpgN83kMmx8wh2rhPoOg482sxcPfaJHLrSBiLFwpM+
	VY3pNwYMrVZ9IQ73DveFZFx/K8jL/gVBsGmEAm1pGhk2H4Dg8lldErQcoZVV+r1myNQ84ThXxJXFM
	vLkGPoSYLIh8ewSs1COuKU7YQ4M+EmHv8tlIkHyiR+FQpQrsL9X+SJkTRRv0xB+DFINvOejky6LfX
	7EZ+sebfT6qLHFATR34VvRvZ4Re6sdrwcvEApEBIy9qvDPeJXpaZ/JKX9wgBfbE06KmsjjkbLi+a0
	C6sFz9Fw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t8Cnn-0000000G1Z6-09k1;
	Tue, 05 Nov 2024 06:12:31 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t8Cnk-0000000G1YA-1tSQ
	for linux-nvme@lists.infradead.org;
	Tue, 05 Nov 2024 06:12:29 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A55cLXK032442;
	Tue, 5 Nov 2024 06:12:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=PcOSH0DDaj4/l5H10
	+PDkzvMTLLwsf46X0woj7f1Rdo=; b=CuANNDTf4P06YCRnlKxARcyrRgVHjzMjV
	2t8vX9vJ/c30/QhfrYYEEY34V0/RVXgjRaIm+Ms/WKw8wrhY//cBxjZK3BpTeWW3
	ih0BfH2mN5BvmZf+PYCf4nk7cw71uS5zgPYC0jO+qyC5ps0fxyrurrNJAv8zpQnV
	vJo/o7LpLNnCHZkTjGUP8RsYJ/N8ok9xlAs9icuZIkKfs+kBLDtS/y9XAdvHAbdr
	2lMLwnnQTshq5VyEEi4WcmL8lg8Ehz1DiHlbMRFyVGkucUgaFx3dkTyMkjMEg6Uu
	yQvHJpTe91LuSOsFITXJfpHz840RuQW9nPQmYSBWXHDfQe/STA/XQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42qc3g0fkw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Nov 2024 06:12:23 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4A4LOELp012237;
	Tue, 5 Nov 2024 06:12:22 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 42p140ufku-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Nov 2024 06:12:22 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4A56CJRl14549260
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 5 Nov 2024 06:12:19 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E9DF92004B;
	Tue,  5 Nov 2024 06:12:18 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 60C2920040;
	Tue,  5 Nov 2024 06:12:16 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.in.ibm.com (unknown [9.109.198.181])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  5 Nov 2024 06:12:15 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, ming.lei@redhat.com,
        axboe@fb.com, chaitanyak@nvidia.com, dlemoal@kernel.org,
        gjoyce@linux.ibm.com, Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCHv4 1/2] Revert "nvme: make keep-alive synchronous operation"
Date: Tue,  5 Nov 2024 11:42:08 +0530
Message-ID: <20241105061212.1008143-2-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241105061212.1008143-1-nilay@linux.ibm.com>
References: <20241105061212.1008143-1-nilay@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 9sQ5uJchQiahecHDa7HQPmrY99kt6Y08
X-Proofpoint-ORIG-GUID: 9sQ5uJchQiahecHDa7HQPmrY99kt6Y08
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 clxscore=1015 impostorscore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 phishscore=0 adultscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411050043
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241104_221228_519487_E2C95C34 
X-CRM114-Status: GOOD (  16.98  )
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

It was realized that the fix implemented to contain the race condition
among the keep alive task and the fabric shutdown code path in the commit
d06923670b5ia ("nvme: make keep-alive synchronous operation") is not
optimal. The reason being keep-alive runs under the workqueue and making
it synchronous would waste a workqueue context.
Furthermore, we later found that the above race condition is a regression
caused due to the changes implemented in commit a54a93d0e359 ("nvme: move
stopping keep-alive into nvme_uninit_ctrl()"). So we decided to revert the
commit d06923670b5a ("nvme: make keep-alive synchronous operation") and
then fix the regression.

Link: https://lore.kernel.org/all/196f4013-3bbf-43ff-98b4-9cb2a96c20c2@grimberg.me/
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/host/core.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index b149b638453f..ddf07df243d3 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1303,9 +1303,10 @@ static void nvme_queue_keep_alive_work(struct nvme_ctrl *ctrl)
 	queue_delayed_work(nvme_wq, &ctrl->ka_work, delay);
 }
 
-static void nvme_keep_alive_finish(struct request *rq,
-		blk_status_t status, struct nvme_ctrl *ctrl)
+static enum rq_end_io_ret nvme_keep_alive_end_io(struct request *rq,
+						 blk_status_t status)
 {
+	struct nvme_ctrl *ctrl = rq->end_io_data;
 	unsigned long rtt = jiffies - (rq->deadline - rq->timeout);
 	unsigned long delay = nvme_keep_alive_work_period(ctrl);
 	enum nvme_ctrl_state state = nvme_ctrl_state(ctrl);
@@ -1322,17 +1323,20 @@ static void nvme_keep_alive_finish(struct request *rq,
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
 	if (state == NVME_CTRL_LIVE || state == NVME_CTRL_CONNECTING)
 		queue_delayed_work(nvme_wq, &ctrl->ka_work, delay);
+	return RQ_END_IO_NONE;
 }
 
 static void nvme_keep_alive_work(struct work_struct *work)
@@ -1341,7 +1345,6 @@ static void nvme_keep_alive_work(struct work_struct *work)
 			struct nvme_ctrl, ka_work);
 	bool comp_seen = ctrl->comp_seen;
 	struct request *rq;
-	blk_status_t status;
 
 	ctrl->ka_last_check_time = jiffies;
 
@@ -1364,9 +1367,9 @@ static void nvme_keep_alive_work(struct work_struct *work)
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



Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C29ECED266
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Oct 2024 04:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=arGo8t1kBAvbVwquzWcvHts3zBunVUGVLM/5H7tLK2Y=; b=n33ViHLAKLZpoVPW0Xm2cyOY1v
	6GPSRxo5DAMUM7CmSIAw9GsxlaIUcqR96HsafOpHy5K76mTJ8NNZE4SkBQ5BcueH5clycldSTV+/5
	DPYnROo6kN6r/w92Ej2YBAUxbiQeqasxjSAnFuc4MAcf8ht0LKbl0q+ko8W+OeXp9AHL2keYO2lsz
	UKwRcqtYJTlwEGbyMAFGrrXL8kqgwj8IFJtjyxOEmKReqXOvlX8Zl9vSGKynbdZWVj9ceuhw65YCj
	eihBeavVojI9mZ1Pi0qQTAy4Ma2LO82mFDjFjhjX8cye2Rwrpx6ZvhRqcxRsngLcQ0iAglUNYqwr0
	/AhwnVkw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sy1cl-00000004St0-2DdV;
	Tue, 08 Oct 2024 04:15:03 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sy1ch-00000004Squ-0gwd
	for linux-nvme@lists.infradead.org;
	Tue, 08 Oct 2024 04:15:00 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4982t5YB023804;
	Tue, 8 Oct 2024 04:14:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=arGo8t1kBAvbV
	wquzWcvHts3zBunVUGVLM/5H7tLK2Y=; b=MzyPYYvqBqboU9G9iSeb3eMbbBvBJ
	ZRofCK6zSZ7qHt6LtEhxqMjBCmT1jpTf9mXp/3PhxgGMPHaUUTVBo/FHn63LjzRE
	hZbIT9r0bpF9tb19WJ41ibFda6d1XWxYIBpiF2jrkQBX74Mso3Dhh1Sguzp9OSU6
	1m0tOl7jKQPEuzjN2CDQBy/Rhwah7P0N/iQZ1C6QsQ7gXsjgsNSlY/3WjQ4DGxAY
	Qpzz8WU/f9PZ23bSf0pFMx9STC8iZvBgowKn5fY9vHBUJr6vrteHm7a0OKXzLhHO
	AVj1qrt4gFiTtceVXMhFfyyLBM+4JZ9vKT0QtPQ6pY069rM6Z6kmkVraQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 424vcc07qk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Oct 2024 04:14:51 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4981AEN1013833;
	Tue, 8 Oct 2024 04:14:50 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 423fss2964-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Oct 2024 04:14:50 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4984EkTe47972820
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 8 Oct 2024 04:14:47 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D7D8320040;
	Tue,  8 Oct 2024 04:14:46 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2733D20043;
	Tue,  8 Oct 2024 04:14:45 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.171.23.125])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  8 Oct 2024 04:14:44 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, axboe@fb.com,
        chaitanyak@nvidia.com, gjoyce@linux.ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH v2 3/3] nvme: use helper nvme_ctrl_state in nvme_keep_alive_finish function
Date: Tue,  8 Oct 2024 09:43:30 +0530
Message-ID: <20241008041436.1073281-4-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241008041436.1073281-1-nilay@linux.ibm.com>
References: <20241008041436.1073281-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: qrLq2Fh15GcN0-T9L3a_9n9p8mW-LovE
X-Proofpoint-GUID: qrLq2Fh15GcN0-T9L3a_9n9p8mW-LovE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-08_03,2024-10-07_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 phishscore=0 adultscore=0 spamscore=0 suspectscore=0 mlxscore=0
 impostorscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 mlxlogscore=969 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410080026
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241007_211459_240913_99AE7A68 
X-CRM114-Status: GOOD (  14.96  )
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

We no more need acquiring ctrl->lock for accessing the NVMe controller
state and instead we can now use the helper nvme_ctrl_state. So replace
the ctrl->lock from nvme_keep_alive_finish function with nvme_ctrl_state
call.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/host/core.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 736adbf65ef5..5a690cf16e5e 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1296,10 +1296,10 @@ static void nvme_keep_alive_finish(struct request *rq,
 				blk_status_t status,
 				struct nvme_ctrl *ctrl)
 {
-	unsigned long flags;
 	bool startka = false;
 	unsigned long rtt = jiffies - (rq->deadline - rq->timeout);
 	unsigned long delay = nvme_keep_alive_work_period(ctrl);
+	enum nvme_ctrl_state state = nvme_ctrl_state(ctrl);
 
 	/*
 	 * Subtract off the keepalive RTT so nvme_keep_alive_work runs
@@ -1322,11 +1322,8 @@ static void nvme_keep_alive_finish(struct request *rq,
 
 	ctrl->ka_last_check_time = jiffies;
 	ctrl->comp_seen = false;
-	spin_lock_irqsave(&ctrl->lock, flags);
-	if (ctrl->state == NVME_CTRL_LIVE ||
-	    ctrl->state == NVME_CTRL_CONNECTING)
+	if (state == NVME_CTRL_LIVE || state == NVME_CTRL_CONNECTING)
 		startka = true;
-	spin_unlock_irqrestore(&ctrl->lock, flags);
 	if (startka)
 		queue_delayed_work(nvme_wq, &ctrl->ka_work, delay);
 }
-- 
2.45.2



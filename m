Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3091FCED270
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Oct 2024 06:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WaELfBELWimkuVmAT3voD7//W0m4cpsRh0CqMdcJIvY=; b=NtDMAKPKyXUXHFmjHE8rtlEFrD
	PwSQ4N03TJFU2Xya+oKvFq8Xb+EUoJW+wb/ZeJH6QUezC1gvGNx09Fcbu0TSOjCExdb73kYxO2yMr
	9Jmyker3s647LNM+YdDz2KMRDfteHYmqHvRqMeyxEkpH/XYrrAgLjSImWPkjyOexkCOELwKr8wLzs
	bAHImRi0sMa+0kBd18KMalehO/gHcYnoK3lIHVraLBv3xdqFI2NX45mhsy5RXYzwGechSWACYb4Dy
	Tb3eX1fP4czioUnD7pJW5ijtmEBeTISNONm5dsbTKXbIGQ5DtvmnBq93weV5zrW2/Tsz7bhOvrFIh
	vk4x7NKA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sy3d8-00000004dgY-0Wgr;
	Tue, 08 Oct 2024 06:23:34 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sy3c9-00000004dTC-2Xg7
	for linux-nvme@lists.infradead.org;
	Tue, 08 Oct 2024 06:22:34 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4984mu6c018704;
	Tue, 8 Oct 2024 06:22:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=WaELfBELWimku
	VmAT3voD7//W0m4cpsRh0CqMdcJIvY=; b=HRZum2jRxNa5CevLxAzaGLreZvlWW
	ELhWihCR/4dnD3ljcE784+eMinb4df0Pgt+L8HrvnFPwwEnWBleYs+7DE7eBO4Dx
	Ew4xHbfOpGF/l/9y8k5XWgr+Weih/w6FTx07sVri9BihY99Nvrv41Fpd/AtIPSqo
	jswbefIZrf8Bb7/tZZboTsxSsqsVKUCVisaWZhVY7TYuyq0mhLJEcmAPI51Jx3GE
	S3+IjD1hvbFR7BB4P+Hq3fOHQ5Z/u0msrPIZ9LRAmcBLy8dOs/4v8V5AVifTwMwT
	7kxigCiB2f+Rx88udoNT2tPmiBAqwF953f2ns+kxlcG6ulKqWAhHwTiCA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 424x168akp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Oct 2024 06:22:26 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 498627OX011524;
	Tue, 8 Oct 2024 06:22:26 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 423g5xjp0e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Oct 2024 06:22:26 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4986MMjw35390076
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 8 Oct 2024 06:22:22 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 46C9D20043;
	Tue,  8 Oct 2024 06:22:22 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 144D720040;
	Tue,  8 Oct 2024 06:22:20 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.171.23.125])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  8 Oct 2024 06:22:19 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, axboe@fb.com,
        chaitanyak@nvidia.com, dlemoal@kernel.org, gjoyce@linux.ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH v3 3/3] nvme: use helper nvme_ctrl_state in nvme_keep_alive_finish function
Date: Tue,  8 Oct 2024 11:51:52 +0530
Message-ID: <20241008062210.1094083-4-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241008062210.1094083-1-nilay@linux.ibm.com>
References: <20241008062210.1094083-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: zkJipllR03O97mlcrdXLgl4QzjUza191
X-Proofpoint-GUID: zkJipllR03O97mlcrdXLgl4QzjUza191
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-08_04,2024-10-08_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 mlxlogscore=954 impostorscore=0 suspectscore=0
 spamscore=0 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410080039
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241007_232233_798790_B40303B0 
X-CRM114-Status: GOOD (  15.55  )
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

We no more need acquiring ctrl->lock before accessing the
NVMe controller state and instead we can now use the helper
nvme_ctrl_state. So replace the use of ctrl->lock from
nvme_keep_alive_finish function with nvme_ctrl_state call.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/host/core.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 736adbf65ef5..4c83424fbd66 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1296,10 +1296,9 @@ static void nvme_keep_alive_finish(struct request *rq,
 				blk_status_t status,
 				struct nvme_ctrl *ctrl)
 {
-	unsigned long flags;
-	bool startka = false;
 	unsigned long rtt = jiffies - (rq->deadline - rq->timeout);
 	unsigned long delay = nvme_keep_alive_work_period(ctrl);
+	enum nvme_ctrl_state state = nvme_ctrl_state(ctrl);
 
 	/*
 	 * Subtract off the keepalive RTT so nvme_keep_alive_work runs
@@ -1322,12 +1321,7 @@ static void nvme_keep_alive_finish(struct request *rq,
 
 	ctrl->ka_last_check_time = jiffies;
 	ctrl->comp_seen = false;
-	spin_lock_irqsave(&ctrl->lock, flags);
-	if (ctrl->state == NVME_CTRL_LIVE ||
-	    ctrl->state == NVME_CTRL_CONNECTING)
-		startka = true;
-	spin_unlock_irqrestore(&ctrl->lock, flags);
-	if (startka)
+	if (state == NVME_CTRL_LIVE || state == NVME_CTRL_CONNECTING)
 		queue_delayed_work(nvme_wq, &ctrl->ka_work, delay);
 }
 
-- 
2.45.2



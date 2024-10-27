Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66879D13572
	for <linux-nvme@archiver.kernel.org>; Sun, 27 Oct 2024 17:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5HgCyZeyn1iSo3vcjA/3EwtuNXjpjnRFes027u4wtbg=; b=GjZSL/LtssfqpOErdL+schPSbL
	DljNZwDb0EnjNQ4mAOPYttP+Jyf5g4lXWg8Hf2VkPx6ALjx2t/dIpmSJwoiVUC4y4bzoQ5SQb+ZpB
	IV+vCxYphmhgzlsjMHzEddGBJd9/CYn08zkK0tV/8lHGe2rGXNFl3ZkILf0ugZ366T3x6XbY7rOca
	N8YJGlsIlKrI/y7K3zQie1zeqIef8/70VVNcrdYGGPbF7iy13EhO0GXTaS8SPMURqV7BvKuosuTPT
	E1au5gJst7qqMaSjaIoabq3FZ8hLplumqjomDOAPRy1NMQ80XdTdAUvKOy9CUAFq08/OmVMaHzxB8
	nhDj671w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t56fE-00000008ZqB-0JJc;
	Sun, 27 Oct 2024 17:02:52 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t56fB-00000008ZoF-1TnZ
	for linux-nvme@lists.infradead.org;
	Sun, 27 Oct 2024 17:02:51 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49R8G8gc002012;
	Sun, 27 Oct 2024 17:02:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=5HgCyZeyn1iSo3vcj
	A/3EwtuNXjpjnRFes027u4wtbg=; b=kMj6FN/CH+sfgxnLN4YLmUK0r2CDeGBf8
	eoOL6+cin8Je1i9F+Jgj64KzK/EqK9HagpHiz4J0JOB8a2VfyL1lAOi8bkrVmRS8
	ByVniaiZA7J9yNVAgq/cComsXFXdEsYdWyHF/RP3+TN2wifTRK6z+gOfEK3VrtOx
	Vu1Lf+bg5LCfb8LOAc3zofoy/I+jubENmh6B8NWqwOFGuLLjocZQvWLp68RA/wwT
	Obbah+ipiIjKMyIw81I+kCFTDjCaNdmfqRe6g9z97MsbKdeA548kNhrZMsDNPJE/
	H2rciCa4idWu9xkAIq8kBW3u8vtq5pSRHswqGbeeIjX0aUIJsW4yQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42grwg5adg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 27 Oct 2024 17:02:38 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49RDOOLf024540;
	Sun, 27 Oct 2024 17:02:37 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 42hcyj2bn6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 27 Oct 2024 17:02:37 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49RH2XNL31589044
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 27 Oct 2024 17:02:33 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 83A6C2004E;
	Sun, 27 Oct 2024 17:02:33 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3DC7220040;
	Sun, 27 Oct 2024 17:02:31 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.179.2.58])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 27 Oct 2024 17:02:31 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, axboe@fb.com,
        chaitanyak@nvidia.com, dlemoal@kernel.org, gjoyce@linux.ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH 3/3] nvme: use helper nvme_ctrl_state in nvme_keep_alive_end_io function
Date: Sun, 27 Oct 2024 22:32:06 +0530
Message-ID: <20241027170209.440776-4-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241027170209.440776-1-nilay@linux.ibm.com>
References: <20241027170209.440776-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: r5mxYyG7kZSJ3941GzOyolm0Y_PtrbqD
X-Proofpoint-ORIG-GUID: r5mxYyG7kZSJ3941GzOyolm0Y_PtrbqD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 phishscore=0 suspectscore=0
 priorityscore=1501 mlxlogscore=851 mlxscore=0 spamscore=0 impostorscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410270144
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241027_100249_638110_676F3C52 
X-CRM114-Status: GOOD (  13.78  )
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
nvme_keep_alive_end_io function with nvme_ctrl_state call.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/host/core.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 865c00ea19e3..6e814daf1002 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1296,10 +1296,9 @@ static enum rq_end_io_ret nvme_keep_alive_end_io(struct request *rq,
 						 blk_status_t status)
 {
 	struct nvme_ctrl *ctrl = rq->end_io_data;
-	unsigned long flags;
-	bool startka = false;
 	unsigned long rtt = jiffies - (rq->deadline - rq->timeout);
 	unsigned long delay = nvme_keep_alive_work_period(ctrl);
+	enum nvme_ctrl_state state = nvme_ctrl_state(ctrl->state);
 
 	/*
 	 * Subtract off the keepalive RTT so nvme_keep_alive_work runs
@@ -1324,13 +1323,9 @@ static enum rq_end_io_ret nvme_keep_alive_end_io(struct request *rq,
 
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
+
 	return RQ_END_IO_NONE;
 }
 
-- 
2.45.2



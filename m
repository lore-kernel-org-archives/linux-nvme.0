Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34528D10C17
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Oct 2024 12:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Plb3g6DwF8MFc+rCfKCrbKv2IjYXlmUMiLV2uLFrcsc=; b=uYN8ID3oTGznVzGIgGWMzwDqhG
	7RhyEZecrhkf+1B11CKgJclfH84RrTp9l1ar70RIVQb5H0SPKxlegBt/R00mJzLe3ueQC+AQqq3GX
	KQx0LRw5sYhAGgJoLM9DApSUfPASytn0EGQKS5Pa/jFhNyQDs4pJ1hOiG1a7pQVvpWFW79uF8lzpq
	xz84I0sVT7L1qSsWv9tNRk1qq+UUtQupB8vYI09+F28H3CSFpNi2D18HI59g4HU09GCQhsxfNPZ0U
	T7R2VU3AiY5KEg91M/CMMXBrDG7HRkhHIhdX8QZ9o7hYgFlLzqK1qNQjMBRLacDh+MtVuENKiw78/
	sObeWpPA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t5PIt-0000000Aql7-0Owc;
	Mon, 28 Oct 2024 12:57:03 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t5PA7-0000000ApHp-2bIb
	for linux-nvme@lists.infradead.org;
	Mon, 28 Oct 2024 12:48:01 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49SCbhSj024452;
	Mon, 28 Oct 2024 12:47:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Plb3g6DwF8MFc+rCf
	KCrbKv2IjYXlmUMiLV2uLFrcsc=; b=TcWw6P6ck+eFguYdMsEtpdgJBH1BhgX/B
	3MRGysdCIyINfkAPSquviXzGGABj4c1wOs5ZV7WCQtjgLzJoDAe1SaqYpKXjTXhf
	0DTglkeqKDWk+YwHFMTl6BV58kE/M59JbAwfgmP85crqIpA8k0mCJJsd35GwJKVQ
	mFqhEBGbgO78lZzoW+pE9dtaqfyj1OAHauXVkaY4WVpU0JqANPwPv+PTtsDIMec7
	VleS7NSKg90wvbFw2DAexIHuAIn7Lir79ijFYYCuoo4eX+GnWwaExDC/4LfzgyL4
	4IqO5LJ7jGGwOd08dJ/TegGQf9cGILLtk0OXzLE0Bedl6yRepD0Ag==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42j43ftehr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Oct 2024 12:47:51 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49S8LG3J018371;
	Mon, 28 Oct 2024 12:47:32 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42hc8jx4jq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Oct 2024 12:47:32 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49SClS9V12386638
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Oct 2024 12:47:29 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DE25520040;
	Mon, 28 Oct 2024 12:47:28 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A00AA2004D;
	Mon, 28 Oct 2024 12:47:26 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.171.1.253])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 28 Oct 2024 12:47:26 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, axboe@fb.com,
        chaitanyak@nvidia.com, dlemoal@kernel.org, gjoyce@linux.ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCHv2 3/3] nvme: use helper nvme_ctrl_state in nvme_keep_alive_end_io function
Date: Mon, 28 Oct 2024 18:17:11 +0530
Message-ID: <20241028124717.517132-4-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241028124717.517132-1-nilay@linux.ibm.com>
References: <20241028124717.517132-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 1AbZxDl0cNzDK7AYj8gw4KLkYKig0nsp
X-Proofpoint-ORIG-GUID: 1AbZxDl0cNzDK7AYj8gw4KLkYKig0nsp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=700 clxscore=1015
 adultscore=0 mlxscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410280103
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241028_054759_694700_3C227579 
X-CRM114-Status: GOOD (  15.01  )
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

We use WRITE_ONCE() for updating the ctrl->state value. So it makes
sense to pair the read of ctrl->state using READ_ONCE(). The helper
nvme_ctrl_state(), helps reads the ctrl->state using READ_ONCE().

In nvme_keep_alive_end_io function, we first acquire ctrl->lock before
reading ctrl->state. However, with use of helper nvme_ctrl_state()
we can avoid ctrl->lock. So this commit removes the ctrl->lock and
replaces it with nvme_ctrl_state call.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/host/core.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 865c00ea19e3..802634022bfa 100644
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
+	enum nvme_ctrl_state state = nvme_ctrl_state(ctrl);
 
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



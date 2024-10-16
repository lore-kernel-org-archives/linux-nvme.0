Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E29A6D20695
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Oct 2024 03:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ObYzUUYokNHrbwSm5+m4mofRX8lvlACPwfjRMcuur/0=; b=X1eAyPJ7O3iK302aDz9ReHO0kA
	uTNa1nxl9ypycYOEWAsux1AZxkEohRZFnfluM7KT+c0juAtzQbyWSMXoALPRE3A4fIKNEd6fZV3oq
	/f7xQ2a1jwIi4z13etPcRm/1ZJSuNfOBun0/m+vuBoFpbIqoK9ixRwLIYzyLO3aAHtDC9lNMg0z6Y
	ZQb8P+h2siMYluXup8QVHeuYuzI2xFnG/MJKspVfdLiWWGZZi4AFnVxSXsOf4xuBdx/HWbu1JQTbm
	nmYjrqS+s/nFk1Q+9f/7Z2eMhjfOhPeWPqksVF4QzDqnUysTYd2NsJUBtl1T+o+8o6ch0P7llGaVT
	nDSlQKsA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t0uLj-0000000AIYb-3CeC;
	Wed, 16 Oct 2024 03:05:23 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t0uKV-0000000AINb-0xDZ
	for linux-nvme@lists.infradead.org;
	Wed, 16 Oct 2024 03:04:08 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49G2t51U005628;
	Wed, 16 Oct 2024 03:04:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=ObYzUUYokNHrbwSm5
	+m4mofRX8lvlACPwfjRMcuur/0=; b=jGEhCjn9lJgWEWRloaznAgqPKbGBtqEhW
	r7BpsGvv1D7F9E8+c2zf3b5gRJqQox0lbRfUD2TTGGcG45SyJMbx4oF+Otq09tbO
	0VJ2knhjz0uxm5mAHaPwQhw5cNboqOsD14tH2d8Ujj2c6aDONGrCW61pSdz5+7lW
	tWcBaks/q0/968+LQCgbFqDU6rcDZXNgRFHV7MrexPNiCRu38dS64ClkqwbzE0Fz
	hhIJWS17Iz2rG5WA1QhBQf2CDcxXZ7ZdwBWjxDnZXzpwowYpQ4Jq3oF77EIoBC/T
	FXcoeTcZ21NF/duzBl+XTIXg96p4aI3Smg0rLc73vDN+CEtEyS9bw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42a54dg0p6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Oct 2024 03:04:03 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49G2PRAR002343;
	Wed, 16 Oct 2024 03:04:02 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4284emq2ug-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Oct 2024 03:04:01 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49G33wIH57672050
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Oct 2024 03:03:58 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 301DE20049;
	Wed, 16 Oct 2024 03:03:58 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6495E20040;
	Wed, 16 Oct 2024 03:03:54 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.171.76.114])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 16 Oct 2024 03:03:54 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, axboe@fb.com,
        chaitanyak@nvidia.com, dlemoal@kernel.org, gjoyce@linux.ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH v4 3/3] nvme: use helper nvme_ctrl_state in nvme_keep_alive_finish function
Date: Wed, 16 Oct 2024 08:33:16 +0530
Message-ID: <20241016030339.54029-4-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241016030339.54029-1-nilay@linux.ibm.com>
References: <20241016030339.54029-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: RAMBQQO_yaBOR1Y3WXZRJaB-NYmKjMQf
X-Proofpoint-ORIG-GUID: RAMBQQO_yaBOR1Y3WXZRJaB-NYmKjMQf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 phishscore=0 mlxlogscore=978 lowpriorityscore=0 suspectscore=0 bulkscore=0
 spamscore=0 malwarescore=0 clxscore=1015 mlxscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410160016
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241015_200407_297249_853AE8BD 
X-CRM114-Status: GOOD (  14.82  )
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

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/host/core.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index b7541dda36b4..5a6a6099cbd1 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1295,10 +1295,9 @@ static void nvme_queue_keep_alive_work(struct nvme_ctrl *ctrl)
 static void nvme_keep_alive_finish(struct request *rq,
 		blk_status_t status, struct nvme_ctrl *ctrl)
 {
-	unsigned long flags;
-	bool startka = false;
 	unsigned long rtt = jiffies - (rq->deadline - rq->timeout);
 	unsigned long delay = nvme_keep_alive_work_period(ctrl);
+	enum nvme_ctrl_state state = nvme_ctrl_state(ctrl);
 
 	/*
 	 * Subtract off the keepalive RTT so nvme_keep_alive_work runs
@@ -1321,12 +1320,7 @@ static void nvme_keep_alive_finish(struct request *rq,
 
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



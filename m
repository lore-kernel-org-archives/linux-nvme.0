Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5B27CD5BD0
	for <linux-nvme@archiver.kernel.org>; Thu, 28 May 2026 01:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WOofK0Nj07KI3RlrPU1SpwwDKUz1V/zDmsROl/EeEms=; b=FDqU6elPKuxhJeqAgM7pyDhIvY
	dlm2JjKCUrByRMsoKKjyufkH9EF1zsrl6Qc6wYqschmkzthYCI9jlycEsK7elXBw7pAyL5omn/Iii
	QutYJup1HrkUAbsdVMCov4gzSDFfNKR6F4SMrW+PyziEi+4x1j3tLsuMeSJhKm9Yoo/B8VS62634W
	YJixQvUwRwhR1GJqeD4VmWXMve4hAIH9f3cOGpHZccGtcUJJ11fzGmYc103sOlrdVT+NbR83Bn2zz
	Y68qFVBKJPG1ya+veL5fheKoG0w6K+sCWYyquEJixgCia9IabNxVnIPePnAPe0L/QE8rgRXyttPG9
	gouDDPmw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSP7a-00000004vAY-18O7;
	Thu, 28 May 2026 01:01:14 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSP7X-00000004v9X-3Ro8
	for linux-nvme@lists.infradead.org;
	Thu, 28 May 2026 01:01:12 +0000
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64RKjHok4094134
	for <linux-nvme@lists.infradead.org>; Wed, 27 May 2026 18:01:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=WOofK0Nj07KI3RlrPU1SpwwDKUz1V/zDmsROl/EeEms=; b=ocZksARZwkZr
	ZdS9rFdL5aAOdBeD4dUgVPH5kYdTxNCyU2qtXdq4xPCBFVcAisT/MWaqR4MndGVR
	jsQgTj2Jj3AlZUh0SrOFMIw6DPlptX/a0lYYxZPCMidZ4jX9RWyavgUZuFsVD0BZ
	2k++dIL0PhL2sExi5gXxEfIjXeGVvAmv6WeoA48DWLeSJwG35JE+plT4JNbtq12t
	XSrUKYAHvQyz8/8a9sOMndE3+HI2qTmMop81wyHJ7SE6UE7YN2hLXUweRFpj32Lw
	2M2yMkDiR82QOZ2rOezWbFkrhSdqG+UEW2A4IWnBcK8wzA9OLpbIjShQH9jy27sU
	BAcZ1mZf5g==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4ee7x6986q-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Wed, 27 May 2026 18:01:11 -0700 (PDT)
Received: from twshared114832.14.frc2.facebook.com (2620:10d:c085:208::7cb7)
 by mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.41; Thu, 28 May 2026 01:01:09 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 1D14F1D39B577; Wed, 27 May 2026 18:00:58 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>
CC: <axboe@kernel.dk>, <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
        Nilay
 Shroff <nilay@linux.ibm.com>,
        Nitesh Shetty <nj.shetty@samsung.com>
Subject: [PATCHv3 2/2] nvme: add support multipath passthrough iostats
Date: Wed, 27 May 2026 18:00:41 -0700
Message-ID: <20260528010041.1533124-3-kbusch@meta.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260528010041.1533124-1-kbusch@meta.com>
References: <20260528010041.1533124-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: UE6X1g1LgxDzWIYON1a_MmPmkdIZCQFc
X-Authority-Analysis: v=2.4 cv=TdymcxQh c=1 sm=1 tr=0 ts=6a1793d7 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=crHB47gyY4rKiduisYu9:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=hD80L64hAAAA:8
 a=xT7lm6qD1slQ1dElJxQA:9
X-Proofpoint-GUID: UE6X1g1LgxDzWIYON1a_MmPmkdIZCQFc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDAwNyBTYWx0ZWRfX2XmbS2pKtjmh
 pT87s04UFO73AtxqpJnxdEiSMDK7POhIQ7WsNZygQf/iPDlpQni0Dk6ECjAhruJDuK2G/8Ijqs9
 Dbs9q7voLktnBvUQHG5Lmf8Q3pBW3NSfI0ovXv3u7jVhfh3JOIQNgcdWs6RX/20Tw9cZ85fmD34
 pcCcuYdBRiQ2dmJunLO5TqXkQ9htFn8nuqS0mQPFCj43KfkzZMvWaHS45LT5g5qe2HQ5WCFoEQY
 7nco5a9tq2UDRraGwyZoxouNH+2CUKNAMQnAvo6imT3mGvs/X4PuQ82FRcCRojNDcjYq/IV+zR+
 SpLYi6wLJAHyNV64IyXPGMz+F/DOADUthFnNP3Y+l5xzEaYlSJWRJq2u+SQ6L0SUt0mkr1Sy/SJ
 gtheCD/aECYwiWNpB1QdtDj+WtB+k8bRQ5VTJ6E+Z9Slky0mcp4T2OYX2qo0RQ/VQgaqcVjCyGf
 iFvnKYkj9mxvfOaM2dw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-27_05,2026-05-26_03,2025-10-01_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260527_180111_866289_DA2C40E6 
X-CRM114-Status: GOOD (  14.09  )
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

From: Keith Busch <kbusch@kernel.org>

Don't skip the io accounting for passthrough commands if the user
enabled tracking these.

Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
Reviewed-by: Nitesh Shetty <nj.shetty@samsung.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/ioctl.c     | 9 +++++++++
 drivers/nvme/host/multipath.c | 5 ++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 08889b20e5d8c..664216eece4a6 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -102,8 +102,17 @@ static struct request *nvme_alloc_user_request(struc=
t request_queue *q,
 		struct nvme_command *cmd, blk_opf_t rq_flags,
 		blk_mq_req_flags_t blk_flags)
 {
+	struct nvme_ns *ns =3D q->queuedata;
 	struct request *req;
=20
+	/*
+	 * The NVME_MPATH flag is set only for IO commands sent to a namespace
+	 * with a multipath enabled head. The request is not eligible for
+	 * failover as passthrough requests also append REQ_FAILFAST_DRIVER.
+	 */
+	if (ns && nvme_ns_head_multipath(ns->head))
+		rq_flags |=3D REQ_NVME_MPATH;
+
 	req =3D blk_mq_alloc_request(q, nvme_req_op(cmd) | rq_flags, blk_flags)=
;
 	if (IS_ERR(req))
 		return req;
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.=
c
index ff442bbf2937a..bca8e7c975190 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -175,9 +175,12 @@ void nvme_mpath_start_request(struct request *rq)
 		nvme_req(rq)->flags |=3D NVME_MPATH_CNT_ACTIVE;
 	}
=20
-	if (!blk_queue_io_stat(disk->queue) || blk_rq_is_passthrough(rq) ||
+	if (!blk_queue_io_stat(disk->queue) ||
 	    (nvme_req(rq)->flags & NVME_MPATH_IO_STATS))
 		return;
+	if (blk_rq_is_passthrough(rq) &&
+	    !blk_rq_passthrough_stats(rq, disk->queue))
+		return;
=20
 	nvme_req(rq)->flags |=3D NVME_MPATH_IO_STATS;
 	nvme_req(rq)->start_time =3D bdev_start_io_acct(disk->part0, req_op(rq)=
,
--=20
2.53.0-Meta



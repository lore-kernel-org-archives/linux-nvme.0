Return-Path: <SRS0=Nr0d=N6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96788C433EF
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Sep 2021 07:42:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55CAF61167
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Sep 2021 07:42:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 55CAF61167
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=marvell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=uXOFGM4rqdkjrD6fQcbCm6QKEHVpUSRbRH6dTAPRYAY=; b=MJ8p9dRDsIhh5p
	1gzzsmnJ7b7XmNv/GO2QkxtdaL6uyqCvWRi02UKBt7h+B84AJ/bhpOdQ+qMA8Km9AowgJbPmJEARM
	wyKzBUC/gzTtujuH6l6wXgkaK/we4urtSDT6p4QFGGgHt2BeC2BhP84PNbHW2D7sFf0IFUntgGyv/
	n4qE1KjII2D6Fuab0/blAfFyhEAAC+fYOUHpM5+OtIrzdCRmq22+vL00bILp3BE0YHUwjOI8TQ6VD
	H0DV8TKZs16JWMzMR902SdYrY+RWlmcu4Vs8ziP+MyhMDyYMT/8MNQutgVO7NwGMRv2FNtj71ty9p
	HxYjFctOptaNIX4TcHNQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mNsDd-005xgj-5V; Wed, 08 Sep 2021 07:42:05 +0000
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mNs2J-005tgj-He
 for linux-nvme@lists.infradead.org; Wed, 08 Sep 2021 07:30:26 +0000
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1883JW4d018275; 
 Wed, 8 Sep 2021 00:30:22 -0700
Received: from dc5-exch01.marvell.com ([199.233.59.181])
 by mx0b-0016f401.pphosted.com with ESMTP id 3axcmjaeaw-4
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
 Wed, 08 Sep 2021 00:30:22 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.18;
 Wed, 8 Sep 2021 00:30:20 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Wed, 8 Sep 2021 00:30:20 -0700
Received: from dut1171.mv.qlogic.com (unknown [10.112.88.18])
 by maili.marvell.com (Postfix) with ESMTP id E5BA23F70AA;
 Wed,  8 Sep 2021 00:30:19 -0700 (PDT)
Received: from dut1171.mv.qlogic.com (localhost [127.0.0.1])
 by dut1171.mv.qlogic.com (8.14.7/8.14.7) with ESMTP id 1887UKL7010146;
 Wed, 8 Sep 2021 00:30:20 -0700
Received: (from root@localhost)
 by dut1171.mv.qlogic.com (8.14.7/8.14.7/Submit) id 1887UJpu010145;
 Wed, 8 Sep 2021 00:30:19 -0700
From: Nilesh Javali <njavali@marvell.com>
To: <martin.petersen@oracle.com>, <linux-nvme@lists.infradead.org>
CC: <linux-scsi@vger.kernel.org>, <GR-QLogic-Storage-Upstream@marvell.com>,
 <djeffery@redhat.com>, <loberman@redhat.com>
Subject: [PATCH 07/10] qla2xxx: Call process_response_queue() in Tx path
Date: Wed, 8 Sep 2021 00:28:43 -0700
Message-ID: <20210908072846.10011-8-njavali@marvell.com>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20210908072846.10011-1-njavali@marvell.com>
References: <20210908072846.10011-1-njavali@marvell.com>
MIME-Version: 1.0
X-Proofpoint-GUID: zwtuFymYDiFppdcFBUWX14zX-o4Ls3SI
X-Proofpoint-ORIG-GUID: zwtuFymYDiFppdcFBUWX14zX-o4Ls3SI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-08_02,2021-09-07_02,2020-04-07_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210908_003023_747908_80F75774 
X-CRM114-Status: GOOD (  10.16  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Shreyas Deodhar <sdeodhar@marvell.com>

Process responses in Tx path if any available for better performance.

Signed-off-by: Shreyas Deodhar<sdeodhar@marvell.com>
Signed-off-by: Nilesh Javali <njavali@marvell.com>
---
 drivers/scsi/qla2xxx/qla_nvme.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/scsi/qla2xxx/qla_nvme.c b/drivers/scsi/qla2xxx/qla_nvme.c
index 877b2b625020..0ae1e081cb03 100644
--- a/drivers/scsi/qla2xxx/qla_nvme.c
+++ b/drivers/scsi/qla2xxx/qla_nvme.c
@@ -399,6 +399,7 @@ static inline int qla2x00_start_nvme_mq(srb_t *sp)
 	uint16_t	avail_dsds;
 	struct dsd64	*cur_dsd;
 	struct req_que *req = NULL;
+	struct rsp_que *rsp = NULL;
 	struct scsi_qla_host *vha = sp->fcport->vha;
 	struct qla_hw_data *ha = vha->hw;
 	struct qla_qpair *qpair = sp->qpair;
@@ -410,6 +411,7 @@ static inline int qla2x00_start_nvme_mq(srb_t *sp)
 
 	/* Setup qpair pointers */
 	req = qpair->req;
+	rsp = qpair->rsp;
 	tot_dsds = fd->sg_cnt;
 
 	/* Acquire qpair specific lock */
@@ -571,6 +573,10 @@ static inline int qla2x00_start_nvme_mq(srb_t *sp)
 	/* Set chip new ring index. */
 	wrt_reg_dword(req->req_q_in, req->ring_index);
 
+	if (vha->flags.process_response_queue &&
+	    rsp->ring_ptr->signature != RESPONSE_PROCESSED)
+		qla24xx_process_response_queue(vha, rsp);
+
 queuing_error:
 	spin_unlock_irqrestore(&qpair->qp_lock, flags);
 
-- 
2.19.0.rc0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

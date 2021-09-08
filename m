Return-Path: <SRS0=Nr0d=N6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8152DC433F5
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Sep 2021 07:40:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E5D961164
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Sep 2021 07:40:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3E5D961164
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=marvell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bG0QqrEjaVJAu0ri2SkwtU4XvXDbEaKy3R775+C+CBc=; b=UrJM2f+bHuXiuC
	oYeOLt0gCIXdqYv+Xjlw31kA3FXDPvhCMLcfZLW/yBCWZ2G0VUi0SQA3aWovKIf1cyxVqc65kuJJp
	WHH/5Dq2/Uqg7vAE1e9+f59zkBn4Np5Rd/i9M3h4umxzE6LEJpcxGWnKMTUwk3bwrBsSKA5ntiwyQ
	WKqxhWZenUHY3AFxcOqpHyX5edskGK2LcwZiAxzqKMtWXtFSukBtSEiIrT5XX3OMRimdFuMd5DB2M
	pktLHVxDW/BQjRXW4Mr225z4d1xl7QtHslOMj6MCB3DRPMtkgKeXjCU4Zfqd/O+vBikG4kWW9ehYE
	3Vv5IWBHADPl0RBR7X9A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mNsBu-005xDS-Qg; Wed, 08 Sep 2021 07:40:18 +0000
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mNs2I-005tgI-P9
 for linux-nvme@lists.infradead.org; Wed, 08 Sep 2021 07:30:24 +0000
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1883JW4b018275; 
 Wed, 8 Sep 2021 00:30:22 -0700
Received: from dc5-exch01.marvell.com ([199.233.59.181])
 by mx0b-0016f401.pphosted.com with ESMTP id 3axcmjaeaw-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
 Wed, 08 Sep 2021 00:30:21 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.18;
 Wed, 8 Sep 2021 00:30:19 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Wed, 8 Sep 2021 00:30:19 -0700
Received: from dut1171.mv.qlogic.com (unknown [10.112.88.18])
 by maili.marvell.com (Postfix) with ESMTP id 9C8183F705B;
 Wed,  8 Sep 2021 00:30:19 -0700 (PDT)
Received: from dut1171.mv.qlogic.com (localhost [127.0.0.1])
 by dut1171.mv.qlogic.com (8.14.7/8.14.7) with ESMTP id 1887UG0p010134;
 Wed, 8 Sep 2021 00:30:19 -0700
Received: (from root@localhost)
 by dut1171.mv.qlogic.com (8.14.7/8.14.7/Submit) id 1887UBZi010133;
 Wed, 8 Sep 2021 00:30:11 -0700
From: Nilesh Javali <njavali@marvell.com>
To: <martin.petersen@oracle.com>, <linux-nvme@lists.infradead.org>
CC: <linux-scsi@vger.kernel.org>, <GR-QLogic-Storage-Upstream@marvell.com>,
 <djeffery@redhat.com>, <loberman@redhat.com>
Subject: [PATCH 04/10] qla2xxx: Fix crash in NVME abort path
Date: Wed, 8 Sep 2021 00:28:40 -0700
Message-ID: <20210908072846.10011-5-njavali@marvell.com>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20210908072846.10011-1-njavali@marvell.com>
References: <20210908072846.10011-1-njavali@marvell.com>
MIME-Version: 1.0
X-Proofpoint-GUID: 1mQ9Y0k4n-9JMgJ68sKxer9AVfj_yIgm
X-Proofpoint-ORIG-GUID: 1mQ9Y0k4n-9JMgJ68sKxer9AVfj_yIgm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-08_02,2021-09-07_02,2020-04-07_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210908_003023_058122_D9E8CBE2 
X-CRM114-Status: GOOD (  13.40  )
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

From: Arun Easi <aeasi@marvell.com>

System crash was seen when I/O was run against a NVME target and when I/O
aborts were occurring.

Crash stack is:

    -- relevant crash stack --
    BUG: kernel NULL pointer dereference, address: 0000000000000010
    :
    #6 [ffffae1f8666bdd0] page_fault at ffffffffa740122e
       [exception RIP: qla_nvme_abort_work+339]
       RIP: ffffffffc0f592e3  RSP: ffffae1f8666be80  RFLAGS: 00010297
       RAX: 0000000000000000  RBX: ffff9b581fc8af80  RCX: ffffffffc0f83bd0
       RDX: 0000000000000001  RSI: ffff9b5839c6c7c8  RDI: 0000000008000000
       RBP: ffff9b6832f85000   R8: ffffffffc0f68160   R9: ffffffffc0f70652
       R10: ffffae1f862ffdc8  R11: 0000000000000300  R12: 000000000000010d
       R13: 0000000000000000  R14: ffff9b5839cea000  R15: 0ffff9b583fab170
       ORIG_RAX: ffffffffffffffff   CS: 0010  SS: 0018
    #7 [ffffae1f8666be98] process_one_work at ffffffffa6aba184
    #8 [ffffae1f8666bed8] worker_thread at ffffffffa6aba39d
    #9 [ffffae1f8666bf10] kthread at ffffffffa6ac06ed

The crash was due to a stale SRB structure access after it was aborted.
Fixed the issue by removing stale access.

Signed-off-by: Arun Easi <aeasi@marvell.com>
Signed-off-by: Nilesh Javali <njavali@marvell.com>
---
 drivers/scsi/qla2xxx/qla_nvme.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_nvme.c b/drivers/scsi/qla2xxx/qla_nvme.c
index 1c5da2dbd6f9..877b2b625020 100644
--- a/drivers/scsi/qla2xxx/qla_nvme.c
+++ b/drivers/scsi/qla2xxx/qla_nvme.c
@@ -228,6 +228,8 @@ static void qla_nvme_abort_work(struct work_struct *work)
 	fc_port_t *fcport = sp->fcport;
 	struct qla_hw_data *ha = fcport->vha->hw;
 	int rval, abts_done_called = 1;
+	bool io_wait_for_abort_done;
+	uint32_t handle;
 
 	ql_dbg(ql_dbg_io, fcport->vha, 0xffff,
 	       "%s called for sp=%p, hndl=%x on fcport=%p desc=%p deleted=%d\n",
@@ -244,12 +246,20 @@ static void qla_nvme_abort_work(struct work_struct *work)
 		goto out;
 	}
 
+	/*
+	 * sp may not be valid after abort_command if return code is either
+	 * SUCCESS or ERR_FROM_FW codes, so cache the value here.
+	 */
+	io_wait_for_abort_done = ql2xabts_wait_nvme &&
+					QLA_ABTS_WAIT_ENABLED(sp);
+	handle = sp->handle;
+
 	rval = ha->isp_ops->abort_command(sp);
 
 	ql_dbg(ql_dbg_io, fcport->vha, 0x212b,
 	    "%s: %s command for sp=%p, handle=%x on fcport=%p rval=%x\n",
 	    __func__, (rval != QLA_SUCCESS) ? "Failed to abort" : "Aborted",
-	    sp, sp->handle, fcport, rval);
+	    sp, handle, fcport, rval);
 
 	/*
 	 * If async tmf is enabled, the abort callback is called only on
@@ -264,7 +274,7 @@ static void qla_nvme_abort_work(struct work_struct *work)
 	 * are waited until ABTS complete. This kref is decreased
 	 * at qla24xx_abort_sp_done function.
 	 */
-	if (abts_done_called && ql2xabts_wait_nvme && QLA_ABTS_WAIT_ENABLED(sp))
+	if (abts_done_called && io_wait_for_abort_done)
 		return;
 out:
 	/* kref_get was done before work was schedule. */
-- 
2.19.0.rc0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

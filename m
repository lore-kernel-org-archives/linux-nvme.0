Return-Path: <SRS0=Nr0d=N6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36878C433FE
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Sep 2021 07:46:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF0DE60F6C
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Sep 2021 07:46:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EF0DE60F6C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=marvell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3WPWOwT8cbMytg+9tIPXrSwbA/X8H/8ZQjLel7di4YY=; b=rYaV3et0s2/L5Y
	kRQ7hIvWOZJpTp1aL5Cz26PaR37RVM/NZ9HVXACaAvjFcGLkTEcH4Co4wiRD7nxPxi4Z3+jrBXSQO
	PrSmFX2BbC96hvw6TiWc2m2dCEd5e8zmZYFrWKX4Eg5iq2HDqlH6a6gTEgGt6t/XFBkEltE5VmDEf
	6kV++ic3H9hTPvS8b4/KT73rrpcPn13mXAMV1+Fe90dTQ5H+f4fni5hYDWhVaXoJ+HXy/Qo9ao5y2
	l4LGufl1YwUhdmn8eiqLpvqJ2+GLa7dwiq9VfvvOsQFY7/x7zyfriPpO6Ia2WFx4up8pLFSUgwxXp
	4g1DuDJns2mpxsbHTljg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mNsHD-005yVb-As; Wed, 08 Sep 2021 07:45:47 +0000
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mNs2K-005thR-6i
 for linux-nvme@lists.infradead.org; Wed, 08 Sep 2021 07:30:26 +0000
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1883JW4e018275; 
 Wed, 8 Sep 2021 00:30:23 -0700
Received: from dc5-exch01.marvell.com ([199.233.59.181])
 by mx0b-0016f401.pphosted.com with ESMTP id 3axcmjaeaw-5
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
 Wed, 08 Sep 2021 00:30:23 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.18;
 Wed, 8 Sep 2021 00:30:20 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Wed, 8 Sep 2021 00:30:20 -0700
Received: from dut1171.mv.qlogic.com (unknown [10.112.88.18])
 by maili.marvell.com (Postfix) with ESMTP id 343C13F70AE;
 Wed,  8 Sep 2021 00:30:20 -0700 (PDT)
Received: from dut1171.mv.qlogic.com (localhost [127.0.0.1])
 by dut1171.mv.qlogic.com (8.14.7/8.14.7) with ESMTP id 1887UKFH010154;
 Wed, 8 Sep 2021 00:30:20 -0700
Received: (from root@localhost)
 by dut1171.mv.qlogic.com (8.14.7/8.14.7/Submit) id 1887UKUj010153;
 Wed, 8 Sep 2021 00:30:20 -0700
From: Nilesh Javali <njavali@marvell.com>
To: <martin.petersen@oracle.com>, <linux-nvme@lists.infradead.org>
CC: <linux-scsi@vger.kernel.org>, <GR-QLogic-Storage-Upstream@marvell.com>,
 <djeffery@redhat.com>, <loberman@redhat.com>
Subject: [PATCH 09/10] qla2xxx: Fix use after free in eh_abort path
Date: Wed, 8 Sep 2021 00:28:45 -0700
Message-ID: <20210908072846.10011-10-njavali@marvell.com>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20210908072846.10011-1-njavali@marvell.com>
References: <20210908072846.10011-1-njavali@marvell.com>
MIME-Version: 1.0
X-Proofpoint-GUID: FTmLUtrwRpHqzgv5uHB0oGINzBr5JCkx
X-Proofpoint-ORIG-GUID: FTmLUtrwRpHqzgv5uHB0oGINzBr5JCkx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-08_02,2021-09-07_02,2020-04-07_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210908_003024_503773_E37615A7 
X-CRM114-Status: GOOD (  13.37  )
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

From: Quinn Tran <qutran@marvell.com>

In eh_abort path, driver prematurely exit the call to upper layer.
This patch would check for command is aborted / completed by FW
before exiting the call.

9 [ffff8b1ebf803c00] page_fault at ffffffffb0389778
  [exception RIP: qla2x00_status_entry+0x48d]
  RIP: ffffffffc04fa62d  RSP: ffff8b1ebf803cb0  RFLAGS: 00010082
  RAX: 00000000ffffffff  RBX: 00000000000e0000  RCX: 0000000000000000
  RDX: 0000000000000000  RSI: 00000000000013d8  RDI: fffff3253db78440
  RBP: ffff8b1ebf803dd0   R8: ffff8b1ebcd9b0c0   R9: 0000000000000000
  R10: ffff8b1e38a30808  R11: 0000000000001000  R12: 00000000000003e9
  R13: 0000000000000000  R14: ffff8b1ebcd9d740  R15: 0000000000000028
  ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
10 [ffff8b1ebf803cb0] enqueue_entity at ffffffffafce708f
11 [ffff8b1ebf803d00] enqueue_task_fair at ffffffffafce7b88
12 [ffff8b1ebf803dd8] qla24xx_process_response_queue at ffffffffc04fc9a6
[qla2xxx]
13 [ffff8b1ebf803e78] qla24xx_msix_rsp_q at ffffffffc04ff01b [qla2xxx]
14 [ffff8b1ebf803eb0] __handle_irq_event_percpu at ffffffffafd50714

Fixes: f45bca8c5052 ("scsi: qla2xxx: Fix double scsi_done for abort path")
Signed-off-by: David Jeffery <djeffery@redhat.com>
Signed-off-by: Laurence Oberman <loberman@redhat.com>
Signed-off-by: Quinn Tran <qutran@marvell.com>
Signed-off-by: Nilesh Javali <njavali@marvell.com>
---
 drivers/scsi/qla2xxx/qla_os.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index 0454f79a8047..0f3048723965 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -1258,6 +1258,7 @@ qla2xxx_eh_abort(struct scsi_cmnd *cmd)
 	uint32_t ratov_j;
 	struct qla_qpair *qpair;
 	unsigned long flags;
+	int fast_fail_status = SUCCESS;
 
 	if (qla2x00_isp_reg_stat(ha)) {
 		ql_log(ql_log_info, vha, 0x8042,
@@ -1266,9 +1267,10 @@ qla2xxx_eh_abort(struct scsi_cmnd *cmd)
 		return FAILED;
 	}
 
+	/* Save any FAST_IO_FAIL value to return later if abort succeeds */
 	ret = fc_block_scsi_eh(cmd);
 	if (ret != 0)
-		return ret;
+		fast_fail_status = ret;
 
 	sp = scsi_cmd_priv(cmd);
 	qpair = sp->qpair;
@@ -1276,7 +1278,7 @@ qla2xxx_eh_abort(struct scsi_cmnd *cmd)
 	vha->cmd_timeout_cnt++;
 
 	if ((sp->fcport && sp->fcport->deleted) || !qpair)
-		return SUCCESS;
+		return fast_fail_status != SUCCESS ? fast_fail_status : FAILED;
 
 	spin_lock_irqsave(qpair->qp_lock_ptr, flags);
 	sp->comp = &comp;
@@ -1311,7 +1313,7 @@ qla2xxx_eh_abort(struct scsi_cmnd *cmd)
 			    __func__, ha->r_a_tov/10);
 			ret = FAILED;
 		} else {
-			ret = SUCCESS;
+			ret = fast_fail_status;
 		}
 		break;
 	default:
-- 
2.19.0.rc0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

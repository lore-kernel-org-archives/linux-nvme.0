Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8175C43458
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Jul 2026 11:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ChkAh3gaywzJXImQmQOWd1t1cE3zaSyeQwaizlxDvlw=; b=skpGaoGOxhoe/k4Sz0Etlx95sE
	vrsRhjEoHRmmOZhI9r7JmD0zDxrW51U7PYB1xBiRqdV+wbMrj/mHW+YmA5t+tgq9gDT3dXSrGsKFv
	ntIlGbQlkGBnYbcJAwThfdqPak0AmXS3jt61FynJmpq9mCyMOlaOdp0cVlVQ7ozUIngFhE+HSYV+Y
	iw4v/T6vumHWHXYEDcxIG7y2uW0TZ2Wo08Q/MMnWmD8r8rPEu97qisym6hhn48rgxplUmwGkxbIbF
	XSdtLZPfxqLgLPqvLKXqrkJA4kB27TBgCjlb0OAAto0sY5pVrH/IAdDGbwGi9hJCHRPON1My37SsO
	SWWxGHUA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjFG9-000000094r1-22JG;
	Mon, 13 Jul 2026 11:55:41 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjFG6-000000094ld-1tkO
	for linux-nvme@lists.infradead.org;
	Mon, 13 Jul 2026 11:55:40 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66D6fk671740418;
	Mon, 13 Jul 2026 11:55:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=ChkAh3gaywzJXImQm
	QOWd1t1cE3zaSyeQwaizlxDvlw=; b=N5dPoXIWtRs1KGWdz/DPeCJ4l3nQJHWrR
	y9XoCvs0DjfaFhSkP/DvUB2NkEBpbYWT/AV/07fYsOVNXyx36UvNVlnuBRlHG1DA
	zT899NxjVfflttMxdkNVxSpK0qivTLLfJC7fuFynNt0NzR/TTxxf2UtVV5Ef8XKT
	+ZZfQpjDtRyJf7MKqqF6mws7h581rFb936WK7aBMiZD3aOaf8N9zC5eZhpzOrdU0
	V0H6xUhkkufVMstGlNz8KcnWLo0O7ru3NtRRpkQGvN/63YBU9bI7F6nqTfwg7lQ/
	7LhuA6jgqHyCIT0wFFkwOd3ZPpug6IZS3c8LnQWd6qfvEAmowmx8w==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbegt0fbp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 11:55:30 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66DBnatJ023611;
	Mon, 13 Jul 2026 11:55:29 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fc1nh5cwt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 11:55:29 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66DBtP1A56820086
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Jul 2026 11:55:25 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3321F2004D;
	Mon, 13 Jul 2026 11:55:25 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5BB8F20040;
	Mon, 13 Jul 2026 11:55:23 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.bl1-in.ibm.com (unknown [9.123.7.57])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 13 Jul 2026 11:55:23 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: hch@lst.de, elver@google.com, kbusch@kernel.org, sagi@grimberg.me,
        axboe@fb.com, bvanassche@acm.org, gjoyce@linux.ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH v4 13/20] nvme: add context annotations for nvme_subsystems_lock
Date: Mon, 13 Jul 2026 17:24:14 +0530
Message-ID: <20260713115444.465704-14-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260713115444.465704-1-nilay@linux.ibm.com>
References: <20260713115444.465704-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: i6BWqseZdvXsjF5OyEStSp8ePD9-S3By
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDEyMiBTYWx0ZWRfXx44yqvTJsyQa
 yzVQssw3+eDOH8GL3YIbd4nlzk/5Mak00CZPrD4BFs9BENBPYCXiJtxkCpiTpY/0X9nxiwvN3VY
 OOaF2SYVkGGffYlLok1umscP2+HPN68=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDEyMiBTYWx0ZWRfX6T1KnuvSTR5g
 mvE59+m0UyG8DNHJobo6SxSZV8Ap6rBEJd1deZIM+BDNg8NcRNmlybcY6nkL1whCFzBKtOOK1qB
 u4fNkQ5cHDlF5Y7JJ7C3+1VyGl26LOtfKNGBEMUVIDHnoxQJOqFp8SxA5DbIo4yb5hsi4x7XZm9
 jMghQ6hS80rtJXwXPTuVC9+OQYCUp4NvsY2wh2lE9ur0dMe6OirLyI2FNmcIIYHOGtkCA0CEoOD
 +rhftSOwJImgOJc4oMUUxkmMMLZwULMf58647sa5nv1cQqP0SeMJMZhTWAPRhWgSA3iwsARE3xu
 e7h104M9+f4FMQ2OstG9iHF9/fOjDSiUkqhmB9YMgdyA3S7sO0umlGjMrgMLbmMQqe404KjQ6EY
 VlUjOkpEy28Hul7ECETY5gdTLNLRt6QgQlyTqNYDWy9sChtt29geDOAah5YwL4WD0e4hqA+1fTU
 kASzhxQpl17gLVGhcWA==
X-Authority-Analysis: v=2.4 cv=IqMutr/g c=1 sm=1 tr=0 ts=6a54d232 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=ey47_XiNFC_5WBcqlPkA:9
X-Proofpoint-GUID: JwurJhM-YsHSMAGDzBbiGAudLrkREORx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0
 phishscore=0 suspectscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130122
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260713_045538_795037_49BD2975 
X-CRM114-Status: GOOD (  14.04  )
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

The global nvme_subsystems list, nvme_subsystem::entry,
nvme_subsystem::ctrls, and nvme_ctrl::subsys_entry are protected by
nvme_subsystems_lock. Annotate these objects with
__guarded_by(&nvme_subsystems_lock) so that Clang's context analysis
can validate accesses to them.

__nvme_find_get_subsystem() and nvme_validate_cntlid() traverse the
global subsystem list and subsystem controller list and therefore
require callers to hold nvme_subsystems_lock. Annotate both helpers
with __must_hold(&nvme_subsystems_lock).

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/host/core.c | 4 +++-
 drivers/nvme/host/nvme.h | 9 ++++++---
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f7a4cdb988f1..26bca14e7d81 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -126,8 +126,8 @@ EXPORT_SYMBOL_GPL(nvme_reset_wq);
 struct workqueue_struct *nvme_delete_wq;
 EXPORT_SYMBOL_GPL(nvme_delete_wq);
 
-static LIST_HEAD(nvme_subsystems);
 DEFINE_MUTEX(nvme_subsystems_lock);
+static LIST_HEAD_GUARDED(nvme_subsystems, nvme_subsystems_lock);
 
 static DEFINE_IDA(nvme_instance_ida);
 static dev_t nvme_ctrl_base_chr_devt;
@@ -3200,6 +3200,7 @@ static void nvme_put_subsystem(struct nvme_subsystem *subsys)
 }
 
 static struct nvme_subsystem *__nvme_find_get_subsystem(const char *subsysnqn)
+	__must_hold(&nvme_subsystems_lock)
 {
 	struct nvme_subsystem *subsys;
 
@@ -3244,6 +3245,7 @@ static inline bool nvme_is_io_ctrl(struct nvme_ctrl *ctrl)
 
 static bool nvme_validate_cntlid(struct nvme_subsystem *subsys,
 		struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
+	__must_hold(&nvme_subsystems_lock)
 {
 	struct nvme_ctrl *tmp;
 
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 602d567f3def..607fa9664272 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -361,7 +361,8 @@ struct nvme_ctrl {
 	wait_queue_head_t state_wq;
 
 	struct nvme_subsystem *subsys;
-	struct list_head subsys_entry;
+	struct list_head subsys_entry
+		__guarded_by(&nvme_subsystems_lock);
 
 	struct opal_dev *opal_dev;
 
@@ -493,9 +494,11 @@ struct nvme_subsystem {
 	 * a separate refcount.
 	 */
 	struct kref		ref;
-	struct list_head	entry;
+	struct list_head	entry
+		__guarded_by(&nvme_subsystems_lock);
 	struct mutex		lock;
-	struct list_head	ctrls;
+	struct list_head	ctrls
+		__guarded_by(&nvme_subsystems_lock);
 	struct list_head	nsheads
 		__guarded_by(&lock);
 	char			subnqn[NVMF_NQN_SIZE];
-- 
2.53.0



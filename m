Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4672ACD98DE
	for <linux-nvme@archiver.kernel.org>; Sun, 14 Jun 2026 13:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=f6Zu8l03fl9GgwQNye7HsEqsBMablBLNtGsWRuC89LM=; b=af1ooQCKNB5sZQ+i42KSymPCOi
	ajJ/zDxupSRkN9ifzj1EuN4JXqS1txdWH6frGpeT0sBGWYH/nGz0JTwwqHFok0uuqSmObeAnlY9zM
	NOk+x4VpkKBBPSInwI6Uc8m0IY41aouamh8kx4yVEmkdhochZTOFrI/2jgvcTqN4k18sODiV1ORBe
	EIIHCchSnHNj+eRfYwhwQyTc7Z4qhtahiOCSEEdOrLQ6tRZTtwzS6ZiQxDPkvr1+fTvx0rvjylRIb
	OBGdY4Yabk19aMRcTvXJAqQTLPJVtwupxypDjGDR+1z4Ct/uyKVEPLhlcKdzVXt+DRlejJaMPxwXx
	JyiJdKYg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wYkhL-0000000D0m5-3syb;
	Sun, 14 Jun 2026 13:16:23 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wYkhG-0000000D0lQ-0hDf
	for linux-nvme@lists.infradead.org;
	Sun, 14 Jun 2026 13:16:19 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65ECnaCj3542648;
	Sun, 14 Jun 2026 13:15:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=f6Zu8l03fl9GgwQNy
	e7HsEqsBMablBLNtGsWRuC89LM=; b=DGvDeE+vy6QBurX8wNcNKIIoFI67da/so
	1hOGHCoEYwKfRLUEhoKiy3s3Hb6WHhdb4iJFwdKFya26L5QDUYOYtNapaLW/FgVW
	CiE3hmYZjKAtQQZWY7VDsJCsr1bsOF323GMSghTCFRHQtRkcxZ9plLXSJkGb9I1L
	CPkPBqMkd8qN0jxcuxICkksaWzxSEnF+rOA8BXZL5BSQETjFG4WFdbr1O2feQdhs
	cZd6y/0b6dX1dt44z79iX+1ckDQGMD5X1ZXCwrzF+SduEuWY/XnN/lBonoxNj2hI
	aSAN2yjOzYiTk9Ne6xzt38WFcElzGEbZNkJSWQsAGXQblZV8UA1Pw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4es1efuby6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 14 Jun 2026 13:15:57 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65ED4bkh008939;
	Sun, 14 Jun 2026 13:15:57 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4eshhpstfr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 14 Jun 2026 13:15:56 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65EDFrDq52822296
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 14 Jun 2026 13:15:53 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 92DC320043;
	Sun, 14 Jun 2026 13:15:53 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0A46920040;
	Sun, 14 Jun 2026 13:15:51 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.43.80.1])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 14 Jun 2026 13:15:50 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com,
        bvanassche@acm.org, elver@google.com, gjoyce@linux.ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCHv2 01/17] nvme: update nvme_passthru_end() signature
Date: Sun, 14 Jun 2026 18:45:16 +0530
Message-ID: <20260614131541.2017845-2-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260614131541.2017845-1-nilay@linux.ibm.com>
References: <20260614131541.2017845-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE0MDEzMCBTYWx0ZWRfX2VWhB2yKb6cx
 6eBYuoTCYGW7q3MumwMLlHVBgkxn2mPFi4grcpfdrGnVkjHRr3iK5ueVCIUfM1j30NRqvDdd4jI
 AXNPGOpBedNLY5mnB+yqqn+hufMvtB8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE0MDEzMCBTYWx0ZWRfX7xQrUP0SGRwx
 OFmiLXLuqPF8R6o7Rk8bnoqdGpSYreXYyDwb5IGZAbstcydZ8Br+FtG0RrS6vFfLg1rA6GxXriv
 MN9eHaK1K4XzHuFmbonaeOlDmOvYfkciotYj4xo3f+1GYSVX5YouOll42Aapv/2mPuyFNL1KOib
 xATqzxG30N9a/ryjEJbgPO8dJ+b63fxqcWcooWKJ8wORqkt68wDdwtTXYdZ5wemRR4GQtbcW/Hy
 EtodslW4uYmlZ3SAyQ588FpxR+Q8tb7eiuoW21WYaWOSX+wxlICpbs3AiDP7Ppxp+Ourez5ulPj
 OirgA0BV3zZmXnYZC/L0iBZJ6ombKdmnLgajxHjJ+wFqM9piXq8aUAN3bNa48W59ka7Oo7Ciwff
 UvlGW4wdJwRmzKyDhB2XzPEszlyH/i5YnSG99fCYY9fDhrwh+A2H0VK6nliyHrqMQTAlQYYFvHp
 PiL5eUWeIfTrUotzw7A==
X-Proofpoint-GUID: 8dt_HOLqgCdvF2EVHdRHzIynauj2UD00
X-Authority-Analysis: v=2.4 cv=NuDhtcdJ c=1 sm=1 tr=0 ts=6a2ea98e cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=SiEiA-kSKP9ZIulfK2kA:9
X-Proofpoint-ORIG-GUID: Xv0leRDhSsABjcT_Cax4t___k8uilPnF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-14_03,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 suspectscore=0 impostorscore=0 clxscore=1015
 phishscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606140130
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260614_061618_363623_D81D5130 
X-CRM114-Status: GOOD (  14.65  )
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

Change nvme_passthru_end() to return the command effects value passed
to it.

This is a preparatory change for Clang's context/thread-safety analysis
support. The conditional release annotations (__cond_releases()) model
lock release based on a function's return value. Returning the existing
effects value allows a subsequent patch to annotate nvme_passthru_end()
as conditionally releasing locks acquired by nvme_passthru_start().

No functional change intended.

A follow-up patch will add the corresponding context analysis
annotations.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/host/core.c | 6 ++++--
 drivers/nvme/host/nvme.h | 2 +-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index c3032d6ad6b1..d6153c3e0007 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1257,7 +1257,7 @@ u32 nvme_passthru_start(struct nvme_ctrl *ctrl, struct nvme_ns *ns, u8 opcode)
 }
 EXPORT_SYMBOL_NS_GPL(nvme_passthru_start, "NVME_TARGET_PASSTHRU");
 
-void nvme_passthru_end(struct nvme_ctrl *ctrl, struct nvme_ns *ns, u32 effects,
+u32 nvme_passthru_end(struct nvme_ctrl *ctrl, struct nvme_ns *ns, u32 effects,
 		       struct nvme_command *cmd, int status)
 {
 	if (effects & NVME_CMD_EFFECTS_CSE_MASK) {
@@ -1278,7 +1278,7 @@ void nvme_passthru_end(struct nvme_ctrl *ctrl, struct nvme_ns *ns, u32 effects,
 		flush_work(&ctrl->scan_work);
 	}
 	if (ns)
-		return;
+		return effects;
 
 	switch (cmd->common.opcode) {
 	case nvme_admin_set_features:
@@ -1299,6 +1299,8 @@ void nvme_passthru_end(struct nvme_ctrl *ctrl, struct nvme_ns *ns, u32 effects,
 	default:
 		break;
 	}
+
+	return effects;
 }
 EXPORT_SYMBOL_NS_GPL(nvme_passthru_end, "NVME_TARGET_PASSTHRU");
 
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index ccd5e05dac98..aa42f5a9d1fa 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -1274,7 +1274,7 @@ u32 nvme_command_effects(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 			 u8 opcode);
 u32 nvme_passthru_start(struct nvme_ctrl *ctrl, struct nvme_ns *ns, u8 opcode);
 int nvme_execute_rq(struct request *rq, bool at_head);
-void nvme_passthru_end(struct nvme_ctrl *ctrl, struct nvme_ns *ns, u32 effects,
+u32 nvme_passthru_end(struct nvme_ctrl *ctrl, struct nvme_ns *ns, u32 effects,
 		       struct nvme_command *cmd, int status);
 struct nvme_ctrl *nvme_ctrl_from_file(struct file *file);
 struct nvme_ns *nvme_find_get_ns(struct nvme_ctrl *ctrl, unsigned nsid);
-- 
2.53.0



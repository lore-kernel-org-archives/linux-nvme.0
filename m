Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5496C44501
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Jul 2026 11:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QakmAYygB0U9BE+3qkUyBXTW78Hm6uwh3yDd4Bo9AuM=; b=l7adDInQ7uUUJX3ThReKdGjzHo
	a6Wso+ULGVqAPcE5fBJevPWPxeA4B9a7YI5IORnhhSvkIRaHj4O6JIQ23ovRuJQXCm6W52voO4QTi
	lZVDvR3t/K3CSn2RqYvXKRpqW4HshSMGamh5gHZpQquYHdD1u/ycWqeg67+m1w6s/vpovpvZY7Xog
	2ujh/kYthfDR/t52tH8VD/hFPFZTuPn3Twfy5duOUPF3e+oXIsCW+C5ORcafHVxxPw/MmHYsGlc1S
	XefNUFxT9X48Ez76G9PpjPsAtuA7vbUEGlxMG4UmAqzVBOO5/G+5Oys6Z3xBElKfieDM9UmI/1TmX
	KtSuD26w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjFFt-000000094UZ-2ZFr;
	Mon, 13 Jul 2026 11:55:25 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjFFn-000000094Pr-3AAF
	for linux-nvme@lists.infradead.org;
	Mon, 13 Jul 2026 11:55:22 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66D6gWrO1728555;
	Mon, 13 Jul 2026 11:55:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=QakmAYygB0U9BE+3q
	kUyBXTW78Hm6uwh3yDd4Bo9AuM=; b=fAeG+shbB8tTdXb8pYeIirAS2sPVJ2zbF
	KPEUatNZH7r5Jh7xOA0drej3iRa6ygdT71OB3+G6j4I9YMNTApXsq8umPAsvaOLj
	TCUNTCDC+ikYIGK80HEjw9h7jWom4XElUsS8c9iVBZ7HUO1fvaIqyiwaq5cWxvsW
	JrayfrcY1jPzr5q3h74Rwqdsa1uBGcAn+irbjrc3vySc3MlCWQz0oW+B8LPaza8b
	/xI17gaRhLNNUwDWhRTjAxDDRMbAVrzh24PNppY7OQWycvFs3W6ACheY4j6IA4m+
	ep6d+Rb2PxKsUvKT4UPM2Bl4qbXG48unV5x6ANoxzuzNj2TyZ9KNg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbepx8dcr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 11:55:09 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66DBne8S023628;
	Mon, 13 Jul 2026 11:55:08 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fc1nh5cvh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 11:55:07 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66DBt37H57934138
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Jul 2026 11:55:04 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D961E2004B;
	Mon, 13 Jul 2026 11:55:03 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1AC9F20040;
	Mon, 13 Jul 2026 11:55:02 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.bl1-in.ibm.com (unknown [9.123.7.57])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 13 Jul 2026 11:55:01 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: hch@lst.de, elver@google.com, kbusch@kernel.org, sagi@grimberg.me,
        axboe@fb.com, bvanassche@acm.org, gjoyce@linux.ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH v4 03/20] nvme: update nvme_passthru_end() signature
Date: Mon, 13 Jul 2026 17:24:04 +0530
Message-ID: <20260713115444.465704-4-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260713115444.465704-1-nilay@linux.ibm.com>
References: <20260713115444.465704-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: cPv2Eno8wz7eORVtW1E1OF_JY3XZs7hS
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDEyMiBTYWx0ZWRfX4qpjfouRQ5zl
 2s73uVAR7A3hovVbw7kY3dUPKiUr20AXxLBFdozoJfXizYr1LGhLn3V8pPQnWH97HXJK6biV/Wk
 JlppAAQOuqMDeQqUDaFZwliK6BlfDw0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDEyMiBTYWx0ZWRfXyRtV6A+vE95x
 uWV8gqsaenNqUNANrJt1DuzZl+4+SGUUlu2GfP2a1cb0ce0el7b74YVRXhh6Heztj6L+/9ml+J5
 /Q0xOPvVUl+lsDdHR+8zCznOG5eAx6k6x8oddXhuy/0Tdw7c0t1zoXBrPvfOUCP+7I5lxIWTEn0
 tH26zPTAl2VCKQPpvB07oG9ijkjsiZLxU2OZXW2oq7xIPMIeyD5xtnp4WvJBxF8+8G+61xwEbWC
 mayUbcQtBYeJdMUQC2tMQ6e8uIC6DNWRrfsZy6+CLat+4rDjiBUegVlEVsto+UwTJUBZrBx+5w3
 iuJV5qlqOwphMBpYYnc2HCZUgXWZCGBu5ULZQGn6UwQv/zJwxoOXhc8tIozwfWyfkLVGn0DaMQb
 bWqNPqpnlW2ckA6I3v/FU4Zp1C8qGgxoMQQXprpMdHu94N7Mp399p38Kg6EzjjyQcGT1aEhuPeP
 zHTA16zomznYk8/34aQ==
X-Authority-Analysis: v=2.4 cv=XbS5Co55 c=1 sm=1 tr=0 ts=6a54d21d cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=SiEiA-kSKP9ZIulfK2kA:9
X-Proofpoint-ORIG-GUID: QbetWT8_2HwMVd0I9wPlGF391Uql1V0y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130122
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260713_045519_801342_65ABCC2A 
X-CRM114-Status: GOOD (  16.60  )
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

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/host/core.c | 6 ++++--
 drivers/nvme/host/nvme.h | 2 +-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 453c1f0b2dd0..d6a095e1e44e 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1268,7 +1268,7 @@ u32 nvme_passthru_start(struct nvme_ctrl *ctrl, struct nvme_ns *ns, u8 opcode)
 }
 EXPORT_SYMBOL_NS_GPL(nvme_passthru_start, "NVME_TARGET_PASSTHRU");
 
-void nvme_passthru_end(struct nvme_ctrl *ctrl, struct nvme_ns *ns, u32 effects,
+u32 nvme_passthru_end(struct nvme_ctrl *ctrl, struct nvme_ns *ns, u32 effects,
 		       struct nvme_command *cmd, int status)
 {
 	if (effects & NVME_CMD_EFFECTS_CSE_MASK) {
@@ -1289,7 +1289,7 @@ void nvme_passthru_end(struct nvme_ctrl *ctrl, struct nvme_ns *ns, u32 effects,
 		flush_work(&ctrl->scan_work);
 	}
 	if (ns)
-		return;
+		return effects;
 
 	switch (cmd->common.opcode) {
 	case nvme_admin_set_features:
@@ -1310,6 +1310,8 @@ void nvme_passthru_end(struct nvme_ctrl *ctrl, struct nvme_ns *ns, u32 effects,
 	default:
 		break;
 	}
+
+	return effects;
 }
 EXPORT_SYMBOL_NS_GPL(nvme_passthru_end, "NVME_TARGET_PASSTHRU");
 
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 824651cc898d..0797c3a6a9c1 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -1292,7 +1292,7 @@ u32 nvme_command_effects(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
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



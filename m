Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95A8BC44509
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Jul 2026 11:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8+M7RExt2GjfkCztuhQCS86rc+iABZUktjOmqv/Izig=; b=1V1FlHrQep7R6a6VB67Dku9RmG
	uBx9F9k/6vfRPK4p4N5HKuu2M+sdD7cVfNjLIZWix8VWfwHRz5eXmZmuZ2yrkrVYZggmNyWMsjiq2
	cfT2zAIzAnG3H7cswdKfCeIfUB9pIGVcV8JiCFvOESBmggOBaaw74I3Ke44zqKgjWZiK8+9db8//R
	XDuwTb0Z4H5RTdKSeKBZsLphBZFuyRhUwFXwB1A88CuZIQMBW+bUSaRoouj2KXcxBtSOO7Xzcrkk3
	YD9Fo9QtS+fzEn6a4HP4iragY09GMhDdJ+dI0Vuahfc6Ir13C4Zy67rRzgKhqXv5IzWZq413pTs50
	o2ZGZRIg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjFFt-000000094V7-3EwJ;
	Mon, 13 Jul 2026 11:55:25 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjFFn-000000094Or-0mYQ
	for linux-nvme@lists.infradead.org;
	Mon, 13 Jul 2026 11:55:22 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66D6flB71731614;
	Mon, 13 Jul 2026 11:55:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=8+M7RExt2GjfkCztu
	hQCS86rc+iABZUktjOmqv/Izig=; b=Qpn5HlGZrZ/88/mdPM94GmW5bfB9Of4f5
	UcUzAJ0D71RQfpmnWA+rnzWZxDgvxwn6z+IdfIe4dlBX6ydI9uyJADyuUBa1D8HC
	W2n5jT/qoPzY17xwIOXADYGEkhLLmXJAbWaZe3jXcnLDeY91R6zFH64dBoB9dm0h
	aH2vNbYoVkL3DlyelBNnwGxJe8be9c1jFHTWYOzUoMuU2jTOppVi475qgsYREl2H
	67nHIwt9c6DmBFUPS0SGb1RkdLqd/bl4Ny5dXWoHjQrSUeDG5LCPPGcTYUNMnzyF
	OvTR9gEaGq/wyY5Zu5LnWt2HPh32TihqcOj9lcn44qWt8K4tuuxqA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbegbg3yy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 11:55:10 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66DBna27012330;
	Mon, 13 Jul 2026 11:55:10 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fc0hvwk4m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 11:55:10 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66DBt6dk43319648
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Jul 2026 11:55:06 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F2C8D2004B;
	Mon, 13 Jul 2026 11:55:05 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2CDDA20040;
	Mon, 13 Jul 2026 11:55:04 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.bl1-in.ibm.com (unknown [9.123.7.57])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 13 Jul 2026 11:55:03 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: hch@lst.de, elver@google.com, kbusch@kernel.org, sagi@grimberg.me,
        axboe@fb.com, bvanassche@acm.org, gjoyce@linux.ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH v4 04/20] nvme: add context annotations for nvme_passthru_{start|stop}
Date: Mon, 13 Jul 2026 17:24:05 +0530
Message-ID: <20260713115444.465704-5-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260713115444.465704-1-nilay@linux.ibm.com>
References: <20260713115444.465704-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=fOcJG5ae c=1 sm=1 tr=0 ts=6a54d21f cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=7bgEqNGeQr-mGYOCYikA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDEyMiBTYWx0ZWRfX594Zpo8qzJA1
 NHVwUvuwp44u/vEOS1rItGJbQa4XyCzMDoo5br12XC5Y5dvTktH+lXUUMk518tcjzKq6fouUPng
 2yKT0hYuiK/rlouGrs7lzOENrW+sJSPyrqRFQZv2GS2Prwq4Bswb1SAfPoPrvNVPmRPeXhzrqZJ
 i0rGm2GHcZJmOq1dX0dM3BNFUTVzkccbYKGh0j7XC4+sbxuhHLGCMNcw0Qz2PRLKauIMmo2544T
 vdSOrI2uerJS3miMeiFsK6qUajYSC/2h/PJUcKRxM0GZptvsOA4AuIyITf/stsSvcsrVrBi1oia
 voYfQHB+RpEAhR2+kRGw7jqFeYiobspKDUDtfHAIy6/3Yhk9CTE8jNxLscEscQ1xMfx9UpxjrM9
 2KKIceibBxx0I74EVWZIToMV4hM3AKA0AOAXiHwrSVAF83J40G8pcveBHSOsZN8LET2i4Ai1H0G
 HV0oGUkCxcDZSdW7gCA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDEyMiBTYWx0ZWRfX6ZJDYeipiNJ7
 vbzaM0nzy4oCt04Rs4sZSUSSTi8Ck8vN0Eo4q6WpiQ5npqkZs6fWJ0VyaO2bGqjjnOGQJiyzldL
 gRpOwueL5883/qjfSTn3anxuhMRXdDA=
X-Proofpoint-GUID: SiOZ5Jh9bkyAy_Ye9XFxQoE_Lwg1Ad-K
X-Proofpoint-ORIG-GUID: nuTAGwprWG5uwOGFCqnTBEGVCT28Gzzn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607130122
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260713_045519_338858_AFE4AE02 
X-CRM114-Status: GOOD (  14.69  )
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

Annotate nvme_passthru_start() and nvme_passthru_end() for Clang
context/thread-safety analysis.

The __cond_acquires() and __cond_releases() annotations model
conditional lock acquisition and release based on a function's return
value. Use a nonzero return value as the abstract condition denoting
that the associated locks have been acquired or released.

This allows the analyzer to track the lock state across the
nvme_passthru_start() / nvme_passthru_end() pair and verify correct
locking semantics.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/host/nvme.h | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 0797c3a6a9c1..fba2d7674623 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -1290,10 +1290,16 @@ static inline void nvme_auth_revoke_tls_key(struct nvme_ctrl *ctrl) {};
 
 u32 nvme_command_effects(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 			 u8 opcode);
-u32 nvme_passthru_start(struct nvme_ctrl *ctrl, struct nvme_ns *ns, u8 opcode);
+u32 nvme_passthru_start(struct nvme_ctrl *ctrl, struct nvme_ns *ns, u8 opcode)
+	__cond_acquires(nonzero, &ctrl->subsys->lock)
+	__cond_acquires(nonzero, &ctrl->scan_lock);
+
 int nvme_execute_rq(struct request *rq, bool at_head);
 u32 nvme_passthru_end(struct nvme_ctrl *ctrl, struct nvme_ns *ns, u32 effects,
-		       struct nvme_command *cmd, int status);
+		       struct nvme_command *cmd, int status)
+		       __cond_releases(nonzero, &ctrl->scan_lock)
+		       __cond_releases(nonzero, &ctrl->subsys->lock);
+
 struct nvme_ctrl *nvme_ctrl_from_file(struct file *file);
 struct nvme_ns *nvme_find_get_ns(struct nvme_ctrl *ctrl, unsigned nsid);
 bool nvme_get_ns(struct nvme_ns *ns);
-- 
2.53.0



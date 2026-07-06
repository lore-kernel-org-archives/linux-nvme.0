Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1C95C44500
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Jul 2026 14:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QakmAYygB0U9BE+3qkUyBXTW78Hm6uwh3yDd4Bo9AuM=; b=FmorPVIkkzN0RQuWzXWcpz/C6X
	Sn01OPf5Ud+zzrbHMmca14BM7Vi8cFZCVjDYYHu70Futkur8bwTTCKAoBNJiEXSJ4c5jZIsIFFXRw
	8v46F32GBDPZPWOHcpeT4jBP+QId13spI2628JDS0Y2r6q89DmJWssYTFZpdqMuBrAy92S2P0pWpr
	OgBOefOLxS+DTM56axhLlqTOWR4EfCm0LMa6b1M2GIUH91N+j+g6TjxAvSmoRE3zHIXwgGn4EaVS+
	MBlTPgGX9PTqo7yWDWiZEIA97U4y8mhIZBYmQ8Difa610QNA9Gts+aokDiWKxmlhfhLE9x/A06sba
	0BGehd4Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wgk6r-0000000Chmn-3pEQ;
	Mon, 06 Jul 2026 14:15:45 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wgk6p-0000000ChmB-2sog
	for linux-nvme@lists.infradead.org;
	Mon, 06 Jul 2026 14:15:44 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666BJkfE3467894;
	Mon, 6 Jul 2026 14:15:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=QakmAYygB0U9BE+3q
	kUyBXTW78Hm6uwh3yDd4Bo9AuM=; b=NqlleUJA4F1TDCo9T5MJtZcw/JTeQD7l9
	M31rqZrnTJVLJiQbnhVBlC/XMdiSckudhTOt6TGZHTdWJyFzFs0rF9WQPnujkRp8
	wk3sv6u79QFFw+LwFbTYwApVx/RFP+3TNjhkyETx6JYJIWMfTY6yb5WDrES1OxVv
	lzqeHGIc37pxmUTBFd5NQCuMI3AeobxpNRu2mOCbMzagle1xpVBYYZAmsIA7rOT3
	b2bG2SroHDnPFfKcg4VwkRn+pQznZuc+IIOHyQaXigLrj21+Je7ZBVL7DhKKqbuX
	5JYPFQ0R/dtjyTNejf9Of77KBTGYrIVxXEdz1mrLS7J8GLDdC4O+A==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6rkdjevv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 14:15:31 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 666E4bIm015284;
	Mon, 6 Jul 2026 14:15:31 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7eqfwp7x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 14:15:30 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 666EFR3l61014446
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 6 Jul 2026 14:15:27 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3CDAD20043;
	Mon,  6 Jul 2026 14:15:27 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0D0C320040;
	Mon,  6 Jul 2026 14:15:25 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.bl1-in.ibm.com (unknown [9.123.7.57])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  6 Jul 2026 14:15:24 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: hch@lst.de, elver@google.com, kbusch@kernel.org, sagi@grimberg.me,
        axboe@fb.com, bvanassche@acm.org, gjoyce@linux.ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH v3 01/18] nvme: update nvme_passthru_end() signature
Date: Mon,  6 Jul 2026 19:44:03 +0530
Message-ID: <20260706141452.3008233-2-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260706141452.3008233-1-nilay@linux.ibm.com>
References: <20260706141452.3008233-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=M7J97Sws c=1 sm=1 tr=0 ts=6a4bb884 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=SiEiA-kSKP9ZIulfK2kA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE0MSBTYWx0ZWRfXxgUKYvTEhDni
 pwglWwCpRyuiSzba0r+avvJn+L9BZa5fQNQFGfuH+I4Ab0wZdB6o6cPm2iwWTxk7PkSdfYa0aJd
 k5C5lHPYPHh8pZ7Toc6Oo9mC1IaCO5Yiq8iLEx1G+0ZPcLXQE8DlSJyLLKu0dqK06jy0tzFInn3
 RekAdV2Ic0ZbUIw2W87As7SzPi8PIig0nmDDywWh27NDL8d0kS/eclijKpSbP/xHxzTWhdACHNx
 0iZLOPoMrrTDgi+9gwPX0+tUtM1+lejTLr2fw++7G2OhLdoCn6nbDtMRofWhzu1yLN3eIRSo66p
 e6dRwqhPVjk1cZmVARLLgyFrgscBJBy4PCntQa+iG3oQAWwFdajVoXKdOQzFMUrZm2KCD+aef0N
 ExsFPconIKoVdxpMlQDjU5i5TsEKA+kLCfe4qYcOh5GXk6VErBFdxhUIF3Ohgb0CaXxetYE9yVW
 o/6iykf8yDPAWlU6cWg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE0MSBTYWx0ZWRfX0ZZjXTi2NpAK
 UJB/WBymimAnX2/WGQQr4hPo6UOQaPmkjrV8vwawBFUaa6yJQvev2yhSj95gTNtvroT8/4xULmp
 l7XRZd5BZTLzLuMy1goWOA8XvvZarxY=
X-Proofpoint-GUID: wYMLvYovf7dyWGhQzNmq52vJqunITKbF
X-Proofpoint-ORIG-GUID: 4KHvXefuZ4-E6_V61cf4fSv6tvG7wNra
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015 adultscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060141
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260706_071543_846081_8DF1230F 
X-CRM114-Status: GOOD (  17.04  )
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



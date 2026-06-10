Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF6A0CD8CB9
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Jun 2026 14:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=f6Zu8l03fl9GgwQNye7HsEqsBMablBLNtGsWRuC89LM=; b=d4G6p0IJMJkhV8Q28amn86a0FX
	NPW4P62FsJ1e1BRZOIFG0ge+s5NWgkBPGfXgubxUPp+dVZeJ7m4r0si7KVSJKtulmqiTQ6XG3VZAg
	9FYmKihwYumLxGjmjmo4NJ8q6rjJ/edzA19FErpmMHu828I+x+XuVqi8TPLXdvF4JO0X7Ho+mZXxz
	SNROrMqEXKo0D/0Yo0E63Mcj66J52twtXttGeVr0Oz/w63nRG5ISNm1MBCdiDUNRsX3pKyp4uPMvY
	3hLrJG606FWxbACW2dnyjtl7qLl2wtYDoSbfw+zOd0OCbWigcgjUI2LPYTwoWUIP9t6VZJYU705Hz
	p1YoPgWg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXJux-00000007sVg-3dGb;
	Wed, 10 Jun 2026 14:28:31 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXJuu-00000007sTd-1E91
	for linux-nvme@lists.infradead.org;
	Wed, 10 Jun 2026 14:28:29 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65A55HXG3408398;
	Wed, 10 Jun 2026 14:28:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=f6Zu8l03fl9GgwQNy
	e7HsEqsBMablBLNtGsWRuC89LM=; b=SSafE4QauU2lLEtG1SO3+KYfxJW3lW++/
	jeQP8tjXtyqTUp6hgZyRfHftGwSFWZoWM8TUZLtltDVWQuRQqAcBpGqAWyNUJX+7
	In63o+MfTfG1NckFVxqvSQ90ul2yZzHWSEbJoASUtXA0UDUYbqMY482mJVkkut2Q
	bX+GGjGTaZYBdeyQXBu2kF+c+GFKsA1anpfov0Y0BzieXHqj5HBghsmrWA2Qvd0Y
	L8zXoVh2PgKXB0cYbG/+uAlldRqSMabc1ZT0eyVSHMNMLl/2PUm/BwhlXb2cPgX1
	czYafn5pbBLKP0JsL5XNv7TSBXSSTSCUZl9OTIiD2B75TcDzhG5aw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4em8yj1bh0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jun 2026 14:28:14 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65AEJvqj011389;
	Wed, 10 Jun 2026 14:28:14 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4en0jyeruw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jun 2026 14:28:14 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65AESAKG47513894
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jun 2026 14:28:10 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 84C5720049;
	Wed, 10 Jun 2026 14:28:10 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3379920040;
	Wed, 10 Jun 2026 14:28:08 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.43.34.89])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 10 Jun 2026 14:28:07 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com,
        bvanassche@acm.org, elver@google.com, gjoyce@linux.ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH 01/15] nvme: update nvme_passthru_end() signature
Date: Wed, 10 Jun 2026 19:57:21 +0530
Message-ID: <20260610142743.115898-2-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260610142743.115898-1-nilay@linux.ibm.com>
References: <20260610142743.115898-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDEzNSBTYWx0ZWRfX2EdrYyRyYNsT
 iSVzBYney/OUIZ6pl+EgSgl5yeHP+KXt9hBcHHQMQou7jcSWzn5OIFPYunxcHe6jIcBjPcs26LC
 pJRxMHex48vuI+q2WeWSr1NbWRuxmv+H709sY34mPu7oVo8nzjxiHY0qgp5e418vvVeOJG6CYc+
 6gU3XloN6A/eRN2DdNG1esgt6lMGX3qlEM3W2IJx+2R27mHbFV+gUi7PziM1H/hguLrmba/kbIO
 4fjqjQzYGCQuGshqy5BjAblsfRsc3sUnmewoCvwNSC/QyryMMD9VFDSLyJwaySW19UI0fm/pvfS
 nC/BEPm7St882Bb2lxugQ9OZ/nAjZfAZ1YC+i89OklFoMziGYnx5F6XHaHu3T6Bcytr8livfmvR
 I3BmO8QkLbUtgd+iAdcqzSKaLwiaSusXf5+Owmf6bSNg5+ERKSgzctR416Mk++r8LGkqCzJ1GML
 Jc+s0ua7jSVQjkY8VLQ==
X-Authority-Analysis: v=2.4 cv=HvFG3UTS c=1 sm=1 tr=0 ts=6a29747f cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=SiEiA-kSKP9ZIulfK2kA:9
X-Proofpoint-ORIG-GUID: gSH8RCKGM0h5HRzLKMLAjxXHwyUj4f8g
X-Proofpoint-GUID: w1wLMyirtBoPwYtiMnCuX3G3vr5hu7dz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_03,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 phishscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606100135
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260610_072828_452868_0B83A48A 
X-CRM114-Status: GOOD (  15.44  )
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



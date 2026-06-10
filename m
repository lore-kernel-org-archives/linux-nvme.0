Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92739CD98CE
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Jun 2026 14:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vVgWwwwwQBl//+r12iJqW6fsOgS/+0BAvJaPWxQz8Iw=; b=aQZiL1kjEgKKCqVK9qAKHWGr8r
	O4ijxo14H/hP5ihjde2MZi5w3DFd7kCoGFiQoeyfWHX+D4NrpqOuQ+LMnSRCG17gnAVfvLgCsDTYK
	3BsJw2WBYrq2jaLimSBc3D4XN9lp23BnKtL4epVRaNzoH4uTZ7ssbfhEPWRrtW41RdFAwPfyLJefE
	O+D+J9pSRmmRzHtPc4LO2IJHSMoVG3xmlJMED6m4Ec18A/OK/BG8h8IuxL12kFNF/6EJ18/333P9w
	hT8wAzzI5Zom1Ye2UNiQn9BD9wMTM+EyNkYO90AwPPgKpuwsIeqD9eHNKf1hsbjve5Sy3w4WWuH67
	GrSFCkNg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXJuy-00000007sWF-0vCK;
	Wed, 10 Jun 2026 14:28:32 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXJuv-00000007sUW-0t9w
	for linux-nvme@lists.infradead.org;
	Wed, 10 Jun 2026 14:28:30 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65AE9JWU1628934;
	Wed, 10 Jun 2026 14:28:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=vVgWwwwwQBl//+r12
	iJqW6fsOgS/+0BAvJaPWxQz8Iw=; b=m1EQkBMajPXoud+QFc4k4RU7h1oEkESoy
	8vIRFMVm40huZ2NQjPx3bBGXYhg37JGRcMDL6LFvA4UYPCFsRmToeZulWl8Tw/oc
	TS5ZJo7DQDmIcMNVF9gxYzWMkPQKcduyUlA2ZDHwu8nhhZzD2sRN/pCQ62MOkKfE
	CHePB541O3Aj1/uPPtHIyNPEWIQTXFhnNF6vG5j7VWvuhN+zY5DnpWXb5weDlC1R
	Flz2ihMnoXYUvzCVDFvjFGkXiVreS9pNgG1zlPN80GiPUv/PvNSfFeB0kj7IgdIS
	LhK7iao3XZXIghxQl0JZsFGV1lOMSxvV4UjXkGd9dT9GSa0owp31w==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4emb241knm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jun 2026 14:28:17 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65AEK2uc013491;
	Wed, 10 Jun 2026 14:28:16 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4emwvq764f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jun 2026 14:28:16 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65AESDQA38076690
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jun 2026 14:28:13 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1EA1920049;
	Wed, 10 Jun 2026 14:28:13 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DA79720040;
	Wed, 10 Jun 2026 14:28:10 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.43.34.89])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 10 Jun 2026 14:28:10 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com,
        bvanassche@acm.org, elver@google.com, gjoyce@linux.ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH 02/15] nvme: add Clang context annotations for nvme_passthru_{start|stop}
Date: Wed, 10 Jun 2026 19:57:22 +0530
Message-ID: <20260610142743.115898-3-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260610142743.115898-1-nilay@linux.ibm.com>
References: <20260610142743.115898-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=b4uCJNGx c=1 sm=1 tr=0 ts=6a297481 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=7bgEqNGeQr-mGYOCYikA:9
X-Proofpoint-ORIG-GUID: Kmy1h68p4uGqiMexuhCUdLR8sMYJ3G0I
X-Proofpoint-GUID: EMgjSyAURaiKFx6R-EQZpFKlkGpEPvfN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDEzNSBTYWx0ZWRfX0aBrnf4pWMvO
 q/kqAeSdN9nSUK7dnf42m5XftN9BR/sEOtiYMRartMe4Hag6Kd7AiAnhY2FHhU5Ug3u+7DlPlL+
 BpGNZd+RkXESMz+Opy07KMLQjKk6BFQWcyikj1ApQDOdw0Oel3mKwK41iZuzJtmOhkdlZ0zWnkq
 RD/Q4hniVEyqAUc0Y+/oHxXUD18jNltYFb8vfLA66pVmMpjcQV8NIllV2WFOX6NQkzVba8WhXYN
 jDL69ceore6eqXZ/Bc5JSdrY+J+LF6hgU7SQCG/cLTmzUE5ro3gJKAlOHP2qiZtsqFhff8HsqcK
 YHRirzYASKx7a1hAg+1W34A1uGgxEf13ue4sHKwzHS18f7ntceVSbkNPyIKhOi9qaejoh6NZYxW
 oaHQ4uOQVC+HreLfdCwYC+UQh55/MqtSL91f7Q/Qzk0tbGFsdnImpeOu6QlBEnH+4jo15wfmmG2
 2f94BppouZ4t1vB2kuQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_03,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606100135
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260610_072829_271829_8BFB8F8B 
X-CRM114-Status: GOOD (  13.20  )
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

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/host/nvme.h | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index aa42f5a9d1fa..3b6754ec2edd 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -1272,10 +1272,16 @@ static inline void nvme_auth_revoke_tls_key(struct nvme_ctrl *ctrl) {};
 
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



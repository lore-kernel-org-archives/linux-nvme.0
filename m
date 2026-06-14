Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F6AACD98DA
	for <linux-nvme@archiver.kernel.org>; Sun, 14 Jun 2026 13:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vVgWwwwwQBl//+r12iJqW6fsOgS/+0BAvJaPWxQz8Iw=; b=124ZkqRIRUQj20bKpRpFP61usq
	OEoQONeRRnHKiu+xHwYvr6YwWn9rsDOE+tEf0+IaAh2YhRZnk9vuTr24HvQ0QeFxviYw5ocu93RVG
	MMu99L0ThFywRabkoepjj89SY6aFxQk4yLWGQJUZHi5EehSqKVG+L9XYTreIfQUOByRPWE5pgpijA
	Q+kK9F5C7iaYao1vLFSk91K7qAyLcpQggezlDxBKhe0clULXdAzFEQQGaAZyzfz+iNC5GicWO7Mj+
	jtm3rD7t04sMTzLymV1IKtNy6fAjLNqndupmtDQmJJeqhOntUmsn8N0lNYydReG7Srfms/tmkL325
	Nzraxkxg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wYkhT-0000000D0rV-3XSU;
	Sun, 14 Jun 2026 13:16:31 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wYkhQ-0000000D0p4-38zG
	for linux-nvme@lists.infradead.org;
	Sun, 14 Jun 2026 13:16:29 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65ECmNPY3483853;
	Sun, 14 Jun 2026 13:16:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=vVgWwwwwQBl//+r12
	iJqW6fsOgS/+0BAvJaPWxQz8Iw=; b=OVpVnO/LYAKCgNvZjp+HHlR1th014n/NY
	0hnCx6JFEgW4DhMmdmy4YPqBaFXd1oTuzPwVNFE4x6gdHrPrnHekp6Ju9OQrDFfI
	P1KPxI6/mxWQ8xlaPTxPwXIA6URB8Z6gMoqaQC0y73FZManh8XUCbDEeJNbV9bES
	y9vPh7qzgjyIEiTEmPRJ+pcxRoqiqWLjskGgSM5gVYHPayz6osfwZ6HZ+Zl/WPbw
	YBD5JNxToDj6oA2jee1HXQv/f+MLFBogSlRYO2XKAXyz6B2pQXMIv7bPPSlj8cEH
	B1IxcXz5HDXTNOcKQXfBkKXpgm1ryqNBJsnJOFu0lyYID7XMKPDBg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4es1wkumhr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 14 Jun 2026 13:16:01 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65ED4i8o013241;
	Sun, 14 Jun 2026 13:16:00 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4esjhjsmyr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 14 Jun 2026 13:16:00 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65EDFuEK34341168
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 14 Jun 2026 13:15:56 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 85A7220040;
	Sun, 14 Jun 2026 13:15:56 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 069422004B;
	Sun, 14 Jun 2026 13:15:54 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.43.80.1])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 14 Jun 2026 13:15:53 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com,
        bvanassche@acm.org, elver@google.com, gjoyce@linux.ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCHv2 02/17] nvme: add Clang context annotations for nvme_passthru_{start|stop}
Date: Sun, 14 Jun 2026 18:45:17 +0530
Message-ID: <20260614131541.2017845-3-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260614131541.2017845-1-nilay@linux.ibm.com>
References: <20260614131541.2017845-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE0MDEzMCBTYWx0ZWRfX1YeU4UmYzXhD
 hrIPSYuOijaZu71KtKYXu6duB63Rtw00sms5KqsuAVQoFVHcFOkZwcc5R1KDAAvj3iboRTYaO0w
 R4T/PTija6ziv5wU2aQVtofX83BF0o4=
X-Proofpoint-GUID: 7w3kpwiapfZ_iuYw8gadwu0ymxuAW2YJ
X-Authority-Analysis: v=2.4 cv=SY/HsPRu c=1 sm=1 tr=0 ts=6a2ea991 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=7bgEqNGeQr-mGYOCYikA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE0MDEzMCBTYWx0ZWRfX6Nu0jeiKCDzn
 KJBndbbARHwt/uHE2I4lqN/BW6iy5MtiBi1VwqUM7d7C463PAFFbafdesloyaIHYW1lh5e8p3pI
 y9K5s5srqdS6qSrLW9Gjg5tic/ggOVcOImqLaQMCYISFe/ONjv1N5rqehFS2ielt5yB7fdLFoXv
 Kg/JuoOWKht0iwcP6qxosT8tZCfudEG7Rm8DxP6BaT7EjL04P7JQv9Sv/au35L5wc/2cTfHeZ5F
 x5PJ58D+UyRMW/NFFCq3oG5WvyW7vD9T8+Wzjs83/Ky/C+R2OQofHcxjrQEiFGXfMWTZFcra0VZ
 ZXmRJ/u8Bkp4R0ZIu9ugDpctq8mQQnUmuWOci96C3kOfRSMgJscXLJQbJJ6HvvDGdX6sj6BozfD
 V5JTkqM5PFYhWCF8/cCS7oCtQd/s2HvKyfg0wGK5puJoEl6hFmLqDME8/ck7OX6ZwVMgCDcuiZb
 wh8Y2nJi6GPOnco6lTQ==
X-Proofpoint-ORIG-GUID: LsUuy14qAtPSNeApUH7ZdBsvBASkkjcn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-14_03,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 suspectscore=0 spamscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606140130
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260614_061628_786318_D60E4BC8 
X-CRM114-Status: GOOD (  12.59  )
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



Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70827C43458
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Jul 2026 14:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8+M7RExt2GjfkCztuhQCS86rc+iABZUktjOmqv/Izig=; b=oxhdzfyGlmCiR709b1LWJChJqk
	DCe80yZP1AeWfks8RK8VhFuBMZ0G8EL10+6eZ80OLaDPfkspDrMxhB6ecIUm84zjA/BXu2qxh1biL
	5zv81VxFISfZKVfs2YO0o4LnZ2/VqPULP3mJ+pLc/SZcR3Z9j9FVxVQeWrTVk9a/PAkbK0WBWqCjZ
	tVj47N+oS0Cqp3T3ho1FYJXqYRBO53dDvMfTgFq/gkoCIYnwwdFdL3+ctB0vJ38nMKtrOJuo3lLdm
	73Cu0irWx+XM9v1XcjbfdpjzqvAuMJDYLvtSzygU1pQdaU3ezbNMuC+eYRhGis7b7VleD/nXxA/+E
	rujFaQig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wgk6z-0000000ChpM-0D9Y;
	Mon, 06 Jul 2026 14:15:53 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wgk6v-0000000Chnw-0v8P
	for linux-nvme@lists.infradead.org;
	Mon, 06 Jul 2026 14:15:50 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666BIVrV007960;
	Mon, 6 Jul 2026 14:15:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=8+M7RExt2GjfkCztu
	hQCS86rc+iABZUktjOmqv/Izig=; b=GMmljfwDHsfV6XUG053Vrar6VtgTlF5oK
	8/lv3yfGFWXgUdPJ4EzSMzZaEGkIxy7W6el5KOaG7Juh/ShZDn2Po8/PWNsINBgM
	/LbM8/wABPeIwU/D7j27bSz2HsrBwjf92KrTw23BHW0VEaVVtTeKdtoOW3wQRNbV
	+mPJoi/zDKk0qsG/ys5Nr1GL2bU9sbB0jNPzryo1udSQiT4kvWoB5/aPR+Fv/ZOg
	wval2lBdgT37chmvuG6TWwVwLL+PATdEIE0qbI1s/4gd9QZ8ms6/r0l9gjv+2dtX
	wciFkAA2FNbzzGKfGSXd0YF4vFFGwJsawdkGeMDHItK8AQ81pFF/w==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6sp3hupb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 14:15:37 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 666E4md6022950;
	Mon, 6 Jul 2026 14:15:36 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7dgjwwym-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 14:15:36 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 666EFWf151184120
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 6 Jul 2026 14:15:32 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A21D820043;
	Mon,  6 Jul 2026 14:15:32 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A4ED820040;
	Mon,  6 Jul 2026 14:15:30 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.bl1-in.ibm.com (unknown [9.123.7.57])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  6 Jul 2026 14:15:30 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: hch@lst.de, elver@google.com, kbusch@kernel.org, sagi@grimberg.me,
        axboe@fb.com, bvanassche@acm.org, gjoyce@linux.ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH v3 02/18] nvme: add context annotations for nvme_passthru_{start|stop}
Date: Mon,  6 Jul 2026 19:44:04 +0530
Message-ID: <20260706141452.3008233-3-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260706141452.3008233-1-nilay@linux.ibm.com>
References: <20260706141452.3008233-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=KsJ9H2WN c=1 sm=1 tr=0 ts=6a4bb88a cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=7bgEqNGeQr-mGYOCYikA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE0MSBTYWx0ZWRfX3DhLNUADekyb
 c+E+vut1CcNkNUZiw/+R43R4hvqsOeYjuCLhpOjPu6VCShiX2ob1hTAQz1lBUs2o5IBOnGukw8x
 zlqzYTCNfDTg2OoS0P/cdhOsO+IaMWI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE0MSBTYWx0ZWRfX5Suw+LQYMwh9
 cpuL6lKyPQitLyNOW2mkUGKbHAVcwvVr+i0eUj5LYcYIdwyqbL1LwjK/7najg/4VfLZkXFw8WUM
 UgS1qXbG/Lmuvprfd1jGPEkBmvNaeGkuNVE/+iIVicm6wrJQWXLKNmX14s0H8CGcVwOuezBudbs
 C36gvDwCpsEazUWJZHi4WPVDk6Tl24zjOLx5eKjE8yNTPfOw6Qh7It5nTb32W3v5YR1CxmHeScf
 7fedVP9lMY16DTw/ooALMjqBPVFbtfD7NFX3X3pgM6LFyhh/LeGlcmSGzfgssuC5ayghcgimtYJ
 3CwUga4SSQSP56wp/Xy4f4TPE5odIG7f8AknVcHzWSbtM+qA3OR7fh7VjqWXHyfReAsfQTYqXb+
 ssIgo5kJvslZASTdP2KV5kGurX1VxBtxAz/7h4PpQpvkKQ1EplysmQdKbAVUCFeP7UKsFiwn89G
 ylvdbjsAPiOVi5Ck5cA==
X-Proofpoint-ORIG-GUID: WdYfRW52j4qqsMfb-64ctPV4Rd_ej2Ed
X-Proofpoint-GUID: v5wzHTPuFr5epWPcT5AebVxzsAQmZ-0h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 adultscore=0 clxscore=1015
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060141
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260706_071549_263715_F6F537B9 
X-CRM114-Status: GOOD (  14.87  )
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



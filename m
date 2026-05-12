Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FFCBCD4F21
	for <linux-nvme@archiver.kernel.org>; Tue, 12 May 2026 20:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Fzk22lIF9ScbUDTLAgypyk2BdyfUfVm/xN2X9xwe+ZQ=; b=uO0H8Z5R8NbaCccCqxniHP34GU
	EW11dGEgG0nnSayxwdGYD7ZZefWQBEl0cPSM/lbihBT8Yu4yeobDJwrr34jW4K3N/7WeRxZD15OX9
	Ftdp7J/rP3OARF7w+d/O/8BQOyf0w9Uohn+VPyUL7KAc43OfupfXCaQC0XbdqMgC0qM9LouJkAFLI
	WIEwtXlf7b/m9fjsixRpHRX/xVz7WtD42qS1JlUeb/XK7u7YSPRbAzlvEgdNP8Ai7VyvyKwRClgBI
	nGvT3NWZq2EXgiolvKumh1vbmv2UG/Mw/CZuUZsQ7zi8Rh3uEyeXWE/Gk+OspTsR2TqaOJgP7O3I6
	AoUD7wjg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMtWq-00000000JGO-2HIK;
	Tue, 12 May 2026 20:16:32 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMtWo-00000000JF5-0Tm4
	for linux-nvme@lists.infradead.org;
	Tue, 12 May 2026 20:16:31 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64CBX7Go2760511;
	Tue, 12 May 2026 20:16:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Fzk22lIF9ScbUDTLA
	gypyk2BdyfUfVm/xN2X9xwe+ZQ=; b=LotsrgCZ/G9HjyUbwjZYw1Cc51KejLecg
	/IE48xaEV6gLT9NEqxHYb+1E8IMtfQzsBSJheBPK5VjYVCPH6iNiJYUdnM/HAxOp
	Gc9aty89cq3ySZlQorwZAA+vMzSn7BFQBfX8ZfmmhQQ/BX8nh+1/uFParBARC6Mg
	Cy/YoEghLSsmW2sOLiFeJqtq4IWWoKlSuDwrsEql7k0Gq+4sjZJq3xgr18Dz8dWp
	yixEDQ8csv7i7NTbtL656q84wQpde4jzthHx2SikoYFLTs7eAMgdb8Pj60LO1u2D
	O8SOTnfLMrtNuan5HMcuAY1ZCaZvi7MRjZakac2Doa2cE6Z4+IWSQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e3nv6mmq6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 May 2026 20:16:25 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64CK9aJR029317;
	Tue, 12 May 2026 20:16:25 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e3nfgmr8p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 May 2026 20:16:24 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64CKGLkF16384398
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 May 2026 20:16:21 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 28FD520043;
	Tue, 12 May 2026 20:16:21 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3965020040;
	Tue, 12 May 2026 20:16:18 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.87.130.169])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 12 May 2026 20:16:17 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: dwagner@suse.de, hare@suse.com, kbusch@kernel.org, hch@lst.de,
        sagi@grimberg.me, gjoyce@linux.ibm.com, wenxiong@linux.ibm.com
Subject: [PATCHv3 5/7] nvme: add sigaction for SIGWINCH
Date: Wed, 13 May 2026 01:45:50 +0530
Message-ID: <20260512201559.3057514-6-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260512201559.3057514-1-nilay@linux.ibm.com>
References: <20260512201559.3057514-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: eqymJRiuu46XbuLnUAZOMhwiwn9jckE8
X-Proofpoint-GUID: eqymJRiuu46XbuLnUAZOMhwiwn9jckE8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDIwNyBTYWx0ZWRfX46SozMueSTxk
 nzY5hcXhylHnxFvag1Zb1FGgYlys+o9n+g+6jFqp6fETnOY5DmCgJNMg9dOJI3j7LzkBJ+jhZlh
 9Q09Kruc7Px3qznwqAi4TBIzqSCEHgL4mqe4lcAU4fNAZ9pcluAutrAa0cYNBX08muj11iHotu9
 qGzBoVnk9CmaEsJOuhs1INiWt1syAe1031UF8O4397LopwPb74fKmLu5sNmRmdoCy+MmLiX0Tgo
 D0deG9Xyu/hUmP+27Vyl3D7VPwsuwFv/fKvGwmKM2TF3B+LWVwOVuELbNNFd1jOhyKnrzNbBvrv
 zTs7Wm4TjzgdzftTmUFHUYmwoxYP8QITh5U03aliZjdhKbqvoaYtXjc+J33mIwDCQeLrPUd1FbH
 YeQLtYho9o+F/Ffz4wOc2z0fKaKhnT2NZTExl/OYo4X/SjXOnRJCyao/R6LFRftROONEA1Jqf4j
 wFGhfZt3ogRWwrhPwRA==
X-Authority-Analysis: v=2.4 cv=P8UKQCAu c=1 sm=1 tr=0 ts=6a038a99 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=479iHlz-dOkAYOQHa-gA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 phishscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605120207
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260512_131630_627491_403A396A 
X-CRM114-Status: GOOD (  17.02  )
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

Add a sigaction handler for SIGWINCH so that nvme-top can detect
terminal window size changes.

This allows the dashboard layout to be adjusted and redrawn when the
terminal is resized. To avoid undefined behavior and async-signal-safety
the data type for nvme_sigwinch_received is defined as volatile
sig_atomic_t.

While we are at it, also update the data type of nvme_sigint_received
to volatile sig_atomic_t.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 util/sighdl.c | 25 +++++++++++++++++++++++--
 util/sighdl.h |  5 ++++-
 2 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/util/sighdl.c b/util/sighdl.c
index 146591e5d..e40d896b1 100644
--- a/util/sighdl.c
+++ b/util/sighdl.c
@@ -5,16 +5,22 @@
 
 #include "sighdl.h"
 
-bool nvme_sigint_received;
+volatile sig_atomic_t nvme_sigint_received;
+volatile sig_atomic_t nvme_sigwinch_received;
 
 static void nvme_sigint_handler(int signum)
 {
 	nvme_sigint_received = true;
 }
 
+static void nvme_sigwinch_handler(int signum)
+{
+	nvme_sigwinch_received = true;
+}
+
 int nvme_install_sigint_handler(void)
 {
-	struct sigaction act;
+	struct sigaction act = {0};
 
 	sigemptyset(&act.sa_mask);
 	act.sa_handler = nvme_sigint_handler;
@@ -26,3 +32,18 @@ int nvme_install_sigint_handler(void)
 
 	return 0;
 }
+
+int nvme_install_sigwinch_handler(void)
+{
+	struct sigaction act = {0};
+
+	sigemptyset(&act.sa_mask);
+	act.sa_handler = nvme_sigwinch_handler;
+	act.sa_flags = 0;
+
+	nvme_sigwinch_received = false;
+	if (sigaction(SIGWINCH, &act, NULL) == -1)
+		return -errno;
+
+	return 0;
+}
diff --git a/util/sighdl.h b/util/sighdl.h
index 8d5d1c126..b0c7869e0 100644
--- a/util/sighdl.h
+++ b/util/sighdl.h
@@ -3,9 +3,12 @@
 #define __NVME_SIGHDL
 
 #include <stdbool.h>
+#include <signal.h>
 
-extern bool nvme_sigint_received;
+extern volatile sig_atomic_t nvme_sigint_received;
+extern volatile sig_atomic_t nvme_sigwinch_received;
 
 int nvme_install_sigint_handler(void);
+int nvme_install_sigwinch_handler(void);
 
 #endif // __NVME_SIGHDL
-- 
2.53.0



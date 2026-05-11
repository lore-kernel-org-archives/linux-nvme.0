Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08508CD37AC
	for <linux-nvme@archiver.kernel.org>; Mon, 11 May 2026 11:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rppxAu3i2r9dP9p4jR3BWKkR4c2ZumKVqiYU3mkSwXc=; b=036EQXyZGKBo8YU+lfrL6zO/AC
	/0VaqpTaiS0cyI76ASXPiXlGc3e7oOWuNlQBZZuoNeRDiYbKdtNRElCeFaRCAZjf0fQ3qLbf25lSd
	RXWQQnSKiSBj1hQK/u8wZzLHxaSdo8mHKiNEVS8JM9M3FvvmLFKFoG2/2m64hNSIxJw+FR0iVGPEa
	wlwOfI96YPOM8NhI0TEBEjWO18nh5g7Fu93SCQPGw1udGyK6uOcDrjwgVJxQliwTZe/moossPEkjm
	KDx6enHkGOJrVvYdfVA0V9soQix0nhMaMia9QTGDseYGtpFznQXaA6T6y72h/e/ENmtQNMGBGLm48
	oVNo0dJg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMPFL-0000000DQEL-3Gh0;
	Mon, 11 May 2026 11:56:27 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMPFH-0000000DQCW-3BiD
	for linux-nvme@bombadil.infradead.org;
	Mon, 11 May 2026 11:56:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=rppxAu3i2r9dP9p4jR3BWKkR4c2ZumKVqiYU3mkSwXc=; b=qL9uOS9q/Rh93SsapePWvzO9eS
	XyWoJjIMAGUtMEwd5TGYUdTlwE9MTfYTIC8UCI/RMc8Udsnf28hXOL9cNxkY6wJCZovTk1OQESQH5
	lFyO9mIMgQSiZEOuFzwg/L1TOxcn/z8Z+cT7AN1L3QF80gK8RswvV7XQNwCDkbs78BJ+nU4BPMt54
	2SohD+8gzxvj+Vbq7ZJcWaUiS6ivwueq4cbjtO2250PIJcyGQQ+vFsjHeUh8u+LPn3z4xdaU71jJo
	ft5KNd2SfOTebBIjllidjt+9wHK9hg68ROp+HjKlv7TyCtQ2ILm1Uo5T5l6SleoHMlHJK1JCQV8H/
	DCewGD6Q==;
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by desiato.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMPFA-0000000BXgs-1rqv
	for linux-nvme@lists.infradead.org;
	Mon, 11 May 2026 11:56:22 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64B726L91930649;
	Mon, 11 May 2026 11:56:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=rppxAu3i2r9dP9p4j
	R3BWKkR4c2ZumKVqiYU3mkSwXc=; b=qQwUeqbOOATeR561gWv8+UL2FZVxUA1PJ
	FiuPjNuglf58dxAHjmjJs1/+Ft4SulrP//Pxx3e1WY9vO2VQ+WZgciIQeV9o0g9g
	6Xe/os4F/S5yZaaOXnqSsVBsQcAnES4v13+T2cdZJOf2XRdHCYgSa1LFRDEkGUvN
	oxjAf3q6huU3P3mAxmwvekkEA32Ei54j+MeO8oBlMnVzJFUV8L4xOUTBphgmhXha
	KKYDs5KVl912znD7Ck4LzoLdU3duxT1q91fjt1wNfeAWIwDJPvCdf4wyQvjvf3fS
	b13a0JBEbI2hti4e8LO4rMcinJZOQ0rUTKGzpOoun7SX/K6mwylHw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e1vn4r23s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 May 2026 11:56:13 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64BBsMF0010498;
	Mon, 11 May 2026 11:56:12 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e2f8q56tp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 May 2026 11:56:12 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64BBu8Oc42140134
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 May 2026 11:56:08 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BF8C12004B;
	Mon, 11 May 2026 11:56:08 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 43AD020040;
	Mon, 11 May 2026 11:56:07 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.bl1-in.ibm.com (unknown [9.123.7.57])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 11 May 2026 11:56:07 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: dwagner@suse.de, hare@suse.com, kbusch@kernel.org, hch@lst.de,
        gjoyce@linux.ibm.com, wenxiong@linux.ibm.com
Subject: [PATCHv2 5/7] nvme: add sigaction for SIGWINCH
Date: Mon, 11 May 2026 17:25:45 +0530
Message-ID: <20260511115555.2638335-6-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260511115555.2638335-1-nilay@linux.ibm.com>
References: <20260511115555.2638335-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=BM+DalQG c=1 sm=1 tr=0 ts=6a01c3dd cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=o4XUO4zMC3DDYpt7SS8A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDEyOSBTYWx0ZWRfX5sdDyfrf8ZDo
 8OUOEeCTfVDMle6kF8KcaTaVrJmTzkMYPaddITBRGe6GzOaub1V4fmITqH+FnieHoqHH0vczbke
 IPv2xdzTuoqQ6P/1xwj4RuPSLyKmXwMaUdi8bzv0g59I8aHjtDy94KKX9Bo6PJUHxnTFT6mqpoW
 kwVHmwVHPGO/86QXQ4m0KagWDurMlJbwtqglaM1mrdBll1rKGY0nvdQZ/cT6SH1Cs5Avy/PWdPk
 ItXJ/ATBoHdK8tqxYAmLNhD5z4MxFmRxhFNY2hA1C3XjvEpgnDuZEibiRiJ29kkYmeCAsw1/dUL
 D/Fn+O7kJGlrTupjMgYcRgHaeouPUwU5oe1R/FH3ADhZTHJMF6hw0MjkkNB11RNWOmk9cbU3kGb
 z/H+6B9OoqFFnDXPjxqkBtDGCqESTkaAK+5VUmHR2av3crcPAWj0GOVS9OHKA3sFGsgU8tqpLvC
 m07STReZIi6KCHw1QTg==
X-Proofpoint-GUID: H2xX1MSjbE_7ghVVmnv-yjjQkuiN-rQV
X-Proofpoint-ORIG-GUID: H2xX1MSjbE_7ghVVmnv-yjjQkuiN-rQV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_03,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 suspectscore=0 bulkscore=0 spamscore=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605110129
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260511_125620_235008_42A52ACA 
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
 util/sighdl.c | 16 ++++++++++++----
 util/sighdl.h |  4 +++-
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/util/sighdl.c b/util/sighdl.c
index 146591e5d..2899e9cb3 100644
--- a/util/sighdl.c
+++ b/util/sighdl.c
@@ -5,11 +5,15 @@
 
 #include "sighdl.h"
 
-bool nvme_sigint_received;
+volatile sig_atomic_t nvme_sigint_received;
+volatile sig_atomic_t nvme_sigwinch_received;
 
-static void nvme_sigint_handler(int signum)
+static void nvme_sig_handler(int signum)
 {
-	nvme_sigint_received = true;
+	if (signum == SIGINT)
+		nvme_sigint_received = true;
+	else if (signum == SIGWINCH)
+		nvme_sigwinch_received = true;
 }
 
 int nvme_install_sigint_handler(void)
@@ -17,12 +21,16 @@ int nvme_install_sigint_handler(void)
 	struct sigaction act;
 
 	sigemptyset(&act.sa_mask);
-	act.sa_handler = nvme_sigint_handler;
+	act.sa_handler = nvme_sig_handler;
 	act.sa_flags = 0;
 
 	nvme_sigint_received = false;
 	if (sigaction(SIGINT, &act, NULL) == -1)
 		return -errno;
 
+	nvme_sigwinch_received = false;
+	if (sigaction(SIGWINCH, &act, NULL) == -1)
+		return -errno;
+
 	return 0;
 }
diff --git a/util/sighdl.h b/util/sighdl.h
index 8d5d1c126..41c823abe 100644
--- a/util/sighdl.h
+++ b/util/sighdl.h
@@ -3,8 +3,10 @@
 #define __NVME_SIGHDL
 
 #include <stdbool.h>
+#include <signal.h>
 
-extern bool nvme_sigint_received;
+extern volatile sig_atomic_t nvme_sigint_received;
+extern volatile sig_atomic_t nvme_sigwinch_received;
 
 int nvme_install_sigint_handler(void);
 
-- 
2.53.0



Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6872FF8875
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Apr 2026 10:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GTte9nQ+dJbylywOkTKBxZZ7ncA2ZMS2zQhIGYH9Hj8=; b=GOfidxDjDET4IdgdZ5t20/a6Am
	jMH97vkRzNS0vAmHRyE5IqsQ6vtrv/BYDIM7KwQWwVIedq00Wtew7YJri+ujjjm3DO6L6xJ0aAGWM
	A5ApMTX92fbKt/gvLup4peR2EitiUjFiwVIqTPQ3MaTzsHPCm4kc54EiHp4PlSY2UWoRXEIvrgJkx
	gCTlsbezjdyZ7VtSO6Lc2b3B3bY3r1R+vYxqj4vIuNoKzf/+jb+XrUG74pTO88SPTV+CHo2zDFwWj
	Dc2+l+cmwuUU9cAOoMXBkOizvwB87pETZp2sWr1wc7FirHsGQTq+DSTmgCpKdz8UmOI+VseheMSJs
	QO7xGf6Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIP17-00000005E9k-3tWX;
	Thu, 30 Apr 2026 10:53:13 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIP15-00000005E86-3mkI
	for linux-nvme@lists.infradead.org;
	Thu, 30 Apr 2026 10:53:13 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63U9YoLp1473100;
	Thu, 30 Apr 2026 10:53:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=GTte9nQ+dJbylywOk
	TKBxZZ7ncA2ZMS2zQhIGYH9Hj8=; b=klDPBVVaFtdanKNGBQquHYB2arsKDrOgi
	cTLjV4aZuCshbDostbQ8TnttqJSGR9dwV6DccIGb7OpLq0QGjDBQqfFEmRJn9Bb6
	m+ras7S6aYuHo6pjaOt+W6zHQCuiHUYskBmb9BGNXPdBDd53NxajlmUg/JXo1Q7Z
	A2alnTifZfKZLTHi0sMfpHulKIpMJyCiQwNiu8HStDvKXGcrMMOxBkn4kokAdtbJ
	50rzBsVfM+PSmsbC9etXQGrhBN/OqEWtarnw+DU5deemGWonsyxbe1HiSr9NtiP7
	dlthFYg9KTSeisT6HPcGpXTGjHbfklpyxDQSEYpPVFafl6e0iPm9w==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drn8vnhf8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Apr 2026 10:53:08 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63UAclZD001773;
	Thu, 30 Apr 2026 10:53:08 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dsamyjcb6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Apr 2026 10:53:08 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63UAr41v36176146
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Apr 2026 10:53:04 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AAFA120043;
	Thu, 30 Apr 2026 10:53:04 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3105F20040;
	Thu, 30 Apr 2026 10:53:01 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.43.102.217])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 30 Apr 2026 10:53:00 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: dwagner@suse.de, hare@suse.com, kbusch@kernel.org, hch@lst.de,
        gjoyce@linux.ibm.com, wenxiong@linux.ibm.com
Subject: [PATCH 5/7] nvme: add sigaction for SIGWINCH
Date: Thu, 30 Apr 2026 16:22:26 +0530
Message-ID: <20260430105234.1172446-6-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260430105234.1172446-1-nilay@linux.ibm.com>
References: <20260430105234.1172446-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=CIIamxrD c=1 sm=1 tr=0 ts=69f33494 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=W22P3SBT4iy2hwKDXisA:9
X-Proofpoint-ORIG-GUID: 22bSVSg7P-386ne2245dTEcMM3jN6Rs4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDEwOSBTYWx0ZWRfX3v+aD6d6astL
 yi86ZeSDSlCfelPFfFXwqsYIvK3sNF/h3g7hFox0EEKd6fh9+vieRAcsu7x2S6471HM6ZwEK5EP
 kVTyRDZ3gEpkAPMi5Cxt4FG+9KWP1MGRxM4rGCnYqNn94tY1k896WwzgK0v6Qy/jeUJ1jV7eKh2
 40Kfyn6aZqdvuRt7GapKafY9a+pQdwKARf/EKnH4BQb/6bmvDCb5sXnGtBj37cKgXBqxEpQKYhB
 hdbSYfANonO5Ul7pCdjIV3BXR+gfu6JBQfuDc4s4RfCXf06vHeDl4qQpu0rnv5TNF8W8WdFD7L0
 rLOcwFt2wE9izRiBLxoYrsXSUwais0SwYtqStBcNE5C157xfhFz1IqvZPd+NjDciK/dmVkTBuUJ
 SzYsjMfycq4kNBCp/puLsKE22c5eiAJaAHnZmXkG1NLFDsWEI3ZPUlZLDZ24Kxb9I8Op8Yk3Rju
 +NDE09od4oye6MUn+Og==
X-Proofpoint-GUID: 22bSVSg7P-386ne2245dTEcMM3jN6Rs4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_04,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 malwarescore=0 suspectscore=0 adultscore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604300109
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260430_035312_065310_86EF7E04 
X-CRM114-Status: GOOD (  15.87  )
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

Add a sigaction handler for SIGWINCH so that nvme-top can
detect terminal window size changes.

This allows the dashboard layout to be adjusted and redrawn
when the terminal is resized.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 util/sighdl.c | 14 +++++++++++---
 util/sighdl.h |  1 +
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/util/sighdl.c b/util/sighdl.c
index 146591e5d..f6b3c4a87 100644
--- a/util/sighdl.c
+++ b/util/sighdl.c
@@ -6,10 +6,14 @@
 #include "sighdl.h"
 
 bool nvme_sigint_received;
+bool nvme_sigwinch_received;
 
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
index 8d5d1c126..48afd8b20 100644
--- a/util/sighdl.h
+++ b/util/sighdl.h
@@ -5,6 +5,7 @@
 #include <stdbool.h>
 
 extern bool nvme_sigint_received;
+extern bool nvme_sigwinch_received;
 
 int nvme_install_sigint_handler(void);
 
-- 
2.53.0



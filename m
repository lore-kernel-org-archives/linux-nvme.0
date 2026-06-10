Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80739CD8CB2
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Jun 2026 14:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fCZGxvZ9z2snV0klYkNZMsP3LkT8hfWiONet9pn0Lmo=; b=c64h18AF2ao8PXM4Ov5p7Xt/ua
	IS+syFLDFiWD1q+ife7XEAptqU+V9s+ija7S54LLKUV9cF05j+5i3V4gj3Qu5w6T+pdpEl9rw+f+9
	UJocpHYxZbiMME2ZVRTwQG/E7GJS74cGk5c/KS4rAyilNW2m/z9gHPL7ebJtc/fClHKTrL5nSQ+HE
	xK+DKk8ENLmXWJ7yUBInkcU6E2U8zWGMM/rQ7RRc6l9jKSRj11e1G3otkEiQ1vCW7JvQq0NDSyXf7
	wrKaUIKrDTFp5Vqg+ce5NyRb9u/gA9cyukIc9L07PUylItcXJ12VwAmRafhQfJxxfijyE81O/CyaN
	65iYbVaw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXJvG-00000007ss1-0Dvf;
	Wed, 10 Jun 2026 14:28:50 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXJvD-00000007sne-0Knd
	for linux-nvme@lists.infradead.org;
	Wed, 10 Jun 2026 14:28:48 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65A1gP0g1818848;
	Wed, 10 Jun 2026 14:28:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=fCZGxvZ9z2snV0klY
	kNZMsP3LkT8hfWiONet9pn0Lmo=; b=pcZ37cKerDiu5ODAQPPu0P9nh1IQLDRr3
	ose1K02LxbkcMk4V9774SfZJY9ezM535jNOgm11k5Y4p506XysJc9pRzPfMwNUOG
	StX2sa0/c5f+fTVoneTlJJBezdkAtsXillZlr8zN8E2OMzz5EStyAbr0yR0eiewg
	rTmmHoRomcmOg2KMeXeFDwhXcjk8RRpMD7p2h7G5xNLmUtsnazOKASb+T1Ws+oJb
	aVe89KHsmIWGOxmm10tCnyLFIze6A4SYepFmP8y4CJRDY8dIhC5fn5rOyJCaIh5/
	HnkSfx0tXzUNEgjg9cza7GMz64m8kl9N4ku/7f8tk1YnrS0Ex9JWw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4emb6t12dh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jun 2026 14:28:38 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65AEJoY9010897;
	Wed, 10 Jun 2026 14:28:38 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4en0jyerxa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jun 2026 14:28:38 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65AESYPV48955888
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jun 2026 14:28:34 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2F72820049;
	Wed, 10 Jun 2026 14:28:34 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B64BD20040;
	Wed, 10 Jun 2026 14:28:31 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.43.34.89])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 10 Jun 2026 14:28:31 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com,
        bvanassche@acm.org, elver@google.com, gjoyce@linux.ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH 10/15] nvme: add Clang context annotations in fabric.c
Date: Wed, 10 Jun 2026 19:57:30 +0530
Message-ID: <20260610142743.115898-11-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260610142743.115898-1-nilay@linux.ibm.com>
References: <20260610142743.115898-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: JcS03k1FIr-WK5vlWE4u5adZB_Cf02vV
X-Proofpoint-GUID: xuGaPoi_rxPIu6-NiETy1-75CcfOqSmF
X-Authority-Analysis: v=2.4 cv=ZbEt8MVA c=1 sm=1 tr=0 ts=6a297497 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=-W7SLkP_sVXSNSbjlKUA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDEzNSBTYWx0ZWRfXxsS9qhZoKU3K
 bCf28Q1HbAQDpoyQV2AyC45KyDTHb41E60QO/gVl9/9r9rCpm/dUNrFv6tegbDFJ+tGL9He91IX
 MDL95UxZ+cxCLT7/tgXDTOuy2/lqpzw1orXlcKI7T31Jjopfo49h/5jMOs9bL89aU+m+Cx9k0F4
 bogfSATr2RsJdTQcw2RQsGWjlvh6vxXEeZFnM4J4qloY6wsGormE8miaj5IzE62h24qPScY8hL7
 PZ7Y3HjU7BNL+Gz8qBLpIujzQTDunW8uVi9XQPns0IjsCpOAs+C6VMQ2qHA3ggab+4Qe0BKx8Rm
 u2uNMiDVJRJwqF7xUAhY8c5Fmu+dLaxminU8EWsHM+sPYnwsrthlFIu0fQEZTrK5Eu3RwR2ppvT
 lCbZFc90ah4YT3YNR35B18fMQJp5ILh+C0G0StSzzJxTvg3V82tiWkIw63xzQs2jdZnC4FuagQ+
 zxZ41SfYbcVe9/ArCyA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_03,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 spamscore=0 priorityscore=1501 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606100135
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260610_072847_278916_1742BD2D 
X-CRM114-Status: GOOD (  12.90  )
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

The global nvmf_transports list is protected by nvmf_transports_rwsem
and the global nvmf_hosts list is protected by nvmf_hosts_mutex.

Annotate both lists with __guarded_by() so that Clang's context analysis
can validate accesses to the lists against the corresponding locking
requirements.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/host/fabrics.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index ac3d4f400601..9a627a5095ac 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -14,11 +14,11 @@
 #include "fabrics.h"
 #include <linux/nvme-keyring.h>
 
-static LIST_HEAD(nvmf_transports);
 static DECLARE_RWSEM(nvmf_transports_rwsem);
+static __guarded_by(&nvmf_transports_rwsem) LIST_HEAD(nvmf_transports);
 
-static LIST_HEAD(nvmf_hosts);
 static DEFINE_MUTEX(nvmf_hosts_mutex);
+static __guarded_by(&nvmf_hosts_mutex) LIST_HEAD(nvmf_hosts);
 
 static struct nvmf_host *nvmf_default_host;
 
-- 
2.53.0



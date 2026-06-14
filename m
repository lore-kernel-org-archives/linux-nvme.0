Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96023CD98D2
	for <linux-nvme@archiver.kernel.org>; Sun, 14 Jun 2026 13:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fCZGxvZ9z2snV0klYkNZMsP3LkT8hfWiONet9pn0Lmo=; b=cuD+kBH6NC/8AULuad30gu+DaD
	nikbXwf01NM74cOygDZtzSJdMnU2UVN/OlRB2eqri6Ki2av6odmiJCQ8T8pM5Ftqt/RVkbXtmQZID
	lYxjzg/D+eW3CJAqAO3iaAJMpumB3nUokmsxGvVzWYzuvYxkeMS6/CpYqiY4nhu3Bdw0IpHCZsW1U
	KaxACSPpU6iCRKTsmvTEIV0fef3azEY9C/sHS8AnCTGvrUf2AdK/WHiMwYI49fuqWrpxy4BbZE6Z+
	HV9gNgzRam+UFlp/J9KPEvSK0odtGqyUbQYw/M0wLZmFZkrkhrrsKayjC3KDgrdMje3dgfe7ZnIba
	f1qRbd2A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wYkha-0000000D0xa-1ILp;
	Sun, 14 Jun 2026 13:16:38 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wYkhY-0000000D0vA-01cF
	for linux-nvme@lists.infradead.org;
	Sun, 14 Jun 2026 13:16:37 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65ECmmsM3484875;
	Sun, 14 Jun 2026 13:16:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=fCZGxvZ9z2snV0klY
	kNZMsP3LkT8hfWiONet9pn0Lmo=; b=d9x07ZVoq27XU42Jc77woIA/XY81mko8S
	np7ERaUm13lSrQC5kZX3Im5keefqK6D6Gw9hdAp9aFVS/zITqcO8g4lfJxP/hENy
	LR57l9lcZmj2o3eQq2SK20et7og+MDDZPTLnmOfMPvt6yZfkjxfTEmWMgDyIQ3aN
	BoJJgH3Wn2igSKCudX562b6O7GF3Yj6RdGQk3uYA66zocrqF45QasNLq+hqrS6On
	ZUoonwoPbiWpG6RW8DbzQ0kHkdogIkjrVUt4pfynz27GSe8HS1sXQV0cnPORQrWp
	xLk7USjd6PdY0yPvxng405ratvaXwDeNhJeHotNfsXyBMuTBvEbGQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4es1wkumjs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 14 Jun 2026 13:16:26 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65ED4eD4013227;
	Sun, 14 Jun 2026 13:16:25 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4esjhjsn0b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 14 Jun 2026 13:16:25 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65EDGLdn44040552
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 14 Jun 2026 13:16:21 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 604E22004B;
	Sun, 14 Jun 2026 13:16:21 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D075220040;
	Sun, 14 Jun 2026 13:16:18 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.43.80.1])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 14 Jun 2026 13:16:18 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com,
        bvanassche@acm.org, elver@google.com, gjoyce@linux.ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCHv2 10/17] nvme: add Clang context annotations in fabric.c
Date: Sun, 14 Jun 2026 18:45:25 +0530
Message-ID: <20260614131541.2017845-11-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260614131541.2017845-1-nilay@linux.ibm.com>
References: <20260614131541.2017845-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE0MDEzMCBTYWx0ZWRfX0hWofr9jXAG3
 MOVRJ6XcuoIND9OySDLmb9fifWYPrsOrhy/Jm4u6Nq7nwY+yd6EQJDUQSfTUzujNALhQHcCpy7A
 4NzbqaNH7HKZ7A5bhNpB6/wS5tK1OHU=
X-Proofpoint-GUID: pGQ74hkih9qqwBhIyQGugA_4_aXRCG7Q
X-Authority-Analysis: v=2.4 cv=SY/HsPRu c=1 sm=1 tr=0 ts=6a2ea9aa cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=-W7SLkP_sVXSNSbjlKUA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE0MDEzMCBTYWx0ZWRfX90gZOVZ05o3u
 BzI0z6n3QGZ5qih18b94roCAt8lD54P7mpsrRaHM++a9Oc3DvnEgkyhBOb5C9n0usbmS60Ruz+4
 NNnBDKWzCdJkWqdWfv8QArK1rZricIlUflIlr95DvxPxzpJO+IzF744oJrFjs7pFLKVGdqMUflq
 731HfX2NDBn9bq8BJT+3tbAX4849QZ3qspRiR62tGBLV++TTIo6bVn7eiGbVBYE6j9lq1JQ5Js6
 ceuhstI5XbIwvk97jkeXT94cTui4VUxssUDb4DB2dMLgBq6S3HNMgWxF77GtLAWhl/CduPTq4u8
 KezY1zzGv3XrB142pKTVKxPggfIQuqvf9z04TRAhWfUd/ldZORjma+/GD1ZDJjlFHK/e6dwOZqU
 nq8CBcoMilzECfIk1u+G+laQVZEv14vCS8lp6y/AngzLoFsDNLmIzmEx9KkeFn2jg1LGBRBbdVu
 dm70hSdC1wUOY85gu4A==
X-Proofpoint-ORIG-GUID: DKnoMl0OgNfkPAzBnD2kVaWUgw2wV0a_
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
X-CRM114-CacheID: sfid-20260614_061636_045314_87ACAD0F 
X-CRM114-Status: GOOD (  11.71  )
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



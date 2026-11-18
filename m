Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5B3606A31C
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Nov 2026 07:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=lZMXJRwy;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=E/o4IWDg
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=3G+GFsqPO069KMMVY4UaGdipl03t9TJCU76RJOByl64=; b=lZMXJRwykUNvms
	VZyj+cK7RI9HXJw342NtpyeOj+xlkLE30W0S01B7O2isdzeSVF9BypAuM6HIsjx0evntqVAWwmVn5
	RbB3czIjinHjKV6trnUMNLeLuHycdRP3RANIABoLhzvYg6EGJBa4QxiuQpDL1McLB831xWCuEq+OC
	J72nw82aaQFkHrqY8COJoBtx0vUN0fYPzmfCfqH0LI4QNICHsBBXLdNtJ/ewBFG4WhNnbo30QfYnj
	E5kWiQDJ2SI8CpEQOFHz8RUskQ34F9kdjsxT25Wqtk3Gmo3xQsAg4LyjXzRumhOHyuNkfEbGGdZdA
	qAqss6rcaMvFBjjyIT2Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTaI6-000000083D7-41Wk;
	Wed, 18 Nov 2026 07:41:14 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTaI4-000000083CG-0YTB
	for linux-nvme@lists.infradead.org;
	Wed, 18 Nov 2026 07:41:14 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AI2RxE74081510;
	Wed, 18 Nov 2026 07:37:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=3G+GFsqPO069KMMVY
	4UaGdipl03t9TJCU76RJOByl64=; b=E/o4IWDgtFz8JHrr+LFiOVhnZFUDEt4V3
	UnVQuMPbcKpIjyEqRhOTw8bVGUB7Ll4ZJZf8anOLc+0tYzqdTElKX2U+/NIN/hGD
	29eE4TmfxFXBse5tuEpmvfE9ov0fFgNf4beMb+8MlEK2epEKyP+ztReawBYXeokK
	YO8pFlgRSalcix/wX/SG3eyd80Pnehg6MdRC//zxyZuqjVAvbCNcgjhkMtgEO0+y
	QivZO8tVn27p/+mrxbyirIGUD2hept+mWqkP5OqRbWfCS5eNWE64HvUGjevVzrTb
	ZBYmD6eSTQU+Rq57oEZAGJ0092TqG+1WOcrPhRPJ4aDrLRsKgBQkA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j105vhbkf-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 18 Nov 2026 07:37:27 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AI2nuAp680851;
	Wed, 18 Nov 2026 07:37:26 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hy2bvh6n3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Nov 2026 07:37:26 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AI7bMmL38732130
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Nov 2026 07:37:22 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5E99020049;
	Wed, 18 Nov 2026 07:37:22 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8A0142004B;
	Wed, 18 Nov 2026 07:37:17 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.61.157.4])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 18 Nov 2026 07:37:17 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: kbusch@kernel.org, hch@lst.de, bvanassche@acm.org, sagi@grimberg.me,
        axboe@kernel.dk, chaitanyak@nvidia.com
Cc: gjoyce@linux.ibm.com, elver@google.com, linux-nvme@lists.infradead.org,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH v2 18/22] nvmet: fix PCI P2P parameters access using nvmet_subsys::lock
Date: Wed, 18 Nov 2026 13:04:59 +0530
Message-ID: <20261118073505.288910-19-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261118073505.288910-1-nilay@linux.ibm.com>
References: <20261118073505.288910-1-nilay@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: QE3h9ioplm91bIUA3xNocfsNvPTX2-fb
X-Authority-Analysis: v=2.4 cv=HL9WhYtv c=1 sm=1 tr=0 ts=6afd55b7 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=mgqsmbDQb_rkrO5PrMAA:9
X-Proofpoint-ORIG-GUID: IjwCohSapMprla11GAtW1_9k4s9KUVHR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDAyOSBTYWx0ZWRfX11YscuGlv208
 OPZxjOzi6g5u3C4xd8fFWQVg1+PHhhArfqONuLjynzsZF++2lRAiycbxVdRXYH6OcR7qdIhg6y+
 koL7TgD48exJ4mTxjutJw8YpCGzXff8xLq1fBPUj2VpL2v3vu7NWEycSQ+Q8ki+6Xvo3K0BPSsd
 W3fNpS6pS1Doh1//mPOK+Hef6H+ewAonfbTTFZW11RZOGZRVOQ5irSU0CBBh7hrKQxDWvA83xHv
 Z/+UVyZw3Xp11YMGAIVD7J0QjpKiLeqbsuC3cJfjaDYg8bRUFPjjU8oDHAqMfwKfPNrrwpLLLex
 3BQKjo9lT+0QvgnZmFNZR7vt8aKblaho726hAkj9CVWGH+HeRu2qT9LSmmiQB176AUKyZcvd0ip
 6+7OnpzWwF2qZElU5BaLfatNzavnqAs1sRjiG7Sktnm9jtqlG7M/lBWaJkI/gmm6iEh4xCwViBa
 dzAGl9fiCdch0iPfCxw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDAyOSBTYWx0ZWRfX+vFBvIRPSOn+
 Cga12N4SQrEVxomjM2vpRIsh0fw2PdiLUMAcASemVqBvvbjNXY3sj8GkkrcpJjuVSzYt5Q8L8MT
 LQdpIXo7jpeLUZJ10Kk3pqPFyow/Klc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-18_01,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 spamscore=0 priorityscore=1501 impostorscore=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611180029
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261117_234112_317769_5185533B 
X-CRM114-Status: GOOD (  13.41  )
X-Spam-Score: -2.6 (--)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The nvmet_ns::p2p_dev and nvmet_ns::use_p2pmem fields are protected by
nvmet_subsys::lock. However, nvmet_ns_p2pmem_show() accesses these
fields without holding the corresponding lock, triggering Clang context
analyzer errors:

drivers/nvme/target/configfs.c:587:42: error: reading variable 'p2p_dev' requires holding mutex 'to_nvmet_ns(item).subsys->lock'
      [-Werror,-Wthread-safety-analysis]
  587 |         return pci_p2pdma_enable_show(page, ns->p2p_dev, ns->use_p2pmem);
      |                                                 ^
drivers/nvme/target/configfs.c:587:55: error: reading variable 'use_p2pmem' requires holding mutex 'to_nvmet_ns(item).subsys->lock'
      [-Werror,-Wthread-safety-analysis]
  587 |         return pci_p2pdma_enable_show(page, ns->p2p_dev, ns->use_p2pmem);
      |                                                              ^

Fix the above errors by acquiring ns->subsys->lock before accessing
PCI P2P parameters in nvmet_ns_p2pmem_show().

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/target/configfs.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index a69405279fe3..d7a153dbd494 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -582,8 +582,13 @@ CONFIGFS_ATTR(nvmet_ns_, device_path);
 static ssize_t nvmet_ns_p2pmem_show(struct config_item *item, char *page)
 {
 	struct nvmet_ns *ns = to_nvmet_ns(item);
+	ssize_t ret;
 
-	return pci_p2pdma_enable_show(page, ns->p2p_dev, ns->use_p2pmem);
+	mutex_lock(&ns->subsys->lock);
+	ret = pci_p2pdma_enable_show(page, ns->p2p_dev, ns->use_p2pmem);
+	mutex_unlock(&ns->subsys->lock);
+
+	return ret;
 }
 
 static ssize_t nvmet_ns_p2pmem_store(struct config_item *item,
-- 
2.53.0



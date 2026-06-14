Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80CFBCD98C5
	for <linux-nvme@archiver.kernel.org>; Sun, 14 Jun 2026 13:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+R03tGF9molSsiZLMX2RLmOQx6ijLRIoE/l4iUn1ryo=; b=IiJa5aVUwZwB29vxCubPrMpVZ3
	QOw9HlknbdEiZ7DFa93T19Pm0M9x9XPt1JJodDIRnId9CoB3JtU5w+K7TGmeSeV4iAS+Fi/sr0PRc
	4OfOLDAcSEYq8YkZbw2T1T3TP1io/FS9/y6G+qRfLsuTf64eRpyq8OPFZg5ScJHtbdy7eWsEgG6Xd
	BXhjicX9itNu8uS6TyBLd8yJnSCbtECbWptPdV5uAUT6Nz+D25o2/gbIlbhDydq+76IE5JiCx6w3I
	+dspNHEARPiNFZ/k70D5tiHDekldW/0m7bhYd4s4m+U9zYQzHmIJmzhPr4NiVm2ojp1PBA9YJhBvv
	kKkYLYWQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wYkht-0000000D1Lx-0Xes;
	Sun, 14 Jun 2026 13:16:57 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wYkhq-0000000D1IK-0dvk
	for linux-nvme@lists.infradead.org;
	Sun, 14 Jun 2026 13:16:55 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65ECnOZO3522978;
	Sun, 14 Jun 2026 13:16:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=+R03tGF9molSsiZLM
	X2RLmOQx6ijLRIoE/l4iUn1ryo=; b=ZyonOVSTtXZwzq1L1gaFl9+6VeHIMGiPQ
	2WQGrnKxXmg6wfDEm9gv85ZFHEnbPwQ6J17gRgEG4hNelxEAmGkCOZyLAd3zUI30
	njCy4oYn95VZS3gueQo0KbtRrVLvhEa6z6Aj4UYvnpzG6SJC3KlVNKkYlMPtcY30
	cH6tW405dAJdMfCJMnpl3uveLIdfnszMQ81hWL3hWyLHSC0VAVnRiUzfUDP5Vl1R
	wlyBzsipuEvY2A0pXFaJ+S+293NFmLqmqO91jN2nuK9NrJkdEDyBUwBjPUCzBCpM
	t1DlpVgKE3Stl1rQDiqh8aGNb+H6a6F4GCgEIyF2kjFPllzaZDceQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4es1u0b9vh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 14 Jun 2026 13:16:43 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65ED4Zqg031235;
	Sun, 14 Jun 2026 13:16:43 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4eskrg1fxb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 14 Jun 2026 13:16:42 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65EDGd1050856366
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 14 Jun 2026 13:16:39 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 71A5420043;
	Sun, 14 Jun 2026 13:16:39 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E2CB220040;
	Sun, 14 Jun 2026 13:16:36 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.43.80.1])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 14 Jun 2026 13:16:36 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com,
        bvanassche@acm.org, elver@google.com, gjoyce@linux.ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCHv2 16/17] nvme: fix Clang context analysis warning in tcp.c
Date: Sun, 14 Jun 2026 18:45:31 +0530
Message-ID: <20260614131541.2017845-17-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260614131541.2017845-1-nilay@linux.ibm.com>
References: <20260614131541.2017845-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: oOc30qq8si8fvoiCezPrU07ki5osWM_-
X-Authority-Analysis: v=2.4 cv=XdK5Co55 c=1 sm=1 tr=0 ts=6a2ea9bc cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=Flr4-XlrR5qWkiHAPsEA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE0MDEzMCBTYWx0ZWRfX0nZOZKnhix1P
 TOvllwXFIIXEj3HhP830Uw3v1sgx5mPI5Fubx/rfQtvT7LUEnaK5LxP80o7nA6XsmXJ56CftKiD
 R+7oWqK3+UbpsaFu2ZjnN00UiEJ9204vgJcFqLLGsmoj9XwBuvXZCEwsOQoklXtj1UrU/oLG+yI
 LB4+4Qk6iM1DXHJ/uQ7SDVST4D4Qrmd67MIpugdh+aswfSBcAu86DhPyi/qMo2wC7VU659K3a2h
 vPvRKXBTyEma7d86RQjsv/fZE1O5A00d3vG9nDPfg+DjK3mbfv8HpPEVOEyv4uDqsWVZI1KicMW
 b1WeRQCPbsY4x0Hci1tBZiZKmZwc2zzb/nMqTXCexyGv9/0FiXm+nmb7RE3PziDKjy4IN/nxgUk
 BVeS2ghoWhnHDmL0tje/q/viaP7gcbzalJNMCH0aeu/tRST/MMVElZujdBtjKaIVIwyYhwEu17U
 GCaXo83M0fZ8xBm1fyQ==
X-Proofpoint-ORIG-GUID: RXHz9CBQBJlrl4Iab_qYQDUhwVJNWmDL
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE0MDEzMCBTYWx0ZWRfX9WBgzk0BRDFu
 cGHHhMYsVLG/JWCTbQGRV8ByV4voi3X6/6euESd/4Q7nvni6eI0A2YWC7aiJDvOXGIMfx6+0RBr
 6PGJzC9wf9GjEJDUEH/B3cLdIVTNeMg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-14_03,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 malwarescore=0
 spamscore=0 phishscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606140130
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260614_061654_317285_53484BAF 
X-CRM114-Status: GOOD (  14.86  )
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

After adding Clang context annotations, compiling tcp.c reports the
following warning while context analysis is enabled:

drivers/nvme/host/tcp.c:2572:24: warning: passing pointer to variable 'list' requires holding mutex 'nvme_tcp_ctrl_mutex'
	  [-Wthread-safety-pointer]
2572 |         if (list_empty(&ctrl->list))
     |                               ^

The above warning is triggered because ctrl->list is guarded with mutex
nvme_tcp_ctrl_mutex but when list_empty(&ctrl->list) is invoked it
doesn't acquire nvme_tcp_ctrl_mutex.

Fix the warning by performing the list_empty(&ctrl->list) check while
holding nvme_tcp_ctrl_mutex.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/host/tcp.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index c4662ccb5c49..86ef98aefeb4 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2569,10 +2569,11 @@ static void nvme_tcp_free_ctrl(struct nvme_ctrl *nctrl)
 {
 	struct nvme_tcp_ctrl *ctrl = to_tcp_ctrl(nctrl);
 
-	if (list_empty(&ctrl->list))
-		goto free_ctrl;
-
 	mutex_lock(&nvme_tcp_ctrl_mutex);
+	if (list_empty(&ctrl->list)) {
+		mutex_unlock(&nvme_tcp_ctrl_mutex);
+		goto free_ctrl;
+	}
 	list_del(&ctrl->list);
 	mutex_unlock(&nvme_tcp_ctrl_mutex);
 
-- 
2.53.0



Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 367B2CD98DC
	for <linux-nvme@archiver.kernel.org>; Sun, 14 Jun 2026 13:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VLW8tsoQup8Blbwkc/szIi05fkqf1XslBLstl8xT1I0=; b=sFzcW2HWR301hKcRwqo47vxrfS
	R4ANZk6GjX0oZ+3wu9WFOq0EftIlYm5EaKaMK2OlN9zmOKVsCvDNbdTFnFpYORNOmpjDfbrSNuV6v
	k7ykbRkj13ELuIdDzNOenExPz0M4sG4ZFNIaunkwObSJHXK/4J74AwmqXIqe+3cnm0ESVuluWwjn8
	RU8O3/+ikA0ZOlgXHl0rDh64r+4qzYMLX+X6q9D6OOZlgAHhlExu2hkK2t8tIv7dpDTbikYcMqvt5
	SC44GEkK+HPuS4fR0oZNURBn5j+VJetuUpT1DoBJ5RfOt5TDMKu7MZRbBHzbCam8MmaIZlLYhNVAM
	kwlcoXbg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wYkhS-0000000D0qX-353e;
	Sun, 14 Jun 2026 13:16:30 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wYkhQ-0000000D0oe-15kw
	for linux-nvme@lists.infradead.org;
	Sun, 14 Jun 2026 13:16:29 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65ECmm2D3484882;
	Sun, 14 Jun 2026 13:16:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=VLW8tsoQup8Blbwkc
	/szIi05fkqf1XslBLstl8xT1I0=; b=YdzCK8BkUHZ40aRPrZLrlaoT5dCeRhAsX
	jmI+KJeWAc9LN64UCEJAShZ156As01fxkJ3/9NhXFitLSG+GNwcKnm9UrzYUcjx0
	LceSkjKwQCbvAXYj25y8pmniLLxOvEoiiSHUfLZNUMjwsf/340XCLrnn6lrLA7sK
	V7cHphg7D8Hjle9DMbP53UQjlQWaXO2YLFHLPvLRFDv6rc7MTnKpUQTxZ9boenP7
	MdDD1CsGjrKv8P3oNCloF1uuEGCAReJPtMpu0sIVcsqaRRAcg6AA32kh1VLhTJbo
	i0I0Gl9trjpQWs5gWKhJHEzlXYJmQxnro/Ly3yeqxAR8ZkStL0RBg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4es1wkumj3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 14 Jun 2026 13:16:10 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65ED4c9C031291;
	Sun, 14 Jun 2026 13:16:09 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4eskrg1fvy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 14 Jun 2026 13:16:09 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65EDG64c18219290
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 14 Jun 2026 13:16:06 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 142EC20043;
	Sun, 14 Jun 2026 13:16:06 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4F4BF20040;
	Sun, 14 Jun 2026 13:16:03 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.43.80.1])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 14 Jun 2026 13:16:03 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com,
        bvanassche@acm.org, elver@google.com, gjoyce@linux.ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCHv2 05/17] nvme: add Clang context annotations for nvme_ns_head::current_path
Date: Sun, 14 Jun 2026 18:45:20 +0530
Message-ID: <20260614131541.2017845-6-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260614131541.2017845-1-nilay@linux.ibm.com>
References: <20260614131541.2017845-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE0MDEzMCBTYWx0ZWRfXyLxafnejPPhm
 m0ySAkzqJVcbiyJ9tZp3fsGu2qEPYch1q9NZFgHGhy89eoyk/33Ws9oVrtyLmXGDXRBWY7xAAjA
 eB7IFktKtBNMpxFG3hdotNNtErjXlVE=
X-Proofpoint-GUID: gieN-eifk7E7ADbcdEYDyP5eu1wq-HNR
X-Authority-Analysis: v=2.4 cv=SY/HsPRu c=1 sm=1 tr=0 ts=6a2ea99a cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=OwJPlnfhOLUwuA7eXoMA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE0MDEzMCBTYWx0ZWRfX6GHil9lrzVtH
 eVcqefYKKbR4tnaP4V+yH/puRZjVSA7DMRvUH81NMD/9FU6bkOFfXhYc1T51iefm53nFO40w2Vs
 y/I2mqXL9FIxDAUYL8nUBv5+HmIzfAPBU2jLJ064BL2AF7iO9hRsikzX+hWuDat6U6/C/DiBE6W
 2+vSWOF/k/BmDX0MmAvr7NGFTUH3CjYpzkdUCeSYOGbPdWb8+duO51VX/Lbp1ZIRWGqQcS9hxiP
 xvaf5Jg27AsF31rB7Bf5f3SSyJldcZPzkl97TDR17sE+fjNtJPdlsacKy/QloQI6IA/IG9ThjMP
 CSsZaXW3pI5xA6Kg22vDImaKqp1e1DcaDCZg5L313U0oHrj/fTUbH+xJSVQoT9JigLd4xhOU5sL
 J7D1V9JmhIO6CS6OiOs6L11GnRArGgyuUhZ3wtxawh7mdzkm9wBzujoLZN0fqCZBwLy2cLtSMWw
 FvoCCHN4MzRMsA8dSIQ==
X-Proofpoint-ORIG-GUID: 3rUXnDpBiNye_Ca6TPgyWk_HTf_9tH2Q
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
X-CRM114-CacheID: sfid-20260614_061628_302675_2D2C9B03 
X-CRM114-Status: GOOD (  15.52  )
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

Annotate nvme_ns_head::current_path[] with __rcu_guarded so that
Clang's context analysis can validate accesses to the SRCU/RCU
protected pointer.

The nvme_mpath_clear_current_path() helper only compares the
current_path[] pointer value using rcu_access_pointer() and does not
dereference the referenced namespace. Annotate this access with
context_unsafe() to suppress the corresponding context analysis
warning.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/host/multipath.c | 10 +++++++++-
 drivers/nvme/host/nvme.h      |  2 +-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 9e7f12fe8cd6..94607c5d1a2b 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -231,8 +231,16 @@ bool nvme_mpath_clear_current_path(struct nvme_ns *ns)
 	bool changed = false;
 	int node;
 
+	/*
+	 * This helper is used by namespace failover/teardown and I/O policy
+	 * update paths. We only compare the head->current_path[] pointer value
+	 * and do not dereference the referenced namespace, so suppress the
+	 * context analysis warning for this lockless inspection of the
+	 * __rcu_guarded pointer.
+	 */
 	for_each_node(node) {
-		if (ns == rcu_access_pointer(head->current_path[node])) {
+		if (context_unsafe(ns ==
+				rcu_access_pointer(head->current_path[node]))) {
 			rcu_assign_pointer(head->current_path[node], NULL);
 			changed = true;
 		}
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index f60852944709..41f42f1aee09 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -565,7 +565,7 @@ struct nvme_ns_head {
 	unsigned int		delayed_removal_secs;
 #define NVME_NSHEAD_DISK_LIVE		0
 #define NVME_NSHEAD_QUEUE_IF_NO_PATH	1
-	struct nvme_ns __rcu	*current_path[];
+	struct nvme_ns __rcu_guarded	*current_path[];
 #endif
 };
 
-- 
2.53.0



Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C48ACD98CE
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Jun 2026 14:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Lb6VAsqvu8ksqhSYfmmzJnaFFtL2WmqKVOtw2HEr6Zc=; b=WHRT4+txhJ9p/nXBvZ1jiNmbTY
	zVE5XOSWEtxHFsAoStsAORwGixmIqcXIgWb4yHPeeSpqdfG2z+RI6T82EZHlx3tS0z6JkAanBdyuw
	3Z6VxMDZbOO1p3NfiTLYOjTUEz7SyWx7Jq8x4aGO+nCymx3GxvoEc527etOcSsTIXf5vrJbQvBdPh
	uL23ZzqxBWF665MROpFfJ9xqnI51huW5SVAnAEfDyag8SN065ujgdHHBsoKZln4olKytlL/YAp/H1
	8zcDOOUXorcgZHiUmM+AK7FYdJK3RLGVjlLQpxvFkEQstm/TK6WdVmcswZ/hTlYaXSwUnRx6/XCoG
	FqP9JEcQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXJv1-00000007saP-45HY;
	Wed, 10 Jun 2026 14:28:35 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXJv0-00000007sXx-0qb1
	for linux-nvme@lists.infradead.org;
	Wed, 10 Jun 2026 14:28:35 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65A8H7uT2813091;
	Wed, 10 Jun 2026 14:28:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Lb6VAsqvu8ksqhSYf
	mmzJnaFFtL2WmqKVOtw2HEr6Zc=; b=sB/gNtqbC2wC/ZjvwvdeVr/kJYz4IOfwO
	NviJEscCHm2TlX0dzPLM4tTiYbiriaGpSw4h7k20/EvK+F7KAP36vlJ1HECepqWX
	a2Rn2K+HhGkAdD8rouKYUU0Dgtb8QdexMp/KzfrwiPrsIqZaK6mGB8+8l014tDuf
	cL8CkBaMunD1wWOjFovptSeLoZsudoMdsoCFi5puPuEUE9H4QCO7QSo8xZ/sl+yt
	kEAZJ8ODYikQCxxm5PqbWHdFC0txSpKRPuOACvwsT+ChPwKTsAg5d9y+euUJOan2
	HpwONEgWSOrg5d2s1RgZklyC/1eWzTp8rZ++VM7jcAZSkD0nWgTGw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4emb95hhet-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jun 2026 14:28:26 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65AEJqEp009343;
	Wed, 10 Jun 2026 14:28:25 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4emych6wgv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jun 2026 14:28:24 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65AESLiO27984254
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jun 2026 14:28:21 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1697320049;
	Wed, 10 Jun 2026 14:28:21 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DF5A220040;
	Wed, 10 Jun 2026 14:28:18 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.43.34.89])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 10 Jun 2026 14:28:18 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com,
        bvanassche@acm.org, elver@google.com, gjoyce@linux.ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH 05/15] nvme: add Clang context annotations for nvme_ns_head::current_path
Date: Wed, 10 Jun 2026 19:57:25 +0530
Message-ID: <20260610142743.115898-6-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260610142743.115898-1-nilay@linux.ibm.com>
References: <20260610142743.115898-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=N4UZ0W9B c=1 sm=1 tr=0 ts=6a29748a cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=OwJPlnfhOLUwuA7eXoMA:9
X-Proofpoint-ORIG-GUID: i6i52n2X9zEPnxdPCSq583wQWnWymm5Q
X-Proofpoint-GUID: n85_HnT3zM0InKpWMgdSuYXTheNO5Ab-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDEzNSBTYWx0ZWRfX/Q1a+iPliTkw
 8PwUBcN5BvrN4BPxHAkeCu+R8P6kNYFAaasyudxNHpOmEM3t61ydaQLKLoNsHLYTckJuxpk1v8U
 8qEgrPa3fc04KCRmQphuNE7QNl3nUOZl3NlHhZi5JUQgbfY2xiDv+s0AV0V5McCOSikdCoBDTI7
 mk0FXYxXhD632bHwhdpGvvaM0RMkvRBN8CHydtouh01H+mq20oe5gnfwHn9RG8t2iVlsO6rKmjC
 QTnsvccydNN0Vl3RBYO1oJOHAv17qgwyxPKm0MUdwhF/QG7Qys+y/kY9ACF/hidrv+2/4oIrxq5
 KNqmU8+Sfc/OJxFOZh6wW/qKDZQ60regcTeYMHDVWi3nSw3Jjn0VfXjJyPiOWPpXIlIe/E8c7a/
 4wgGsAZ/Z/2U2nSv+C38FaaoLGGfCWcClcAG/3yaU5I4nxsO6NFgBUKFRs/fv5yL1CjK8yjtat1
 4Y6QE7Ad8Bjeb42QciA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_03,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 clxscore=1015 lowpriorityscore=0
 phishscore=0 impostorscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606100135
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260610_072834_254240_9E290D2C 
X-CRM114-Status: GOOD (  16.22  )
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
index 985a8c693c6f..ef072588eca0 100644
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



Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02949606A330
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Nov 2026 07:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=BBIAu1WZ;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=jMlIh2zN
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=yoqnsab45ehdQLefGH8qdoGtUuyg8vzVJUNZV9PmLE8=; b=BBIAu1WZ34Bcrf
	JHwyjcIX/JkZmua/EPTgyf5pHPfN95UPLQ+GzfUKtah7ZZK2SK8qMziRGI0JlF85H9YPKRBG/f7Q/
	MB42swEPNzOZitbBb+H+bFXE1jzXPWPHPxpJ3JSCqsUPAbH+f5DzOCQE/dOHX3pcFSVl43L1s4ggA
	e/FLJFrr9yZCJSNJDMKQdjE9ny3skLzs9oDxJk5FN5qOFWmlv19747S4J1QU3S0pvwCfq+SnvdVtG
	RAvMDXHd3I4BrSFdt/pNVyot2SnoolsUPaOMX4mxoVjoTvOwWICHWTrtnPrPnhkyn9JXyLDaOYecW
	whDg0scdtJnf4Swl4bLg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTaDG-000000080rn-2bXN;
	Wed, 18 Nov 2026 07:36:14 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTaDB-000000080pm-0hAF
	for linux-nvme@lists.infradead.org;
	Wed, 18 Nov 2026 07:36:10 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AI2S72m032120;
	Wed, 18 Nov 2026 07:36:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=yoqnsab45ehdQLefG
	H8qdoGtUuyg8vzVJUNZV9PmLE8=; b=jMlIh2zNtSKnp7bWrKFNaXXYwEACg4NcZ
	WFFUU8dm3VeqXjApOqu6RH7CyBRPgEeA3byAmdRKRW3BQXaji6oXUvdnGMCQQjok
	S9SilGKaSc6kwXaH7XExfNF8QQdrduGDem87qqL3thZY0HPJUc8RNcxmAc4hcjEQ
	a7onohpwZi088kh5+Bzguhxo8CSv026OM/I0M3krcnCqTyTb+bq6bfhyj+CKXqE7
	bFYirk8a5uY8D2Ou57wFd7X+PasJuuRmnKvtbe3Ntfxe+j65OP5nJaW5eCCUxnZi
	R6uX95jzLMV5rUeZm9DZME8zkgefMYkw9uo/0V3Q0OVz8c95iDeoQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j105n9cu3-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 18 Nov 2026 07:35:59 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AI2Z1b52477237;
	Wed, 18 Nov 2026 07:35:58 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j02jufaxe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Nov 2026 07:35:58 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AI7Zs0G54526420
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Nov 2026 07:35:54 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9C1C52004D;
	Wed, 18 Nov 2026 07:35:54 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2523320040;
	Wed, 18 Nov 2026 07:35:50 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.61.157.4])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 18 Nov 2026 07:35:49 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: kbusch@kernel.org, hch@lst.de, bvanassche@acm.org, sagi@grimberg.me,
        axboe@kernel.dk, chaitanyak@nvidia.com
Cc: gjoyce@linux.ibm.com, elver@google.com, linux-nvme@lists.infradead.org,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH v2 02/22] nvmet: fix nvmet_ns::bdev access using nvmet_subsys::lock
Date: Wed, 18 Nov 2026 13:04:43 +0530
Message-ID: <20261118073505.288910-3-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261118073505.288910-1-nilay@linux.ibm.com>
References: <20261118073505.288910-1-nilay@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDAyOSBTYWx0ZWRfX2aEtz/rCMypc
 w6Jfl2LJ+M9jMCSpGjGpMkItEk5XYAeDEH+nkIb86evCMoZZXdVxiif/r2BLky3Cz2XhLhY7K9s
 OwyrfxhNt423+xR9wU1qQ9KbUeuBPZOoPdSOWmXiwOOU6UaglDsZKcdBtlKGj20pOEjDHArxX5U
 Pe/BcrYnHNHfq06dye86+33DNtZiZZfOVo2oEyPkhNz5iZe4MGCuw/FZ6obsQEWoHAxQk6gkITG
 6lhG3axES8lEpo9UFxJR61rpzygVfTLt2vtUI87D7gli8TsSaWebF151HpGOva/wupdhpxD0zo0
 4kp7Ni79XAFZfDCR69Pi5UrBEw6S0MIqvNx7Ra/HbKaq2R7B1sQ3s535SC0k2x61+2Wqe0ESg29
 KrDiTaIhgB8/NlZYO3vmhVpg2882ZUN1+wb3Vew76ABSocCYq2a3DFRcUXE7U3wVYb/QKWcy4h6
 /1lHq/fbdjBqm02fJnw==
X-Authority-Analysis: v=2.4 cv=HN9WhYtv c=1 sm=1 tr=0 ts=6afd5560 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=MMLL3j20_zw5vxwgO4QA:9
X-Proofpoint-GUID: VuBB92NxcbLrTw0xO6Cqt3TyF5DiMg2_
X-Proofpoint-ORIG-GUID: lXC3A-oaKSYmTTotfJKIB_cHmLCHXLXn
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDAyOSBTYWx0ZWRfX2Z8WNn6NW7/y
 gMDe0Y+qVraX9kpCOmGnAQSQ48A3DjDxUTQN/d9kVDRxFJp1VJ6EpamSph1vwefyGE+6QuQMA9V
 xZ/W8JRKb2OdwdxSMKOsFyMcLfV7AlY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-18_01,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0
 adultscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611180029
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261117_233609_216762_951735B4 
X-CRM114-Status: GOOD (  16.04  )
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

nvmet_get_smart_log_all() iterates over enabled namespaces and accesses
ns->bdev to collect block device statistics without holding
nvmet_subsys::lock.

Since nvmet_ns::bdev is annotated with __guarded_by(&subsys->lock), the
clang context analyser reports this access as a locking violation:

drivers/nvme/target/admin-cmd.c:274:12: error: reading variable 'bdev' requires holding mutex 'ns->subsys->lock' [-Werror,-Wthread-safety-precise]
  274 |                 if (!ns->bdev)
      |                          ^

Fix this by acquiring ctrl->subsys->lock while iterating over the
enabled namespaces and accessing their block device statistics.

Although ctrl->subsys->lock and ns->subsys->lock refer to the same
mutex, the Clang context analyzer cannot infer this relationship
because the lock is accessed through different expressions. Explicitly
assert the ns->subsys->lock capability using __assume_ctx_lock()
before accessing ns->bdev, and release the assumed capability using
__release_ctx_lock() afterward.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/target/admin-cmd.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index d45c05f5d746..70b52a43156b 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -289,17 +289,31 @@ static u16 nvmet_get_smart_log_all(struct nvmet_req *req,
 	unsigned long idx;
 
 	ctrl = req->sq->ctrl;
+	mutex_lock(&ctrl->subsys->lock);
 	nvmet_for_each_enabled_ns(&ctrl->subsys->namespaces, idx, ns) {
+		/*
+		 * Both ctrl->subsys->lock and ns->subsys->lock refer to the
+		 * same lock. However there's no way for us to annotate such
+		 * locking semantics using clang context annotation. So
+		 * explicitly assert the capability.
+		 */
+		__assume_ctx_lock(&ns->subsys->lock);
+
 		/* we don't have the right data for file backed ns */
-		if (!ns->bdev)
+		if (!ns->bdev) {
+			__release_ctx_lock(&ns->subsys->lock);
 			continue;
+		}
 		host_reads += part_stat_read(ns->bdev, ios[READ]);
 		data_units_read += DIV_ROUND_UP(
 			part_stat_read(ns->bdev, sectors[READ]), 1000);
 		host_writes += part_stat_read(ns->bdev, ios[WRITE]);
 		data_units_written += DIV_ROUND_UP(
 			part_stat_read(ns->bdev, sectors[WRITE]), 1000);
+
+		__release_ctx_lock(&ns->subsys->lock);
 	}
+	mutex_unlock(&ctrl->subsys->lock);
 
 	put_unaligned_le64(host_reads, &slog->host_reads[0]);
 	put_unaligned_le64(data_units_read, &slog->data_units_read[0]);
-- 
2.53.0



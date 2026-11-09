Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CAED606A31C
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Nov 2026 03:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=TJ6d3ric;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=kZ04Vi7H
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=n96J0IdjbVJmD8Bi938Q9RfN7Ag8s6CBSge3Rf4bnSo=; b=TJ6d3ricyZp6dl
	aH+YJR6DEa7aPHuZcgs5Ik+Q+Ane08O+if4AbBMBLRFvQsN6QhPGXX6Zs76NvvUkmx4LBpM6yehHb
	pGdLVhxOyNOmQLMI8do26yvvoPqKvVVal6VSHW9GkBk/gArjKoZyWfHXDjPQfS7HfaLAFX/ksROL6
	okCNKc/XgQnETkE9JKc3Jm6lgAwVym3T7Qmqy3RsHuxa6N4PUO55RI3QcF99ETc40vTUTM4TLgZeL
	Nt5Sgek4JkcqcYYY+99ez55h6mu6/0D6L/QqXLOe115ufRrSS6SvpNlJwxC/Z5eCr8wobmNoFGqEL
	z3zNUJerfmyBr/E6lqFw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQG6n-0000000HCME-44RJ;
	Mon, 09 Nov 2026 03:31:49 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQG6l-0000000HCLd-3KSm
	for linux-nvme@lists.infradead.org;
	Mon, 09 Nov 2026 03:31:48 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A90iuBm1947122;
	Mon, 9 Nov 2026 03:31:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=n96J0IdjbVJmD8Bi9
	38Q9RfN7Ag8s6CBSge3Rf4bnSo=; b=kZ04Vi7Hhtyb3GjaxFXYetFwUUKtLBeAw
	dQ/R5stIkLGeq72SILD2pNi22/jhzzS5ytCz+kGo5wxTo3xNCEnlAlxJ2t5ottIh
	XKXTTj1vYjG4knEbFvM945CJGNnOaHiRVn1ZQ+nx+EX4NK1DOmF6/4w4en+cnK7H
	I72/CIqxNqFPKWscmCjiFQSds7B8fjImVjUUAT57WDsCYcbELIFv9EvSU8QY9o7K
	iS/DwpfqukuPeMu+DLbV3zfj+FGl0idoNaGwC6L1ZCIT6dNBgHsPqo8qoE6I8AUA
	TdWiJhEe9OqxBNLTrBlnbh+zgDjL2nxdyIl2sU+VHCf12ieeVjyXg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsuq6jeb9-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 09 Nov 2026 03:31:37 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A93K2h13580729;
	Mon, 9 Nov 2026 03:31:36 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hteapwp3a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Nov 2026 03:31:36 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A93VXUT43057556
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 9 Nov 2026 03:31:33 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ED46720043;
	Mon,  9 Nov 2026 03:31:32 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 117B220040;
	Mon,  9 Nov 2026 03:31:27 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.61.101.130])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  9 Nov 2026 03:31:26 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, axboe@kernel.dk,
        chaitanyak@nvidia.com
Cc: gjoyce@linux.ibm.com, bvanassche@acm.org, elver@google.com,
        linux-nvme@lists.infradead.org, Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH 02/23] nvmet: fix nvmet_ns::bdev access using nvmet_subsys::lock
Date: Mon,  9 Nov 2026 08:58:07 +0530
Message-ID: <20261109033102.982191-27-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109033102.982191-25-nilay@linux.ibm.com>
References: <20261109033102.982191-25-nilay@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDAxMiBTYWx0ZWRfX+GcnrMKucfTv
 9ylQtaL+wUN3f25j5GIqG9BVurR5+fEyzFuuFI6Fu8aTEhTiFyO/OsG0Bxx6yQKz+dXS0RLPi0h
 webtCINZRKYGRtlz0Qs5cOpeVvzy36k=
X-Authority-Analysis: v=2.4 cv=HbCB3SE8 c=1 sm=1 tr=0 ts=6af13e99 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=1IMtbHEatuid3lqjeBwA:9
X-Proofpoint-ORIG-GUID: z4t0e0azy6H3u6wSUQiFXsJwtfd-3Wia
X-Proofpoint-GUID: 0KYantcvF2MlxcFmZdWIMHlb3NNeS66Z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDAxMiBTYWx0ZWRfX0XLzRZhqNJMg
 +msJ4aVFKh2Ed39qAqUNQX/z7NdusVqT9OWpqSjbxE5x08wJhB6LItHoBjVNorcMgLWCivyo43F
 ZhfvMBr07suDLgQStsDs2pUDMMTdiyaoNIDF9X/QCRGhUV6JxAm0eIS8aPkZa4Gst6cXQnw3Fh7
 nKErDAQ0Q4jGp+tbuAyO42tjL8WmCaM2EKKtpa5kgimiP1tqJo0srGGmbYlqQSgx0u9+gV8X67h
 MyPsvKi3ISWp0S4iheHgY1AFkZYvbj93mbspr1SSHslyAt10IneC+X7Wufufb7rXLtXwuXFuqAI
 WJDZdSS6RojxiSXbUzyjnsWuMQdzGOV1dH8iGXeMt6/Wmve3OIZU6t07ctQ2Mvv0nsd9xxLMjru
 1oGRuomWe9nZNbpZIVC2/zmxA8QUC2n3Tvn+SZ/csC3gJk//EdV1ljm0CwZkPWOsN5TXv5lMC8k
 HOI2L5EALz+agW/NLew==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_01,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 spamscore=0 bulkscore=0 phishscore=0
 impostorscore=0 priorityscore=1501 clxscore=1015 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611090012
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261108_193147_842872_0B8C4D89 
X-CRM114-Status: GOOD (  14.52  )
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
clang context analyzer reports this access as a locking violation:

drivers/nvme/target/admin-cmd.c:274:12: error: reading variable 'bdev' requires holding mutex 'ns->subsys->lock' [-Werror,-Wthread-safety-precise]
  274 |                 if (!ns->bdev)
      |                          ^

Fix this by acquiring ctrl->subsys->lock while iterating over the
enabled namespaces and accessing their block device statistics.

Since ctrl->subsys->lock and ns->subsys->lock refer to the same lock,
explicitly use __assume_ctx_lock() to inform the clang context analyzer
of the corresponding locking capability.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/target/admin-cmd.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 2d4e21b3ee7d..517f8cc78473 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -289,7 +289,15 @@ static u16 nvmet_get_smart_log_all(struct nvmet_req *req,
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
 		/* we don't have the right data for file backed ns */
 		if (!ns->bdev)
 			continue;
@@ -300,6 +308,7 @@ static u16 nvmet_get_smart_log_all(struct nvmet_req *req,
 		data_units_written += DIV_ROUND_UP(
 			part_stat_read(ns->bdev, sectors[WRITE]), 1000);
 	}
+	mutex_unlock(&ctrl->subsys->lock);
 
 	put_unaligned_le64(host_reads, &slog->host_reads[0]);
 	put_unaligned_le64(data_units_read, &slog->data_units_read[0]);
-- 
2.53.0



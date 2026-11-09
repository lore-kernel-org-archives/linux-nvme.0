Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02669606A31C
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Nov 2026 03:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=u96gLGIL;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=jPfcCzMO
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=EAl6VRqRf9Ci/gb2yvESuoP4fP0juJ1gINt28TnIW00=; b=u96gLGILgIXuR6
	VFlUB4Esos3sG87jaeVve7j2/fy6KEwQ6aRqtGw0YixtnwkgwWArcoWQ7OXZ4o6208c7xE6oqx39L
	leyAbzri/GYllgR6YRUTZsRLQqo/a1zaCyhYIrDdOwjRiQo++lnqCG3P2P2Cvr7d5rLkwVWZlgDFM
	GQnCwjthFx43wIWx3KD5E0AVuGFfSbhJgLfL9CUgPCBDumOqgjm6epzwls6Qv2B5t7hOU0QNbHlUI
	txJhIlTSLhPKab/MvftHg+bIumSMxafFA2nPl6E4zH8AvD2pa84QJf/s48bcqpZzbjn4fv0WNzpnC
	tlo0Nm7+v8ntm7XJvdKA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQG7P-0000000HCnP-2hQX;
	Mon, 09 Nov 2026 03:32:27 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQG7N-0000000HCke-0Cns
	for linux-nvme@lists.infradead.org;
	Mon, 09 Nov 2026 03:32:26 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A90isf82150265;
	Mon, 9 Nov 2026 03:32:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=EAl6VRqRf9Ci/gb2y
	vESuoP4fP0juJ1gINt28TnIW00=; b=jPfcCzMOge0ApCGiPssvZWuZulcGtaKzp
	0qb3x0h/ed23K+ZsmwADV9nAoVoQLN3qir4TP/oYYINCYyNwjBFJftrlgw3DCmpo
	N8B9RKjU7XXFc4FEpwvUQ7jG3Y/mMNaQgQEadnKx5sU5bsYx1ruNRAjhfQAgI/SO
	KFq4gYWGtCJ6QbpDKonHJO9shCvHD+lbzEtHkftL9ZgUpuFVCXcrVscn06aoBlOd
	lwJmn9N8enP759WkFljPjtWzlOChKQDto0K9FhMBeTENy/93+5YBlIoR4P0VZc1y
	750j3Rhe4kwqtVeD9YXvHmQD0GyhNf4zdEwriCQVirKmxmI8zql1Q==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsug5tg97-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 09 Nov 2026 03:32:16 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A93K4ui2454181;
	Mon, 9 Nov 2026 03:32:16 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4htghfw748-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Nov 2026 03:32:16 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A93WCNC40174014
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 9 Nov 2026 03:32:12 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 556D320043;
	Mon,  9 Nov 2026 03:32:12 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B411020040;
	Mon,  9 Nov 2026 03:32:06 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.61.101.130])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  9 Nov 2026 03:32:06 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, axboe@kernel.dk,
        chaitanyak@nvidia.com
Cc: gjoyce@linux.ibm.com, bvanassche@acm.org, elver@google.com,
        linux-nvme@lists.infradead.org, Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH 07/23] nvmet: fix nvmet_ns::nsid access using nvmet_subsys::lock
Date: Mon,  9 Nov 2026 08:58:12 +0530
Message-ID: <20261109033102.982191-32-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109033102.982191-25-nilay@linux.ibm.com>
References: <20261109033102.982191-25-nilay@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: Si8nEdUjRT219DO0C4e0XamGKi2lPWpE
X-Authority-Analysis: v=2.4 cv=PeVqFShd c=1 sm=1 tr=0 ts=6af13ec1 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=c1bqBYDh63IrXXEvm_wA:9
X-Proofpoint-GUID: 7ODYf1puxLfUaWCsvN7P4VwDpFMbavtz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDAxMiBTYWx0ZWRfX4F6Se0VfVQU6
 yhxqSJMuRkyQKtcqVkjNSZ5sbto2ohBT/kXFjOPp8TCzlDXiYWvWwMhsOHgTOxG5CPoA/EOJ092
 Co5GIevzNCN9OkKpOXi9zsgEFYMfsYYEYAxVK73cc8NVcJW+YB0C6LFaBR8u/cSpE0edNsaFjyU
 paxZj86/md5iYx8/7deMqmSqAkm/6Y/aL8f7H8k8DEgv/PFYW1ZJj8/xxddCX4kP70FmIrZaFjY
 ny/oc+zTsBJia2UxzxE6TpIr9hfBzM2CQ3szgtLkWIIWwnKJHIIXECSNOPU3Yi9B+hIKZiO8CmO
 I4DhZyT9zMmNQgJB9QaU55gAXnCiP6KJqbHQSkZ6UPKm8EQz3nJ+qFQqoN97qUJTyrNvl++cG9Y
 eF+PILppx/KJP9Vll9wkQrz1YGE0mh64fym/Swlc2Onpp8Myotwh/jQzTc/RhAEg1tWeOf57ayr
 XIp0P9pOocUs/pkKMKQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDAxMiBTYWx0ZWRfX1tpNKDtJMwRP
 V7636tu2tsXKc5C0CdeAqhW8fLL8qJRtAMN/GzdCZve0wsEnrqrTJEENBGO6IoqV0ZwcIzqTfK2
 LE5BlFrNyXkeVKhSkOKV3RQcKUlG+s0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_01,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 suspectscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 malwarescore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090012
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261108_193225_175676_A96E2DA5 
X-CRM114-Status: GOOD (  14.86  )
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

nvmet_ns::nsid is protected by nvmet_subsys::lock. However, the Clang
context analyzer reports errors in nvmet_format_ana_group(),
nvmet_execute_identify_endgrp_list() and nvmet_execute_identify_nslist()
because these functions access ns->nsid while iterating over enabled
namespaces without holding the corresponding lock:

drivers/nvme/target/admin-cmd.c:493:44: error: reading variable 'nsid' requires holding mutex 'ns->subsys->lock'
      [-Werror,-Wthread-safety-precise]
  493 |                                 desc->nsids[count++] = cpu_to_le32(ns->nsid);
      |                                                                        ^

drivers/nvme/target/admin-cmd.c:955:11: error: reading variable 'nsid' requires holding mutex 'ns->subsys->lock'
      [-Werror,-Wthread-safety-analysis]
  955 |                 if (ns->nsid <= min_endgid)
      |                         ^

drivers/nvme/target/admin-cmd.c:1002:31: error: reading variable 'nsid' requires holding mutex 'ns->subsys->lock'
      [-Werror,-Wthread-safety-analysis]
 1002 |                 list[i++] = cpu_to_le32(ns->nsid);

Fix above errors, acquiring ctrl->subsys->lock while iterating over
enabled namespaces in these functions to protect accesses to namespace
fields.

Since the context analyzer cannot infer that ctrl->subsys->lock and
ns->subsys->lock refer to the same mutex, explicitly assert the
ns->subsys->lock capability using __assume_ctx_lock() inside each
iteration.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/target/admin-cmd.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 590ca68588f8..761caac84255 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -512,10 +512,19 @@ static u32 nvmet_format_ana_group(struct nvmet_req *req, u32 grpid,
 	u32 count = 0;
 
 	if (!(req->cmd->get_log_page.lsp & NVME_ANA_LOG_RGO)) {
+		mutex_lock(&ctrl->subsys->lock);
 		nvmet_for_each_enabled_ns(&ctrl->subsys->namespaces, idx, ns) {
+			/*
+			 * Both ctrl->subsys->lock and ns->subsys->lock refers
+			 * to the same lock. However there's no way for us to
+			 * annotate such locking semantics using clang context
+			 * annotation. So explicitly assert the capability.
+			 */
+			__assume_ctx_lock(&ns->subsys->lock);
 			if (ns->anagrpid == grpid)
 				desc->nsids[count++] = cpu_to_le32(ns->nsid);
 		}
+		mutex_unlock(&ctrl->subsys->lock);
 	}
 
 	desc->grpid = cpu_to_le32(grpid);
@@ -966,7 +975,16 @@ static void nvmet_execute_identify_endgrp_list(struct nvmet_req *req)
 		goto out;
 	}
 
+	mutex_lock(&ctrl->subsys->lock);
 	nvmet_for_each_enabled_ns(&ctrl->subsys->namespaces, idx, ns) {
+		/*
+		 * Both ctrl->subsys->lock and ns->subsys->lock refers to the
+		 * same lock. However there's no way for us to annotate such
+		 * locking semantics using clang context annotation. So
+		 * explicitly assert the capability.
+		 */
+		__assume_ctx_lock(&ns->subsys->lock);
+
 		if (ns->nsid <= min_endgid)
 			continue;
 
@@ -974,6 +992,7 @@ static void nvmet_execute_identify_endgrp_list(struct nvmet_req *req)
 		if (i == buf_size / sizeof(__le16))
 			break;
 	}
+	mutex_unlock(&ctrl->subsys->lock);
 
 	list[0] = cpu_to_le16(i - 1);
 	status = nvmet_copy_to_sgl(req, 0, list, buf_size);
@@ -1009,7 +1028,16 @@ static void nvmet_execute_identify_nslist(struct nvmet_req *req, bool match_css)
 		goto out;
 	}
 
+	mutex_lock(&ctrl->subsys->lock);
 	nvmet_for_each_enabled_ns(&ctrl->subsys->namespaces, idx, ns) {
+		/*
+		 * Both ctrl->subsys->lock and ns->subsys->lock refers to the
+		 * same lock. However there's no way for us to annotate such
+		 * locking semantics using clang context annotation. So
+		 * explicitly assert the capability.
+		 */
+		__assume_ctx_lock(&ns->subsys->lock);
+
 		if (ns->nsid <= min_nsid)
 			continue;
 		if (match_css && ns->csi != req->cmd->identify.csi)
@@ -1018,6 +1046,7 @@ static void nvmet_execute_identify_nslist(struct nvmet_req *req, bool match_css)
 		if (i == buf_size / sizeof(__le32))
 			break;
 	}
+	mutex_unlock(&ctrl->subsys->lock);
 
 	status = nvmet_copy_to_sgl(req, 0, list, buf_size);
 
-- 
2.53.0



Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C418606A325
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Nov 2026 07:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=FsO6dhzG;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=dZBQcdeC;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ZrTu31XP
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=gttQOVQztJ5fjC2wn/wXvoHalet9NFN4+zZOdxzeuWM=; b=FsO6dhzGrr6nel
	zKXSDto6QLav3FuXcZlexYJ5S9GCn5R748UE/64A8pmNxXRg/MCWCytrOxB6jwU1L3KpS92YUTnKi
	MqbZjLXH2cPCGSi/P9QF9moeYySx9B8qQufmQrLfNa9So8N3FpkE4TOcYcCaDqRMHjfyd1jN6MFfU
	LJ2jSLOl704/mPq/jE9iYMo8/ey1iJYcn6iWrrxRuvkqaLYyr8MqeT3sxFWdgfGs7bxOCYnAavBEF
	JWRMNROpxra03v/qBAA7koQzTF+CPrNW0qM/rnGjXfcQYClSY5XK1QU+LvmatvlusOI4prwb+Be9s
	05oHC6HZkD1L/kjeLMMw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTaDz-000000081KS-0Zvf;
	Wed, 18 Nov 2026 07:36:59 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTaDy-000000081Im-0DKi
	for linux-nvme@bombadil.infradead.org;
	Wed, 18 Nov 2026 07:36:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=gttQOVQztJ5fjC2wn/wXvoHalet9NFN4+zZOdxzeuWM=; b=dZBQcdeCHTuGJSgdIaDTExNx5N
	ul1eIMJum2RhVucF24dzQxxQ29CAOmABWzuLUU/Jsf8NEUIiJlpx4aoBb15EwyyBSkkhcHumDT8VL
	G2W9Rx2QpuDdLVQvhdIrHUIF60ltlxg50jzOP0bHZEcVO23HYUIDiW19dVy8y1RlL95+JzLfoidqP
	Z3Tctu7vNFmuvP2i6CmMsd9QArivOpUtUGY893pJU5jH5wc2baVvM8yvjNX9oFcLRLI134U0eyhTE
	akX4CFyTKGJ+8GzCmxexChX2X50tRsokEdwjeU4SRBXOn8U0F7ZMRSN1XqzwRe9VBNRaa+jfXLFWT
	e/I8mIsA==;
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by desiato.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTaDt-0000000FkEA-1uFT
	for linux-nvme@lists.infradead.org;
	Wed, 18 Nov 2026 07:36:55 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AI2TcLa2435728;
	Wed, 18 Nov 2026 07:36:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=gttQOVQztJ5fjC2wn
	/wXvoHalet9NFN4+zZOdxzeuWM=; b=ZrTu31XPhFOzkwEhOEps2fH2cew+VaMzj
	qUoMupWU3ad153nNujh51X7EEP/SqQVUToCHwGYSrIizYyBTyzagwfGHncKOcuEa
	4CVYs+SxMhu2vC6SJr2CnxTvjI3yoGn0UeaGilKAivrjIF3c8l/3djFov+GdCL+X
	ciRezvG+l+gThfeTE5kpA3KyOFQzy481E/ZUEx8rKooml7PcYmIiSM/5jOUKflP4
	+t6v2M/HxMoNPH9ZoWfpMINQLtw25O1vgBBUqMeO5ircyG7n3CL7/6qdMBusrPbJ
	Lkad7g2bZHZxnZE7UbKh9EsKUITQcVShlhgHLfLIFdKkwx+p1HB1A==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j105rhct6-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 18 Nov 2026 07:36:43 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AI2YtZd1428861;
	Wed, 18 Nov 2026 07:36:42 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j02dfg952-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Nov 2026 07:36:42 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AI7aceR11731402
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Nov 2026 07:36:38 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4ADF020040;
	Wed, 18 Nov 2026 07:36:38 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C15BA20049;
	Wed, 18 Nov 2026 07:36:33 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.61.157.4])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 18 Nov 2026 07:36:33 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: kbusch@kernel.org, hch@lst.de, bvanassche@acm.org, sagi@grimberg.me,
        axboe@kernel.dk, chaitanyak@nvidia.com
Cc: gjoyce@linux.ibm.com, elver@google.com, linux-nvme@lists.infradead.org,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH v2 10/22] nvmet: fix nvmet_ns::uuid access using nvmet_subsys::lock
Date: Wed, 18 Nov 2026 13:04:51 +0530
Message-ID: <20261118073505.288910-11-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261118073505.288910-1-nilay@linux.ibm.com>
References: <20261118073505.288910-1-nilay@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: HHXiS9Db71dqoDhNRif4OJRexMil1tMi
X-Authority-Analysis: v=2.4 cv=e8uT2qp/ c=1 sm=1 tr=0 ts=6afd558b cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=n2KTWaI9zIpT5opI1KsA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDAyOSBTYWx0ZWRfXzbn8qVR0FY65
 bVYd/LuP8iL/Q9Ih/QzkIPBBn86YhdjKgA7YcG6mwq0yZyhcoCMyGOGBz30kbDN33KvpdvQwRPl
 wziwdcLzrMvSNz/mRg+Zne6d59kpADQ=
X-Proofpoint-ORIG-GUID: RI6dOie7SyjY1ma86wd9LD4RAMCJq-MG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDAyOSBTYWx0ZWRfX10wsj5YtRXMi
 5V04yiNWMmngYw6ZXwGsQnEtDJiB09hqlG6QAo8ivArDT9oUiNwvWIVscTcE9O3ckS4sc4b3PpJ
 vMnO08DhEcWfl3EbyWGBmWbhyVlPHHBlYJ+BXs7IEgkiwTf0W3alIBL/sL4wRrk8rTtZ5uYPh6v
 Ktr2oI0v2/urm5x8KKcvMenbR16j7xltmGEHsseVWX+E5OGHqr9IPFy6dRKazaFSDdcbgVHsSfc
 PxcNFEH1oEpqisOjgFKIDgCs0xdhe15inevat2pVtmyj2asyZgM+DXIapXSJOYsXU6SaTi+WXP2
 DIyHYte7GR0LIhqa8EoTwBlqs8K1y7CDuh8+SPu9dk6mILa3YqK7JBUNPPbd3YgoqoQr4Dd6lSx
 AoF77YYWpS5/opUje3sKLW7Oxc+4NRst+st+kNc/sv9JZy58tAcouF9S1TmfVd4U3c9dt1Ognb3
 yNEdI0xvYjnW/4lxwhw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-18_01,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 suspectscore=0 phishscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 bulkscore=0 malwarescore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611180029
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261118_073653_855060_6BAF76A3 
X-CRM114-Status: GOOD (  17.29  )
X-Spam-Score: -0.7 (/)
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

The nvmet_ns::uuid field is protected by nvmet_subsys::lock. However,
nvmet_ns_alloc() calls uuid_gen() without holding this lock, triggering
a Clang context analyzer error:

drivers/nvme/target/core.c:781:16: error: passing pointer to variable 'uuid' requires holding mutex '_res->subsys->lock'
      [-Werror,-Wthread-safety-pointer]
  781 |         uuid_gen(&ns->uuid);
      |                       ^

Fix this by separating namespace allocation from initialization.
Rename nvmet_ns_alloc() to nvmet_ns_alloc_and_init() and introduce
nvmet_ns_init(). Move part of the namespace initialization into a new
nvmet_ns_init(), Annotate nvmet_ns_init() with
__must_hold(&subsys->lock) to document and validate this requirement.

Although subsys->lock and ns->subsys->lock refer to the same mutex, the
Clang context analyzer cannot infer this relationship. Add
lockdep_assert_held(&ns->subsys->lock) in nvmet_ns_init() so that the
context analyzer can satisfy the corresponding lock annotation.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/target/configfs.c |  2 +-
 drivers/nvme/target/core.c     | 48 ++++++++++++++++++++++------------
 drivers/nvme/target/nvmet.h    |  2 +-
 3 files changed, 33 insertions(+), 19 deletions(-)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index f8a4d0d88946..10249affcccc 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -899,7 +899,7 @@ static struct config_group *nvmet_ns_make(struct config_group *group,
 	}
 
 	ret = -ENOMEM;
-	ns = nvmet_ns_alloc(subsys, nsid);
+	ns = nvmet_ns_alloc_and_init(subsys, nsid);
 	if (!ns)
 		goto out;
 	config_group_init_type_name(&ns->group, name, &nvmet_ns_type);
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index b031595d8edb..6b0ec84a4c09 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -723,7 +723,36 @@ void nvmet_ns_free(struct nvmet_ns *ns)
 	kfree(ns);
 }
 
-struct nvmet_ns *nvmet_ns_alloc(struct nvmet_subsys *subsys, u32 nsid)
+static int nvmet_ns_init(struct nvmet_subsys *subsys, struct nvmet_ns *ns,
+		u32 nsid)
+	__must_hold(&subsys->lock)
+{
+	int ret;
+
+	ns->subsys = subsys;
+
+	lockdep_assert_held(&ns->subsys->lock);
+
+	init_completion(&ns->disable_done);
+	ns->nsid = nsid;
+
+	ret = xa_insert(&subsys->namespaces, ns->nsid, ns, GFP_KERNEL);
+	if (ret)
+		return ret;
+
+	if (ns->nsid > subsys->max_nsid)
+		subsys->max_nsid = nsid;
+
+	subsys->nr_namespaces++;
+
+	uuid_gen(&ns->uuid);
+	ns->buffered_io = false;
+	ns->csi = NVME_CSI_NVM;
+
+	return ret;
+}
+
+struct nvmet_ns *nvmet_ns_alloc_and_init(struct nvmet_subsys *subsys, u32 nsid)
 {
 	struct nvmet_ns *ns;
 
@@ -736,19 +765,9 @@ struct nvmet_ns *nvmet_ns_alloc(struct nvmet_subsys *subsys, u32 nsid)
 	if (!ns)
 		goto out_unlock;
 
-	init_completion(&ns->disable_done);
-
-	ns->nsid = nsid;
-	ns->subsys = subsys;
-
-	if (ns->nsid > subsys->max_nsid)
-		subsys->max_nsid = nsid;
-
-	if (xa_insert(&subsys->namespaces, ns->nsid, ns, GFP_KERNEL))
+	if (nvmet_ns_init(subsys, ns, nsid))
 		goto out_exit;
 
-	subsys->nr_namespaces++;
-
 	mutex_unlock(&subsys->lock);
 
 	down_write(&nvmet_ana_sem);
@@ -756,13 +775,8 @@ struct nvmet_ns *nvmet_ns_alloc(struct nvmet_subsys *subsys, u32 nsid)
 	nvmet_ana_group_enabled[ns->anagrpid]++;
 	up_write(&nvmet_ana_sem);
 
-	uuid_gen(&ns->uuid);
-	ns->buffered_io = false;
-	ns->csi = NVME_CSI_NVM;
-
 	return ns;
 out_exit:
-	subsys->max_nsid = nvmet_max_nsid(subsys);
 	kfree(ns);
 out_unlock:
 	mutex_unlock(&subsys->lock);
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 847115759985..01132beb5904 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -702,7 +702,7 @@ u16 nvmet_req_find_ns(struct nvmet_req *req);
 void nvmet_put_namespace(struct nvmet_ns *ns);
 int nvmet_ns_enable(struct nvmet_ns *ns);
 void nvmet_ns_disable(struct nvmet_ns *ns);
-struct nvmet_ns *nvmet_ns_alloc(struct nvmet_subsys *subsys, u32 nsid);
+struct nvmet_ns *nvmet_ns_alloc_and_init(struct nvmet_subsys *subsys, u32 nsid);
 void nvmet_ns_free(struct nvmet_ns *ns);
 
 void nvmet_send_ana_event(struct nvmet_subsys *subsys,
-- 
2.53.0



Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D916C624A5
	for <linux-nvme@archiver.kernel.org>; Mon, 31 Aug 2026 15:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rTnWaPOwLQFoHqYg9zEtbHqGiY4Yh/uPYJ3gKKotrb8=; b=o6PuPOKjNthe0XLsoOfCaOefXN
	9EbWhVmJ+v0JCyrSpAR33PsJCmfjx8jeUPhvo4m066aKwlSoS+NOrO7d6+Vw5sZiTXaYLk16MB1+h
	i9l+jfjjv81y6pEI6qPz4kL48wLLuRpfVNscaJVbw4BmnMK0dE+Nl7tkaXFska2toDXySfmSByYJf
	oaBgZ0q9GmDWZ/ws8f/xptjAttNz0cdeX5j0Dgi8dWjLVnGl+xzFblzJ4CYlpCAKDxsnQWDArIXmi
	yoyEUtUtrkMgcjPtVEYnOnlMGKYoavJlf1vN5ugUEkO7j7fmRZk8xYpR80bX2mFlzPTwMPYJ4GIz7
	KDbFKrAg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x13ol-00000009q9g-3Uy6;
	Mon, 31 Aug 2026 15:21:03 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x13ok-00000009q91-1A3N
	for linux-nvme@lists.infradead.org;
	Mon, 31 Aug 2026 15:21:03 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67VEZ9ne652843;
	Mon, 31 Aug 2026 15:20:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=rTnWaPOwLQFoHqYg9
	zEtbHqGiY4Yh/uPYJ3gKKotrb8=; b=mIF5kV1uU+mszO3IzCnWR0lqpb233Z+C9
	SC/CP9+ddpTnyLYrIzZ+sTRjgkr3g6gUvPp5Z570dgNgF9EY5jV6/VwPwh47XDUz
	5DqsXhAvHY0NcxlKYZtEJX4gkKS0oIGwhjEghfmEM2zWS6SSxUyfs9zdITmOk50D
	ckhQQu/nQFJgJFGn/99Wf0FBdqeW6q1TZAWOdswYteVigJDUfKXo1l38SyyLgHtF
	ElFPfGFSzt0f57ovlZmvW9KQEmTScPOBcd40/8eIF+F+odNZTHiNuuChAMtA1XEP
	DnUOfrlmw2rNQ82EUuesQ2S9CPXP8LrU+TEbQbGI4IHd20uQUaOVQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq3r25dd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 15:20:54 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67VEuPYP005704;
	Mon, 31 Aug 2026 15:20:53 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gcb8h6j0m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 15:20:53 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67VFKnGp31326804
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Aug 2026 15:20:49 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0495820043;
	Mon, 31 Aug 2026 15:20:49 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8915220040;
	Mon, 31 Aug 2026 15:20:44 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.61.22.126])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 31 Aug 2026 15:20:43 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, sagi@grimberg.me, hch@lst.de, axboe@fb.com,
        john.g.garry@oracle.com, wenxiong@linux.ibm.com, gjoyce@linux.ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>, Marco Elver <elver@google.com>
Subject: [PATCH 2/2] nvme: add context annotation for nvme_ns_head::nr_openers
Date: Mon, 31 Aug 2026 20:49:55 +0530
Message-ID: <20260831152006.819471-3-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260831152006.819471-1-nilay@linux.ibm.com>
References: <20260831152006.819471-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=EIc2FVZC c=1 sm=1 tr=0 ts=6a959bd6 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=1XWaLZrsAAAA:8 a=VnNF1IyMAAAA:8
 a=b0pfLhaz68M4ODDVWFYA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDEzMCBTYWx0ZWRfX7nQVLA8UKBi1
 NFmfKaz0HAZOM7QJS++TWVXT6JXudQQ/AKK+H2O/RM4fFw6FmwGtA5T2Liaxpy/HJJUWNC8jeCB
 MqgFBX+bJrVUdhsZUqiVnjZhNUkJAJ98elFmOWt6BjOf36mrpzBdzrd40r+VYPFEl89cA8E2H1J
 QzjR35v2pJfugxfrGJd76KcvtWo8UfWJWFXODUBb4MinX85jESV1u4nFBRrfYd+82wEayBYRxlZ
 YUWnFUa0QPMLBuFHIZFFrXHvBxb3xoeK7LVVHewSUwgHpvlNOK7VojPesonGVIdymoKd2PCvxQP
 ekBuNPS/hNwGgXk2WYWo8qRWj//ultF//Y3R78NHloa2lAkSibwzp1AXW+jKm6WqHTqImXawbF0
 t/qM/nyXZ9Ey+lMs84kUFUtdvTyMbvpOdv9t19ugxAc2YcTMYczxa0xNfEyDsmZ0OV8OCCRMILV
 KNZjB8pv/mr+axYcH9w==
X-Proofpoint-GUID: PF1DVkQkR4PZERhwJ7vV3FozZZwYRNtO
X-Proofpoint-ORIG-GUID: 7ufjWG-LkhgrRZtmKUejSS1CFTuvORHH
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDEzMCBTYWx0ZWRfX2DepIFkjiGBR
 0Qn8xk+wombfnahOF/qmS7xzuhBU71AKECb2QdsTKinyMgLtsvTTV+05EVP2lDsJtNzoJ/hIOVM
 eyDCMXir6f+ZEkO3dtqtYeInbwg2J3A=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_05,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 phishscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310130
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260831_082102_322592_B44CBEC7 
X-CRM114-Status: GOOD (  16.96  )
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

nvme_ns_head::nr_openers is protected by nvme_subsystem::lock. Annotate
it with __guarded_by(&subsys->lock) so that Clang's context analyzer can
validate that all accesses to nvme_ns_head::nr_openers are protected by
nvme_subsystem::lock.

Clang's context analyzer cannot currently model the same lock when it
is accessed through different object paths. Explicitly add the
capability in nvme_init_ns_head() using
__assume_ctx_lock(&head->subsys->lock) to avoid a false positive, as
ctrl->subsys->lock and head->subsys->lock refer to the same lock.

Similarly, in nvme_ns_remove(), replace ns->ctrl->subsys->lock with
ns->head->subsys->lock so that the lock expression matches the
capability used by the __guarded_by() annotation and avoids a false
positive from the context analyzer.

Cc: Marco Elver <elver@google.com>
Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/host/core.c | 5 +++--
 drivers/nvme/host/nvme.h | 3 ++-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index fdf760c57e02..29e3f2a7b5dd 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4173,6 +4173,7 @@ static int nvme_init_ns_head(struct nvme_ns *ns, struct nvme_ns_info *info)
 
 	list_add_tail_rcu(&ns->siblings, &head->list);
 	ns->head = head;
+	__assume_ctx_lock(&head->subsys->lock);
 	ret = nvme_module_get(ns, head->nr_openers);
 	if (ret)
 		goto out_err_module_get;
@@ -4368,7 +4369,7 @@ static void nvme_ns_remove(struct nvme_ns *ns)
 	if (nvme_mpath_clear_current_path(ns))
 		synchronize_srcu(&ns->head->srcu);
 
-	mutex_lock(&ns->ctrl->subsys->lock);
+	mutex_lock(&ns->head->subsys->lock);
 	list_del_rcu(&ns->siblings);
 	if (list_empty(&ns->head->list)) {
 		if (!nvme_mpath_queue_if_no_path(ns->head))
@@ -4376,7 +4377,7 @@ static void nvme_ns_remove(struct nvme_ns *ns)
 		last_path = true;
 	}
 	nvme_module_put(ns, ns->head->nr_openers);
-	mutex_unlock(&ns->ctrl->subsys->lock);
+	mutex_unlock(&ns->head->subsys->lock);
 
 	/* guarantee not available in head->list */
 	synchronize_srcu(&ns->head->srcu);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index db08f4618f92..d2b91140712c 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -569,7 +569,8 @@ struct nvme_ns_head {
 
 	struct gendisk		*disk;
 
-	unsigned int		nr_openers;
+	unsigned int		nr_openers
+		__guarded_by(&subsys->lock);
 
 	u16			nr_plids;
 	u16			*plids;
-- 
2.53.0



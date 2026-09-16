Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12F31C982C4
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Sep 2026 15:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FqLDnrcteHK5S/7d6FBsaAPQcmaAmif37JjMEJUwCSQ=; b=uAxR5oWlcPewGh7yFz2bGihRHo
	uQHEPOm6H6p5BQWvyE605tTgNvZMSk3uGg4ZxAL2wsaycyk9ileBkK68cMFi1w+a8n/me8DJDmM4w
	x9nzseqfNT9z21RrPiItrXbDHAhtgQLC7WxpeXniG3+Su1q5ncrAYOfZTYIo7slaF3cGzTt2+ciZu
	IV1pBYevuWmU9b01hay71ygkso7kkJ5BqGinM1wgKu/oMsJ7Va3hQMyo9DeQ04cBDoX8f3+ESe3Lo
	o4L0FSY3/Mz59m2KrOVob/ldF6eNhlmXrgqswdTogzWTuGxuaLQ8WfiEOYmItVUkHoNU1MG9T1yvn
	pYx2hlCw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6rI3-00000009Wp7-0IVj;
	Wed, 16 Sep 2026 15:11:16 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6rHh-00000009WW9-3Dwz
	for linux-nvme@lists.infradead.org;
	Wed, 16 Sep 2026 15:10:58 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68GEVuP44007658;
	Wed, 16 Sep 2026 15:10:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=FqLDnrcteHK5S/7d6
	FBsaAPQcmaAmif37JjMEJUwCSQ=; b=eOiPHdb3lbaDHsR1RVLJdGygZGtD9OfIk
	hhC0hW+xcG4kW2WvSF/yzdbxBz1GY1w3R8mrScBR7Um9DrizJdF2QW3xYAdhsH5O
	Uvy2rtJlvV1pV7vtnw2XN9KKavW0pAI9BnU+iezZsFszJs/T5YTT8e6bypFdiTE+
	KRVK+HDL3Uj4frRY8bYjAFpD2L1wQ43xNxQtutztyxBy9UlJrsd9bRxke+1JRnso
	gwBoVW4yK2EGpAr/hHFyVsTSi8BApHrArnRAlFDkWdVwoMRFCnn/YrdsfsbUaXs6
	BtNnHqvggSGcVKNYvDjFaGFGbVO74snTC7EZ4y9ItvyojeSyp9ndA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmx83wa2r-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 16 Sep 2026 15:10:39 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68GEaBXj1585015;
	Wed, 16 Sep 2026 15:10:38 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gq089putb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Sep 2026 15:10:38 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68GFAXin41091564
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Sep 2026 15:10:33 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3081020040;
	Wed, 16 Sep 2026 15:10:33 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CE75020043;
	Wed, 16 Sep 2026 15:10:28 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.61.52.228])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 16 Sep 2026 15:10:28 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, kch@nvidia.com
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        gjoyce@linux.ibm.com, Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH 1/2] nvmet: defer setting ns->enabled to false in nvmet_ns_disable()
Date: Wed, 16 Sep 2026 20:39:59 +0530
Message-ID: <20260916151012.3702896-2-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916151012.3702896-1-nilay@linux.ibm.com>
References: <20260916151012.3702896-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDIwNCBTYWx0ZWRfX6dGS980MbI+N
 E1uazvwmAOosUXR53+sqojk1wQtwy4HaJuwQ+ri6fotqzASbEtxSeEoe6uszcHBpdWI+8G/8uam
 xxaimdewMd8Uj0ZJlT6T5v1Fk3o/caG8CD22/H6b5bs3qs5UNWvc205DfdBNJiO+/D/ywOs+iJq
 LzxEe88ZpobH95How3Z5meiB+LdaBRW6vvxUaYsog/Qu6fsNRKmrM04sAGw0ta+7xh+wJaYvXyH
 RHAjvm2NV6z8iXXJSXbYj0pEG4Lmu3Nug41FO80LcXmt/H9rJAI7p518MVHqdFYnAvS/qQ/KZ6z
 7KYmbNgmyIROd5ZmHPUftp9h8ToT3Zd0NaegIMC1x6iX8jeM/L3Ijr5HhOTb9fPwqS+dKx7s5hB
 FZihB2JzPn2LWBK9yFgctUIOMfOe5fRBgrXSNYaWNItwCH2uXf/bHv+MY2wNiKtxpWqLrkv3Vht
 vA/rlyLaWc0ZxqAvLKA==
X-Proofpoint-ORIG-GUID: NBho84BV1Yc1YOjkmKW_iko5EqwNDbEV
X-Proofpoint-GUID: NBho84BV1Yc1YOjkmKW_iko5EqwNDbEV
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDIwNCBTYWx0ZWRfXxLI6g4tw+KuB
 EQDM3IKNfYidhgyHthDLcZZHFgaj+75EOKsGL2RZiyIdjPh0KeIysjC5vQydWiwkbbWq73qoVCC
 z+fIVccUmemAhPgUs9n6MX/zYRlysyM=
X-Authority-Analysis: v=2.4 cv=cY9HPXDM c=1 sm=1 tr=0 ts=6aaab16f cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=rmADpZh76WS4eRlhKtcA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-16_02,2026-09-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 impostorscore=0 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609160204
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260916_081053_835718_E09C9DC2 
X-CRM114-Status: GOOD (  16.83  )
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

nvmet_ns_disable() currently clears ns->enabled before draining
in-flight I/O references. This allows namespace configuration to be
changed while existing I/O requests can still hold a reference to the
namespace.

This can race with configuration of namespace attributes such as the
device path, UUID, NGUID etc. These attributes can be accessed by I/O
requests without holding subsys->lock and must not be modified while
such requests are still using the namespace.

In nvmet_ns_disable(), keep ns->enabled set while existing namespace
references are being drained, so namespace configuration remains blocked
until all in-flight I/O has completed. Set ns->enabled to false only
after the namespace references have been drained and the namespace
device has been disabled.

Since setting ns->enabled to false is deferred in nvmet_ns_disable(),
use the NVMET_NS_ENABLED XArray mark in nvmet_req_find_ns() to
determine whether a namespace can accept new I/O.

Similarly, use the NVMET_NS_ENABLED XArray mark in nvmet_ns_disable()
to prevent concurrent callers from starting namespace disable.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/target/core.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 43871a8f56ca..77d113fceced 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -448,7 +448,8 @@ u16 nvmet_req_find_ns(struct nvmet_req *req)
 	struct nvmet_subsys *subsys = nvmet_req_subsys(req);
 
 	req->ns = xa_load(&subsys->namespaces, nsid);
-	if (unlikely(!req->ns || !req->ns->enabled)) {
+	if (unlikely(!req->ns) ||
+	    !xa_get_mark(&subsys->namespaces, nsid, NVMET_NS_ENABLED)) {
 		req->error_loc = offsetof(struct nvme_common_command, nsid);
 		if (!req->ns) /* ns doesn't exist! */
 			return NVME_SC_INVALID_NS | NVME_STATUS_DNR;
@@ -644,10 +645,9 @@ void nvmet_ns_disable(struct nvmet_ns *ns)
 	struct nvmet_ctrl *ctrl;
 
 	mutex_lock(&subsys->lock);
-	if (!ns->enabled)
+	if (!xa_get_mark(&subsys->namespaces, ns->nsid, NVMET_NS_ENABLED))
 		goto out_unlock;
 
-	ns->enabled = false;
 	xa_clear_mark(&subsys->namespaces, ns->nsid, NVMET_NS_ENABLED);
 	nvmet_debugfs_ns_free(ns);
 
@@ -675,6 +675,7 @@ void nvmet_ns_disable(struct nvmet_ns *ns)
 	mutex_lock(&subsys->lock);
 	nvmet_ns_changed(subsys, ns->nsid);
 	nvmet_ns_dev_disable(ns);
+	ns->enabled = false;
 out_unlock:
 	mutex_unlock(&subsys->lock);
 }
-- 
2.53.0



Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5731BFD8FF5
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Feb 2026 18:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QgLNEJcwMafEKjzIsDmOc7Pt9Y9Qdy2XKJh5secnCFE=; b=1/Ielz4Wqys1kJBS1FOaw1IIFf
	CEsn5LYSKyShdxeuiD+kAUFM9uImwLKMzCMTA8T1MgjmSBMvEu0ybOwPIAoHaVc+FdInvpCcvuTW1
	gm9JRKsiTYG0FN6OLOQXxFGdh1OuqpSMM9XGQ50/6Z097CY2lm9/HfzjvTXlJWciuUpwLTyAbQMml
	MV+eXS6Ys6Ol4HQ2fsZef82gVUAcPsMbp/mZ1k0DtAcld/YlKpyCxYn9T5etOSVxQsZypdxsnf0cS
	iVaz0yjyBGAKRKCF4QOO/VJ+cFFgz7Il4x3KnCEV2T81/E7OlFZeyfzVgleNivt4sWmH0tcWxytWx
	jkU4XUww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvgA6-00000006yH6-40C3;
	Thu, 26 Feb 2026 18:32:34 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvgA3-00000006yFP-3jdh
	for linux-nvme@lists.infradead.org;
	Thu, 26 Feb 2026 18:32:33 +0000
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61QGn3SF524996
	for <linux-nvme@lists.infradead.org>; Thu, 26 Feb 2026 10:32:28 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=QgLNEJcwMafEKjzIsDmOc7Pt9Y9Qdy2XKJh5secnCFE=; b=r5/+8NDnCXZJ
	QeUTmTYuFCYZZhZUGMYDI1qhJRYNyXMdJjaxPSfobPkfj5VoW8+rNLMX/YwlHjQI
	mh4u2qS52Z1/+wgpKDRV8OnTOUiZ/1oeRr/PlcJzc8ElRGxxXKoD0J7CW6OFtm4X
	PfVFGr7hbdmCUU0y84YuWyLtoeJ9JruGEJwkN4tMG6Ii/me3NBgzCbB4c+eU3NDD
	ldPWefV2UidicdObmo2WHVZvctf8/7dFZt0lOrchGfVQ5L0ehxMZ9MBlH7+wDMtG
	nndR/kcdO8vNq9XT+fficgoYdZabuTxwHoULIDJkSgySaqjsOsNm1T2YPjVHvgFJ
	H6TpEl2dJA==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4cjt1f1b5x-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Thu, 26 Feb 2026 10:32:27 -0800 (PST)
Received: from twshared26368.04.snb1.facebook.com (2620:10d:c0a8:1b::8e35) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Thu, 26 Feb 2026 18:32:25 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id C7D7B90B693E; Thu, 26 Feb 2026 10:32:16 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>, <hch@lst.de>, <nilay@linux.ibm.com>
CC: Keith Busch <kbusch@kernel.org>, John Garry <john.g.garry@oracle.com>
Subject: [PATCHv2 1/3] nvme-multipath: fix leak on try_module_get failure
Date: Thu, 26 Feb 2026 10:32:14 -0800
Message-ID: <20260226183216.2098584-2-kbusch@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260226183216.2098584-1-kbusch@meta.com>
References: <20260226183216.2098584-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: TJwTHoV_tz8DcsQzrNPNziGEEiBSvBWX
X-Authority-Analysis: v=2.4 cv=QKRlhwLL c=1 sm=1 tr=0 ts=69a091bb cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=wpfVPzegXHpEFt3DAXn9:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=yPCof4ZbAAAA:8
 a=z37yyg1j4Q0jIBrKCm0A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI2MDE2OSBTYWx0ZWRfX/SZmbTqoLPjv
 DHL1EhDon6cq4WSZYM12Wc5tSXtqsM5mG5Ak/Cxsj8mthSsIORhSOkQbGGi7UxNyjQlZN2mcDwJ
 xhGtgri89mUQ+DlYTOn2twgRYBeVgpftzdg4FKcy4at42kNj5Pe6FR6id+Y+rhmNAfL2FJaxsk4
 mH0peWd5v4nqSf7n3pMdl+k3UyfZVocU/RJdL6o0DpfCEUvteleDFe5M9ot7Raa6/GHh2a0bkrr
 s7YoUji1AkKrCkSnTgMaleS85mY8UebdX7wWpeEWNoN7eEtUmp7F+0Kxff6CO+dSxVaVqe8QF0m
 cgEr2Uo95ackNhmeLUrZSOtfME5wuLwW5VYcQZcFoFQ399HKfGXvmETr8yNJuFPZnVIXNkKy52Q
 ZP55kYypqLLef7J46gKhiEFbL7Tdri2+EFp3FSxDkzfI08L4kUNi92sEEq9BDevLVJiK0NcIo4C
 ZpPemiRk+6nWfZJ41pQ==
X-Proofpoint-GUID: TJwTHoV_tz8DcsQzrNPNziGEEiBSvBWX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-26_02,2026-02-26_01,2025-10-01_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260226_103232_087940_866A983C 
X-CRM114-Status: GOOD (  14.51  )
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

From: Keith Busch <kbusch@kernel.org>

We need to fall back to the synchronous removal if we can't get a
reference on the module needed for the deferred removal.

Fixes: 62188639ec16 ("nvme-multipath: introduce delayed removal of the mu=
ltipath head node")
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
Reviewed-by: John Garry <john.g.garry@oracle.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/multipath.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.=
c
index bfcc5904e6a26..fc6800a9f7f94 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -1310,13 +1310,11 @@ void nvme_mpath_remove_disk(struct nvme_ns_head *=
head)
 	if (!list_empty(&head->list))
 		goto out;
=20
-	if (head->delayed_removal_secs) {
-		/*
-		 * Ensure that no one could remove this module while the head
-		 * remove work is pending.
-		 */
-		if (!try_module_get(THIS_MODULE))
-			goto out;
+	/*
+	 * Ensure that no one could remove this module while the head
+	 * remove work is pending.
+	 */
+	if (head->delayed_removal_secs && try_module_get(THIS_MODULE)) {
 		mod_delayed_work(nvme_wq, &head->remove_work,
 				head->delayed_removal_secs * HZ);
 	} else {
--=20
2.47.3



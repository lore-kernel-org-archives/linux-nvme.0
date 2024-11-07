Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 554E0D5D687
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Nov 2024 19:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HjRbxREVZf8E/vap7Rsu55/uWLDm+bC0NgvEV4DgIhw=; b=1BAlUqO+v0KFQHZc7li3cbIsn3
	1pQT4Lm1qXflvaBh9AMmlKTEwy7xpE+2W6OU9Oj/5CvQU+Yd/RuLSJpx+tX2AQ85AURHghNz3N/ZJ
	LSA2XFJQADit6BWHWvXgNytUleYO/d45xOOGh2Xc4O1irz/113etwsEGtEtRsFzGBiUs8oIMEDyFo
	8yYMGAZJJybpJluQbm0i7P5f8gkuvuVIfNIj2HSUOB90CfQmNChJ8FXU17Dv0oDdW9wv9rRzi57o7
	XMwrNKdjkBYISazFh0gjnNkxSKtkg/JRbfKJLzuSKgaMkniwVfpKs4ss+ThvVcQhZ98e3Xxd3vKTc
	HA6esRCg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t98cP-00000008AOH-1K8e;
	Thu, 07 Nov 2024 19:56:37 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t98Lw-000000086cM-2FEM
	for linux-nvme@lists.infradead.org;
	Thu, 07 Nov 2024 19:39:38 +0000
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7ImW3U008443
	for <linux-nvme@lists.infradead.org>; Thu, 7 Nov 2024 11:39:36 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2021-q4;
	 bh=HjRbxREVZf8E/vap7Rsu55/uWLDm+bC0NgvEV4DgIhw=; b=FVt5f1UUVsN4
	sQYGlUlt43AAeJNq9NZx0qx5DTbPYq+XlNU8faoJ+4G4M7jK6QMJkgVfv4TK/n4R
	k6CJyBEtausbQixxYQ9CLFsz2Yw3y6miHAvFckf9P2eCWepEeCLxqtAfb7QU7/b7
	6ppbf88CQyqNAG+MfZMi9LTPFREWPQDFPu9W6Cl5UwuwJS1HIU2yEP2yl1RiOvAN
	pSlr4VW+bns5+ra5E0NeC7o4jpm6NS93iM7gi04LqRDIQIfi1/zqJjbdEcyheFzD
	w4i0vezWkL9Z1D07kT+gcti/KazzPob8lm46V0z33Ftjx+nWg3DJrs2mUx6MbmZD
	zNfQuit4hw==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 42ruk2bnqr-10
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Thu, 07 Nov 2024 11:39:36 -0800 (PST)
Received: from twshared12347.06.ash8.facebook.com (2620:10d:c085:208::7cb7) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Thu, 7 Nov 2024 19:39:08 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id 9D88714DC3A06; Thu,  7 Nov 2024 11:38:55 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <m@bjorling.me>, <matias.bjorling@wdc.com>, <kch@nvidia.com>,
        <kanie@linux.alibaba.com>,
        "Martin K . Petersen"
	<martin.petersen@oracle.com>,
        Keith Busch <kbusch@kernel.org>
Subject: [PATCHv4 10/13] nvme: use command set independent id ns if available
Date: Thu, 7 Nov 2024 11:38:45 -0800
Message-ID: <20241107193849.995554-11-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241107193849.995554-1-kbusch@meta.com>
References: <20241107193849.995554-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
X-Proofpoint-GUID: P4yC7oZkwoX0b6U8aQD0GTCpS2Pn4pjb
X-Proofpoint-ORIG-GUID: P4yC7oZkwoX0b6U8aQD0GTCpS2Pn4pjb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_02,2024-10-04_01,2024-09-30_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241107_113936_614653_8AF8BEE2 
X-CRM114-Status: GOOD (  13.47  )
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

From: Matias Bj=C3=B8rling <matias.bjorling@wdc.com>

The NVMe 2.0 specification adds an independent identify namespace
data structure that contains generic attributes that apply to all
namespace types. Some attributes carry over from the NVM command set
identify namespace data structure, and others are new.

Currently, the data structure only considered when CRIMS is enabled or
when the namespace type is key-value.

However, the independent namespace data structure is mandatory for
devices that implement features from the 2.0+ specification. Therefore,
we can check this data structure first. If unavailable, retrieve the
generic attributes from the NVM command set identify namespace data
structure.

Signed-off-by: Matias Bj=C3=B8rling <matias.bjorling@wdc.com>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/core.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 279b0f445904d..162889b6382aa 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3988,7 +3988,7 @@ static void nvme_scan_ns(struct nvme_ctrl *ctrl, un=
signed nsid)
 {
 	struct nvme_ns_info info =3D { .nsid =3D nsid };
 	struct nvme_ns *ns;
-	int ret;
+	int ret =3D 1;
=20
 	if (nvme_identify_ns_descs(ctrl, &info))
 		return;
@@ -4005,9 +4005,10 @@ static void nvme_scan_ns(struct nvme_ctrl *ctrl, u=
nsigned nsid)
 	 * set up a namespace.  If not fall back to the legacy version.
 	 */
 	if ((ctrl->cap & NVME_CAP_CRMS_CRIMS) ||
-	    (info.ids.csi !=3D NVME_CSI_NVM && info.ids.csi !=3D NVME_CSI_ZNS))
+	    (info.ids.csi !=3D NVME_CSI_NVM && info.ids.csi !=3D NVME_CSI_ZNS) =
||
+	    ctrl->vs >=3D NVME_VS(2, 0, 0))
 		ret =3D nvme_ns_info_from_id_cs_indep(ctrl, &info);
-	else
+	if (ret > 0)
 		ret =3D nvme_ns_info_from_identify(ctrl, &info);
=20
 	if (info.is_removed)
--=20
2.43.5



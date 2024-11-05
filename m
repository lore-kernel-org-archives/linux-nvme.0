Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 762BDD31769
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Nov 2024 17:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3XoYSXt00p/m2g460tpoBcjZTn/kB0RVgz3RdRrosgE=; b=swWxrokhvaTHZ00tWUkFw5sNp7
	er/oZnlS/mIPauZKjqlJC15upMouaKXpq1IL7DvWOzFCVX7KiP0lK+m5g/zmkONC6G6iBw6+sIZmX
	MzYIYQhzPWha/RLoBRpTZh44OHIuyO5A9iF5MENQP/kIGLF44KPQMKfEpTR82fIfL0LTDoFWcqAwp
	zjZJyoMsuIQMQE0pHf9ypWL6UaFfJfClD1w++CjnQgUAWnAQwa/oKZCD/xzZCuJRFFH7zE5PLZpBm
	gtJXOojxXVurLCuWrA6xFA383fdGmCd6o8R6Eqac7GFDe7wjUBmDWLhPmWeXLjnrx9XqgzPNod7wt
	FmCBfrWQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t8NgO-00000000Grf-1YQE;
	Tue, 05 Nov 2024 17:49:36 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30] helo=mx0a-00082601.pphosted.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t8NgB-00000000Gg4-38IA
	for linux-nvme@lists.infradead.org;
	Tue, 05 Nov 2024 17:49:26 +0000
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 4A5HLAtf021574
	for <linux-nvme@lists.infradead.org>; Tue, 5 Nov 2024 09:49:23 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2021-q4;
	 bh=3XoYSXt00p/m2g460tpoBcjZTn/kB0RVgz3RdRrosgE=; b=BUQQYWgDTENt
	wrsjvyEQcZwIdW/Cq5GpRj9SOXaYsP5IpZV6ll48zvxQrN1ValX9O496w/dHJ+87
	agEswD+wfDzzv0uYqzoANPl84znfaBx5ZzBLc0qEJJ6qVRyGjUcTjvJXEXfcNwp5
	N1kr9ssvmrl0UcFtD2K5B8J+7uRFnCz0XhxOwalnmhWCUqqEZzBYE4goLh4cXnRP
	Ayg8ZD6VadEykk/QaW9eiBj+BkPIyPVJZdUCFfag+gskg9/yeVf56A0xonTe5dfH
	QQ1QdsJL1AxzBGJGJbYrxgUu98uKALo++D30VAtP1aoXrGfGyQmWfblvG1TGqE5F
	VKUnjE2Sog==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by m0089730.ppops.net (PPS) with ESMTPS id 42qjyptcpf-16
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Tue, 05 Nov 2024 09:49:22 -0800 (PST)
Received: from twshared22972.15.frc2.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Tue, 5 Nov 2024 17:49:17 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id B163A14CB3BEF; Tue,  5 Nov 2024 09:49:06 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <m@bjorling.me>, <matias.bjorling@wdc.com>,
        "Martin K .
 Petersen" <martin.petersen@oracle.com>,
        Keith Busch <kbusch@kernel.org>
Subject: [PATCHv3 10/11] nvme: make independent ns identify default
Date: Tue, 5 Nov 2024 09:49:03 -0800
Message-ID: <20241105174904.3612888-11-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241105174904.3612888-1-kbusch@meta.com>
References: <20241105174904.3612888-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
X-Proofpoint-GUID: E-aDqwa5GApdWydxkjQdYcc4jjq53aKD
X-Proofpoint-ORIG-GUID: E-aDqwa5GApdWydxkjQdYcc4jjq53aKD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241105_094923_950289_8078FFD3 
X-CRM114-Status: GOOD (  14.61  )
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

The NVMe 2.0 specification adds an independent identify namespace data
structure that contains generic attributes that apply to all namespace
types. Some attributes carry over from the NVM command set identify
namespace data structure, and others are new.

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
 drivers/nvme/host/core.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index e51021294a78b..4361fc7e8a225 100644
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
@@ -4004,10 +4004,9 @@ static void nvme_scan_ns(struct nvme_ctrl *ctrl, u=
nsigned nsid)
 	 * data structure to find all the generic information that is needed to
 	 * set up a namespace.  If not fall back to the legacy version.
 	 */
-	if ((ctrl->cap & NVME_CAP_CRMS_CRIMS) ||
-	    (info.ids.csi !=3D NVME_CSI_NVM && info.ids.csi !=3D NVME_CSI_ZNS))
+	if (ctrl->vs >=3D NVME_VS(2, 0, 0))
 		ret =3D nvme_ns_info_from_id_cs_indep(ctrl, &info);
-	else
+	if (ret > 0)
 		ret =3D nvme_ns_info_from_identify(ctrl, &info);
=20
 	if (info.is_removed)
--=20
2.43.5



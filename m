Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FCB6D5D683
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Nov 2024 19:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=elz6k7HmypESf5GmJPZxGQnn2F0b4q1H9FkvvKLPM7I=; b=Er09xz8zjstUKf3HcluEgyNP3y
	Y77l0uvYiiGL193Q3PfOkVhRwll6VSx+YbMMco+3XUHCq1RLJuBw5yMva/rNXk48Bbx7DNecZ8ImE
	KiBXq7hY8+ZAwm26ZWVu+U56JCy8V4WKAJzyrQprzXlgWAhgnoSrHsNhmvCVmNVP5PAtok6FgzEfj
	15rFf1uucjEm/uqVsO8DRyPq3lLtUxL4xx9uccYfYBDfwvfgdVBRgTb5xKc/khzMueG0pPnMgifxM
	PxZ32myEa2fhF4WfYhNkhdJiz+g6Lrr8+as6w2SZY0cYRhLbva2EI5mYZ2qT3hL/cXdH2HTMbTsMC
	LMgJlPzA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t98cQ-00000008APj-3V4K;
	Thu, 07 Nov 2024 19:56:38 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t98Ly-000000086cm-0fnA
	for linux-nvme@lists.infradead.org;
	Thu, 07 Nov 2024 19:39:39 +0000
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7ImOg9015822
	for <linux-nvme@lists.infradead.org>; Thu, 7 Nov 2024 11:39:38 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2021-q4;
	 bh=elz6k7HmypESf5GmJPZxGQnn2F0b4q1H9FkvvKLPM7I=; b=UIG6MMfn3o98
	87juFlzYbEsd4VyY9aqMHOnC1EK+lX8HVeM0lfg6gWaAC1RVtGaoF2puhykXi5rk
	vCqfqWV1iVhQ9ngTVzTViNQlEc8TqnJkeIY/hKsUy8AzztLc++jQQMPXELgonstZ
	+yzsH/fRCr5F6FbvZ+dCETergXpr0/JoDCMw+v2KZvaqJpIfB3d3SRMVvyXfWSS7
	eJlY9YQgWv11zSAMlQaaLdZfz/rGnPH+3HfhvCRJ8kqnsdp+vzY4G9hirnwgQUzu
	LzYmEdnscAMjiL06EqRa7KX/2gZJht4PAPu+8Ulu56581voiCM0VpgP9UQfet3ys
	VQYxadR1Cg==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 42ry2hjj4t-13
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Thu, 07 Nov 2024 11:39:37 -0800 (PST)
Received: from twshared25495.03.ash8.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Thu, 7 Nov 2024 19:39:08 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id A3C6814DC3A08; Thu,  7 Nov 2024 11:38:55 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <m@bjorling.me>, <matias.bjorling@wdc.com>, <kch@nvidia.com>,
        <kanie@linux.alibaba.com>, Wang Yugui
	<wangyugui@e16-tech.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv4 11/13] nvme: add rotational support
Date: Thu, 7 Nov 2024 11:38:46 -0800
Message-ID: <20241107193849.995554-12-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241107193849.995554-1-kbusch@meta.com>
References: <20241107193849.995554-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
X-Proofpoint-ORIG-GUID: rXXPJowXQnU93ALgMAmLgkKADEmWQlHC
X-Proofpoint-GUID: rXXPJowXQnU93ALgMAmLgkKADEmWQlHC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_02,2024-10-04_01,2024-09-30_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241107_113938_690941_FDAFF476 
X-CRM114-Status: GOOD (  13.42  )
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

From: Wang Yugui <wangyugui@e16-tech.com>

Rotational devices, such as hard-drives, can be detected using
the rotational bit in the namespace independent identify namespace
data structure. Make the bit visible to the block layer through the
rotational queue setting.

Signed-off-by: Wang Yugui <wangyugui@e16-tech.com>
Reviewed-by: Matias Bj=C3=B8rling <matias.bjorling@wdc.com>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/core.c | 6 ++++++
 drivers/nvme/host/nvme.h | 1 +
 2 files changed, 7 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 162889b6382aa..6f51dde7de6ce 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -42,6 +42,7 @@ struct nvme_ns_info {
 	bool is_readonly;
 	bool is_ready;
 	bool is_removed;
+	bool is_rotational;
 };
=20
 unsigned int admin_timeout =3D 60;
@@ -1615,6 +1616,7 @@ static int nvme_ns_info_from_id_cs_indep(struct nvm=
e_ctrl *ctrl,
 		info->is_shared =3D id->nmic & NVME_NS_NMIC_SHARED;
 		info->is_readonly =3D id->nsattr & NVME_NS_ATTR_RO;
 		info->is_ready =3D id->nstat & NVME_NSTAT_NRDY;
+		info->is_rotational =3D id->nsfeat & NVME_NS_ROTATIONAL;
 	}
 	kfree(id);
 	return ret;
@@ -2162,6 +2164,9 @@ static int nvme_update_ns_info_block(struct nvme_ns=
 *ns,
 	else
 		lim.features &=3D ~(BLK_FEAT_WRITE_CACHE | BLK_FEAT_FUA);
=20
+	if (info->is_rotational)
+		lim.features |=3D BLK_FEAT_ROTATIONAL;
+
 	/*
 	 * Register a metadata profile for PI, or the plain non-integrity NVMe
 	 * metadata masquerading as Type 0 if supported, otherwise reject block
@@ -3608,6 +3613,7 @@ static struct nvme_ns_head *nvme_alloc_ns_head(stru=
ct nvme_ctrl *ctrl,
 	head->ns_id =3D info->nsid;
 	head->ids =3D info->ids;
 	head->shared =3D info->is_shared;
+	head->rotational =3D info->is_rotational;
 	ratelimit_state_init(&head->rs_nuse, 5 * HZ, 1);
 	ratelimit_set_flags(&head->rs_nuse, RATELIMIT_MSG_ON_RELEASE);
 	kref_init(&head->ref);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 093cb423f536b..900719c4c70c1 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -474,6 +474,7 @@ struct nvme_ns_head {
 	struct list_head	entry;
 	struct kref		ref;
 	bool			shared;
+	bool			rotational;
 	bool			passthru_err_log_enabled;
 	struct nvme_effects_log *effects;
 	u64			nuse;
--=20
2.43.5



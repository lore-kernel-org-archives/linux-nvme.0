Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C5CBD3176B
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Nov 2024 17:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=a9n8lbXz7nvhrLlXwqKV2/i26cUWV7Ls8MHGFTOCFa4=; b=4OCIl/iyfU/6hT9TOIkP5GhCu3
	SGRdE+zpVGnZ820OrvSWgqEVwsvdFXxmyEPmU665KWv6AbV0yP/mA2rAObJ0RLQ08PdX5YhtZ8WUg
	AvUdNrSQrSufdpp3T/PUMkIv2qMZIbgkSNZLUieJu8uRcjxty7LrCWRvQaiRqdKZ9He3hmSIYBbEf
	we9xFE4n6DNLfx3iritTYvNuJp2E7CRQ10PndpN8lpOcb0o4TnbU7lytneLtob+G9qOMHn8uakBrC
	fuLh6Bj8Wa4Z/K7MMzJAws64I7TS2/rplEzlzRMvTRZC3vXmlyHue6ww9VVnpGFbyvMzwVgSV8at6
	FQvxSFLQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t8Ng8-00000000Gdm-0k9e;
	Tue, 05 Nov 2024 17:49:20 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30] helo=mx0a-00082601.pphosted.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t8Ng3-00000000GbT-105g
	for linux-nvme@lists.infradead.org;
	Tue, 05 Nov 2024 17:49:17 +0000
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 4A5HLAtQ021574
	for <linux-nvme@lists.infradead.org>; Tue, 5 Nov 2024 09:49:13 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2021-q4;
	 bh=a9n8lbXz7nvhrLlXwqKV2/i26cUWV7Ls8MHGFTOCFa4=; b=YGdJk4ltjVpn
	Y5fe6aq+J6+j/lO5K/KFc+QoikrT6zZWLgWTCNqCadbyT9p8p/nUm257rTHW+I7g
	1EII4LA0gGnWxEAjBEYll6v8/gq2Nys3tkQAHmJA4VXuv9Ok52SmHgqAjab5fron
	WxGZP3wavCZ5ttBx8xYsRE7Lf4WueNbB3g841c/EvOAE/7LOn7k5tM+EPwTA2lDj
	upK+uU+S2oSeq0YTNbvqf45MAqP6VbO2dMCjwOly5hL2QUiQIrCYcCHRA5hm01zb
	+ul7fJriKGGY9Tn5+YIHpHa5EYk5tF/FnPkk5fEyzUeuXfVWHuQgFC3nnl+hfAXx
	p9xjvTECtw==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by m0089730.ppops.net (PPS) with ESMTPS id 42qjyptcpf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Tue, 05 Nov 2024 09:49:13 -0800 (PST)
Received: from twshared13460.05.ash9.facebook.com (2620:10d:c0a8:1c::1b) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Tue, 5 Nov 2024 17:49:11 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id BB92D14CB3BF1; Tue,  5 Nov 2024 09:49:06 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <m@bjorling.me>, <matias.bjorling@wdc.com>,
        "Martin K .
 Petersen" <martin.petersen@oracle.com>,
        Keith Busch <kbusch@kernel.org>
Subject: [PATCHv3 11/11] nvme: add rotational support
Date: Tue, 5 Nov 2024 09:49:04 -0800
Message-ID: <20241105174904.3612888-12-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241105174904.3612888-1-kbusch@meta.com>
References: <20241105174904.3612888-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
X-Proofpoint-GUID: UsMnd6rL68Gm98zJWi3xDAyP1my8_NAn
X-Proofpoint-ORIG-GUID: UsMnd6rL68Gm98zJWi3xDAyP1my8_NAn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241105_094915_494731_35B03574 
X-CRM114-Status: GOOD (  14.55  )
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

Rotational devices, such as hard-drives, can be detected using
the rotational bit in the namespace independent identify namespace
data structure. Make the bit visible to the block layer through the
rotational queue setting.

Note that rotational devices typically can be used to generate random
entropy, the device is therefore also added as a block device that adds
entropy.

Signed-off-by: Matias Bj=C3=B8rling <matias.bjorling@wdc.com>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/core.c | 5 +++++
 include/linux/nvme.h     | 1 +
 2 files changed, 6 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 4361fc7e8a225..a47149858be59 100644
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
+		lim.features |=3D BLK_FEAT_ROTATIONAL | BLK_FEAT_ADD_RANDOM;
+
 	/*
 	 * Register a metadata profile for PI, or the plain non-integrity NVMe
 	 * metadata masquerading as Type 0 if supported, otherwise reject block
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 9bd37ec01c072..5976285192ae4 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -563,6 +563,7 @@ enum {
 	NVME_NS_FLBAS_LBA_SHIFT	=3D 1,
 	NVME_NS_FLBAS_META_EXT	=3D 0x10,
 	NVME_NS_NMIC_SHARED	=3D 1 << 0,
+	NVME_NS_ROTATIONAL	=3D 1 << 4,
 	NVME_LBAF_RP_BEST	=3D 0,
 	NVME_LBAF_RP_BETTER	=3D 1,
 	NVME_LBAF_RP_GOOD	=3D 2,
--=20
2.43.5



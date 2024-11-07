Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38BD7D5D683
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Nov 2024 19:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ejsM701oMHgRsqdwFCZNJbS4tEbYO/E8Om9kRs8Yn+8=; b=sS8QKAbF74UzXH0VnuSrgKKRHW
	E3Fl07uNc4xiZWVF4pzvadt4uwMxEwGOc0t1jvAePeRJI1/RE0L5+8ZnL+G9idK8zc7cqtNipvybQ
	F6lzK8UZ0bj/eBBsdm/tkJpPIBVY2XnqLM6pc4WjNWImjIdahwS0QGpmJJTsV20xiqwEkDhORXAkO
	1pY/R8O4Nc2NLGxxYVdLroISHAY7Y10b0u0CROG9cA9i7P/ObdnZcRP5k7gN3K8ZPEKukea/KK5jB
	1YpLgNpSKMZ0sK8E6iXdX/AtCt2TWdWyPY6iMTBdjGziy5c6JLll/Bjx6e1O1dwu42c73NFPyr7sK
	ioWOFXfg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t98cH-00000008AI3-3m25;
	Thu, 07 Nov 2024 19:56:29 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t98Lu-000000086b4-2NmA
	for linux-nvme@lists.infradead.org;
	Thu, 07 Nov 2024 19:39:35 +0000
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7ImW3O008443
	for <linux-nvme@lists.infradead.org>; Thu, 7 Nov 2024 11:39:34 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2021-q4;
	 bh=ejsM701oMHgRsqdwFCZNJbS4tEbYO/E8Om9kRs8Yn+8=; b=a2UlBoxz7A3M
	trctxvpWKeyDMTbkbSAwwqVYvNRUDwIhZytPnZlaFKt0QPqBMVa3s86W5RJfE8fy
	QnN9FbV3JPfwKG/plvhnSBvqqH8XvNpqty5VaqVMlhP3Z1TozLZcMnJfsw86d92E
	G3ekCMyKq1kEB4KRduuLCqtjWvgaiSYDEnhBv6LGUw/dm4Xk/rOEpwUjPAz+RyPH
	cQVirMPCP44840PtIM+9ypgWoxef+PtH9JZ3eKVmM40385+lP+y05r6YEX2upkiB
	5QR7Qs+6vbmR0MDhkccxgp5sK1iKzzuW8Nc5wpS3iTaqesPebeosubZzuQsTC9cQ
	DftdM1vuHw==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 42ruk2bnqr-6
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Thu, 07 Nov 2024 11:39:34 -0800 (PST)
Received: from twshared22972.15.frc2.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Thu, 7 Nov 2024 19:39:08 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id B000D14DC3A0B; Thu,  7 Nov 2024 11:38:55 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <m@bjorling.me>, <matias.bjorling@wdc.com>, <kch@nvidia.com>,
        <kanie@linux.alibaba.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv4 12/13] nvme: check ns's volatile write cache not present
Date: Thu, 7 Nov 2024 11:38:47 -0800
Message-ID: <20241107193849.995554-13-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241107193849.995554-1-kbusch@meta.com>
References: <20241107193849.995554-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: Hd4aAIYEN5pc6sSVmorf8LleW8q0lJCS
X-Proofpoint-ORIG-GUID: Hd4aAIYEN5pc6sSVmorf8LleW8q0lJCS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_02,2024-10-04_01,2024-09-30_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241107_113934_679628_5D3BB154 
X-CRM114-Status: GOOD (  13.99  )
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

From: Guixin Liu <kanie@linux.alibaba.com>

When the VWC of a namespace does not exist, the BLK_FEAT_WRITE_CACHE
flag should not be set when registering the block device, regardless
of whether the controller supports VWC.

Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/core.c | 4 +++-
 include/linux/nvme.h     | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 6f51dde7de6ce..e119ba0f8ab8b 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -43,6 +43,7 @@ struct nvme_ns_info {
 	bool is_ready;
 	bool is_removed;
 	bool is_rotational;
+	bool no_vwc;
 };
=20
 unsigned int admin_timeout =3D 60;
@@ -1617,6 +1618,7 @@ static int nvme_ns_info_from_id_cs_indep(struct nvm=
e_ctrl *ctrl,
 		info->is_readonly =3D id->nsattr & NVME_NS_ATTR_RO;
 		info->is_ready =3D id->nstat & NVME_NSTAT_NRDY;
 		info->is_rotational =3D id->nsfeat & NVME_NS_ROTATIONAL;
+		info->no_vwc =3D id->nsfeat & NVME_NS_VWC_NOT_PRESENT;
 	}
 	kfree(id);
 	return ret;
@@ -2159,7 +2161,7 @@ static int nvme_update_ns_info_block(struct nvme_ns=
 *ns,
 	    ns->head->ids.csi =3D=3D NVME_CSI_ZNS)
 		nvme_update_zone_info(ns, &lim, &zi);
=20
-	if (ns->ctrl->vwc & NVME_CTRL_VWC_PRESENT)
+	if ((ns->ctrl->vwc & NVME_CTRL_VWC_PRESENT) && !info->no_vwc)
 		lim.features |=3D BLK_FEAT_WRITE_CACHE | BLK_FEAT_FUA;
 	else
 		lim.features &=3D ~(BLK_FEAT_WRITE_CACHE | BLK_FEAT_FUA);
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 22375c87591a2..5c6d065c2f178 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -564,6 +564,7 @@ enum {
 	NVME_NS_FLBAS_META_EXT	=3D 0x10,
 	NVME_NS_NMIC_SHARED	=3D 1 << 0,
 	NVME_NS_ROTATIONAL	=3D 1 << 4,
+	NVME_NS_VWC_NOT_PRESENT =3D 1 << 5,
 	NVME_LBAF_RP_BEST	=3D 0,
 	NVME_LBAF_RP_BETTER	=3D 1,
 	NVME_LBAF_RP_GOOD	=3D 2,
--=20
2.43.5



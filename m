Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FE8CD5D683
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Nov 2024 19:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Gr0BHVCHRXIx2p7KslDkcqxAa4bCs6L1M5lF2ynaB7s=; b=FweXT+mhQqThHX+PcIWx9Y8L43
	Q0HZmk6rlT93LjNK237ngXj2I2irIxSceumbW1djily2RfT83sQo0rRYUftUL1745H5vRP9As9+k3
	h9Fzu8JK0GnU/j/lH9NHqd0IZz0UUjb82ELHNhS3LhHvyykl/pQgQcz5wHCbHY9DK6yJy8V4ox1R4
	+O3c0LkhzprisZ0TmuSikG2DyQY9iXd7Gvosku0Aj1rRMh9y3upL+ag9Yr0hbGpqJupglRtyhd5wk
	kxtfSlWiYLJrSoM5YRt+BaKtxj6aJqMiD02oeJJED+DGbz0bWl4cKJhAGHg0OiZMv269mVRKR7MCp
	1PQXXLhw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t98cK-00000008AJz-16f1;
	Thu, 07 Nov 2024 19:56:32 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t98Lv-000000086bl-3QyP
	for linux-nvme@lists.infradead.org;
	Thu, 07 Nov 2024 19:39:37 +0000
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7ImOg5015822
	for <linux-nvme@lists.infradead.org>; Thu, 7 Nov 2024 11:39:35 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2021-q4;
	 bh=Gr0BHVCHRXIx2p7KslDkcqxAa4bCs6L1M5lF2ynaB7s=; b=S5JAmEe6sDNC
	0d/QZ5N4U0pgY8XzidsTi0sxwKoZnkEbqa/zxWiHfIjtsD1BaZWaB7ju/OYMz6/y
	bTIWq2FK09QkyJNfx3ntd58r3BU915FN0L0uaXBX6Siyu4Xr5AnJ0ti0IGaW6wXc
	my53ulX/D+K7+YfQFlZzq6Luo3iBFu2CCZ4Hlk1+1koEXDCL8TIgiXB9F8Wz1Ens
	jtGwN5dbWQbNxrnjV4IkW2EOFo/xAJTOqeWBI0H0Tq/PejoLwCKbstTX0KR+HCkv
	LgS25sH7QA8h1+EJqjWmBr7BP8kS8Q4KgTM5kwfKlGepWigRUWkkeB67JZBRpkGN
	vKpgKTe4fw==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 42ry2hjj4t-9
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Thu, 07 Nov 2024 11:39:35 -0800 (PST)
Received: from twshared25495.03.ash8.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Thu, 7 Nov 2024 19:39:08 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id 5C8AE14DC39FC; Thu,  7 Nov 2024 11:38:55 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <m@bjorling.me>, <matias.bjorling@wdc.com>, <kch@nvidia.com>,
        <kanie@linux.alibaba.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv4 05/13] nvmet: implement crto property
Date: Thu, 7 Nov 2024 11:38:40 -0800
Message-ID: <20241107193849.995554-6-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241107193849.995554-1-kbusch@meta.com>
References: <20241107193849.995554-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: XNfi4rhpQ0rw0yzjHFCenBBzaMRLwV3m
X-Proofpoint-GUID: XNfi4rhpQ0rw0yzjHFCenBBzaMRLwV3m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_02,2024-10-04_01,2024-09-30_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241107_113935_933586_13CF6512 
X-CRM114-Status: UNSURE (   9.33  )
X-CRM114-Notice: Please train this message.
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

This property is required for nvme 2.1. The target only supports ready
with media, so this is just the same value as CAP.TO.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/target/fabrics-cmd.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvme/target/fabrics-cmd.c b/drivers/nvme/target/fabr=
ics-cmd.c
index c4b2eddd5666a..bb80db6a7950b 100644
--- a/drivers/nvme/target/fabrics-cmd.c
+++ b/drivers/nvme/target/fabrics-cmd.c
@@ -64,6 +64,9 @@ static void nvmet_execute_prop_get(struct nvmet_req *re=
q)
 		case NVME_REG_CSTS:
 			val =3D ctrl->csts;
 			break;
+		case NVME_REG_CRTO:
+			val =3D NVME_CAP_TIMEOUT(ctrl->csts);
+			break;
 		default:
 			status =3D NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
 			break;
--=20
2.43.5



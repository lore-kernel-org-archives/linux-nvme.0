Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB6A5C0218A
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Jan 2025 18:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=EgIp3OFUpil60sC5dEcEI0/x2qSQMGbxO4Z/onVUilg=; b=l1wsIOteu4Mz6iwRifmQ/s/N0N
	MlWOaK/oplS2JVnhuNHhCGGTLUxsIX89rGXAfJkg99/QlcltMsd2d6xN9C/EIRIO+Xja0tyTEO3bP
	lH7N2LiW4btpqg0ecwjoiDnYusGStDtd6iv7hP4Oxdx0xyRIl6otM5B+l0/NldsJUK9NdIfbsRnh5
	dqfAXHkkb6oqHUkHO1LNrPvzdLCfYqc+luE4O2QD1Qj20iids716ktbNXUE/x6VYLM/tgczsIUXH4
	Y8rHsn13/NVDWZLM1S4MT2rqv4CV5GWh7muPMHFvUwORp2u3fNi4SSuXh5SHHeOMPp/MDwqhFCnkO
	2QRIZa9A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tdYrw-00000009M2w-3YLB;
	Thu, 30 Jan 2025 18:02:24 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tdYhm-00000009Koy-2Vep
	for linux-nvme@lists.infradead.org;
	Thu, 30 Jan 2025 17:51:55 +0000
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50UHbHAw016509
	for <linux-nvme@lists.infradead.org>; Thu, 30 Jan 2025 09:51:52 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2021-q4; bh=EgIp3OFUpil60sC5dE
	cEI0/x2qSQMGbxO4Z/onVUilg=; b=f85aeb370QxzNIsN+85QZHna9hbdKIbbKQ
	j8Nllx4LT/O1AHspvmaAKhd6h47skOWJ5CmfBAh1PHG19TFw7OS+D3MYMKeTBVXZ
	PvzGYv6+FgrqakSyNICT33b1moEWrsKUqVbIg1S39XZS1s1n/rSGboZ67RiWayuU
	RJGSDEvxiWO5XkdHf2l+n/nJUBSBf2P++T5AyPehIKlnRPcmDS0iv4xaxMhVzWK0
	6JZ3w3h+gyutvlgbqbTGKzl8Lqrc+zuif++p1sc6qH84jgKv0YArcdc2vkyWaNBE
	P9oShKJpN0TvPmMN6Nd9rCAPonjQ4B0JkhaIl8m9eFClBSeDSwrA==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 44gdxjg450-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Thu, 30 Jan 2025 09:51:52 -0800 (PST)
Received: from twshared53813.03.ash8.facebook.com (2620:10d:c0a8:1b::8e35) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Thu, 30 Jan 2025 17:51:49 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id C69451778195C; Thu, 30 Jan 2025 09:51:36 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <sagi@grimberg.me>, <pmenzel@molgen.mpg.de>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [RFC PATCH] nvme: replace lazy sgl warn with informational message
Date: Thu, 30 Jan 2025 09:51:31 -0800
Message-ID: <20250130175131.3613423-1-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: rEg-boArenVuo8GDKDAYGOxvom3bVEZM
X-Proofpoint-GUID: rEg-boArenVuo8GDKDAYGOxvom3bVEZM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-30_08,2025-01-30_01,2024-11-22_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250130_095154_648173_C0D17160 
X-CRM114-Status: GOOD (  13.83  )
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

Instead of warning about the device's SGL capabilities the first time we
consider using them with a passthrough command, print out what the
device is capable of during initialization. While we're at it, print
other interesting capabilities that may be useful to know when you just
have a dmesg. The ouput format was inspired by other existing subsystems
like pci.

And example of the new message when used with a default qemu nvme
emulated device:

  nvme nvme0: sgl+ meta-sgl+ sed- vwc+ apst- dsm+ wz+

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/core.c  | 20 ++++++++++++++++++++
 drivers/nvme/host/ioctl.c | 11 ++---------
 2 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 2bcd9f710cb65..7535a9b9d2afa 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3440,6 +3440,22 @@ static int nvme_init_identify(struct nvme_ctrl *ct=
rl)
 	return ret;
 }
=20
+#define ENABLED(cond) ((cond) ? '+' : '-')
+
+static void nvme_ctrl_caps(struct nvme_ctrl *ctrl)
+{
+	dev_info(ctrl->device,
+		"sgl%c meta-sgl%c sed%c vwc%c apst%c dsm%c wz%c\n",
+		ENABLED(nvme_ctrl_sgl_supported(ctrl)),
+		ENABLED(nvme_ctrl_meta_sgl_supported(ctrl)),
+		ENABLED(!!ctrl->opal_dev),
+		ENABLED(ctrl->vwc & NVME_CTRL_VWC_PRESENT),
+		ENABLED(ctrl->apst_enabled),
+		ENABLED(ctrl->oncs & NVME_CTRL_ONCS_DSM),
+		ENABLED(ctrl->oncs & NVME_CTRL_ONCS_WRITE_ZEROES)
+	);
+}
+
 /*
  * Initialize the cached copies of the Identify data and various control=
ler
  * register in our nvme_ctrl structure.  This should be called as soon a=
s
@@ -3489,6 +3505,10 @@ int nvme_init_ctrl_finish(struct nvme_ctrl *ctrl, =
bool was_suspended)
 	}
=20
 	clear_bit(NVME_CTRL_DIRTY_CAPABILITY, &ctrl->flags);
+
+	if (!ctrl->identified)
+		nvme_ctrl_caps(ctrl);
+
 	ctrl->identified =3D true;
=20
 	nvme_start_keep_alive(ctrl);
diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index e8930146847af..2b5b650443229 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -125,15 +125,8 @@ static int nvme_map_user_request(struct request *req=
, u64 ubuffer,
 	struct bio *bio =3D NULL;
 	int ret;
=20
-	if (!nvme_ctrl_sgl_supported(ctrl))
-		dev_warn_once(ctrl->device, "using unchecked data buffer\n");
-	if (has_metadata) {
-		if (!supports_metadata)
-			return -EINVAL;
-		if (!nvme_ctrl_meta_sgl_supported(ctrl))
-			dev_warn_once(ctrl->device,
-				      "using unchecked metadata buffer\n");
-	}
+	if (has_metadata && !supports_metadata)
+		return -EINVAL;
=20
 	if (ioucmd && (ioucmd->flags & IORING_URING_CMD_FIXED)) {
 		struct iov_iter iter;
--=20
2.43.5



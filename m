Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AA44D3C526
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Oct 2024 17:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=t/K7on7HVR/lzmjEFd6MOAaEw5KKhkkVzQn0pwpQ1JA=; b=jzLUUK0RQuHcXoauhCPdU8QR1i
	kMVhAQssTavyoApQvpP79LQe7/a2X1uiUVj4NhSP2iQFlWSmujSViLH67T2jPkDaIcwhkj/S11z9y
	o3t+G+5UiW/CaOL2vz6+257DNXfaKi1Upfl040Qft4Qm6a+Kaj+IdH4pTD4f06JAWaHWsGS3CTvpw
	hnrQHKuFUjor9CIF9d6dyo6nuVeO0/zKiHIH9JRHnX5tXG3eBMddP7RYGNnh72eqCIN3LtZZ9qpvE
	1QrCh1XC7aGZx0OhB8PK5rCowFke1lMm9zYFOCk1hm92vnXOVdWWAJ+MgMZjEcx7PJuBFwc6lNZHb
	Ws5EzPPg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t1UF2-0000000Fhs1-0ccG;
	Thu, 17 Oct 2024 17:24:52 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t1UBR-0000000FhOV-3RYd
	for linux-nvme@lists.infradead.org;
	Thu, 17 Oct 2024 17:21:13 +0000
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49HCgxRc005972
	for <linux-nvme@lists.infradead.org>; Thu, 17 Oct 2024 10:21:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2021-q4; bh=t/K7on7HVR/lzmjEFd
	6MOAaEw5KKhkkVzQn0pwpQ1JA=; b=KgsNoHlJSo9Q1y5DA0xGsG30def3UWN4on
	NfzPWOuzyoGeiAfWhzB+5QfKcU+dfCixGbZnKYLj/QUm5UJTvePOhl4+JTkDOMmU
	SwTFGgJQn81DtRfhVdifpkpxprN2q04YgBBXXtXaF0GHlbPcWdPcTHqCZa15n2vy
	N9UBG47sZOb9bd2nkc4TzEQ2hFEURJcjqHUkeM2VwKLicqpU+XJadArlGBy3wXWq
	eZhzAHNj8O6/D4ObY9hZxCNUyLpRgi767D6SKRKmld1lMM9HemexBng94VrqN/Wc
	O8UHNq8qu9D8kIgjHOVvKRJ7HNWdcDnj+CcQX5Z6xKbX7xpU71zw==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 42ar0mnqx3-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Thu, 17 Oct 2024 10:21:08 -0700 (PDT)
Received: from twshared18321.17.frc2.facebook.com (2620:10d:c085:208::7cb7) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Thu, 17 Oct 2024 17:21:07 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id AD27F143ABC3F; Thu, 17 Oct 2024 10:20:57 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>
CC: <sagi@grimberg.me>, <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH] nvme-loop: set blocking flag
Date: Thu, 17 Oct 2024 10:20:52 -0700
Message-ID: <20241017172052.2603389-1-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: PAOLR8e-E96ugArCO6V6HXDUw-CvLoqp
X-Proofpoint-GUID: PAOLR8e-E96ugArCO6V6HXDUw-CvLoqp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_02,2024-10-04_01,2024-09-30_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241017_102109_890070_47BAA4A2 
X-CRM114-Status: GOOD (  12.07  )
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

Commit 505363957fad ("nvmet: fix nvme status code when namespace is
disabled") introduced a mutex lock in the io path for target. The loop
target connects this to the blk-mq submission side, so it requires the
blocking flag set so that queue_rq doesn't happen inside an rcu context.

Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/target/loop.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index e32790d8fc260..77dd809fe4507 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -479,7 +479,7 @@ static void nvme_loop_reset_ctrl_work(struct work_str=
uct *work)
 static const struct nvme_ctrl_ops nvme_loop_ctrl_ops =3D {
 	.name			=3D "loop",
 	.module			=3D THIS_MODULE,
-	.flags			=3D NVME_F_FABRICS,
+	.flags			=3D NVME_F_FABRICS | NVME_F_BLOCKING,
 	.reg_read32		=3D nvmf_reg_read32,
 	.reg_read64		=3D nvmf_reg_read64,
 	.reg_write32		=3D nvmf_reg_write32,
--=20
2.43.5



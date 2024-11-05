Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3FCED3176C
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Nov 2024 17:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3Z1tq38UDQAqEYwJha1nWPxMbxg1Ycu9C/QKjIDWvI8=; b=eye6XR20CRonQkeYnGJZCDExlw
	daiNISvsjl3Hf6Xf4bArD0yRV3PKJ7XSWc3lodNazB25MmRKTLm5l8hLUIjPR2GoMpg4y2Mh/oeLQ
	yVO9kmPkIywNDdsgfJZQAJbsxlfGlIhhCktUW1wr5FDXgq2+9FIfAv2JOl+mvHbXN14GjyooL7lDJ
	C4vQuEJ2VrK5hfGw337i9CWkMMbENBG5eWATlm7c1Gj4OvT4tMR0kKzImhm9Uce8Z0bA91OWECaDa
	Xb/KSl/IZTjLAJA4j37U63iGeztsOifMy+p6tqjs56JzKLGCeDmJfDvZUc+3mXHgbjs8XUmG95HoX
	QgYtzLFQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t8NgF-00000000GkB-36dv;
	Tue, 05 Nov 2024 17:49:27 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t8Ng9-00000000Gev-3j7v
	for linux-nvme@lists.infradead.org;
	Tue, 05 Nov 2024 17:49:23 +0000
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A5HLCZg021443
	for <linux-nvme@lists.infradead.org>; Tue, 5 Nov 2024 09:49:21 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2021-q4;
	 bh=3Z1tq38UDQAqEYwJha1nWPxMbxg1Ycu9C/QKjIDWvI8=; b=YbS9kH2XH6gb
	8DbL0au7ssB0NZWlcbR8vFeq451xh438eczyIxB8fLGyEOMGQ2BXkN8r1iT7Wapw
	X1tHAh2Q/PRhWggsCzMdR+alsKvxsVI9zI5PgbfIccvBOloJ8KrjmHO8EgEr0Nli
	sJiUY52S0xY1AOjhiaNbSebhVTuIjmTUKLS0Kct6CJciG4dFf+BZuGPJ2PXHVtXY
	PXifEH2WgMNbc4Ci95wzChnB/BU/Y7O+8JDQafjYQE1appAUvSg0yhl7HPEf2kFh
	hRPGLJe6u43VRn5c6+xuSFF85fs+TO1W+KTk4gnuwXSrhvd0mazmjob29AvfbPgp
	jdVkOM1bQw==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 42qhedjtjn-17
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Tue, 05 Nov 2024 09:49:21 -0800 (PST)
Received: from 7be2-ac94-0300-0000.twshared25495.03.ash8.tw.fbinfra.net
 (2620:10d:c085:108::150d) by mail.thefacebook.com (2620:10d:c08b:78::c78f)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1544.11; Tue, 5 Nov
 2024 17:49:19 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id 84AA414CB3BE7; Tue,  5 Nov 2024 09:49:06 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <m@bjorling.me>, <matias.bjorling@wdc.com>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCHv3 06/11] nvmet: declare 2.1 version compliance
Date: Tue, 5 Nov 2024 09:48:59 -0800
Message-ID: <20241105174904.3612888-7-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241105174904.3612888-1-kbusch@meta.com>
References: <20241105174904.3612888-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: WY3kFzZFoVUQKbjbq7Jt1PUcCtC64p6D
X-Proofpoint-GUID: WY3kFzZFoVUQKbjbq7Jt1PUcCtC64p6D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_02,2024-10-04_01,2024-09-30_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241105_094922_042787_DAAC4B88 
X-CRM114-Status: GOOD (  10.76  )
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

The target driver implements all the mandatory logs, identifications,
features, and properties up to nvme sepcification 2.1.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/target/nvmet.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 190f55e6d7532..f902a630a5cf4 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -21,7 +21,7 @@
 #include <linux/radix-tree.h>
 #include <linux/t10-pi.h>
=20
-#define NVMET_DEFAULT_VS		NVME_VS(1, 3, 0)
+#define NVMET_DEFAULT_VS		NVME_VS(2, 1, 0)
=20
 #define NVMET_ASYNC_EVENTS		4
 #define NVMET_ERROR_LOG_SLOTS		128
--=20
2.43.5



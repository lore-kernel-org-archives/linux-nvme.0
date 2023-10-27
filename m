Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37754C25B47
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Oct 2023 18:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=NOUjFiB78XQjRlQHb63l5U9Go+J7UMF5QL8vPqB9zMA=; b=lPzYJqYSbc863r+DAQfMtjXj2X
	qSjH++iynUoekUcG3s67pa1cSXePKqPjT9LAnnmdGixE8E7ZaMaN6olw/89ZKZRMDALCSB8kKPBdU
	LI7P49U+/aYs59W76kWAovElKW5ZjONF3kFmFTjrlRtjI0enuFNoI/uF9kkLspj5UFsPFCUjkN+ja
	Il6mveedUbfX721Fa3Nmysza3sT49tDEtoql2R59SvxG5YkyQzDKLd9YvrbpDYoQED31aC5ZSwYjC
	30e7qSgVsE7523tseZROReDDJIlzNx/0IS7WK8Vzvngd3vXcQiufp5bTLLdW8yGyLpZpAzvriq+Z1
	T5Pj7sVw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qwRGf-00Gt8i-12;
	Fri, 27 Oct 2023 18:09:09 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qwRGa-00Gt8K-0U
	for linux-nvme@lists.infradead.org;
	Fri, 27 Oct 2023 18:09:05 +0000
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39RE5eO4006590
	for <linux-nvme@lists.infradead.org>; Fri, 27 Oct 2023 11:09:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=s2048-2021-q4;
 bh=NOUjFiB78XQjRlQHb63l5U9Go+J7UMF5QL8vPqB9zMA=;
 b=W5obZc6DPUjxnxT89V1K9cVYqJJYut1OH5736V+VLOxdN16xkgHoo552mai+g+3JsvER
 Yh6ObZUq2Fi06e1m/Hc+bi6h72WVWMJwW1xoEoimcTUcWcnetEUxerVn10RiUTwF5vGm
 pspZ9+j9OxkopofZedGGpkyWDk7f4KsE/HzRZKzD9H2ComxKBvB93hSdGCYdrU2z0ryK
 13mePf6P7uQrseO8JLf2lzGD8d2xOQ75ORmk/m2kzeoAaksrtewWUKTKmpjGzDAI4Zqd
 0ZDRMhLgUXxtYUYsh/zxKWmfvBuVi/lotvr8GWf+RmOTWHdBZp0skXSGHz7eNu4KpomO HA== 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3u0892vhee-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Fri, 27 Oct 2023 11:09:01 -0700
Received: from twshared1106.02.ash9.facebook.com (2620:10d:c0a8:1c::11) by
 mail.thefacebook.com (2620:10d:c0a8:83::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 27 Oct 2023 11:08:59 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id B5AD420D078F4; Fri, 27 Oct 2023 11:07:54 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>, <hch@lst.de>
CC: <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
        Minh Hoang
	<mh2022@meta.com>
Subject: [PATCH] nvme: ensure reset state check ordering
Date: Fri, 27 Oct 2023 11:07:52 -0700
Message-ID: <20231027180752.2527653-1-kbusch@meta.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: rbt0eWDDtRw4sS_Akcg5Ozn23EtMuBL0
X-Proofpoint-ORIG-GUID: rbt0eWDDtRw4sS_Akcg5Ozn23EtMuBL0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-27_17,2023-10-27_01,2023-05-22_02
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231027_110904_212181_ABBDB30F 
X-CRM114-Status: GOOD (  15.38  )
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

A different CPU may be setting the ctrl->state value while flushing the
reset work, so ensure proper barriers to prevent reading a stale state.
Reading the wrong state can report unexpected ENETRESET errors when
everything was successful.

Fixes: 8000d1fdb07e36 ("nvme-rdma: fix sysfs invoked reset_ctrl error flo=
w")
Reported-by: Minh Hoang <mh2022@meta.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 62612f87aafa2..9ec7ce8cc802e 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -201,7 +201,7 @@ int nvme_reset_ctrl_sync(struct nvme_ctrl *ctrl)
 	ret =3D nvme_reset_ctrl(ctrl);
 	if (!ret) {
 		flush_work(&ctrl->reset_work);
-		if (ctrl->state !=3D NVME_CTRL_LIVE)
+		if (smp_load_acquire(&ctrl->state) !=3D NVME_CTRL_LIVE)
 			ret =3D -ENETRESET;
 	}
=20
--=20
2.34.1



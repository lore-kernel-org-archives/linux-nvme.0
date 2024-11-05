Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3CC8D3176D
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Nov 2024 17:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ngfxCVdxaze14v87LLrtGyQA69EZwPnbpgOefbXDrmU=; b=WcmaJxfrRW8DApN7tmjkmRbq7q
	Bb8XF7CD26+R1BjirZQ/gGexZaKeXu6RSaYtgrKxQ+3H7zJbpjjkQzyg/bPcTE94owB4cd4aFopuM
	EoBBe/UpB1b3qLUGagJRXgnox01PdTaIGJTtWFn7lgWKIjoF5scKsgcR12x7uFWntrwumD7bTH1nG
	Fn3BnSBpkqmbPTbVhFsISewrFuFdiFgUaahBi11v+zNB7M11+8H0NAUR1ef+RwSIR4PNeQeAwlyXe
	Uw4Dk8cSraCZiZ0zLvNWY+xh6xjekNd5WWGEQPSpentuRs397QJ55XyCjqjlCWGFKr9EB96Ny/i2V
	W0hdlKRQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t8Ng9-00000000Gf0-43X3;
	Tue, 05 Nov 2024 17:49:21 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30] helo=mx0a-00082601.pphosted.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t8Ng3-00000000Gba-1KiB
	for linux-nvme@lists.infradead.org;
	Tue, 05 Nov 2024 17:49:17 +0000
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 4A5HLAvV027889
	for <linux-nvme@lists.infradead.org>; Tue, 5 Nov 2024 09:49:14 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2021-q4;
	 bh=ngfxCVdxaze14v87LLrtGyQA69EZwPnbpgOefbXDrmU=; b=Q87V13s0WWei
	4ovbnUUh/ln7yzBaOUdnZhNcAC1pCEc1kh9/qmiqzUFzGoSOuaSy80o0ug1S1eGY
	aCtQbb/pcq8f6Omybp3YXrrmrs0G+ZncqGho4mEc3izlRA2V6FEjsDj5owwH4wvt
	EJFsM6jieTIn7VJcRZ0uAzvDxKXhe7tgkWzB74wjXyyIjYgCJ+w/Xa4r9wMr5rTT
	j4y2uMfjz2CUv28lpSdtbfHpk1KDqpnov2hzmrOCI91S4Ki7EYUUOhmnAy6s4xtq
	YfoUAwGxK1kSuUse5/iI1u2S1qi6jXA50we1EBqpvsnJi2EHyAAgFR+kFgNqkAnO
	D0C7lRaYfg==
Received: from mail.thefacebook.com ([163.114.134.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 42qgjbu50d-6
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Tue, 05 Nov 2024 09:49:14 -0800 (PST)
Received: from twshared18321.17.frc2.facebook.com (2620:10d:c085:208::7cb7) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Tue, 5 Nov 2024 17:49:12 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id A73E214CB3BED; Tue,  5 Nov 2024 09:49:06 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <m@bjorling.me>, <matias.bjorling@wdc.com>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCHv3 09/11] nvmet: support for csi identify ns
Date: Tue, 5 Nov 2024 09:49:02 -0800
Message-ID: <20241105174904.3612888-10-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241105174904.3612888-1-kbusch@meta.com>
References: <20241105174904.3612888-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: uZ3Ma3K3xnz8ypl26QBap4EPp_379BWl
X-Proofpoint-ORIG-GUID: uZ3Ma3K3xnz8ypl26QBap4EPp_379BWl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241105_094915_536944_4F540358 
X-CRM114-Status: GOOD (  10.71  )
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

Implements reporting the I/O Command Set Independent Identify Namespace
command.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/target/admin-cmd.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-=
cmd.c
index dba8940a85e35..9609bda7b5629 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -879,6 +879,35 @@ static void nvme_execute_identify_ns_nvm(struct nvme=
t_req *req)
 	nvmet_req_complete(req, status);
 }
=20
+static void nvmet_execute_id_cs_indep(struct nvmet_req *req)
+{
+	struct nvme_id_ns_cs_indep *id;
+	u16 status;
+
+	status =3D nvmet_req_find_ns(req);
+	if (status)
+		goto out;
+
+	id =3D kzalloc(sizeof(*id), GFP_KERNEL);
+	if (!id) {
+		status =3D NVME_SC_INTERNAL;
+		goto out;
+	}
+
+	id->nstat =3D NVME_NSTAT_NRDY;
+	id->anagrpid =3D req->ns->anagrpid;
+	id->nmic =3D NVME_NS_NMIC_SHARED;
+	if (req->ns->readonly)
+		id->nsattr |=3D NVME_NS_ATTR_RO;
+	if (req->ns->bdev && !bdev_nonrot(req->ns->bdev))
+		id->nsfeat |=3D NVME_NS_ROTATIONAL;
+
+	status =3D nvmet_copy_to_sgl(req, 0, id, sizeof(*id));
+	kfree(id);
+out:
+	nvmet_req_complete(req, status);
+}
+
 static void nvmet_execute_identify(struct nvmet_req *req)
 {
 	if (!nvmet_check_transfer_len(req, NVME_IDENTIFY_DATA_SIZE))
@@ -926,6 +955,9 @@ static void nvmet_execute_identify(struct nvmet_req *=
req)
 	case NVME_ID_CNS_NS_ACTIVE_LIST_CS:
 		nvmet_execute_identify_nslist(req, true);
 		return;
+	case NVME_ID_CNS_NS_CS_INDEP:
+		nvmet_execute_id_cs_indep(req);
+		return;
 	case NVME_ID_CNS_ENDGRP_LIST:
 		nvmet_execute_identify_endgrp_list(req);
 		return;
--=20
2.43.5



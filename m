Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14A90D3176C
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Nov 2024 17:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ko2mqGb1MNbrfYlnC7erAinDpE/OeCOBltr45BHZip4=; b=u1zV+NExHqEuBptGSwMoHBAzYI
	oQxvxTPxjlJ7kycEInLHTEPqbPwM8yNLmDBzGtJ/tHdOpwqYQrfFREspUGp3ZcCPRAI4vTmV8qf7S
	CT1jPKtFCZm/+K9rqKM4sy0/7taHeJq2mQ1my1Z0sgVAQDJe18eD994MFb1RXR18dRVE6snXLz5Z+
	SLExeJXaFkLg2abxTW4Db5eIPLoYqVpPyy9W4wv8yevLiJvk6x4H0eti+jyjeQKC0c0QYcUCDOIay
	IpibZxJ6vxvE9MjxGb9Jh70M420zm1mra8H5o11kwQUYBaN8gZTJrn816wscifcLo3hfTLuslwFzc
	LYIZpEuA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t8Ng7-00000000Gdf-1drS;
	Tue, 05 Nov 2024 17:49:19 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t8Ng2-00000000GbX-3739
	for linux-nvme@lists.infradead.org;
	Tue, 05 Nov 2024 17:49:16 +0000
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A5HLCZW021443
	for <linux-nvme@lists.infradead.org>; Tue, 5 Nov 2024 09:49:14 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2021-q4;
	 bh=ko2mqGb1MNbrfYlnC7erAinDpE/OeCOBltr45BHZip4=; b=XFdOB6TnnLFm
	HNy1keWSH1rcWGUw2P/vwphsdwAmEOntwZMLnaqfNJuoKGbSwQNkz/xrSPmudFUv
	M8K9zvUQJjlBFUo2m1c+s5AOwLLhaSmOejS5aEaFe84knuUDEA3ZepxVd2VfMchh
	uV+fibTJiiw4hO/Uz34wamBW1T3TYFluH/V7dVQVcipD1hE37M1d499V2ZfKnjjt
	Ot86q0bNq6qm5yWucQKntWXzZnXgNlVXTMcRKpYjlFaXMme2arynkbXOQLdQUVJf
	ASQo8yDs/NMZjpKj7N0B/8QCG5xHnBI7hQP12o0xJDpUItEFh5z/nzC558oAPxDN
	fJlbOLQqOQ==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 42qhedjtjn-7
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Tue, 05 Nov 2024 09:49:14 -0800 (PST)
Received: from twshared29075.03.ash8.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Tue, 5 Nov 2024 17:49:10 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id F096F14CB3BDC; Tue,  5 Nov 2024 09:49:05 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <m@bjorling.me>, <matias.bjorling@wdc.com>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCHv3 04/11] nvmet: implement supported features log
Date: Tue, 5 Nov 2024 09:48:57 -0800
Message-ID: <20241105174904.3612888-5-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241105174904.3612888-1-kbusch@meta.com>
References: <20241105174904.3612888-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 5h0-ILLe0srXJqfCXhLT17mb6jH_Glwf
X-Proofpoint-GUID: 5h0-ILLe0srXJqfCXhLT17mb6jH_Glwf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_02,2024-10-04_01,2024-09-30_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241105_094914_924386_DA856CD2 
X-CRM114-Status: GOOD (  11.99  )
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

This log is required for nvme 2.1.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/target/admin-cmd.c | 25 +++++++++++++++++++++++++
 include/linux/nvme.h            |  1 +
 2 files changed, 26 insertions(+)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-=
cmd.c
index b8229d6c9998d..c9b38d593fda5 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -344,6 +344,29 @@ static void nvmet_execute_get_log_page_ana(struct nv=
met_req *req)
 	nvmet_req_complete(req, status);
 }
=20
+static void nvmet_execute_get_log_page_features(struct nvmet_req *req)
+{
+	__le32 *features;
+	u16 status;
+
+	features =3D kzalloc(1024, GFP_KERNEL);
+	if (!features) {
+		status =3D NVME_SC_INTERNAL;
+		goto out;
+	}
+
+	features[NVME_FEAT_NUM_QUEUES] =3D cpu_to_le32(1 << 21 | 1);
+	features[NVME_FEAT_KATO] =3D cpu_to_le32(1 << 21 | 1);
+	features[NVME_FEAT_ASYNC_EVENT] =3D cpu_to_le32(1 << 21 | 1);
+	features[NVME_FEAT_HOST_ID] =3D cpu_to_le32(1 << 21 | 1);
+	features[NVME_FEAT_WRITE_PROTECT] =3D cpu_to_le32(1 << 20 | 1);
+
+	status =3D nvmet_copy_to_sgl(req, 0, features, 1024);
+	kfree(features);
+out:
+	nvmet_req_complete(req, status);
+}
+
 static void nvmet_execute_get_log_page(struct nvmet_req *req)
 {
 	if (!nvmet_check_transfer_len(req, nvmet_get_log_page_len(req->cmd)))
@@ -369,6 +392,8 @@ static void nvmet_execute_get_log_page(struct nvmet_r=
eq *req)
 		return nvmet_execute_get_log_cmd_effects_ns(req);
 	case NVME_LOG_ANA:
 		return nvmet_execute_get_log_page_ana(req);
+	case NVME_LOG_FEATURES:
+		return nvmet_execute_get_log_page_features(req);
 	}
 	pr_debug("unhandled lid %d on qid %d\n",
 	       req->cmd->get_log_page.lid, req->sq->qid);
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index a94e2280d350e..b1238691bd491 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -1256,6 +1256,7 @@ enum {
 	NVME_LOG_TELEMETRY_CTRL =3D 0x08,
 	NVME_LOG_ENDURANCE_GROUP =3D 0x09,
 	NVME_LOG_ANA		=3D 0x0c,
+	NVME_LOG_FEATURES	=3D 0x12,
 	NVME_LOG_DISC		=3D 0x70,
 	NVME_LOG_RESERVATION	=3D 0x80,
 	NVME_FWACT_REPL		=3D (0 << 3),
--=20
2.43.5



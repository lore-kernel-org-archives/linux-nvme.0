Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 359D8CE8E8A
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Oct 2024 15:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=7VH7YeEDhD9qmTSvktsVibvS17/CV9FObpKUpGjh8LI=; b=fdPkzWsoL8cNyuk3VgVZlU1bwl
	H5X6b7sShZU5H20bToD3HOdofqqLANR4vyuseMaKE1tACuyGIwm/FsJfFRFnIsN/CVrL8lcQkzHqi
	sD0p3/GQrqvNyUFxkgBcYiKDhG0yn8n06vYxkT8bKhT+2HTHhQLhI1DlQc/ZCQtW6t1pz0Xw3DiJC
	1U9oW9Sfs5+FOyOurZJZ0sVGwBN0ixcrZOYZ3LfW6W3/sHBrlh9v9myThpr9TYj4Juvlxr51OHtYD
	M0MN9+b+uAMsq3OLW71+UD60+rX92hZsvKQDMEeLZgea3yYJR606uYlRC2RIxgYmnXSuJDJg8FfOS
	/Zs6J51Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t40CA-000000010F9-1p1H;
	Thu, 24 Oct 2024 15:56:18 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t405m-00000000zOP-2p9o
	for linux-nvme@bombadil.infradead.org;
	Thu, 24 Oct 2024 15:49:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:Content-Transfer-Encoding
	:MIME-Version:Message-ID:Date:Subject:CC:To:From:Sender:Reply-To:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=7VH7YeEDhD9qmTSvktsVibvS17/CV9FObpKUpGjh8LI=; b=M0EBb3Vxtz4Be5AgCEJc3k4Hp3
	fwMliuRnz8ij39mz8qtkTawatQcNxIT2CBPh4B1X0wqwVq9nMNex0a6IMlpLylNoOpSJhCApoqQkc
	2fCEk6U6D7Sut07mE2hVMGyQSZYr2H3X/Gyju9kIBeXTwjHpXCc6EuNQAV1vA1sGuZqY0iIkUDxE5
	1o8nSCi9qxT0P8wn9+z539rr2ulG6UfZQOHnLtBarIy0ofmuYtjyYvLrZHy6r5/WyLMch10AX748x
	Itx6UaJyh53Ow4Nam7PYMQKvdZlygGNF+84M10jGEqeOYOyz2zA3K3rPDHpcMBGrtYcjUpU8JXAS5
	h5regcyA==;
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t405j-00000008hxp-17qx
	for linux-nvme@lists.infradead.org;
	Thu, 24 Oct 2024 15:49:41 +0000
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49O9ex2E002927
	for <linux-nvme@lists.infradead.org>; Thu, 24 Oct 2024 08:49:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2021-q4; bh=7VH7YeEDhD9qmTSvkt
	sVibvS17/CV9FObpKUpGjh8LI=; b=fb3VoSGfVNMDboG33S6bd6SQ/GfyH5n5z+
	K+A21hAKTc0aD7LnnhD7R9t8ZycxmJUK/wjQNMLw8fRjiQtHJSQLduBctOfi/ihD
	SAERFetMeLYk/RvJaxUE5m2eYOaoiMWL8diiagEbdwKYyXXn+Jbru/w9BaU13AqR
	5MPa39FhjpRorsIHs3iDjpc036RBq3aZkd+Buwg9vnmPCiwrAKLh/jEwkLrj9qxq
	cIUauE0lCHLzuDo4/56ObdXDrild86Jp6f7BmTsovv8fme3heDKCsddSzssViBWL
	QAU0h7qeeewU8JzLE9JxE4Cc6y39OMqJMUBu929drQGPCDQEH4gw==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 42fe9svb78-18
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Thu, 24 Oct 2024 08:49:33 -0700 (PDT)
Received: from twshared23455.15.frc2.facebook.com (2620:10d:c085:208::7cb7) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Thu, 24 Oct 2024 15:49:29 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id E61F3146D7E11; Thu, 24 Oct 2024 08:49:26 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>, <hch@lst.de>
CC: <martin.petersen@oracle.com>, <joshi.k@samsung.com>,
        Keith Busch
	<kbusch@kernel.org>, David Wei <dw@davidwei.uk>
Subject: [PATCHv3] nvme: module parameter to disable pi with offsets
Date: Thu, 24 Oct 2024 08:49:23 -0700
Message-ID: <20241024154923.3156803-1-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: R2nga5wRm6JRT1z3FFKaPSRVVTgAARkc
X-Proofpoint-GUID: R2nga5wRm6JRT1z3FFKaPSRVVTgAARkc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241024_164939_869065_EE262CA5 
X-CRM114-Status: GOOD (  13.98  )
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

A recent commit enables integrity checks for formats the previous kernel
versions registered with the "nop" integrity profile. This means
namespaces using that format become unreadable when upgrading the kernel
past that commit.

Introduce a module parameter to restore the "nop" integrity profile so
that storage can be readable once again. This could be a boot device, so
the setting needs to happen at module load time.

Fixes: 921e81db524d17 ("nvme: allow integrity when PI is not in first byt=
es")
Reported-by: David Wei <dw@davidwei.uk>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
v2->v3:

  Updated name and added a comment to explain why the parameter exists
=20
 drivers/nvme/host/core.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 84cb859a911d0..4ae878b86f2ba 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -91,6 +91,17 @@ module_param(apst_secondary_latency_tol_us, ulong, 064=
4);
 MODULE_PARM_DESC(apst_secondary_latency_tol_us,
 	"secondary APST latency tolerance in us");
=20
+/*
+ * Older kernels didn't enable protection information if it was at an of=
fset.
+ * Newer kernels do, so it breaks reads on the upgrade if such formats w=
ere
+ * used in prior kernels since the metadata written did not contain a va=
lid
+ * checksum.
+ */
+static bool disable_pi_offsets =3D false;
+module_param(disable_pi_offsets, bool, 0444);
+MODULE_PARM_DESC(disable_pi_offsets,
+	"disable protection information if it has an offset");
+
 /*
  * nvme_wq - hosts nvme related works that are not reset or delete
  * nvme_reset_wq - hosts nvme reset works
@@ -1915,6 +1926,8 @@ static void nvme_configure_metadata(struct nvme_ctr=
l *ctrl,
 		head->pi_type =3D id->dps & NVME_NS_DPS_PI_MASK;
 	if (!(id->dps & NVME_NS_DPS_PI_FIRST))
 		info->pi_offset =3D head->ms - head->pi_size;
+	if (info->pi_offset && disable_pi)
+		head->pi_type =3D 0;
=20
 	if (ctrl->ops->flags & NVME_F_FABRICS) {
 		/*
--=20
2.43.5



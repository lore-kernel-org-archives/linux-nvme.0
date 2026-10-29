Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244E6606A31A
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Oct 2026 15:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=VLbUGoYs;
	dkim=pass (2048-bit key, unprotected) header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=caVufXDE
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=99vALuZgjZO9RomtnzFlIaVUwD3adyaVtgFnxoKa60U=; b=VLbUGoYscGHp2n7Pj9eTBDzUKV
	2IGP7/q86Iz99in6xv4TR9ooWA13N+ynDwN9/gt0hueD+KzaQXgAB0pbZgKCWmPwoP6yAveiCpdVI
	xbDyieARHyPrbYRyeRHz+CXVoYZO+LwGBRb1IG5jPGpTU0WkaDBy46r8gVxyVaTxxryD3m8TkVecd
	E4ar/V/LdwLgaraCTpYTCIjLvFajQCHk7aU3R/eSrPYNcOBqi/cdgVcv53GW8gkBAaIchOEvVPEzG
	SuuLGqWDCYziCe/Ej0F9a0P9cZFDZN+LEe13yoL+ZO3ZF+pyVU1y0U/8a/WHTIXKVMGd5viJDh27R
	nxbk6Ffw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMSRN-00000009g7u-3EIA;
	Thu, 29 Oct 2026 15:53:21 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMSRJ-00000009fyy-06en
	for linux-nvme@lists.infradead.org;
	Thu, 29 Oct 2026 15:53:18 +0000
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69TCdNgv2670384
	for <linux-nvme@lists.infradead.org>; Thu, 29 Oct 2026 08:53:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pps82601-s2048-2026-q3; bh=99vALuZgjZO9RomtnzFlIaVUwD3adyaVtgFnx
	oKa60U=; b=caVufXDEzNpLk+uEQShShzcEVutkNx1iPP/SAMAYP1YYp/3jwMwQk
	IJ8sitsnVH6SZlmQ5JRrTGh8KBKc2F67xKl7rF5FphNtsjVJlkMH/F4kyja4KdKK
	23BjOZZMhALO1Ox/kDjYVPp0PqFwpBiFzfj8UU3cCM/KFpPnAJ1pGp8aOlWJunoT
	FdJY502BuFmaFcitqNwiCfwn9Je16nLWg/yz+CaJe8AbcIZ5akbKVzlGQ3lY7M4j
	sCRtTi5SoY5MagonxyXc/F+vS0EAhuHJLf1N3orfu6f7WihKtPhy7n8gjuK6eET7
	HhqHMfpe6gZ3FHV0hydd6Ey1fQ1hMzB3Q==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4hm28qjnp5-16
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Thu, 29 Oct 2026 08:53:16 -0700 (PDT)
Received: from twshared30277.33.frc3.facebook.com (2620:10d:c085:208::7cb7) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.56; Thu, 29 Oct 2026 15:53:12 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 12B272E22CEA8; Thu, 29 Oct 2026 08:52:55 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>
CC: <axboe@kernel.dk>, <hch@lst.de>, Josef Bacik <josef@toxicpanda.com>,
        Sagi
 Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCH 06/19] nvmet: check the host NQN against the TLS PSK identity
Date: Thu, 29 Oct 2026 08:52:39 -0700
Message-ID: <20261029155252.2332266-7-kbusch@meta.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261029155252.2332266-1-kbusch@meta.com>
References: <20261029155252.2332266-1-kbusch@meta.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA2MiBTYWx0ZWRfX1IZbWQVMol36
 mh8Vv38pcmRgmXDtrqmfgzw3KJQvBBXqoUrDQSYgrnHsQtDbvIpb45eBWUksHfIo/Epy3wS46wr
 V/o0KjxOXbHQUDxc/7E77N6lefBBkzM=
X-Proofpoint-GUID: yKf-NkwuSLRmoSwmoqjDvcTGF5VAyb6a
X-Proofpoint-ORIG-GUID: yKf-NkwuSLRmoSwmoqjDvcTGF5VAyb6a
X-Authority-Analysis: v=2.4 cv=NudE4MdJ c=1 sm=1 tr=0 ts=6ae36bec cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=PAz_-FQ8hEVmOPYdF0yf:22 a=maIFttP_AAAA:8 a=Ikd4Dj_1AAAA:8 a=VwQbUJbxAAAA:8
 a=ZULzmbVybzX1wQDs6AMA:9 a=qR24C9TJY6iBuJVj_x8Y:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA2MiBTYWx0ZWRfX6oJR4D6wwH0c
 snbtUz9/sgKJc2usYu2DJjCd3dQrqYlT2A2y0OoE8akdBBkvJyOzeIsoNvkZfPP7nPW3KHPGcAU
 D8GHO/d6aaq52f0gACvpFvBAvTVhYTiIm1lfdJnwq3fplC453fdp52gM1FfC96E0DzoZEL+CI5Z
 8LiS+XwIPMMV44XL+ZJqbqYxlI75MFgPdGrTU44PyZL9OI6w/ZH4v4nK/3xP5Ekq55btqD4mADX
 Xa2GpBZwDfg9GeKozHm93Jp+hADUmhk+12/Id94WfcY2VDpuGb5aqDqUn+JH0M/MI8qvdJS6Y62
 nIkDiLv9NAOkb7Ofw7llyNOEyiG7FSaeBij4KuKJW/M2nWrO3LCcqOGMmly8qHzgvU6oUU2ShGM
 YTJYqttiq3M09Q2dSXkmweXaJSjidDGn9cnNPkpxVq62QjgksFs6s21uhouTKU0iOsy+u+Awu3+
 aLyNQp3k3YpUclAWTog==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_04,2026-10-21_02,2025-10-01_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261029_085317_097624_F116E472 
X-CRM114-Status: GOOD (  15.50  )
X-Spam-Score: -2.8 (--)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Josef Bacik <josef@toxicpanda.com>

The identity of a TLS PSK names the host and subsystem the key was
generated for. The target remembers which key a handshake ended with,
but never compares it with the host NQN in the Connect that follows. So
a host holding any PSK in the port's keyring can connect as another
host, sees what that host may see, and isn't asked for DH-HMAC-CHAP
since TLS queues skip it. It can add an I/O queue to that host's TLS
controller the same way.

Refuse a Connect whose host NQN isn't the one in the PSK identity of the
queue. The subsystem NQN isn't compared, a discovery subsystem goes by
two names.

Fixes: 675b453e0241 ("nvmet-tcp: enable TLS handshake upcall")
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/target/fabrics-cmd.c | 33 +++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/nvme/target/fabrics-cmd.c b/drivers/nvme/target/fabr=
ics-cmd.c
index fc626c2fd2c92..b950000696c2a 100644
--- a/drivers/nvme/target/fabrics-cmd.c
+++ b/drivers/nvme/target/fabrics-cmd.c
@@ -267,6 +267,30 @@ static u32 nvmet_connect_result(struct nvmet_ctrl *c=
trl, struct nvmet_sq *sq)
 		(needs_auth ? NVME_CONNECT_AUTHREQ_ATR : 0);
 }
=20
+/*
+ * The identity of a TLS PSK names the host that the key was made for:
+ * "NVMe<version><type><hash> <host NQN> <subsystem NQN> ...".
+ * Whoever has proven to hold the key is that host, and no other one.
+ */
+static u16 nvmet_check_tls_host(struct nvmet_sq *sq, const char *hostnqn=
)
+{
+#ifdef CONFIG_NVME_TARGET_TCP_TLS
+	size_t len =3D strlen(hostnqn);
+	const char *id;
+
+	if (!sq->tls_key)
+		return 0;
+
+	id =3D strchr(sq->tls_key->description, ' ');
+	if (!id || strncmp(id + 1, hostnqn, len) || id[len + 1] !=3D ' ') {
+		pr_warn("TLS PSK %08x does not belong to host %s\n",
+			key_serial(sq->tls_key), hostnqn);
+		return NVME_SC_CONNECT_INVALID_HOST | NVME_STATUS_DNR;
+	}
+#endif
+	return 0;
+}
+
 static void nvmet_execute_admin_connect(struct nvmet_req *req)
 {
 	struct nvmf_connect_command *c =3D &req->cmd->connect;
@@ -312,6 +336,10 @@ static void nvmet_execute_admin_connect(struct nvmet=
_req *req)
 	d->subsysnqn[NVMF_NQN_FIELD_LEN - 1] =3D '\0';
 	d->hostnqn[NVMF_NQN_FIELD_LEN - 1] =3D '\0';
=20
+	args.status =3D nvmet_check_tls_host(req->sq, d->hostnqn);
+	if (args.status)
+		goto out;
+
 	args.subsysnqn =3D d->subsysnqn;
 	args.hostnqn =3D d->hostnqn;
 	args.hostid =3D &d->hostid;
@@ -366,6 +394,11 @@ static void nvmet_execute_io_connect(struct nvmet_re=
q *req)
=20
 	d->subsysnqn[NVMF_NQN_FIELD_LEN - 1] =3D '\0';
 	d->hostnqn[NVMF_NQN_FIELD_LEN - 1] =3D '\0';
+
+	status =3D nvmet_check_tls_host(req->sq, d->hostnqn);
+	if (status)
+		goto out;
+
 	ctrl =3D nvmet_ctrl_find_get(d->subsysnqn, d->hostnqn,
 				   le16_to_cpu(d->cntlid), req);
 	if (!ctrl) {
--=20
2.52.0



Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C047606A31D
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Oct 2026 15:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=RYAOK4bJ;
	dkim=pass (2048-bit key, unprotected) header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=Zg2RbOIe
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=6qdEONiF+AR/vPL9T8u6uBo5tDazTHsRzYb8alfXH5Q=; b=RYAOK4bJGPJ6Og/ZYoF9dMVmLs
	uPrNjLiU6qj6xGWxwXAm04PiasssN0lJEsUDQvb5TemOS422k6C/ZjX0I24Bdnmntv+vIVWQcuIn7
	KZB2bfycr3BVvalzV/kc8y32HcB8LuuKGbRmRCG3R62wrrPem5hYWjvNx2hec4EGzCqVDWjYz10Lg
	W9iT5SdirPiMuP2Xv2wLHEtnrBWIpCnwM+iVQUp3Y3JBzG1+DxZrw50AMRe1nStGF/Ivv02dIEIz8
	uBhBcR8hr286aXGrjA6CHSC1mMc3lUrMjpISinJZk87/vmWhn86rdVmHTWXFH3CfHr/FYec7ThJ1G
	7SWoeEUQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMSRN-00000009g8K-3twT;
	Thu, 29 Oct 2026 15:53:21 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30] helo=mx0a-00082601.pphosted.com)
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMSRJ-00000009fzQ-2iVu
	for linux-nvme@lists.infradead.org;
	Thu, 29 Oct 2026 15:53:19 +0000
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 69TCe3PY2479599
	for <linux-nvme@lists.infradead.org>; Thu, 29 Oct 2026 08:53:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pps82601-s2048-2026-q3; bh=6qdEONiF+AR/vPL9T8u6uBo5tDazTHsRzYb8a
	lfXH5Q=; b=Zg2RbOIe9UaNis6hFrVU2ojITwag8+FdKZISHBpMVGx3nHc09Pilv
	opxPXLrF4FffY1yFrYlhRDQfyopkotbneQnq8ec0PRbp4d64qrx+BgRnj5hUAoP6
	TLAZrzzLdT6W9nLL1IOlUYy0tCBibXrGrwKCcrdIu0ST5vBV0Uj/Ejtn7VW4YwSa
	d/erJtVoddWT1IRx/Y2rn3/SIzkIj4YY7Mf6OD7jZ06F+VnhjIX5dvgI5gww4YEz
	5peJOgur2AS36Bs5OeOgAfroQ8jDRURJV/em3tIgCM4eFouTRaXo3t0TA4vSWsiU
	FwEnmx1Ke+vZkOBnP8KX8kOO7WxZ75ZWw==
Received: from mail.thefacebook.com ([163.114.134.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 4hm5yr9mav-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Thu, 29 Oct 2026 08:53:16 -0700 (PDT)
Received: from twshared30277.33.frc3.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.56; Thu, 29 Oct 2026 15:53:12 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id DB8F42E22CE85; Thu, 29 Oct 2026 08:52:54 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>
CC: <axboe@kernel.dk>, <hch@lst.de>, Josef Bacik <josef@toxicpanda.com>,
        Hannes Reinecke <hare@suse.de>, Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya
 Kulkarni <kch@nvidia.com>,
        Hannes Reinecke <hare@kernel.org>, Keith Busch
	<kbusch@kernel.org>
Subject: [PATCH 04/19] nvmet-auth: keep the old keys if the new ones fail
Date: Thu, 29 Oct 2026 08:52:37 -0700
Message-ID: <20261029155252.2332266-5-kbusch@meta.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261029155252.2332266-1-kbusch@meta.com>
References: <20261029155252.2332266-1-kbusch@meta.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=S8NMU4sP c=1 sm=1 tr=0 ts=6ae36bec cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=_78whYxrdx1mplLwxq1U:22 a=maIFttP_AAAA:8 a=Ikd4Dj_1AAAA:8 a=VwQbUJbxAAAA:8
 a=fZjt8k4mCumlHEbMZ4kA:9 a=qR24C9TJY6iBuJVj_x8Y:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA2MSBTYWx0ZWRfX1F6Ve90SSIYS
 phoVyeLb5HPKtpe6RW17g2r4oDfGh7w45n5/0seaGncQjStDlN44DyT0yIhJjM4TYyxr/wPefuY
 nsLibwT/m9H0lmQK1bAWv9ytvXNnr5o=
X-Proofpoint-ORIG-GUID: H1_n4uMG0GoyypD2uWManWph1MegDy_s
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA2MSBTYWx0ZWRfX0DTYARYx9N9S
 SqrSA4z2aozv0iB8TKhvT9c2iPMYGK8azuEexSuIxK9xmBWsebyVqVxBhYjFvs+PC8NI6AsL/jT
 PHjcFon6o/gHNcKSts+0z6aepmzGNslK+YWfAfglP4fqg1xiHyb69ap+hV2NtxLS5uyqCGG3zGD
 cXTaosZrpICWvYLSMlpOO4rW9ZAILy8Nl1WZpU7zj7yvaVlxrCd/IMVDHVZoACi2vPA8JBiNSFo
 QjSj1BnPlJqVG/XUVYIULXO8KTIU7kOtSxwtzq7rD7cfoLJkQLUbME9RBHlIypwILM830ANTfVK
 fzFARg9BaidcozzB/HZ0vipNBt6lT69dFkvx/7mZ+kI8aIK18HbCCIu+eRlRwH1P3zoRyRc7p7F
 UIPtd+7IDsBjNV/krANmHk/yaxPGAg91GQMhRX1jdPxZyxf090zw1koBK7a8RJ8BOd78M9KYcVe
 A7KRXjuA6aQZ95sUmnQ==
X-Proofpoint-GUID: H1_n4uMG0GoyypD2uWManWph1MegDy_s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_04,2026-10-21_02,2025-10-01_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261029_085317_863809_55D003A4 
X-CRM114-Status: GOOD (  17.24  )
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

AUTH_Negotiate on the admin queue has nvmet_setup_auth() reload the
host's keys, and it frees the old host key first. If decoding the new
secret fails, or an allocation does, the controller is left without a
host key, which means no authentication at all: nvmet_check_auth_status()
passes everything and I/O queue Connects no longer ask for it. configfs
accepts any string starting with "DHHC-1:" and a digit, so one typo
while changing a secret opens the namespaces to any connected admin
queue.

Decode the new keys first and only then replace the old ones.

Fixes: db1312dd9548 ("nvmet: implement basic In-Band Authentication")
Cc: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Hannes Reinecke <hare@kernel.org>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/target/auth.c | 69 ++++++++++++++++----------------------
 1 file changed, 28 insertions(+), 41 deletions(-)

diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
index 574025730834c..ccba84b1344e0 100644
--- a/drivers/nvme/target/auth.c
+++ b/drivers/nvme/target/auth.c
@@ -135,6 +135,7 @@ u8 nvmet_setup_auth(struct nvmet_ctrl *ctrl, struct n=
vmet_sq *sq, bool reset)
 	int ret =3D 0;
 	struct nvmet_host_link *p;
 	struct nvmet_host *host =3D NULL;
+	struct nvme_dhchap_key *host_key, *ctrl_key =3D NULL;
=20
 	down_read(&nvmet_config_sem);
 	if (nvmet_is_disc_subsys(ctrl->subsys))
@@ -172,55 +173,41 @@ u8 nvmet_setup_auth(struct nvmet_ctrl *ctrl, struct=
 nvmet_sq *sq, bool reset)
 		goto out_unlock;
 	}
=20
-	if (host->dhchap_hash_id =3D=3D ctrl->shash_id) {
-		pr_debug("Re-use existing hash ID %d\n",
-			 ctrl->shash_id);
-	} else {
-		ctrl->shash_id =3D host->dhchap_hash_id;
-	}
-
-	/* Skip the 'DHHC-1:XX:' prefix */
-	nvme_auth_free_key(ctrl->host_key);
-	ctrl->host_key =3D nvme_auth_extract_key(host->dhchap_secret + 10,
-					       host->dhchap_key_hash);
-	if (IS_ERR(ctrl->host_key)) {
+	/*
+	 * Skip the 'DHHC-1:XX:' prefix. Keep the old keys until the new ones
+	 * are there: a controller without a host key needs no authentication.
+	 */
+	host_key =3D nvme_auth_extract_key(host->dhchap_secret + 10,
+					 host->dhchap_key_hash);
+	if (IS_ERR(host_key)) {
 		ret =3D NVME_AUTH_DHCHAP_FAILURE_NOT_USABLE;
-		ctrl->host_key =3D NULL;
-		goto out_free_hash;
+		goto out_unlock;
 	}
+	if (host->dhchap_ctrl_secret) {
+		ctrl_key =3D nvme_auth_extract_key(host->dhchap_ctrl_secret + 10,
+						 host->dhchap_ctrl_key_hash);
+		if (IS_ERR(ctrl_key)) {
+			nvme_auth_free_key(host_key);
+			ret =3D NVME_AUTH_DHCHAP_FAILURE_NOT_USABLE;
+			goto out_unlock;
+		}
+	}
+	nvme_auth_free_key(ctrl->host_key);
+	ctrl->host_key =3D host_key;
+	nvme_auth_free_key(ctrl->ctrl_key);
+	ctrl->ctrl_key =3D ctrl_key;
+	ctrl->shash_id =3D host->dhchap_hash_id;
 #ifdef CONFIG_NVME_TARGET_AUTH_DEBUG
 	pr_debug("%s: using hash %s key %*ph\n", __func__,
 		 ctrl->host_key->hash > 0 ?
 		 nvme_auth_hmac_name(ctrl->host_key->hash) : "none",
 		 (int)ctrl->host_key->len, ctrl->host_key->key);
+	if (ctrl->ctrl_key)
+		pr_debug("%s: using ctrl hash %s key %*ph\n", __func__,
+			 ctrl->ctrl_key->hash > 0 ?
+			 nvme_auth_hmac_name(ctrl->ctrl_key->hash) : "none",
+			 (int)ctrl->ctrl_key->len, ctrl->ctrl_key->key);
 #endif
-	nvme_auth_free_key(ctrl->ctrl_key);
-	if (!host->dhchap_ctrl_secret) {
-		ctrl->ctrl_key =3D NULL;
-		goto out_unlock;
-	}
-
-	ctrl->ctrl_key =3D nvme_auth_extract_key(host->dhchap_ctrl_secret + 10,
-					       host->dhchap_ctrl_key_hash);
-	if (IS_ERR(ctrl->ctrl_key)) {
-		ret =3D NVME_AUTH_DHCHAP_FAILURE_NOT_USABLE;
-		ctrl->ctrl_key =3D NULL;
-		goto out_free_hash;
-	}
-#ifdef CONFIG_NVME_TARGET_AUTH_DEBUG
-	pr_debug("%s: using ctrl hash %s key %*ph\n", __func__,
-		 ctrl->ctrl_key->hash > 0 ?
-		 nvme_auth_hmac_name(ctrl->ctrl_key->hash) : "none",
-		 (int)ctrl->ctrl_key->len, ctrl->ctrl_key->key);
-#endif
-out_free_hash:
-	if (ret) {
-		if (ctrl->host_key) {
-			nvme_auth_free_key(ctrl->host_key);
-			ctrl->host_key =3D NULL;
-		}
-		ctrl->shash_id =3D 0;
-	}
 out_unlock:
 	up_read(&nvmet_config_sem);
=20
--=20
2.52.0



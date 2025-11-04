Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88ABCCCF9E3
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Nov 2025 23:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=IBXI96WMpDGx42+VJ4xeNtr5+eWqCLgIWQkUXRFFjgE=; b=lvZ8mGf4RNWEOWWOv9RDI7hdRn
	h7ZI2j/Nq0ncTu/z3g33UAfkJ2zYvVLM5Lz5dLoGgzlgAVb6t0w8ls6mRpf8xH16aBgZYU0NyF7M+
	V5JeHR4XteLtPH0+CB5xQWiHFT+2jsj9zjC1eRBMiYVIoKKvkKrqaRIgMfzD7oFm9kOmA2sJ0Nii2
	T2T4dqB5zu62/Daf1l150HLZqTR05gwxHYu65Qre8isweFRVYVp4dov3jl/oCs/HMTSz0MK0qqdNo
	4FEdZqxHES8wzxRXhVlC/HF7eviSTC5J4DSF+vv0V06xuXqsA2FQ0VUQ6VecjWJSBIj9V4JpN1Lgw
	I3j5K1VA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGQEP-0000000CjvA-3XbX;
	Tue, 04 Nov 2025 23:14:29 +0000
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGQEM-0000000Cjun-2y18
	for linux-nvme@lists.infradead.org;
	Tue, 04 Nov 2025 23:14:27 +0000
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-29555415c5fso48768325ad.1
        for <linux-nvme@lists.infradead.org>; Tue, 04 Nov 2025 15:14:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762298065; x=1762902865; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IBXI96WMpDGx42+VJ4xeNtr5+eWqCLgIWQkUXRFFjgE=;
        b=YM9WI6D4STSWljdqqQ85tmBH7sPFbxl0qI5glm24Ywar9r0awkKmcs4k4bOOCYpuMs
         FCPjbs9WYlTfVup4xy/ZHk425qx/uBdvvCabMTe81XaiugLpEMmZRoVhmVo4ys3BEkkL
         1mlPSwXhGbkBadlus9F/sNP/cGRfm2TcKyj4zWjBcbI9dyqAdiyuA/NGTLJ1GdQB5tuy
         DiXRsm2qvXI7PhDNU8vKOowofgvBq3Sfcy8QNQptDiypXe5Ntac9dPKIfIC8/tj6uJYc
         6Egk4eN5SPle59715IShLt5YNy5X35zAQntI0p9YEa70Ain6u2pZRKH62uCbHN3cm607
         4j1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762298065; x=1762902865;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IBXI96WMpDGx42+VJ4xeNtr5+eWqCLgIWQkUXRFFjgE=;
        b=HSbF93v5U/KlyM+Yd74nMs/Nrp1h0rWuS76HSldPWlaRDTWuYwGer4QO/siAo7KkVc
         M0WAoyrdSaWpFvjmxiYRqcwQPJ0EX5vPUWTO/EO+nBv6hjyzdrp6ZP6G86tKL1f/+MwA
         bfM5jQM63WZwBRBRqiDA7TXSfubpzHK551Datz/YFEVegjXi3G3f23LtCH1ryEnwWIVl
         iVk2hlCdB2nsZY4oqC96SdBdQjY2YU/IIVVOI2ePbCKuc37NUNTujyq2zJQqtN1av1OV
         aC7RrD4voIT+pEXx6MHdyMMjZj0OaYv76tlAYYUS/1sZUSDpZCMOucqCL873zhRk8PLV
         xcCQ==
X-Forwarded-Encrypted: i=1; AJvYcCV93uFySO1/Y3rGNcIHd3xDFDkhnxnMfgkGCCr7G+BE5DV02YtO0I8u9ztK07mszN3L4Wa7ksAy++3w@lists.infradead.org
X-Gm-Message-State: AOJu0YzO27ebcLXh/XPiZ6iv6Qb7vQ/rkC4/rJMDcJkdVy6/M/dlPIuV
	oNKSC/yrAmIcIe0S/XlAqs8BSnenog0mxP/ReAK9rbcXLD/8y7baxpFX
X-Gm-Gg: ASbGncu3lyeKwUXskQYCD0bIGWOz9tfhV6sH5GJaT/CijOfOnPWq6F23tQx85jEdKtn
	uZ7JMrvFVgrxlspzZmbf065v7IJ2Rg8uSvfCBTmYgNZO6EC5jyYtDCJNBL544JKeN0f9FeKb00C
	QxQpk0oAUjR1XSxTort6x8yoYHEWq1K6FTxDZVtE9vbgI4xGeap+kDDPK2gTFKUUMSQQt1eMtBl
	I+5UhnbUbX4eou87ZMVVS2kEJqRHsLdm68Ex/r0BFYD1rfavNE2JGkC3WEYR5KN40QPwYun3ykO
	Yx0vdm2wA0gIW0Ro19PXtKVQFSppJsgfT3IzwSgxpsYuRtXYjQDtkXzQY/0i1To+P6huB8r/AuK
	LR0plzxq8lo0xpLa1gwOBo3cUvdTic1VoMHqNiYHWaV62NxogI2wlqW2V4ew9K1KLqDuiBftiCO
	0g7qFZJSwVpm5K9X+2J0pkAxJz3Zbe979/MYK7mIVRlUI5DFbyucDuTFG1NfKNlOF0s/vydISTI
	+YRWpaP
X-Google-Smtp-Source: AGHT+IGdBvi17Le17PP5vZw2RL9BrEoB7qvViDJrnCG5SSCKlLWk2zN00TV8C7+sP+lFXy/yHxGY2g==
X-Received: by 2002:a17:902:fc8f:b0:26b:da03:60db with SMTP id d9443c01a7336-2962ad1faabmr19740605ad.13.1762298065412;
        Tue, 04 Nov 2025 15:14:25 -0800 (PST)
Received: from toolbx.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29601998887sm39697785ad.42.2025.11.04.15.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 15:14:24 -0800 (PST)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: hare@suse.de,
	kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	alistair23@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v2] nvmet-auth: update sc_c in target host hash calculation
Date: Wed,  5 Nov 2025 09:14:14 +1000
Message-ID: <20251104231414.1150771-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251104_151426_758607_85111356 
X-CRM114-Status: GOOD (  17.32  )
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

From: Alistair Francis <alistair.francis@wdc.com>

Commit 7e091add9c43 "nvme-auth: update sc_c in host response" added
the sc_c variable to the dhchap queue context structure which is
appropriately set during negotiate and then used in the host response.

This breaks secure concat connections with a Linux target as the target
code wasn't updated at the same time. This patch fixes this by adding a
new sc_c variable to the host hash calculations.

Fixes: 7e091add9c43 ("nvme-auth: update sc_c in host response")
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
v2:
 - Rebase on v6.18-rc4
 - Add Fixes tag

 drivers/nvme/host/auth.c               | 1 +
 drivers/nvme/target/auth.c             | 5 +++--
 drivers/nvme/target/fabrics-cmd-auth.c | 1 +
 drivers/nvme/target/nvmet.h            | 1 +
 4 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index a01178caf15b..19980122d3d5 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -492,6 +492,7 @@ static int nvme_auth_dhchap_setup_host_response(struct nvme_ctrl *ctrl,
 	ret = crypto_shash_update(shash, buf, 2);
 	if (ret)
 		goto out;
+	memset(buf, 0, sizeof(buf));
 	*buf = chap->sc_c;
 	ret = crypto_shash_update(shash, buf, 1);
 	if (ret)
diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
index 02c23998e13c..f54a1425262d 100644
--- a/drivers/nvme/target/auth.c
+++ b/drivers/nvme/target/auth.c
@@ -298,7 +298,7 @@ int nvmet_auth_host_hash(struct nvmet_req *req, u8 *response,
 	const char *hash_name;
 	u8 *challenge = req->sq->dhchap_c1;
 	struct nvme_dhchap_key *transformed_key;
-	u8 buf[4], sc_c = ctrl->concat ? 1 : 0;
+	u8 buf[4];
 	int ret;
 
 	hash_name = nvme_auth_hmac_name(ctrl->shash_id);
@@ -367,7 +367,7 @@ int nvmet_auth_host_hash(struct nvmet_req *req, u8 *response,
 	ret = crypto_shash_update(shash, buf, 2);
 	if (ret)
 		goto out;
-	*buf = sc_c;
+	*buf = req->sq->sc_c;
 	ret = crypto_shash_update(shash, buf, 1);
 	if (ret)
 		goto out;
@@ -378,6 +378,7 @@ int nvmet_auth_host_hash(struct nvmet_req *req, u8 *response,
 	ret = crypto_shash_update(shash, ctrl->hostnqn, strlen(ctrl->hostnqn));
 	if (ret)
 		goto out;
+	memset(buf, 0, sizeof(buf));
 	ret = crypto_shash_update(shash, buf, 1);
 	if (ret)
 		goto out;
diff --git a/drivers/nvme/target/fabrics-cmd-auth.c b/drivers/nvme/target/fabrics-cmd-auth.c
index 5d7d913927d8..16894302ebe1 100644
--- a/drivers/nvme/target/fabrics-cmd-auth.c
+++ b/drivers/nvme/target/fabrics-cmd-auth.c
@@ -43,6 +43,7 @@ static u8 nvmet_auth_negotiate(struct nvmet_req *req, void *d)
 		 data->auth_protocol[0].dhchap.halen,
 		 data->auth_protocol[0].dhchap.dhlen);
 	req->sq->dhchap_tid = le16_to_cpu(data->t_id);
+	req->sq->sc_c = le16_to_cpu(data->sc_c);
 	if (data->sc_c != NVME_AUTH_SECP_NOSC) {
 		if (!IS_ENABLED(CONFIG_NVME_TARGET_TCP_TLS))
 			return NVME_AUTH_DHCHAP_FAILURE_CONCAT_MISMATCH;
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 73da823a91fb..20be2fe43307 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -159,6 +159,7 @@ struct nvmet_sq {
 	bool			authenticated;
 	struct delayed_work	auth_expired_work;
 	u16			dhchap_tid;
+	u8			sc_c;
 	u8			dhchap_status;
 	u8			dhchap_step;
 	u8			*dhchap_c1;
-- 
2.51.1



Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7B69CCFA05
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Nov 2025 23:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=MxkbqocSKuMAYx2uu2Fs9IEgdxjiKFemke+ud0Q0HuA=; b=mc2BT+K896XFf5hFbqsO/i4bra
	0KKYDipJ2nD5q8AYktNbX/dmw/WLnLgj5j0gzWxOnvD2C4fyl0T+vRRq2PVLAO3hbxOGuj+2wMk7h
	ZJ6oB3rrg3s3wbRh5S5Ex9fqrTgAv1Lrv52X/Gl/cpjmrS4DEEgyls6bICSom0OKbipWaiBZc4M7T
	Ivt8UzJT9wW/PuHvHKqJ5PHYY6r9GS5lrICIJAqq0C2eWcTld8QDdWshGLt/DzPZgdTRXzoQqtGgd
	gQIzxC2+YaP2uMImEQhjQSZaqvoBHgPXHJ53ugDMu18JQOGl2oBfp3yZ9fBvrgdIhgoy6Wu9WB0Uf
	v6VNy3XA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vH9EO-0000000GMFI-1QAd;
	Thu, 06 Nov 2025 23:17:28 +0000
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vH9EI-0000000GMEt-3CME
	for linux-nvme@lists.infradead.org;
	Thu, 06 Nov 2025 23:17:23 +0000
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-7a9fb6fccabso156151b3a.0
        for <linux-nvme@lists.infradead.org>; Thu, 06 Nov 2025 15:17:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762471042; x=1763075842; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MxkbqocSKuMAYx2uu2Fs9IEgdxjiKFemke+ud0Q0HuA=;
        b=fN2iXyCLhr4uwlQsK3hiDt02d40Ie/qDIDratiBlubUMDzXKH6FP0l90yxxPLOYkGH
         ndzt+XTUAZGEQQfqwZl044OPxvMW4AG0IaXHN4tfZLm7LsEAf5MJ7rDyfN/WKk/tee1e
         ulAQ0oTuyUbKiwDdhxJEMO7v6e54QrLHGk+0uxQNZFEg9PmtGrobgNRBimMO8uul2AXY
         75Y/K1zS46SkHSrEUyls9/FG+TZluDeqih/fTOGiluU56680wYB0nWVtwo1IKyDhNggc
         /ZnLIa3Wom60+SWtj+XvBo4Spv4vqTtUXI5FBZ3rJwgeZELDyVL4s1l8b/2og0DCJ+vh
         Mcuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762471042; x=1763075842;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MxkbqocSKuMAYx2uu2Fs9IEgdxjiKFemke+ud0Q0HuA=;
        b=Zw5eD6ZYjQ+2QPG3+qKcm7ubtNkDTkl5pyi6PEFV0ePaKkftt5uS1kCVGcfTsnpQ20
         gjkKmRH+qhmRVp4nreyaAFMBADyOtsfPWO+ax6I05p9857gUYnT29tgymSlL0I9KstPq
         i2ienEWDbH1v7HXr2XaQRyv2gAFWlwkU8QFwcp+OKM9go1Xxf/C+xNNqWPtnftKD3kvV
         w+HKClT+SQNCMTawmHNKfyOoU+Tq+3/rJXi/eyth92atWnMbXbR3TIIhl/hpIlUG0svh
         djQCTKKfhYPIFiAOKCKyYS+AHl7Ny+ROwh/5U89KlSDnve80UfQvYMSKd1BTOidbdhjO
         qVhg==
X-Forwarded-Encrypted: i=1; AJvYcCUFQEx3ryTbXpMoxhmP6fV4QwkxOzhBtv9amNyScRNZwX1c1PiBc41znw+RTYnJlp4LoctwioRDKuJX@lists.infradead.org
X-Gm-Message-State: AOJu0YwvCPbuGRzRnjBV0wD4/u+qhP8bfTjOXVCf07ZGB8AtETsEEST9
	xrQMc35ufH1DmtwOaVCzlir2UMmaoYzJdv8m/Gy+x41Fk1NF9Ds7cNEi
X-Gm-Gg: ASbGnctPNJUjQNBJ5kRirDNlUQlxMYnQ8Yj22Qa0bOqeUQVxGrkZg53bADTXLNy1KcM
	T1ynxPwJ4gzqsEqbgojuMiAFXUcVpGGsV730jOhqLMYmKylNNEGlhDg4WmK3vkuBhicAu6GCKyw
	+/RYo7AyKyOCFEJqlIlHplzeHoPkeh2tyJbkIlRAGfwIX9kaKIrjmEVwU+ZiWfqVfl7nfUenW+4
	3ngMnZ6vSn08kv1vrL4rMVSdPDfwHvTwRxVn5cYjqtyYIjY7VMs5jBx2guPqV5z+P/upXIk2wZc
	hoio3y3X9KtIUW9uholExtV9RFl6gm/B05vAb+Hxgx15kjRCxDcT/Cj02IWWX6gS4COVx6wq//S
	TPQYpDDG8yET2qaNGYke9tD3MjQBXRxqMQ7ZVO+lAfq0foKutI4nvsxkJzENB1pMOv5HzQsR6O8
	50a98g5wJUWsZyLfF+cOFN2YLKui2EDEYPYcUEUnDREAqJ4D+sHJ5blg5k49VKKU7ubmLsBfJT/
	dxYaflJ+w==
X-Google-Smtp-Source: AGHT+IFgt5H5/Jh5UddUTi/eC84zmUvNW7lSw4KqwjZ32dpmEteJM77JYy4M7NtASe4ejJ68zTxu7w==
X-Received: by 2002:a05:6a20:9145:b0:342:873d:7e62 with SMTP id adf61e73a8af0-35229d5e6a6mr1867860637.29.1762471041912;
        Thu, 06 Nov 2025 15:17:21 -0800 (PST)
Received: from toolbx.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0cc175484sm680245b3a.42.2025.11.06.15.17.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 15:17:21 -0800 (PST)
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
Subject: [PATCH v3] nvmet-auth: update sc_c in target host hash calculation
Date: Fri,  7 Nov 2025 09:17:11 +1000
Message-ID: <20251106231711.3189836-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251106_151722_813273_2AD4EE73 
X-CRM114-Status: GOOD (  15.55  )
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
 drivers/nvme/target/auth.c             | 4 ++--
 drivers/nvme/target/fabrics-cmd-auth.c | 1 +
 drivers/nvme/target/nvmet.h            | 1 +
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
index 02c23998e13c..58d80fc72fda 100644
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
diff --git a/drivers/nvme/target/fabrics-cmd-auth.c b/drivers/nvme/target/fabrics-cmd-auth.c
index 5d7d913927d8..0cd722ebfa75 100644
--- a/drivers/nvme/target/fabrics-cmd-auth.c
+++ b/drivers/nvme/target/fabrics-cmd-auth.c
@@ -43,6 +43,7 @@ static u8 nvmet_auth_negotiate(struct nvmet_req *req, void *d)
 		 data->auth_protocol[0].dhchap.halen,
 		 data->auth_protocol[0].dhchap.dhlen);
 	req->sq->dhchap_tid = le16_to_cpu(data->t_id);
+	req->sq->sc_c = data->sc_c;
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



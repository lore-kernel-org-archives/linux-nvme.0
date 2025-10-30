Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7A4ACCF9F6
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Oct 2025 03:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yV4KJ/itlJFLRca3pmyjvPn6JyCSXSOLPe2auNiZSzY=; b=PO9InDPS/Ink+nf5uHq6lBf1bz
	r9iQYUq6ycbMwyvdpV35Y9LEK2ywLkJsv3euZWo1OzeM3lWru8/xYLxIO7ulHX2cMYPajlLVJj1RP
	VRT/JaUpx5eFrbVCHS2YfuoyMU8g8C91yJdOuIMbT3PGeRzJyDZCIRpq5011TLJomJciu/+3muNWk
	Ly+S/xTFDDakWRvDfw74zcD12mu+i/xNeaoMjYMeK23UVezn739ObCww+0PW/UiK6sUbCLR+ySZpI
	hYqfIis7hw3f+OQy9lkTgT5ypFYQoW+o7Wx8a0NXFndGwf+1Wu4mHtN+lL40VvFFK/xf7qtsFVnw8
	ZR8JWgEg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vEJhF-00000003QuM-0LkU;
	Thu, 30 Oct 2025 03:51:33 +0000
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vEJhD-00000003QtY-0SFQ
	for linux-nvme@lists.infradead.org;
	Thu, 30 Oct 2025 03:51:32 +0000
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-290ac2ef203so5222575ad.1
        for <linux-nvme@lists.infradead.org>; Wed, 29 Oct 2025 20:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761796290; x=1762401090; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yV4KJ/itlJFLRca3pmyjvPn6JyCSXSOLPe2auNiZSzY=;
        b=UM0U2TIvMKLELMfHqyvmisB5ay8HeR6Aya9kBRmJEDHuCsZDLDnrkhb8vlKFSdB2UV
         YLI6AxebiWSw4hWmzht05AEaHcci+f/qRWbIBpqacMvBqTc/q/jmEcsDNQZe26/yNNjn
         x9E1njqOf9oBROjfHzadygfcIgUj8Psl9N7f/Af+8mroERcGdFaKeKrQCPPtg64acYSw
         5bCeQSu+0uBudHu1F27xu++WTASnRhM0kcU3HXmLfY6wEXQOB+kjEuDmC+jAtR5rmu8L
         +f8W52y9bK4muZ4V4eaGHM2Rcq7jJeK/pwysw42LI9h8O5lYOoMCC4euRagm55QW8aRg
         85kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761796290; x=1762401090;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yV4KJ/itlJFLRca3pmyjvPn6JyCSXSOLPe2auNiZSzY=;
        b=sjjoiBwYpYp0yNus6XquzZe3V73XrdyTzeGE5GULTyF+x3+WiyvHA10On1Vlmqhqt9
         o8qnvmqqIBPJvqs6lWbKDwO4B4a3qNAuSulldBbGBcSqzFcMdbWwbyLrxvgKoqdc3aIz
         B+9e0RVFoU8PlYFX9ip9lG7Wo4jrL9VouEtaEwVx6OZeUBz81WYNL7/4IK+g75+bnIjB
         G1O1lGG5xAJwj7PKn3Gzok7taePMXodapGonNOvLHgoGUFP2Mw4Dx1q70NXgkqEYMZkq
         A8XWoLVAdL4neL3KA9ykyySaYNKDF01L7HZnVHNpl2iOCrLXnOS+B23IwhFYJ8psTJ/M
         DkJg==
X-Forwarded-Encrypted: i=1; AJvYcCUb0Yd3IOQhYOctJIx32i+sggxzDg171f5YB5wYsx6s8gey2GT5waGjyHUfqTxO77LkX6Mf80g8MsW9@lists.infradead.org
X-Gm-Message-State: AOJu0YyNF5wtLvBH86eE3RwCYcDSEJPHC7HzpOj5PEIAnJ9zx0nr2iYG
	3TcyUZ8PgQNO7ExIEUDUT/MWUyAw246I4NE5q/ZSVj+YXTZFJMxLmCG+
X-Gm-Gg: ASbGncsgOvBDDLtW6X02RKQpLcxqHq66C+4ykkYri3LEZDwI/iX4cy7dHE8RhiEGDZx
	x8y6/r870yrGSW+B5wTgN2lwqSDivTmY+U//SaaDuISH7mKHYEpY7d3WIBwCIWCNu/rKrhNDstX
	HS3F111Nu2OMLWvjnnypThopHmX7vJGlrP6krNTwxNOGMOvisVGE9rT5WHlz7WBOfG+Ew7JDL6G
	79HAFObiODUXQZZgTPEuNTJziFJa7tb+wIu/IL+YNJuM8RXKqmcyoOxxxCfgJhguQ16sP7MrtdB
	oGGjSoJmI+ieunUgiRaR+btIr9z434rBvtoxqi5npxZhSbpamFsdD+Tt5kAfFAGNbvvry3jJvJd
	mIvh/+YZBMwVvm0LsarTnmGuHh40zBrH0kYhKzn8eTm5NBwt8o4sYGhQX4nJ3FKPfsSH/TSB/tQ
	veAT07KZhlxtMxPNVGG/Uy+C5B0j89bOzSSEgfXj9EFTKkfqM//OhvM35pNbk6w6WdKGKYxvLOS
	L/zgv6EjK72GXIYE56b
X-Google-Smtp-Source: AGHT+IFPBdMt0Uqk3RC4Q5N98p917B/ethKWmCVg0XTxRxMZNghvClcvOMeLv6v7oMLApmWNNYOqWw==
X-Received: by 2002:a17:902:f68a:b0:294:fc1d:9d0 with SMTP id d9443c01a7336-294fc1d0db8mr8265645ad.40.1761796290208;
        Wed, 29 Oct 2025 20:51:30 -0700 (PDT)
Received: from toolbx.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498cf3381sm167953225ad.16.2025.10.29.20.51.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 20:51:29 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	hare@suse.de,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	alistair23@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH 1/3] nvmet-tcp: Don't error if TLS is enabed on a reset
Date: Thu, 30 Oct 2025 13:51:12 +1000
Message-ID: <20251030035114.16840-2-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251030035114.16840-1-alistair.francis@wdc.com>
References: <20251030035114.16840-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251029_205131_155042_9576FB2D 
X-CRM114-Status: GOOD (  15.33  )
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

If the host sends a AUTH_Negotiate Message on the admin queue with
REPLACETLSPSK set then we expect and require a TLS connection and
shouldn't report an error if TLS is enabled.

This change only enforces the nvmet_queue_tls_keyid() check if we aren't
resetting the negotiation.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 drivers/nvme/target/auth.c             | 4 ++--
 drivers/nvme/target/core.c             | 2 +-
 drivers/nvme/target/fabrics-cmd-auth.c | 2 +-
 drivers/nvme/target/nvmet.h            | 4 ++--
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
index f3cf7236e080..3e7024899608 100644
--- a/drivers/nvme/target/auth.c
+++ b/drivers/nvme/target/auth.c
@@ -140,7 +140,7 @@ int nvmet_setup_dhgroup(struct nvmet_ctrl *ctrl, u8 dhgroup_id)
 	return ret;
 }
 
-u8 nvmet_setup_auth(struct nvmet_ctrl *ctrl, struct nvmet_sq *sq)
+u8 nvmet_setup_auth(struct nvmet_ctrl *ctrl, struct nvmet_sq *sq, bool reset)
 {
 	int ret = 0;
 	struct nvmet_host_link *p;
@@ -166,7 +166,7 @@ u8 nvmet_setup_auth(struct nvmet_ctrl *ctrl, struct nvmet_sq *sq)
 		goto out_unlock;
 	}
 
-	if (nvmet_queue_tls_keyid(sq)) {
+	if (!reset && nvmet_queue_tls_keyid(sq)) {
 		pr_debug("host %s tls enabled\n", ctrl->hostnqn);
 		goto out_unlock;
 	}
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 5d7d483bfbe3..bd9746715ffc 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1689,7 +1689,7 @@ struct nvmet_ctrl *nvmet_alloc_ctrl(struct nvmet_alloc_ctrl_args *args)
 	if (args->hostid)
 		uuid_copy(&ctrl->hostid, args->hostid);
 
-	dhchap_status = nvmet_setup_auth(ctrl, args->sq);
+	dhchap_status = nvmet_setup_auth(ctrl, args->sq, false);
 	if (dhchap_status) {
 		pr_err("Failed to setup authentication, dhchap status %u\n",
 		       dhchap_status);
diff --git a/drivers/nvme/target/fabrics-cmd-auth.c b/drivers/nvme/target/fabrics-cmd-auth.c
index 50639e6e31eb..f71456a94b66 100644
--- a/drivers/nvme/target/fabrics-cmd-auth.c
+++ b/drivers/nvme/target/fabrics-cmd-auth.c
@@ -293,7 +293,7 @@ void nvmet_execute_auth_send(struct nvmet_req *req)
 			pr_debug("%s: ctrl %d qid %d reset negotiation\n",
 				 __func__, ctrl->cntlid, req->sq->qid);
 			if (!req->sq->qid) {
-				dhchap_status = nvmet_setup_auth(ctrl, req->sq);
+				dhchap_status = nvmet_setup_auth(ctrl, req->sq, true);
 				if (dhchap_status) {
 					pr_err("ctrl %d qid 0 failed to setup re-authentication\n",
 					       ctrl->cntlid);
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index f3b09f4099f0..20be2fe43307 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -896,7 +896,7 @@ void nvmet_execute_auth_receive(struct nvmet_req *req);
 int nvmet_auth_set_key(struct nvmet_host *host, const char *secret,
 		       bool set_ctrl);
 int nvmet_auth_set_host_hash(struct nvmet_host *host, const char *hash);
-u8 nvmet_setup_auth(struct nvmet_ctrl *ctrl, struct nvmet_sq *sq);
+u8 nvmet_setup_auth(struct nvmet_ctrl *ctrl, struct nvmet_sq *sq, bool reset);
 void nvmet_auth_sq_init(struct nvmet_sq *sq);
 void nvmet_destroy_auth(struct nvmet_ctrl *ctrl);
 void nvmet_auth_sq_free(struct nvmet_sq *sq);
@@ -917,7 +917,7 @@ int nvmet_auth_ctrl_sesskey(struct nvmet_req *req,
 void nvmet_auth_insert_psk(struct nvmet_sq *sq);
 #else
 static inline u8 nvmet_setup_auth(struct nvmet_ctrl *ctrl,
-				  struct nvmet_sq *sq)
+				  struct nvmet_sq *sq, bool reset)
 {
 	return 0;
 }
-- 
2.51.0



Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6FFCCDE001
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Nov 2025 04:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QXcTimvtj5rCpXMw3qVJ0C+3WpX47nnTdRXHsBIeFxA=; b=UZKXXRstD2WlbbuEl5KLUv5uE8
	EmjF4h+xfokXFSwQXKuhSeBEtDm0edy5x1/kDzZRxHYNSvZFsHN0pj1a6kVRPjaWUx22JQTTpi+uE
	ITS/bXUAniyFGwagPO6O22ifrZqGoQFsSCNkqAUvxjJrR/hhdoZxkg+HTfPRl83+lfo6gq7bLZ7Jy
	64jsy9/u/cSxngmhJ1HEtjLzhe3oOR6uQbqnlOB34EdBwtEyr+TzTPf3BEZhc7xV2BfWXXTYrXvO9
	HC0dW/sM7zpBBoWzLpzlnSiAK93OutzZRv1Fy0kbxi8e3CeydgGJ5OogcLIK96xC1eqwlEN7SwGEv
	yjcbwk1A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJlu4-0000000BZJo-0kcK;
	Fri, 14 Nov 2025 04:59:20 +0000
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJlu1-0000000BZIi-47DF
	for linux-nvme@lists.infradead.org;
	Fri, 14 Nov 2025 04:59:19 +0000
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-7aae5f2633dso1848210b3a.3
        for <linux-nvme@lists.infradead.org>; Thu, 13 Nov 2025 20:59:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763096357; x=1763701157; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QXcTimvtj5rCpXMw3qVJ0C+3WpX47nnTdRXHsBIeFxA=;
        b=TANUKRINJcQ0krXwYS9AkMPKaJWh/sQlC1azVFnqmndt+dhRJ4EWYT/4LfBmQLq+XK
         zq0iQnRBzh5RcypZpkNtoHr7W9Lo43Tcy73Q9W0WXjKxnMAf4rSCUTE+iuK+54ietYFe
         Td+YYqGfuUOIPhfnVI8eecZVXyU/TDcNv3Oo7usBe75P1gS6Dn/YF+sVyQCx8Nvh+0sV
         o0ZRl3TM0/rJhioidyIUOfiQepms+g7vsG+d34Hc6clpw43wsbU3loIZ/carYlX0g6FX
         uYnoY87VD7fdJWjQcqzxfInEbf4w8Ss+aP7nlwkOswRnYyZ4KOv8AMhBnTntdLepCQbz
         to6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763096357; x=1763701157;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QXcTimvtj5rCpXMw3qVJ0C+3WpX47nnTdRXHsBIeFxA=;
        b=w+B++ws/X0tov7bjbRrOoMU9hpkjV64QIUgX7HyBrMhjfJ15d7tQ2lQOvT/U399plg
         A8t0Ksz5JvNT6Jcnu8Thuwk7yNFdrBPo7OL4YrkPr3y73PyXMZvZRMre4AFdW4ZoYVF8
         abln7g3c2f8IZBJ+up11IRn/Blm4E8/VhmOqAB+GZb40hkTjEd8QfglW1wgSqzVnVpo/
         StY+uoqoAU2VpTCC6rL30ZWouuK1vlEoXjHB6IYjDaBcpN9TedFgYsG3BhgVxlPPeqog
         uRFb0FokNQSb9/w2hgrPYUVb6yr5ftsAjs7k/W6FNJARuxYrSFVpLDINfpW/w5/FgIv6
         9FoQ==
X-Forwarded-Encrypted: i=1; AJvYcCXSwz+Vaj7vWbNER6KA/slYpqy0J77iNXN1KknvPr5i8q0dNP6esF7VwDH/mVbOxHlxqW5pEAS/NDTx@lists.infradead.org
X-Gm-Message-State: AOJu0YxIV8fvs/Bs/OEM2QgqXwYH+3Ao9uvyUvQQlOeZoSO0xi6ffvc2
	Tfv+7GH0gLaOqw0CR57F3cOSCpzLVpXYVhjZlxtapKmXFLedDuds7s1r
X-Gm-Gg: ASbGncvqexQbNZVYJ1T+c9IQHDMTyXk6bLdHHAekaGn++BYyNnDhGftozhQ7dO7bKOu
	B2ckGndaCW1grkrGMi/wXp0gmBrXn17p8lvk02r388SR6DC5VIOfAaitsaCWRt6UaUtrE11cKGz
	ralORI3lWiGu7Zv/hDqWR85g5UH7p15A5b3c1U7M2//7vEGx3STYuY3pm/U0dRWhFbDkzXjm6HW
	LJXJ9SYO8YdCn59ZglngdkEEodHlZH5js6vtNRQovjyhI1OpnPP290h6NIZ6HMyCvpLI4iCQ5MG
	EnJFjgbEYSEOdGvNYTqq53N4Mqj2vJNwojFNHnRt8BOqLJFgUNqLdTxK899PwAl3qQR6mUEH7P8
	/JC1rp4Rk2QrC9NvHos4L5cR7Yk2wyiNQmh6Q7mieoyL0vixdb460qBivisVqmGej7chYBmn/nH
	s1BBvBF+OpVT9yJ41qyg0LqHO2lWYMPSmLuy80OMZiPJpJix7Mnm27RGughztW+KPZ99MEMziBO
	nNNq7Y07s80Nv8Uw6grCMTdXX0ohQ==
X-Google-Smtp-Source: AGHT+IErsJB50lCfDdi7LGqrBVMM7NUX3+TNVZur5pN+WeB4GGuca8w3iph23u0QgOoH+hsEwG8OCA==
X-Received: by 2002:a05:6a00:1407:b0:7aa:ac12:2c33 with SMTP id d2e1a72fcca58-7ba39bbdfd8mr2343286b3a.1.1763096357182;
        Thu, 13 Nov 2025 20:59:17 -0800 (PST)
Received: from toolbx.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ba438bed8csm1061189b3a.53.2025.11.13.20.59.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 20:59:16 -0800 (PST)
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
	Alistair Francis <alistair.francis@wdc.com>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>
Subject: [PATCH v3 1/4] nvmet-tcp: Don't error if TLS is enabed on a reset
Date: Fri, 14 Nov 2025 14:58:47 +1000
Message-ID: <20251114045850.1898865-2-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251114045850.1898865-1-alistair.francis@wdc.com>
References: <20251114045850.1898865-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251113_205918_023934_A11B4177 
X-CRM114-Status: GOOD (  14.95  )
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
Reviewed-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
v3:
 - No change
v2:
 - Fixup long line

 drivers/nvme/target/auth.c             | 4 ++--
 drivers/nvme/target/core.c             | 2 +-
 drivers/nvme/target/fabrics-cmd-auth.c | 3 ++-
 drivers/nvme/target/nvmet.h            | 4 ++--
 4 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
index 300d5e032f6d..58d80fc72fda 100644
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
index 5946681cb0e3..2e828f7717ad 100644
--- a/drivers/nvme/target/fabrics-cmd-auth.c
+++ b/drivers/nvme/target/fabrics-cmd-auth.c
@@ -293,7 +293,8 @@ void nvmet_execute_auth_send(struct nvmet_req *req)
 			pr_debug("%s: ctrl %d qid %d reset negotiation\n",
 				 __func__, ctrl->cntlid, req->sq->qid);
 			if (!req->sq->qid) {
-				dhchap_status = nvmet_setup_auth(ctrl, req->sq);
+				dhchap_status = nvmet_setup_auth(ctrl, req->sq,
+								 true);
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
2.51.1



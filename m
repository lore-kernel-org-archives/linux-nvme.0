Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1111CFD376
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Dec 2025 05:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZyMaMs2d/BjTv7Szr+G0CiikeiHxf3PC4/K7SZLnLjc=; b=BFNeufJmEcshK2eiay7e4f7mn8
	5cjMnpNsE6ZDZzdX7PY7wEUGQjBmssdjjkDnWqZD0LAa2ND9a84Kb1q4nZ/5F5Hgenkr6crIoVkhc
	xfMKfPz5x8prwUz0ezAdoyLppfSo+gYmdpp4TD/gFtu4Z+jFwqFyJjywHi9MhR+AtKzgLBqYXIz4O
	mr64/NX7oUp96qVU+Wwa7Ru9TTY7mORKMr6zSA1jdOw5YmIPS9Fa+2fkf+UTz/CKb7LKYh/psdy+h
	hl2e1vlGVg2X4LQBTa6C0TRVe4nbsTKkG9FyW3ETwP495GVyPuElmTR9gq90+Lmm2/+WJ2TUHPY7P
	hA0KW8kw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vQImt-00000004ouU-1xSK;
	Tue, 02 Dec 2025 05:18:55 +0000
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vQImq-00000004otZ-0fIl
	for linux-nvme@lists.infradead.org;
	Tue, 02 Dec 2025 05:18:54 +0000
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-7acd9a03ba9so5547579b3a.1
        for <linux-nvme@lists.infradead.org>; Mon, 01 Dec 2025 21:18:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764652727; x=1765257527; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZyMaMs2d/BjTv7Szr+G0CiikeiHxf3PC4/K7SZLnLjc=;
        b=YjkCLAklp5SG7E5naWwty+nQX8Wo4tuBf6dR+/KaqBhAu+oIXyiuqWs00pBNqXMuR2
         0Ces+9pJsgY3c2C8PWt6NlUxxMr5KBep4tI+2zlfn4jn/tfU1ccxuUugvKc85SjZAwTB
         TpdWVmY+2j0BklxgiE6N0+iJ9FqNz3Ceeps781kNDw2SYTAheWXWNot4MASxZAwXg8gB
         mptZVDvKp2v4S31A6znxUGL338etwEPI714Cf69h9d2/v2iHm1SSaweQLlVz2LEmc132
         tmxFeU11/vh6bJJMVhSBuZEgx03SRRKRhX1ol5GBrG9vzHRV/0qQxXwwjwB4e0H+3Sr5
         +9Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764652727; x=1765257527;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZyMaMs2d/BjTv7Szr+G0CiikeiHxf3PC4/K7SZLnLjc=;
        b=hAyxH2hxqGWE5cQ5nicbKSWwVwRO9RdlBU68HZJ59lRqJ5LK4oVjY7HrX1lXDLUPB5
         xi3zggHStiYrPJpsBQu2uG5EVEPA2OkUyTdFyWIDMoesfOvUT3lNx0IfkEloucKQULCO
         vT58ruZeDyxf80I5imV3h+ZV0vPfCYLcVdoie7ReF/Hufgmt5YmJ4tfkoOdLhUWSquwu
         vGnuRLR3HmUjtpfGa9d+QVjI24Ot936Pv3Cck8wYK4l1dLEeQOsEgD4DXbKIPmNJVbtW
         uGZMKQqZSlDPhOX1qi9Dmw2caSGynw+HJZxsDbRVtoZ123wWgrwh0FLK1MoP+95E5i3/
         u7ug==
X-Forwarded-Encrypted: i=1; AJvYcCWYsDanif9iQ7LAxI0lheNaWrM6MZw07VpGKJKq7kc145pbTzTsWAmg6CSWxWV6A8LKFz2X5YS4+2BY@lists.infradead.org
X-Gm-Message-State: AOJu0YyCMTtQODPzm5la++A1uF1Gqx2C/pF51LmddFDl/N6jU0EFShWm
	dXUprELx3pQAfthqSojllLIt/QNQc2FXwR7CSoKZsTJ31ZcncXy+NwkP
X-Gm-Gg: ASbGncuMCClzNAZvCYLvV2riqZyxX4WajFFsVzXjySCyE2/m9vGyJPUnGkzR8z5G28x
	IcY8/esAX01wgJEf9Z8L82/t0mN54IUlpeajRQ8UvdNI3GLfyT9NcojNnQABvXD4MSPncxwE9yo
	OGFbYcSlsFrGq2ylYnT+RqH9OeBNo1ISRNevEPiR5Oai9kCk0XUPm8jRu2a39mRQUQSaL2muRsT
	UcXKa4HkS4qK4xa1GhcXSv+qZjQJacU/nBv/sS0srQtLs0EFTr52BxVPMCWEQSz0qjFYuqDhNpn
	TGSn6yhLCwposKi3+ts97+7w2QmAwMKU3Ims70QKpEHHfYZgl0a7diXMV5fZ9dbb1caeWN5P0vG
	oSSYsh6/NqrMczXYcv/61kd757GjKFUZ9CQMj3uIYtRn4VpeDlh68X0a4Nltzo2BP7EL313Hw8x
	0G8Uu/p1aXePJ3eN+YoZ4aYLzv5Xxt6MZKxeshk2JrX7XNtcC64cJVdGk1tn4se4kLyUnTKXJzV
	p8JCa3I7JixtAyHE98RPQbBCYRpeQ==
X-Google-Smtp-Source: AGHT+IFuuFEGROEHRcGsjZKKaRvs7MsnvO5gPwb0vg2lP59PiqqTi6p9w0hYZNIWEz7e0fnIZjYKaw==
X-Received: by 2002:a05:6a20:7f86:b0:35e:1a80:464 with SMTP id adf61e73a8af0-3614ed95c93mr44246658637.46.1764652727338;
        Mon, 01 Dec 2025 21:18:47 -0800 (PST)
Received: from toolbx.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7d15e9c3f79sm15206433b3a.42.2025.12.01.21.18.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 21:18:46 -0800 (PST)
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
Subject: [PATCH v4 1/4] nvmet-tcp: Don't error if TLS is enabed on a reset
Date: Tue,  2 Dec 2025 15:17:52 +1000
Message-ID: <20251202051755.1312158-2-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251202051755.1312158-1-alistair.francis@wdc.com>
References: <20251202051755.1312158-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251201_211852_802230_A5FE8563 
X-CRM114-Status: GOOD (  15.23  )
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
v4:
 - No change
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



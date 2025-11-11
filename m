Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF373CCFA1E
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Nov 2025 23:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EWBi1oTQN8xeszhItyirAU4mtvXfb1sh1s1DRwqqzOI=; b=X7ZnaLSHeO0Qp1O1QgsduP7BXN
	JxzZd0OwhoARaR5zoL5fFyYIYohSK+agElzd4VtUkGzKUGuh8fX0oU+lCAsmaKpvlQTRj4Og+4QaR
	kH8liZVrXZhov5CEhVq0jhmdlT9NH0n0IO7pkHfDjQ+hecaDV+JRrZdFMlIj8AYUvkcwWCkQdRJOe
	P/js0ITuI7VIG7pXpLG+a2clNQkPkBUXwSSTKtyQQcl6uEBd+Ttiv+cWALC4nrc1AYZbODFvwjYsX
	zER4JSe3W+2dybqGXqc20ntgioguXe4Rtyy8Te71hiDrKY1j6FxHrgS0TlW+qJoairJVpf0K3XODK
	vLiY9GRg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vIy3X-00000007tQQ-0piE;
	Tue, 11 Nov 2025 23:45:47 +0000
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vIy3U-00000007tPN-0Jzy
	for linux-nvme@lists.infradead.org;
	Tue, 11 Nov 2025 23:45:45 +0000
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-7b18c6cc278so326812b3a.0
        for <linux-nvme@lists.infradead.org>; Tue, 11 Nov 2025 15:45:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762904743; x=1763509543; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EWBi1oTQN8xeszhItyirAU4mtvXfb1sh1s1DRwqqzOI=;
        b=FTxNwgR7YFBy6MIee1tVBKCqmJyc5qjD5Sef2TY+5GnjqbR1+KyjuI2CJCVqhgcfQ2
         IdcS6kNXBPvZfVv4Ccy5GDH1SQm6CqUtatX2qc6yJ2B7rFpJlKAF6sALwrlYqim+fkU0
         GDPUTjupVZraxjtuJeJyFmUsQ14X4PkgtLn1t01xE2LDpus1/kv36HLIGRUK0drEHNYl
         ryCPp8TEBKlnanPgVQ7ZzvG9OIie6MuKDMbZesE4Se2MJq5q3xsvXuZWF5GpJ3Y38HYo
         z+EIUg3o2yVNzSP4NxDTGIO2LRbfL4NSLrmRNxfAMqPuaCDvabi43azTQ0ztmyg24Trf
         mSRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762904743; x=1763509543;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EWBi1oTQN8xeszhItyirAU4mtvXfb1sh1s1DRwqqzOI=;
        b=wl9SS1hCCmZxLRoTguwHOSz5ta3iSMLvGiDPjQEhHPDOeo0ZHmHsql8bWPYFbKRCbb
         2YbtEa1jZ4JzDo881t7CZvpYeXXQIhNT9f9+kFFftpMVQDX3MUD6KlQpTkdZ6dmb1+M1
         3639ETfqdqXjzF+tdJNPBTb4SndaooN4YuFcfKMcVIyX7oKqGqnuZQfEsoeW2veglVLx
         GJpDETnoXf9MS7Vk0u8bYdkkIoX8ECkgc1+TXwgMqSBVCNFwuhGkoyfL/W0kwTj9kcB6
         f50dtHELU3l/+z0VSDfl2QJ7FCPGVntozY7rBE3ieGftJHl9ydS8Kog8BVv0CuLfNgb9
         k/Rg==
X-Forwarded-Encrypted: i=1; AJvYcCUnH9hV/jbAug+Bcx4HVwPiURbubVfjV35ZNw7ozZNAqrNDAHi9bi5l0KCoXyLT/rI+ynKeG+LfDYui@lists.infradead.org
X-Gm-Message-State: AOJu0YzcF8kHF6fFanIY0+qRoNFbzNf6zYHm+IAZ6KzbDkNVPMzddTzZ
	DOnV19wlhJC5a1iffJNpycre2oBsnEJdXEf++to7H57njsx0qyFezqdoaP2o+g==
X-Gm-Gg: ASbGncuS41AbhcWcq04L8Nza7kFLgjbBuvD1Zw4DnsxGVtG9mJWSu6MUlK8jMmywji3
	04ijqQA+9qQd/A72+TBcuxU0hebaiGB2IqSMN0Ca7A1ooZi2i2mdRVLHD/qdlBPkruivGu4Zidh
	1h5ZDaiTgsEQRkDfVLnp2jUEqkQn4TE9M00n9cZYrEqyyXYqKElvAqypyjzQ0vxJ5rcskezCEFk
	uwT7G4wDCliPlx5VXA0TW4Udqh9Fn0Kcbi/GxYC8FJhZQxrqnYOSk1wDrltGy443viB5r+mtAFi
	cZxwmP/t0rbOeopycvqJ9llVZNtyPpN8yylAD4NQqIP9QZyWnh0HCJH0eI09TiY+WkJDEV0Ms+0
	MJjcGIlSiivErXCEodx4fCytdRIkCe1JhNw68WpsQQPmd9laiIY+RBlfye6JP8hSPnlKjNJij2f
	IQI3HjHyPT88sk3yu6VLYPkr+jkW96ME0Oz+7jJF/3pIYJuqtVXApp0COmK0/jQ7T/9vjB9fBP7
	EI7vqHezA==
X-Google-Smtp-Source: AGHT+IGEypHOScirbVPg+y6OQNiNvnVEj5qynDGboxmj9L9oebys66ZkruXNUzo16Du0Cf/D6yCZQw==
X-Received: by 2002:a05:6a21:999a:b0:342:3b8a:f33e with SMTP id adf61e73a8af0-3590ae34118mr1060999637.39.1762904743267;
        Tue, 11 Nov 2025 15:45:43 -0800 (PST)
Received: from toolbx.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bbf06e85bb4sm784308a12.0.2025.11.11.15.45.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 15:45:42 -0800 (PST)
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
Subject: [PATCH v2 2/4] nvmet-tcp: Don't free SQ on authentication success
Date: Wed, 12 Nov 2025 09:45:16 +1000
Message-ID: <20251111234519.3467440-3-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251111234519.3467440-1-alistair.francis@wdc.com>
References: <20251111234519.3467440-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251111_154544_122322_B953BB85 
X-CRM114-Status: GOOD (  13.46  )
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

Curently after the host sends a REPLACETLSPSK we free the TLS keys as
part of calling nvmet_auth_sq_free() on success. This means when the
host sends a follow up REPLACETLSPSK we return CONCAT_MISMATCH as the
check for !nvmet_queue_tls_keyid(req->sq) fails.

This patch ensures we don't free the TLS key on success as we might need
it again in the future.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
v2:
 - Don't call nvmet_auth_sq_free() in nvmet_execute_auth_send() either

 drivers/nvme/target/fabrics-cmd-auth.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/target/fabrics-cmd-auth.c b/drivers/nvme/target/fabrics-cmd-auth.c
index 2e828f7717ad..0cd722ebfa75 100644
--- a/drivers/nvme/target/fabrics-cmd-auth.c
+++ b/drivers/nvme/target/fabrics-cmd-auth.c
@@ -397,9 +397,10 @@ void nvmet_execute_auth_send(struct nvmet_req *req)
 		goto complete;
 	}
 	/* Final states, clear up variables */
-	nvmet_auth_sq_free(req->sq);
-	if (req->sq->dhchap_step == NVME_AUTH_DHCHAP_MESSAGE_FAILURE2)
+	if (req->sq->dhchap_step == NVME_AUTH_DHCHAP_MESSAGE_FAILURE2) {
+		nvmet_auth_sq_free(req->sq);
 		nvmet_ctrl_fatal_error(ctrl);
+	}
 
 complete:
 	nvmet_req_complete(req, status);
@@ -575,9 +576,7 @@ void nvmet_execute_auth_receive(struct nvmet_req *req)
 	status = nvmet_copy_to_sgl(req, 0, d, al);
 	kfree(d);
 done:
-	if (req->sq->dhchap_step == NVME_AUTH_DHCHAP_MESSAGE_SUCCESS2)
-		nvmet_auth_sq_free(req->sq);
-	else if (req->sq->dhchap_step == NVME_AUTH_DHCHAP_MESSAGE_FAILURE1) {
+	if (req->sq->dhchap_step == NVME_AUTH_DHCHAP_MESSAGE_FAILURE1) {
 		nvmet_auth_sq_free(req->sq);
 		nvmet_ctrl_fatal_error(ctrl);
 	}
-- 
2.51.1



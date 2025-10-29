Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0F4FCCF9E9
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Oct 2025 04:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=6CY+0MVmUH5PmZeNVly8IHxBzQaDRE+875WgMWeyJQI=; b=fONXu+XbXiGJxAof0TXggSDirO
	kj9d+ZgXZ43A9rb/gNNL7pvAklYyQv6wFdT6csaFC1eHOuCeURgPLKI+iB6BFv2VbwV7f9yZyzV/b
	DBAQtkjEfN6kqhoYhoR8Ybk4lNSYGjnBSRJYkLB+V+P13T3qase2QYhfzzf+kIiM8zts3ONoAWsRY
	aHdXRlddzz4iYUxltlPxiGinUF4c31zn0/AOpXxCuc3qi8ItZTThamxoh5uPq2YHa9Xf9gplPGoLN
	xgZrpFpIlFg0pXh8NngFDfDFUSoubUh3TN5mX9ZkJKQ2j5vCkmuoAwDkpDkGZoZbXTtN3Dc1EtiCM
	7IBUmarA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDyC0-0000000HEcI-3eJw;
	Wed, 29 Oct 2025 04:53:52 +0000
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDyBy-0000000HEbK-2oe6
	for linux-nvme@lists.infradead.org;
	Wed, 29 Oct 2025 04:53:51 +0000
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-33e0008d3b3so6878933a91.3
        for <linux-nvme@lists.infradead.org>; Tue, 28 Oct 2025 21:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761713629; x=1762318429; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6CY+0MVmUH5PmZeNVly8IHxBzQaDRE+875WgMWeyJQI=;
        b=Uz0RWdycDwxdeuxlVF1hpzlvLrA93+DaKcX0smL7yMFhKwyO7wIzQXKGeQET7Cz9Jn
         jPU3KRro6dcQNK/sMcctg//QSk0LhCoQnjo1fdr+Wck4cPXPXW3R5h/7ig69tSDp36I3
         Mh8zNqbzfQTLqZqm/LiohPHRFqEyobtap2HfCaWjP8bxQVT2HdoJ7LCO4zuPw+A81ZMz
         EvmbRbSrua7UBKqBCYQ530JhOXQL9zZCoMOQGMhXBwCYu/wRe8Bgrw5fj0hbS2lZpFnI
         UQU690D2U03zYoOjOLuQJ93AXBtAECrMGZLOjGohrA7xdCxsEVno3VfxsIG6LvK2qdnG
         xGBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761713629; x=1762318429;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6CY+0MVmUH5PmZeNVly8IHxBzQaDRE+875WgMWeyJQI=;
        b=I0FkFPQpB4fagP8caojNMotVy0dnB/9VPcvkeka3f/MuRIAoCWzHVLUmYB+EyqvXcj
         HHudwFtl18U4wvkvNUHuv79wOD+HYBLya4r0IxoZEcjnwNZzFXqhXK26iaZ2NuZjPGCw
         fxWHdVw2LzLCC4zV3CTTa92I1631Ck5paWTwb29enyD59FiMwuIMomA1H2aRgwwTGevo
         22Nuq1FpR3WMt86WCnx9660g7NGU/knlXZQxU+gFqP9hYyCgmbpZY163sw/aT0u+Th0D
         ewdIEl34s1/eR51lvHiOUzzwcTJhUab47dlw5IrYtTsVIrvJtleda6CXH4wg0HUteF27
         iztg==
X-Forwarded-Encrypted: i=1; AJvYcCWo58ZGUfTlqPtsdD6PS1osihs6qyRATd2YwecfCzsleIyFcaK79rT76tI1FIlRW7sveJvote3CJSG0@lists.infradead.org
X-Gm-Message-State: AOJu0Yxdr3UtMNp58B1wxYFfBnPeG6iYZCkyg9L6I6w3Ffp5wOGlsMAN
	HdENoPvhU4afmDeGtoGf1rUdohdJZQHuKDqhV7mUnsNKBa0odvF/vGII/aBUyw==
X-Gm-Gg: ASbGncvt9rwPmfQOYCuX8+sa1x/D9aDK2rgoRCO3DN+/dNsr47CECxoHcMU0KZgphLp
	EDE9o3PkLFckBGTCY6xs+M6FhG6xHwDbwih7uPrIcIl2blLwvzjaXsvdUh+9ug2YtP4gATYlbVo
	SVO3frkp0JH2mELNqbGBmIn07fTO82ViClxSPqBphqu4dDaxP8qF3YkqZUj3jqpPLfgIM2cppN6
	3cDVzL19tAYjSDnlSwkw02Dg403y+UqjqD26fRKpNQXqTrsT4e1/kUTO33FJ4zNX4c7NAxDQ+X+
	q/IWncSCsGho5p5O8RsTPfKmi/Joe3/3bdOhc9Q7Ot4hQhj36HW2pbPcmGr+3Em8DIiwPhIoeQV
	MuvBmBgwqeEiLab3/11Q+NT3n2aCZ0Zc1dQVX6qPfFGw56nN8yxsMZwx7jkbnIiGQhVbfWf86t4
	CGdwEBahX2UL7OtJxCoQi0YXMyfdc7rA1Wobho3pQeIbjDt7yws7HuWOaomAw7q+JM37wwfcZ5n
	mqtpp9R
X-Google-Smtp-Source: AGHT+IF+tL1blEpB18Y1AyOuIFg8VIy3ahQmS7vzQLIp8gqRT5i0NTRaLH2fdnERQALAl+3zHQHK5Q==
X-Received: by 2002:a17:90b:1c09:b0:33b:b0f7:fdc3 with SMTP id 98e67ed59e1d1-3403a1435f1mr1757128a91.8.1761713629106;
        Tue, 28 Oct 2025 21:53:49 -0700 (PDT)
Received: from toolbx.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed7f6035sm14051709a91.17.2025.10.28.21.53.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 21:53:48 -0700 (PDT)
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
Subject: [PATCH] nvmet-auth: update sc_c in target host hash calculation
Date: Wed, 29 Oct 2025 14:53:27 +1000
Message-ID: <20251029045327.2035337-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251028_215350_773917_DF077824 
X-CRM114-Status: GOOD (  15.72  )
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

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 drivers/nvme/host/auth.c               | 1 +
 drivers/nvme/target/auth.c             | 3 ++-
 drivers/nvme/target/fabrics-cmd-auth.c | 1 +
 drivers/nvme/target/nvmet.h            | 1 +
 4 files changed, 5 insertions(+), 1 deletion(-)

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
index b340380f3892..f3cf7236e080 100644
--- a/drivers/nvme/target/auth.c
+++ b/drivers/nvme/target/auth.c
@@ -367,7 +367,7 @@ int nvmet_auth_host_hash(struct nvmet_req *req, u8 *response,
 	ret = crypto_shash_update(shash, buf, 2);
 	if (ret)
 		goto out;
-	memset(buf, 0, 4);
+	*buf = req->sq->sc_c;
 	ret = crypto_shash_update(shash, buf, 1);
 	if (ret)
 		goto out;
@@ -377,6 +377,7 @@ int nvmet_auth_host_hash(struct nvmet_req *req, u8 *response,
 	ret = crypto_shash_update(shash, ctrl->hostnqn, strlen(ctrl->hostnqn));
 	if (ret)
 		goto out;
+	memset(buf, 0, sizeof(buf));
 	ret = crypto_shash_update(shash, buf, 1);
 	if (ret)
 		goto out;
diff --git a/drivers/nvme/target/fabrics-cmd-auth.c b/drivers/nvme/target/fabrics-cmd-auth.c
index bf01ec414c55..50639e6e31eb 100644
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
index 51df72f5e89b..f3b09f4099f0 100644
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
2.51.0



Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2FA5FB5EA8
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Mar 2026 03:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=gu1DU71QEoeriPLtDyr4IxAoMPD9+M+2Obobs0fac7Q=; b=DkdL4iupEu6crYyRnAyE40EsSb
	Sbm1OXFd18dKvuWflVCBQA+cAfap0ld2bFucvoDjf01zk3E63Dot+h4Vv9anOcPUH12cjiR5uNIsR
	Aj0bcr2u5oLI0oPc4nnT6EL8GEXpf7H8A2sfMceJhiZf+37tu/8bzYNZbZUo4S3V4bRP+d6CYYPbz
	eD51+Wjs1lGfWtrQ7+TKVpx6CO6kWuVJcUEDAJHXcpI02diomYLh1/uILp+CRbn0qY+cpKNVLy7Px
	nSej/Sb4f7k6ez86AjUNhujvNSMt590hHGML2CabiYCHs2kDrSd7H/ojNbUNDAZ6btXN0fw5WV3tC
	dBX2tfmA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2KsW-00000005Hx4-0D9e;
	Tue, 17 Mar 2026 03:13:56 +0000
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2KsR-00000005HwY-2TUX
	for linux-nvme@lists.infradead.org;
	Tue, 17 Mar 2026 03:13:52 +0000
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-8296d553142so2407348b3a.3
        for <linux-nvme@lists.infradead.org>; Mon, 16 Mar 2026 20:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773717228; x=1774322028; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gu1DU71QEoeriPLtDyr4IxAoMPD9+M+2Obobs0fac7Q=;
        b=Hv/ruaQSj19Kiz56W+4IfkkkZqgMu/njysTppDzkQ5rkbSkKoflePtxtFXQSWEy2Mu
         X2Dl1Euwl5s8K0LRLcDPcIaQiRY/b8e4C6XvBgAtmSw2RCCBWzw0eXQlQnPMCq4UgU6X
         sP7CAuvua0sWvbq4DlhsgsQiiNs149Jr06lajUO5u2K2rZfPN0erpKGmyyuNParIUTBR
         3rF6RqMjdS1VNbaBHuMIUfMUrEagBGmCBajY7Q4jUyWc0O2W1B/SFHyn6yO4l6FwBu7f
         6/ywIYwl+eKhX0IfYkTLNhsPoo/imkS1z7LUDHBpCouIWHZH0Ce5LlF0j9FFnPve53g0
         QVCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773717228; x=1774322028;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gu1DU71QEoeriPLtDyr4IxAoMPD9+M+2Obobs0fac7Q=;
        b=me6fABKjCxAwGNGBNbiem5x/tbI7wMnPsVxyMKcCxnNu4/KbkwQ6tIFgFRxo8J0Tux
         x3mTLLjdd1UxnCre2D9A+vGsUi8t2Z2BnAPjpl8OuemkYVzIQkeB7BLpm5kdGG/rivs0
         Xj5ijhypdRJA3U/qNPw2x6IXryEnGRMfIRH/issoWU6niGtN91hhkQ/9Gn5gfykZIUbm
         Iv+NWygtXG4AI4pa+sq+s7GIVCbFzvfK3XMfrJTvKy6suIT9wA5e7BlI2u5/DnD/ewDx
         7eVoD1/YAf7s6xev4REqGjTd0qPAnVUTgFktJ34hjay5AxagdBKimaY2/G8K6OEgso1C
         8joQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtbRooTItQLsTzKzn/I8IFAe6xyNBdchpPInVVtkvxWrHcXdSFl/LNfRcRqRm82aAlFirFacPI1WPt@lists.infradead.org
X-Gm-Message-State: AOJu0YzAaCKqQORpycnTOILUnXIIcpmW4NwM9EULO7TkJ9MMsn/mCLFj
	islGXhp0sKUf+6Z4Y0CIlAoj8ZDsAmvAanSrabCqxi0WzbhjqAiEI8+U
X-Gm-Gg: ATEYQzx0UWJ8JTlMIAG/lF+KQYGj7N0slP53hb36w5NtQZEN2WW31b3Vui0Fek429G2
	NIMiCS8rECoQTMZozAJjXj1tTWA7/XcFSIPM+GJpek2enoix9UqEcjnl7Ypb/dOJ6k+r57lDjqy
	FNd2Auc5owxUcrUC8TsB9ePrH5N+Q4Xs/R117R+DsOJwH9iX8zh8TP7i3pGplJTtu+aHCC+14It
	xuNxAj8vc/U2I6Kv5IQDNj8QrsoATLUSWIfHb/ULkDPJkeBfhjTRgX4ri3Dkh8UmRnW4khapSXH
	nbLFSzIB7aVmJu02alu95nsV747Wl+GFOg/Sn693d1t1NVsvb/Xcoj36fhcb0pLeokCYoXbw8eP
	XyrT+4DRj0vXWRc0XfZ/FhClKyGKQ2VRLTwvdlOPhujGb78ut8P3GRy0V/Hq/PyLB0XMzwprn9K
	zpzUzjHcLiaoKzLHzNKQ3CclDoAxTL0xYgg+Wj6vqoDA==
X-Received: by 2002:aa7:888f:0:b0:829:73f4:6ff with SMTP id d2e1a72fcca58-82a198cd33cmr11879984b3a.37.1773717228314;
        Mon, 16 Mar 2026 20:13:48 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a07341ed1sm14337206b3a.33.2026.03.16.20.13.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 20:13:47 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: hare@suse.de,
	kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: alistair23@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH] nvme-auth: Include SC_C in RVAL controller hash
Date: Tue, 17 Mar 2026 13:13:30 +1000
Message-ID: <20260317031330.2794078-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260316_201351_635573_794F66A0 
X-CRM114-Status: GOOD (  12.03  )
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

Section 8.3.4.5.5 of the NVMe Base Specification 2.1 describes what is
included in the Response Value (RVAL) hash and SC_C should be included.
Currently we are hardcoding 0 instead of using the correct SC_C value.

Update the host and target code to use the SC_C when calculating the
RVAL instead of using 0.

Fixes: f50fff73d620 ("nvme: implement In-Band authentication")
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 drivers/nvme/host/auth.c   | 2 +-
 drivers/nvme/target/auth.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index 4e8e4ddd6c8d..4ea1a46bad94 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -581,7 +581,7 @@ static int nvme_auth_dhchap_setup_ctrl_response(struct nvme_ctrl *ctrl,
 	ret = crypto_shash_update(shash, buf, 2);
 	if (ret)
 		goto out;
-	memset(buf, 0, 4);
+	*buf = chap->sc_c;
 	ret = crypto_shash_update(shash, buf, 1);
 	if (ret)
 		goto out;
diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
index 839239fe877a..965690afd1bf 100644
--- a/drivers/nvme/target/auth.c
+++ b/drivers/nvme/target/auth.c
@@ -477,7 +477,7 @@ int nvmet_auth_ctrl_hash(struct nvmet_req *req, u8 *response,
 	ret = crypto_shash_update(shash, buf, 2);
 	if (ret)
 		goto out;
-	memset(buf, 0, 4);
+	*buf = req->sq->sc_c;
 	ret = crypto_shash_update(shash, buf, 1);
 	if (ret)
 		goto out;
-- 
2.53.0



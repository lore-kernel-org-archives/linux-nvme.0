Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FFCCC79FBB
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Sep 2026 22:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UMfVAOprw3d03YbEriUlDSnVZxTmhvnPgihN27iwNZ0=; b=fTTdJMNVMSFL/eV5p0oBx6SsdO
	8ho2GkcgkGByb8I83kz3IpRA6p5PxuhI0DwB3YSQhg5Fl6kxmJC+2X6A05LHcbYizySxe6hwQ6DIB
	T8ne3bGi2AMZpX74nUvABG1AHtV6X9FeG0vR/aW4chQpic/1GlOWpUbpO/mKJjVKiknx65kp/8n1R
	+z6BMCZq0bcS1uaAi5STC0o/tZ3bMUS7kAV7ti2Q5suIkpH5P3YJbQGOI7Dv9BAHH0IMrP3WqKkpT
	mzBDsP6e+3DoTyy/3Ky52DUe17shyROBME7+SsBaBIIv2QYG7gq6Dop2uDIra0+VeuGrnvPx13zrd
	XUNnIPCA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4Qmz-0000000D0ly-3GLK;
	Wed, 09 Sep 2026 22:29:09 +0000
Received: from mail-qk1-x763.google.com ([2607:f8b0:4864:20::763])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4Qmv-0000000D0jK-1gVG
	for linux-nvme@lists.infradead.org;
	Wed, 09 Sep 2026 22:29:07 +0000
Received: by mail-qk1-x763.google.com with SMTP id af79cd13be357-930f518e88eso11240985a.0
        for <linux-nvme@lists.infradead.org>; Wed, 09 Sep 2026 15:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1788992944; x=1789597744; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UMfVAOprw3d03YbEriUlDSnVZxTmhvnPgihN27iwNZ0=;
        b=aRTVwzbNFNESXJ/1SuZLUgRurBz7AV7WsU8TejOn5tI8CV/Rw1KYol0PWrVlJxZtsR
         aST3/Ds5Eg6wQefnNjalsHuHzRoY2yZVxrHw2lMhCaKDbVTg3WbOGT17TPNNErYpEh6e
         szRpHms4j0TCAFXhPWq009ylmXOGCyWBqkTR9jdBiJsqCqg0NCP58fwPGRncw9M8MYFw
         TVMvDZdyAgOJQfo1kwEhsIbCBaMieQrWKJ7XcjI3WegfevsQN1Ddkx3j+p0gg0gO4yov
         iwxIHGSbtcXZH1rZISf4J6UKCEfELL5OIRVK8m99AbOHPmHGSF1nJuyOrRd58ggGtSOz
         gR9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788992944; x=1789597744;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UMfVAOprw3d03YbEriUlDSnVZxTmhvnPgihN27iwNZ0=;
        b=CSdKCgkSOL1/pMYn9YGr39FNxSa24rDbDptNHS7XrKepkpB17O1l4W/7G4plDWWHxo
         M1kf4HnXdv7xLZAM3ZK2qzdJAaTIYPJp3dC9DUT0py9wxqFhxaxe6v4MHLsMs4p4dKmy
         o1vy3jEA+xFqkTf7BTTqK8/VU0rz4UGen+fbU6VpxIk40XR8f9RsSeuQP32z+26kfrlU
         cuyALNvlCCfI7P/f/f2vjBh7PyDQoYxgsxbtmw69AIX1j20xD9vKGbT7lAJqKEOEI7r7
         J+g8N20hB4xb3vxHoQxlASk0fNoy7fUNJjPQ/RVHEbaMBqfyOTY7h6OhvVGOkubolglv
         LuTg==
X-Forwarded-Encrypted: i=1; AKwUvByMh/JTn5CqUrSzD4Z5+OzR4NsMybWsnoWou3jeKnHWiKrZS42nDe2VTTumIMO1wioOekeFH5U+N6cV@lists.infradead.org
X-Gm-Message-State: AFuF++nMW/tNmtkRts1FYVk+jpVSXjadQTTNuuB9ex9+pRs1ziy8P4hq
	5cmx38C8EvGAEd1sK2rKttzDELtmm/ZMSo0B3TvbOoyMYCIWrkOWbZR7FUEGKlbVJA8stDJVmSl
	HJEaKn9xtf/w0cPHMLS1dLPUV4+cyk7rLL0k9DMrjbKKpAgN+W5dQ
X-Gm-Gg: AYBFou0MQ3iokD51ANI0O2kX6c+V0ayfiyW11oXCBceKIBLZD6FyXn1kilq9VggINlG
	qtkOgMMOADs88S9ZLdPqUamdHWsU+9BYbBPU6rYBSFR4VXpqwfxpGuI4gMP4hUk5rtyv8QoiUD1
	NdRMvtklc0YLtwLU2L2ffLq7msG1jf8ERx75dpfyaf4cBAko3kDzVmyHyOgdstK60Z/H3k/QhU8
	4eatdbSpxiNNQei4QsdeiB/hIxYQtskit5+AyNyXbdnbIX8dHfJ/pOwAtOrw4nWbfLOxKHWn8qo
	HM+gQ9Ln2aXu8/cyqN5gAsovWHWrrNyJpqpGHG7W7UXHXeKGJsrwdAGuJ/LGBt+qOH+mBya6CWV
	ejYpWSB2sbGF3B9MM
X-Received: by 2002:a05:620a:46a0:b0:939:8a2e:68bc with SMTP id af79cd13be357-939916a0e37mr2963766485a.1.1788992943812;
        Wed, 09 Sep 2026 15:29:03 -0700 (PDT)
Received: from c7-smtp-2026.dev.purestorage.com ([2620:125:9017:12:36:3:6:0])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-91040757b20sm1488646d6.24.2026.09.09.15.29.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 15:29:03 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (bond0.slc5-n17m28-k8s.dev.purestorage.com [IPv6:2620:125:9025:20::a31:41f])
	by c7-smtp-2026.dev.purestorage.com (Postfix) with ESMTP id 096AD402B2;
	Wed,  9 Sep 2026 16:29:03 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 07299E40322; Wed,  9 Sep 2026 16:29:03 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: io-uring@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 1/6] bio-integrity: remove dead bio_integrity_copy_user() error path
Date: Wed,  9 Sep 2026 16:28:31 -0600
Message-ID: <20260909222836.2475352-2-csander@purestorage.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260909222836.2475352-1-csander@purestorage.com>
References: <20260909222836.2475352-1-csander@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260909_152905_443705_10BF4E51 
X-CRM114-Status: GOOD (  12.42  )
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

If bio_integrity_add_page() in bio_integrity_copy_user() fails in the
write case, bio_integrity_copy_user() will return an error after having
already unpinned the user pages. The release_pages label in
bio_integrity_map_user() would then unpin the pages a second time.
Thankfully, bio_integrity_add_page() can't fail here because the
bio_integrity_payload is freshly allocated, so bip_vcnt is 0. Replace
the unreachable error path with a WARN_ON_ONCE().

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 block/bio-integrity.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index b23e2434d80c..8ba8bfa41f8a 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -299,19 +299,13 @@ static int bio_integrity_copy_user(struct bio *bio, struct bio_vec *bvec,
 	else
 		memcpy(&bip->bip_vec[1], bvec, nr_vecs * sizeof(*bvec));
 
 	ret = bio_integrity_add_page(bio, virt_to_page(buf), len,
 				     offset_in_page(buf));
-	if (ret != len) {
-		ret = -ENOMEM;
-		goto free_bip;
-	}
-
+	WARN_ON_ONCE(ret != len);
 	bip->bip_flags |= BIP_COPY_USER;
 	return 0;
-free_bip:
-	bio_integrity_free(bio);
 free_buf:
 	kfree(buf);
 	return ret;
 }
 
-- 
2.55.0



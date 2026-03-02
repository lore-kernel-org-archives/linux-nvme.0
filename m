Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9537ED58E7C
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Mar 2026 08:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=f8e4N2rrFRbad7+5dTDJiAOov3QKt820X8sOfpuD3Qo=; b=rflZmgQ1XyTjZVBenVWCkKhovi
	VLsbUvV3ZcqkLQn7SAk6j2H724JRIlYz6RXG7ODNHr0sqZT7t82+o1wCdIyZ6U925GsdGSZNOSnRl
	Hkcl8EpOUI5cBFgJHIQjzyrOw7yHv3tbRYy7KbFBgtAIwgvEPdA55lJO03JBlTR9MvIL5LjtL7BfB
	o9fB3zmO36VbZQkKQyQOq2+1LxyItk/xp7J6CQ6gmAVJlneFg/fTchJlTLibdZ4qed+PgiVh8zEN7
	Ds2ndz7cX0vxlSs9QmLFUwjrcKuHLOWArdTsUGX0/4TJOtvsLy9536AGUkD/WG8C10gw3u9P488d5
	gIlaYBwQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vwyDf-0000000CSuf-3Qna;
	Mon, 02 Mar 2026 08:01:35 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vwyDa-0000000CShK-02UN
	for linux-nvme@lists.infradead.org;
	Mon, 02 Mar 2026 08:01:30 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 6C9C060123;
	Mon,  2 Mar 2026 08:01:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95FA5C2BCC4;
	Mon,  2 Mar 2026 08:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772438489;
	bh=Lp2OjfkVFaBG9FhdDQb2hnxI9JJpj41THxQ0Ey2WbFM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Pciav5Rmd8mXtmCpTVRHLS8dUSXgg85gvcGRF6qf+UWPuE5Xp+KtEkB8fnJhkC6lV
	 cdkUGFcIbB/drmszw4ZNefsIzfnkqTHbnlpz1xjQvnp5sGtUzqgP9qwIE/z12CfUZF
	 VlSmSlXY6FUshYqS9I4TA4x8sQUCCib4ep5DJCxg9gVPfbSSBi8t0qWd8Iyb7+3Tq6
	 eLbImORfeF37+S6mDTJZY8PKcmShD/JHGRbLo2hJqf7AkDz4PcR8Gx1ZFVRQVXcu3F
	 DHCj5JE38V3cSFQvxm1ZpVRGahJbvhV+Dn3f5bMVHtD3tDw2n7o1kUHfM24qH9aHqx
	 WCDt2pSfrHiMA==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Christoph Hellwig <hch@lst.de>,
	Hannes Reinecke <hare@suse.de>
Cc: linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH 20/21] nvme-auth: common: remove selections of no-longer used crypto modules
Date: Sun,  1 Mar 2026 23:59:58 -0800
Message-ID: <20260302075959.338638-21-ebiggers@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260302075959.338638-1-ebiggers@kernel.org>
References: <20260302075959.338638-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Now that nvme-auth uses the crypto library instead of crypto_shash,
remove obsolete selections from the NVME_AUTH kconfig option.

Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 drivers/nvme/common/Kconfig | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/nvme/common/Kconfig b/drivers/nvme/common/Kconfig
index 1ec507d1f9b5f..f1639db65fd38 100644
--- a/drivers/nvme/common/Kconfig
+++ b/drivers/nvme/common/Kconfig
@@ -5,16 +5,12 @@ config NVME_KEYRING
        select KEYS
 
 config NVME_AUTH
 	tristate
 	select CRYPTO
-	select CRYPTO_HMAC
-	select CRYPTO_SHA256
-	select CRYPTO_SHA512
 	select CRYPTO_DH
 	select CRYPTO_DH_RFC7919_GROUPS
-	select CRYPTO_HKDF
 	select CRYPTO_LIB_SHA256
 	select CRYPTO_LIB_SHA512
 
 config NVME_AUTH_KUNIT_TEST
 	tristate "KUnit tests for NVMe authentication" if !KUNIT_ALL_TESTS
-- 
2.53.0



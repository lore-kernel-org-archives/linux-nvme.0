Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 275DFD58E7C
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Mar 2026 08:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zDlhvHNIesLugZhR0mDIgTMAVNQ9+zAav1sO8/QwOFk=; b=cvmzBldlrbS73JNaP8vg0zaxjg
	Xb3T4vpd1wgmyjSb+U3nJoD4DdSp0lQIVacW7q7Za4U+J/6amDpmJbXm4ddOlbhNX8aaoiC0PUFbn
	X7npGRHmnRNl6XFPK1xsCdSdVSKlOZqN4/ml1LOEKS5bzqwkA1kUPEvq7ULj99cjM+FAcPyas3jsC
	VsetgC5WdCrw3NA5S/SBYAQgLp+8CArsG9KEC2nJU9cujz52o6Fa7djLstL/6AeUoLUkDI02tORWm
	YK6TCFA0nxAkH31qgZfoZJ4kvR0fT0Zr4U4MUAJCHqcSJUpzGf+slvRQSMgAigRQTKJsjuH/kaoo/
	SgQQhb5Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vwyDW-0000000CSct-287B;
	Mon, 02 Mar 2026 08:01:26 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vwyDT-0000000CSYQ-0JFm
	for linux-nvme@lists.infradead.org;
	Mon, 02 Mar 2026 08:01:23 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 78B8460134;
	Mon,  2 Mar 2026 08:01:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED811C2BCB5;
	Mon,  2 Mar 2026 08:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772438482;
	bh=AGZvoiScBe2bk7FU/2hUSFngb0WCvg6z4AjAzwuuyiw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n1T+bIQ1hGo3FHaOn2rrJphI8JkDXzpzDK/OpjXvBmDETTlD93XJ3fzET8yg98ayR
	 V6ABZs1+/+I+I++brACHJZw7bZdKEfAqkJJeNKis0n230egTymnMYagsjAGGAggNOj
	 8hMrNFOkx55X5FaMfsgTulGdz9A7kXC4sqMChkF0Q2dm5tMMo4jGtwmS64PRkaoNqx
	 u97o8gSYMdRbBI103Nc50XyLq0wg5JGiMQpnv1wE5GUCQRSh/ChjPc9ZbEzPV0/SA+
	 Z3wtBNNHjoaElNBy6/ewvzSnYw6fHUolnifswTtDEGF3OaL9O13xpYwjbq9Sv17frJ
	 mBmsXk3R9EymA==
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
Subject: [PATCH 06/21] nvme-auth: common: explicitly verify psk_len == hash_len
Date: Sun,  1 Mar 2026 23:59:44 -0800
Message-ID: <20260302075959.338638-7-ebiggers@kernel.org>
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

nvme_auth_derive_tls_psk() is always called with psk_len == hash_len.
And based on the comments above nvme_auth_generate_psk() and
nvme_auth_derive_tls_psk(), this isn't an implementation choice but
rather just the length the spec uses.  Add a check which makes this
explicit, so that when cleaning up nvme_auth_derive_tls_psk() we don't
have to retain support for arbitrary values of psk_len.

Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 drivers/nvme/common/auth.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/nvme/common/auth.c b/drivers/nvme/common/auth.c
index 2f83c9ddea5ec..9e33fc02cf51a 100644
--- a/drivers/nvme/common/auth.c
+++ b/drivers/nvme/common/auth.c
@@ -786,10 +786,15 @@ int nvme_auth_derive_tls_psk(int hmac_id, const u8 *psk, size_t psk_len,
 		pr_warn("%s: unsupported hash algorithm %s\n",
 			__func__, hmac_name);
 		return -EINVAL;
 	}
 
+	if (psk_len != nvme_auth_hmac_hash_len(hmac_id)) {
+		pr_warn("%s: unexpected psk_len %zu\n", __func__, psk_len);
+		return -EINVAL;
+	}
+
 	hmac_tfm = crypto_alloc_shash(hmac_name, 0, 0);
 	if (IS_ERR(hmac_tfm))
 		return PTR_ERR(hmac_tfm);
 
 	prk_len = crypto_shash_digestsize(hmac_tfm);
-- 
2.53.0



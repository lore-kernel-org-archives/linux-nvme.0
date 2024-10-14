Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59C20D1813E
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Oct 2024 19:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Tda3lLzcCKkbll2dIHLWJo9+q2yl8o5Fs/kdNQ7djk0=; b=AOKqljr/mcSpjM2kqv0OnvbmHC
	FcPFywxMMAUDrns2AIKLHlQzuMsIE+nf4fLdcAcS5OVTNEAnpL894GhXyFaknW7LMDovM16E9qVDd
	2KsxlwonQxvO4rI66y2W+ih9TFi/G3hCUyRLXhM8NXhbNe/lnreARckJ9JeWTiYQfz5OQLWB45TH6
	QW4c8MLlu98tY9+R3skZrEf8c1P0fzlKidD7L8OE2CVajNEQm6TJoX2/FokTETcR/t6Ud3ulYyiE+
	X2ukFKjbCEOIRMFLR7qKbqtcTPp+pUGAHZsHeKH4KB0XFia1eiSqTpzmZnJ1kY8W8pWkqgRYyk2M5
	rOJjWPUA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t0QuU-00000006JY5-0AKA;
	Mon, 14 Oct 2024 19:39:18 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t0QtV-00000006JQQ-0dwd
	for linux-nvme@lists.infradead.org;
	Mon, 14 Oct 2024 19:38:18 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 241A75C5640;
	Mon, 14 Oct 2024 19:38:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02D15C4CEC3;
	Mon, 14 Oct 2024 19:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728934696;
	bh=CEX//ZqgBf243Jq5Ik7iugVFhpGbU6XT4kUmSQIGSa8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MfyAMs3zUrsCZGU/j6FEKgwmFi35ULiPVN73cPNaRfuinzOxGvl0+TRMwZ7oN3r9b
	 eRUJJ1pUoeZhP1ZVyCKIbgFWtpYELq1e5ik4Mfjqo23oFFZI/G+JFh19rxOJcKCSzY
	 prj+LH1RUHQ/I/PwW0eCdtJbT2cNmyn4kdmhNBI0rw+wEnTJfxJ0Bto7tSh6D1FH49
	 LbEBne0HJjegAvyGdhjScc9cCiRblkhXH/98UYRjxw+AABbUWRQ0d5KRvVgV+reMLQ
	 kUn+oLNh5gZlvcGHKYMXtMhMIRnl4iTbFl4eCMY/ubSG/UnMEJ8g+Rh009Kb0jxSjD
	 3Nr6X4hHAfD8A==
Date: Mon, 14 Oct 2024 12:38:14 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Hannes Reinecke <hare@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	linux-crypto@vger.kernel.org
Subject: Re: [PATCH 1/9] crypto,fs: Separate out hkdf_extract() and
 hkdf_expand()
Message-ID: <20241014193814.GB1137@sol.localdomain>
References: <20241011155430.43450-1-hare@kernel.org>
 <20241011155430.43450-2-hare@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241011155430.43450-2-hare@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241014_123817_299527_F8818120 
X-CRM114-Status: GOOD (  21.57  )
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

On Fri, Oct 11, 2024 at 05:54:22PM +0200, Hannes Reinecke wrote:
> Separate out the HKDF functions into a separate module to
> to make them available to other callers.
> And add a testsuite to the module with test vectors
> from RFC 5869 to ensure the integrity of the algorithm.

integrity => correctness

> +config CRYPTO_HKDF
> +	tristate
> +	select CRYPTO_SHA1 if !CONFIG_CRYPTO_MANAGER_DISABLE_TESTS
> +	select CRYPTO_SHA256 if !CONFIG_CRYPTO_MANAGER_DISABLE_TESTS
> +	select CRYPTO_HASH2

Any thoughts on including SHA512 tests instead of SHA1, given that SHA1 is
obsolete and should not be used?

> +int hkdf_expand(struct crypto_shash *hmac_tfm,
> +		const u8 *info, unsigned int infolen,
> +		u8 *okm, unsigned int okmlen)
> +{
> +	SHASH_DESC_ON_STACK(desc, hmac_tfm);
> +	unsigned int i, hashlen = crypto_shash_digestsize(hmac_tfm);
> +	int err;
> +	const u8 *prev = NULL;
> +	u8 counter = 1;
> +	u8 tmp[HASH_MAX_DIGESTSIZE];
> +
> +	if (WARN_ON(okmlen > 255 * hashlen ||
> +		    hashlen > HASH_MAX_DIGESTSIZE))
> +		return -EINVAL;

The crypto API guarantees HASH_MAX_DIGESTSIZE, so checking that again is not
very useful.

> +
> +	memzero_explicit(tmp, HASH_MAX_DIGESTSIZE);

The zeroization above is unnecessary.  If it's done anyway, it is just an
initialization, so it should use an initializer '= {}' instead of
memzero_explicit() which is intended for "destruction".

> +MODULE_ALIAS_CRYPTO("hkdf");

This alias does not make sense and is unnecessary.  These are library functions
that are not exposed by name through the crypto API, so there is no need to wire
them up to the module autoloading accordingly.

> diff --git a/include/crypto/hkdf.h b/include/crypto/hkdf.h
> new file mode 100644
> index 000000000000..c1f23a32a6b6
> --- /dev/null
> +++ b/include/crypto/hkdf.h
> @@ -0,0 +1,18 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * HKDF: HMAC-based Key Derivation Function (HKDF), RFC 5869
> + *
> + * Extracted from fs/crypto/hkdf.c, which has
> + * Copyright 2019 Google LLC
> + */
> +
> +#ifndef _CRYPTO_HKDF_H
> +#define _CRYPTO_HKDF_H
> +
> +int hkdf_extract(struct crypto_shash *hmac_tfm, const u8 *ikm,
> +		 unsigned int ikmlen, const u8 *salt, unsigned int saltlen,
> +		 u8 *prk);
> +int hkdf_expand(struct crypto_shash *hmac_tfm,
> +		const u8 *info, unsigned int infolen,
> +		u8 *okm, unsigned int okmlen);
> +#endif

This needs to include <crypto/hash.h>.

Otherwise there will be errors if someone includes this as their first header.

- Eric


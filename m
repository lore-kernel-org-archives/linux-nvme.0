Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3E7AC3DA5D
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Jul 2024 01:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rrdL1SphFHdT3/MHyQiypkwN/TwbnqKSTxWFVaRRLp8=; b=DwQIYvTx9sFmwSD1kkq6rmx7or
	irnfU5RHLoWTv421IITMZJF4RnKiYAmClP5QH1iRy3XiG/BvJ8Rk2CxVQtw3reVO5drOR2na5xhWk
	fewmJ457fQRYIBAWxCeuVF07Ctat8ng64AY2fndJr/cZXGSCfevgWySCneVrNcYKTSegmA2R5ETWc
	frvtSlu2YBr3xbVbQ/WQJnaf/aN/Dy4wHtJhjKeL22rDojNX1++2c8GUKEo/rIgrMUhZ0eIZ4P85W
	s4SSSg53XSw4scUwkIkciPWBw8Ij8w6IxInZ+zZrWZrkBFCIc6qyOc1sa5ZBLzlJduZU4UnbupRJI
	HYbZ3iwQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sW4Rl-0000000B3Oq-2H7H;
	Tue, 23 Jul 2024 01:36:09 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sW4Ri-0000000B3OC-1DMF
	for linux-nvme@lists.infradead.org;
	Tue, 23 Jul 2024 01:36:08 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 8649BCE0CDF;
	Tue, 23 Jul 2024 01:36:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0647C116B1;
	Tue, 23 Jul 2024 01:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721698563;
	bh=EHmJAS5gLxznHMyE9QZw/Fdm6OSkClD/yGhdKpoAato=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=upCPwLzBixeAEMPKelny1iv8LwUuCLd33wxWtLrbN/gJzjRLIvBFLY2tTuk3GYHN/
	 f+/8LILzQzBQ8pZ5CksYqIzCsREox+j3X31KI95uhJ5+7Sz1LhDeaZjpEp68ZZDnPX
	 9cYH2Fv1bi12m9eJEOgfVRpPBtsjPZEuIC9DsW9DBwuPvUS/rbcvgLiCrQleD3boHR
	 lL1CB3Qu6X6jGCzjf5vdC0GJrkkSMBJpeWTD0E7MVKk11gFhuzGw78OBrq/T0Mouz5
	 kitKQM5X+0JNFV/lQbCmtYdK2UUOI8CfY1OAdwrKypNMmyUtbzM1ubwv6G/X9xb3Bf
	 K+SyN9a5ms+ug==
Date: Tue, 23 Jul 2024 01:36:02 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: Hannes Reinecke <hare@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, linux-crypto@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/9] crypto,fs: Separate out hkdf_extract() and
 hkdf_expand()
Message-ID: <20240723013602.GA2319848@google.com>
References: <20240722142122.128258-1-hare@kernel.org>
 <20240722142122.128258-2-hare@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240722142122.128258-2-hare@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240722_183606_713644_CD4B7755 
X-CRM114-Status: GOOD (  30.29  )
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

On Mon, Jul 22, 2024 at 04:21:14PM +0200, Hannes Reinecke wrote:
> diff --git a/crypto/Makefile b/crypto/Makefile
> index edbbaa3ffef5..b77fc360f0ff 100644
> --- a/crypto/Makefile
> +++ b/crypto/Makefile
> @@ -29,6 +29,7 @@ obj-$(CONFIG_CRYPTO_ECHAINIV) += echainiv.o
>  
>  crypto_hash-y += ahash.o
>  crypto_hash-y += shash.o
> +crypto_hash-y += hkdf.o
>  obj-$(CONFIG_CRYPTO_HASH2) += crypto_hash.o

This should go under a kconfig option CONFIG_CRYPTO_HKDF that is selected by the
users that need it.  That way the code will be built only when needed.

Including a self-test would also be desirable.

> diff --git a/crypto/hkdf.c b/crypto/hkdf.c
> new file mode 100644
> index 000000000000..22e343851c0b
> --- /dev/null
> +++ b/crypto/hkdf.c
> @@ -0,0 +1,112 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Implementation of HKDF ("HMAC-based Extract-and-Expand Key Derivation
> + * Function"), aka RFC 5869.  See also the original paper (Krawczyk 2010):
> + * "Cryptographic Extraction and Key Derivation: The HKDF Scheme".
> + *
> + * This is used to derive keys from the fscrypt master keys.

This is no longer in fs/crypto/, so the part about fscrypt should be removed.

> +/*
> + * HKDF consists of two steps:
> + *
> + * 1. HKDF-Extract: extract a pseudorandom key of length HKDF_HASHLEN bytes from
> + *    the input keying material and optional salt.

It doesn't make sense to refer to HKDF_HASHLEN here since it is specific to
fs/crypto/.

> +/* HKDF-Extract (RFC 5869 section 2.2), unsalted */
> +int hkdf_extract(struct crypto_shash *hmac_tfm, const u8 *ikm,
> +		 unsigned int ikmlen, u8 *prk)

Needs kerneldoc now that this is a library interface.

> +{
> +	unsigned int prklen = crypto_shash_digestsize(hmac_tfm);
> +	u8 *default_salt;
> +	int err;
> +
> +	default_salt = kzalloc(prklen, GFP_KERNEL);
> +	if (!default_salt)
> +		return -ENOMEM;

Now that this is a library interface, it should take the salt as a parameter,
and the users who want the default salt should explicitly specify that.  If we
only provide support for unsalted use, that might inadventently discourage the
use of a salt in future code.  As the function is named hkdf_extract(), people
might also overlook that it's unsalted and doesn't actually match the RFC's
definition of HKDF-Extract.

The use of kzalloc here is also inefficient, as the maximum length of a digest
is known (HKDF_HASHLEN in fs/crypto/ case, HASH_MAX_DIGESTSIZE in general).

> +	err = crypto_shash_setkey(hmac_tfm, default_salt, prklen);
> +	if (!err)
> +		err = crypto_shash_tfm_digest(hmac_tfm, ikm, ikmlen, prk);
> +
> +	kfree(default_salt);
> +	return err;
> +}
> +EXPORT_SYMBOL_GPL(hkdf_extract);
> +
> +/*
> + * HKDF-Expand (RFC 5869 section 2.3).
> + * This expands the pseudorandom key, which was already keyed into @hmac_tfm,
> + * into @okmlen bytes of output keying material parameterized by the
> + * application-specific @info of length @infolen bytes.
> + * This is thread-safe and may be called by multiple threads in parallel.
> + */
> +int hkdf_expand(struct crypto_shash *hmac_tfm,
> +		const u8 *info, unsigned int infolen,
> +		u8 *okm, unsigned int okmlen)

Needs kerneldoc now that this is a library interface.

> diff --git a/fs/crypto/hkdf.c b/fs/crypto/hkdf.c
> index 5a384dad2c72..9c2f9aca9412 100644
> --- a/fs/crypto/hkdf.c
> +++ b/fs/crypto/hkdf.c
>// SPDX-License-Identifier: GPL-2.0
>/*
> * Implementation of HKDF ("HMAC-based Extract-and-Expand Key Derivation
> * Function"), aka RFC 5869.  See also the original paper (Krawczyk 2010):
> * "Cryptographic Extraction and Key Derivation: The HKDF Scheme".
> *
> * This is used to derive keys from the fscrypt master keys.
> *
> * Copyright 2019 Google LLC
> */

The above file comment should be adjusted now that this file doesn't contain the
actual HKDF implementation.

> @@ -118,61 +105,24 @@ int fscrypt_hkdf_expand(const struct fscrypt_hkdf *hkdf, u8 context,
>  			u8 *okm, unsigned int okmlen)
>  {
>  	SHASH_DESC_ON_STACK(desc, hkdf->hmac_tfm);
> -	u8 prefix[9];
> -	unsigned int i;
> +	u8 *prefix;
>  	int err;
> -	const u8 *prev = NULL;
> -	u8 counter = 1;
> -	u8 tmp[HKDF_HASHLEN];
>  
>  	if (WARN_ON_ONCE(okmlen > 255 * HKDF_HASHLEN))
>  		return -EINVAL;
>  
> +	prefix = kzalloc(okmlen + 9, GFP_KERNEL);
> +	if (!prefix)
> +		return -ENOMEM;
>  	desc->tfm = hkdf->hmac_tfm;
>  
>  	memcpy(prefix, "fscrypt\0", 8);
>  	prefix[8] = context;
> +	memcpy(prefix + 9, info, infolen);

This makes the variable called 'prefix' no longer be the prefix, but rather the
full info string.  A better name for it would be 'full_info'.

Also, it's being allocated with the wrong length.  It should be 9 + infolen.

> +	err = hkdf_expand(hkdf->hmac_tfm, prefix, infolen + 8,
> +			  okm, okmlen);
> +	kfree(prefix);

kfree_sensitive()

> diff --git a/include/crypto/hkdf.h b/include/crypto/hkdf.h
> new file mode 100644
> index 000000000000..bf06c080d7ed
> --- /dev/null
> +++ b/include/crypto/hkdf.h
> @@ -0,0 +1,18 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * HKDF: HMAC-based Key Derivation Function (HKDF), RFC 5869
> + *
> + * Extracted from fs/crypto/hkdf.c, which has
> + * Copyright 2019 Google LLC
> + */

If this is keeping the copyright of fs/crypto/hkdf.c, the license needs to stay
the same (GPL-2.0, not GPL-2.0-or-later).

- Eric


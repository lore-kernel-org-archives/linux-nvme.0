Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EF56C5472F
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Aug 2024 18:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YZjT4qATa3m3kkWTXGpYIl2roDTBYSocV6WBVG+tESc=; b=x9aaa7esCLyeecZa+m7REsAHJc
	0x78UoTWCbserCgk04OVNoaRtgZszzdl77K9uqmUnQsElLb6I3ncxY3SDT/HwX4SaovtmRyqEkuq3
	tEx8MO0JkH5+npLuVDzVg8yFfdXCe3ymGaIUoqlA8xkpHcGu0XnvncutaS4VC8YLgB9a+7OxdGmGX
	BV9VvxyePowY9Yh01Dvw/AiCapYr7RRnjBrh20e0a0vvSfne3yoSpM96kp+u96EAp7xtnGAhVXtPk
	5lj5hegsoRmPOZ8AwKvSRb0NPJ8HbAAj3pafRJVFcnySTrQjQkyIqa7SIzgrsL3LxCGXviVyAb/qd
	aEp7sMrQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sj0WW-0000000COna-2ntV;
	Tue, 27 Aug 2024 18:02:32 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sj0WT-0000000COlj-3gqm
	for linux-nvme@lists.infradead.org;
	Tue, 27 Aug 2024 18:02:32 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 6A9DBA427BF;
	Tue, 27 Aug 2024 18:02:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FD33C4FF6C;
	Tue, 27 Aug 2024 17:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724781147;
	bh=Rj0Vj6+WrjswkpwTWsrIf2NYmNdnC0dOj0MUaatbcVA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ujmZjYXKvs9y9f+J5pweaqudl4ROmOMBNwy9/Dzfc4GbNU/wB7iAJP1OComRfoacJ
	 vIAdTPtQ7o38oXWAfULp9p/fBve0OlB2E2cTSMC1Gn2nHzN4NW0npldepHm1qM0SGP
	 V5tiGgs5Yk3fFkMzRXk12uA1YMLTY9HK2JYBunHe/q/T7XrYvFPxURhgnH/bIEB9y4
	 5G1lqKS1ED3ve/jpIqbBSfVvJyW6cqdD/mVvFh5PoXidz9LjOkkE5PvilqqnaFnap9
	 IZl8X4/ZQ+W94YWPDKlYfXWqBB80iCIo7RM2pLvFDjoBUmGSRUXhzkwKJQoKiI4jyO
	 GyF/v0cZcemLA==
Date: Tue, 27 Aug 2024 10:52:25 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Hannes Reinecke <hare@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	linux-crypto@vger.kernel.org
Subject: Re: [PATCH 1/9] crypto,fs: Separate out hkdf_extract() and
 hkdf_expand()
Message-ID: <20240827175225.GA2049@sol.localdomain>
References: <20240813111512.135634-1-hare@kernel.org>
 <20240813111512.135634-2-hare@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240813111512.135634-2-hare@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240827_110230_081638_84AD9791 
X-CRM114-Status: GOOD (  41.65  )
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

On Tue, Aug 13, 2024 at 01:15:04PM +0200, Hannes Reinecke wrote:
> Separate out the HKDF functions into a separate module to
> to make them available to other callers.
> And add a testsuite to the module with test vectors
> from RFC 5869 to ensure the integrity of the algorithm.

integrity => correctness

> diff --git a/crypto/hkdf.c b/crypto/hkdf.c
> new file mode 100644
> index 000000000000..67d55fc3e180
> --- /dev/null
> +++ b/crypto/hkdf.c
[...]
> +/**
> + * hkdf_extract - HKDF-Extract (RFC 5869 section 2.2)
> + * @hmac_tfm: hash context

Should document hmac_tfm properly.  Maybe something like:

@hmac_tfm: an HMAC transform using the hash function desired for HKDF.  The
           caller is responsible for setting the @prk afterwards.

> + * @ikm: input keying material
> + * @ikmlen: length of @ikm
> + * @salt: input salt value
> + * @saltlen: length of @salt
> + * @prk: resulting pseudorandom key
> + *
> + * Extracts a pseudorandom key @prk from the input keying material
> + * @ikm with length @ikmlen and salt @salt with length @saltlen.
> + * The length of @prk is given by the digest size of @hmac_tfm.
> + * For an 'unsalted' version of HKDF-Extract @salt should be set
> + * to all zeroes and @saltlen should be set to the length of @prk.

should => must (both times above)

> + * otherwise a negative error.

negative errno value (not just any negative error)

> +/*
> + * hkdf_expand - HKDF-Expand (RFC 5869 section 2.3)

Needs to be /** to make it a kerneldoc comment

> + * @hmac_tfm: hash context keyed with pseudorandom key
> + * @info: application-specific information
> + * @infolen: length of @info
> + * @okm: output keying material

Missing documentation for @okmlen parameter

> + *
> + * This expands the pseudorandom key, which was already keyed into @hmac_tfm,
> + * into @okmlen bytes of output keying material parameterized by the
> + * application-specific @info of length @infolen bytes.
> + * This is thread-safe and may be called by multiple threads in parallel.
> + *
> + * Returns 0 on success with output keying material stored in @okm,
> + * negative error number otherwise.
> + */
> +int hkdf_expand(struct crypto_shash *hmac_tfm,
> +		const u8 *info, unsigned int infolen,
> +		u8 *okm, unsigned int okmlen)
> +{
> +	SHASH_DESC_ON_STACK(desc, hmac_tfm);
> +	unsigned int i, hashlen = crypto_shash_digestsize(hmac_tfm);
> +	int err;
> +	const u8 *prev = NULL;
> +	u8 counter = 1;
> +	u8 *tmp;
> +
> +	if (WARN_ON(okmlen > 255 * hashlen))
> +		return -EINVAL;
> +
> +	tmp = kzalloc(hashlen, GFP_KERNEL);
> +	if (!tmp)
> +		return -ENOMEM;

tmp can be allocated on the stack since it has maximum length
HASH_MAX_DIGESTSIZE.

Also, either way, it needs to be zeroized at the end of the function.

> +	desc->tfm = hmac_tfm;
> +
> +	for (i = 0; i < okmlen; i += hashlen) {
> +
> +		err = crypto_shash_init(desc);
> +		if (err)
> +			goto out;
> +
> +		if (prev) {
> +			err = crypto_shash_update(desc, prev, hashlen);
> +			if (err)
> +				goto out;
> +		}
> +
> +		if (info && infolen) {

'if (infolen)' instead of 'if (info && infolen)'.  The latter is a bad practice
because it can hide bugs.

> +struct hkdf_testvec {
> +	const char *test;
> +	const unsigned char *ikm;
> +	const unsigned char *salt;
> +	const unsigned char *info;
> +	const unsigned char *prk;
> +	const unsigned char *okm;
> +	unsigned short ikm_size;
> +	unsigned short salt_size;
> +	unsigned short info_size;
> +	unsigned short prk_size;
> +	unsigned short okm_size;
> +};

u8 and u16 instead of unsigned char and unsigned short, please.

> +static int hkdf_test(const char *shash, const struct hkdf_testvec *tv)
> +{	struct crypto_shash *tfm = NULL;
> +	u8 *prk = NULL, *okm = NULL;
> +	unsigned int prk_size;
> +	const char *driver;
> +	int err;
> +
> +	tfm = crypto_alloc_shash(shash, 0, 0);
> +	if (IS_ERR(tfm)) {
> +		pr_err("%s(%s): failed to allocate transform: %ld\n",
> +		       tv->test, shash, PTR_ERR(tfm));
> +		return PTR_ERR(tfm);
> +	}
> +	driver = crypto_shash_driver_name(tfm);
> +
> +	prk_size = crypto_shash_digestsize(tfm);
> +	prk = kzalloc(prk_size, GFP_KERNEL);
> +	if (!prk) {
> +		err = -ENOMEM;
> +		goto out_free_shash;
> +	}
> +
> +	if (tv->prk_size != prk_size) {
> +		pr_err("%s(%s): prk size mismatch (vec %u, digest %u\n",
> +		       tv->test, driver, tv->prk_size, prk_size);
> +		err = -EINVAL;
> +		goto out_free_prk;
> +	}

Since freeing NULL is a no-op, this function only really needs one label.

> +	err = crypto_shash_setkey(tfm, tv->prk, tv->prk_size);
> +	if (err) {
> +		pr_err("%s(%s): failed to hash key to PRK, error %d\n",
> +		       tv->test, driver, err);

Not sure what "failed to hash key to PRK" means here.  It failed to set the PRK,
so a better error message might be "failed to set PRK".

> +static int __init crypto_hkdf_module_init(void)
> +{
> +	int ret = 0, i;
> +
> +	if (IS_ENABLED(CONFIG_CRYPTO_MANAGER_DISABLE_TESTS))
> +		return 0;
> +
> +	for (i = 0; i < ARRAY_SIZE(hkdf_sha256_tv); i++) {
> +		ret = hkdf_test("hmac(sha256)", &hkdf_sha256_tv[i]);
> +		if (ret)
> +			return ret;
> +	}
> +	for (i = 0; i < ARRAY_SIZE(hkdf_sha1_tv); i++) {
> +		ret = hkdf_test("hmac(sha1)", &hkdf_sha1_tv[i]);
> +		if (ret)
> +			return ret;
> +	}

It's surprising that there are tests for sha1 which is obsolete, but none for
sha512 which is what is actually being used.

In any case, nothing guarantees that sha256 and sha1 are available here, as they
aren't selected by CRYPTO_HKDF.  They would need to be selected, at least if
CRYPTO_MANAGER_DISABLE_TESTS=n, or else the tests would need to be skipped if
the underlying hash algorithm is not available in the crypto API.

> +MODULE_DESCRIPTION("Hashed-Key derivation functions");

This may be a misunderstanding about what HKDF stands for.

How about: MODULE_DESCRIPTION("HMAC-based Key Derivation Function (HKDF)");


> diff --git a/fs/crypto/hkdf.c b/fs/crypto/hkdf.c
> index 5a384dad2c72..4f1d331bee9f 100644
> --- a/fs/crypto/hkdf.c
> +++ b/fs/crypto/hkdf.c
[...]
> @@ -79,12 +63,8 @@ int fscrypt_init_hkdf(struct fscrypt_hkdf *hkdf, const u8 *master_key,
>  		return PTR_ERR(hmac_tfm);
>  	}
>  
> -	if (WARN_ON_ONCE(crypto_shash_digestsize(hmac_tfm) != sizeof(prk))) {
> -		err = -EINVAL;
> -		goto err_free_tfm;
> -	}

Why is this WARN_ON_ONCE being removed?  It doesn't seem to be replaced by
anything.

> -
> -	err = hkdf_extract(hmac_tfm, master_key, master_key_size, prk);
> +	err = hkdf_extract(hmac_tfm, master_key, master_key_size,
> +			   default_salt, HKDF_HASHLEN, prk);
>  	if (err)
>  		goto err_free_tfm;
>  
> @@ -118,61 +98,24 @@ int fscrypt_hkdf_expand(const struct fscrypt_hkdf *hkdf, u8 context,
>  			u8 *okm, unsigned int okmlen)
>  {
>  	SHASH_DESC_ON_STACK(desc, hkdf->hmac_tfm);
> -	u8 prefix[9];
> -	unsigned int i;
> +	u8 *full_info;
>  	int err;
> -	const u8 *prev = NULL;
> -	u8 counter = 1;
> -	u8 tmp[HKDF_HASHLEN];
>  
>  	if (WARN_ON_ONCE(okmlen > 255 * HKDF_HASHLEN))
>  		return -EINVAL;

... but this WARN_ON_ONCE is no longer needed since hkdf_expand() does it.

>  
> +	full_info = kzalloc(infolen + 9, GFP_KERNEL);
> +	if (!full_info)
> +		return -ENOMEM;
>  	desc->tfm = hkdf->hmac_tfm;
>  
> -	memcpy(prefix, "fscrypt\0", 8);
> -	prefix[8] = context;
> -
> -	for (i = 0; i < okmlen; i += HKDF_HASHLEN) {
> -
> -		err = crypto_shash_init(desc);
> -		if (err)
> -			goto out;
> -
> -		if (prev) {
> -			err = crypto_shash_update(desc, prev, HKDF_HASHLEN);
> -			if (err)
> -				goto out;
> -		}
> -
> -		err = crypto_shash_update(desc, prefix, sizeof(prefix));
> -		if (err)
> -			goto out;
> -
> -		err = crypto_shash_update(desc, info, infolen);
> -		if (err)
> -			goto out;
> -
> -		BUILD_BUG_ON(sizeof(counter) != 1);
> -		if (okmlen - i < HKDF_HASHLEN) {
> -			err = crypto_shash_finup(desc, &counter, 1, tmp);
> -			if (err)
> -				goto out;
> -			memcpy(&okm[i], tmp, okmlen - i);
> -			memzero_explicit(tmp, sizeof(tmp));
> -		} else {
> -			err = crypto_shash_finup(desc, &counter, 1, &okm[i]);
> -			if (err)
> -				goto out;
> -		}
> -		counter++;
> -		prev = &okm[i];
> -	}
> -	err = 0;
> -out:
> -	if (unlikely(err))
> -		memzero_explicit(okm, okmlen); /* so caller doesn't need to */
> -	shash_desc_zero(desc);
> +	memcpy(full_info, "fscrypt\0", 8);
> +	full_info[8] = context;
> +	memcpy(full_info + 9, info, infolen);
> +
> +	err = hkdf_expand(hkdf->hmac_tfm, full_info, infolen + 8,
> +			  okm, okmlen);
> +	kfree_sensitive(full_info);
>  	return err;

infolen + 9, not infolen + 8.  Otherwise this patch breaks fscrypt.

> diff --git a/include/crypto/hkdf.h b/include/crypto/hkdf.h
> new file mode 100644
> index 000000000000..ee3e7d21a5fe
> --- /dev/null
> +++ b/include/crypto/hkdf.h
> @@ -0,0 +1,34 @@
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
> +#ifdef CONFIG_CRYPTO_HKDF
> +int hkdf_extract(struct crypto_shash *hmac_tfm, const u8 *ikm,
> +		 unsigned int ikmlen, const u8 *salt, unsigned int saltlen,
> +		 u8 *prk);
> +int hkdf_expand(struct crypto_shash *hmac_tfm,
> +		const u8 *info, unsigned int infolen,
> +		u8 *okm, unsigned int okmlen);
> +#else
> +static inline int hkdf_extract(struct crypto_shash *hmac_tfm,
> +			       const u8 *ikm, unsigned int ikmlen,
> +			       const u8 *salt, unsigned int saltlen,
> +			       u8 *prk)
> +{
> +	return -ENOTSUP;
> +}
> +static inline int hkdf_expand(struct crypto_shash *hmac_tfm,
> +			      const u8 *info, unsigned int infolen,
> +			      u8 *okm, unsigned int okmlen)
> +{
> +	return -ENOTSUP;
> +}
> +#endif
> +#endif

This header is missing <crypto/hash.h> which it depends on.

Also the !CONFIG_CRYPTO_HKDF stubs are unnecessary and should not be included.

- Eric


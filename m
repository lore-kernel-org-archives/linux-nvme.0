Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBDDEC3DA5D
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Jul 2024 01:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9qn+SKTpSTkqYVMPtPsRDijLDM/5dmoH4e7RTsdLd9c=; b=4muEslPBFoxuHj2qy3Kj038cpV
	+3BN1vSCHD5FsfTN261fKldaoqzW6UH909xLIaxdfJj3/OffJRTqDu0ce9fXza99xowqbWzbgs56S
	Eg2GT+vocJdrvUIsfzcDb/R36oUNzAipxx03LgXRrWFTGLTQTd9vQZNq+Icr/Lxir3s3Gkhl7CHIF
	3tS/RXkNJXx+JI8uGEJcdhA1GHS+JltdbV8ISWV2kebxcvszXN3wK+VeYzeoyoYL+OWxnlXSexZ6S
	kxRNB5aymFhiQTzpeX5EwZHCM6AaE0L0hfe3Xma3lcOj3G1mT/nvsKisbsOJKSUrFAbtWr4M7hZPV
	KbXGfdrA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sW4cb-0000000B4Zh-1iNN;
	Tue, 23 Jul 2024 01:47:21 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sW4cY-0000000B4ZB-01dC
	for linux-nvme@lists.infradead.org;
	Tue, 23 Jul 2024 01:47:19 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 4F5DE60B61;
	Tue, 23 Jul 2024 01:47:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E131AC116B1;
	Tue, 23 Jul 2024 01:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721699237;
	bh=1qD7OygewgIbFcjAXnb+L1GDWAFAWUP1dFyU5n2QMw4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qvFaOE7unC9L3dtAZBCnEwLCvyRr+pBBDzO1z/+4bpUCUZADpdUDn7dvHZuvJ2Nvj
	 8WXVlkJ2p2l2JJK19JvoCZKX4PxlYTSfka7IV2NsKhDk30htSPBIp1niqDZX/xXRQq
	 rnf2Pg+UvWf7nMT5FGQnTwZw/nq/mkM7Mkge6TiEfmCBYgOdiEnJFRb3tpliM2n6cP
	 hueXAlp2gzyYR+8ClamueqqJdJgcLdfjXyqAuLLG8eMoCn8ynXhC/oLAGfsDnsBSpU
	 wbw0NNZMw4RrSBcqbzGXnS9B7AuB8P4R0wEXeB1J0X5NdebO2k/nIWcnSDbxvAPH4L
	 AlvMq6niV6XTQ==
Date: Tue, 23 Jul 2024 01:47:15 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: Hannes Reinecke <hare@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, linux-crypto@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 4/9] nvme: add nvme_auth_derive_tls_psk()
Message-ID: <20240723014715.GB2319848@google.com>
References: <20240722142122.128258-1-hare@kernel.org>
 <20240722142122.128258-5-hare@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240722142122.128258-5-hare@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240722_184718_171384_64BE04E1 
X-CRM114-Status: GOOD (  19.99  )
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

On Mon, Jul 22, 2024 at 04:21:17PM +0200, Hannes Reinecke wrote:
> +/*
> + * Derive a TLS PSK as specified in TP8018 Section 3.6.1.3:
> + *   TLS PSK and PSK identity Derivation
> + *
> + * The TLS PSK shall be derived as follows from an input PSK
> + * (i.e., either a retained PSK or a generated PSK) and a PSK
> + * identity using the HKDF-Extract and HKDF-Expand-Label operations
> + * (refer to RFC 5869 and RFC 8446) where the hash function is the
> + * one specified by the hash specifier of the PSK identity:
> + * 1. PRK = HKDF-Extract(0, Input PSK); and
> + * 2. TLS PSK = HKDF-Expand-Label(PRK, "nvme-tls-psk", PskIdentityContext, L),
> + * where PskIdentityContext is the hash identifier indicated in
> + * the PSK identity concatenated to a space character and to the
> + * Base64 PSK digest (i.e., "<hash> <PSK digest>") and L is the
> + * output size in bytes of the hash function (i.e., 32 for SHA-256
> + * and 48 for SHA-384).
> + */
> +int nvme_auth_derive_tls_psk(int hmac_id, u8 *psk, size_t psk_len,
> +		u8 *psk_digest, u8 **ret_psk)
> +{
> +	struct crypto_shash *hmac_tfm;
> +	const char *hmac_name;
> +	const char *psk_prefix = "tls13 nvme-tls-psk";
> +	size_t info_len, prk_len;
> +	char *info;
> +	unsigned char *prk, *tls_key;
> +	int ret;
> +
> +	hmac_name = nvme_auth_hmac_name(hmac_id);
> +	if (!hmac_name) {
> +		pr_warn("%s: invalid hash algoritm %d\n",
> +			__func__, hmac_id);
> +		return -EINVAL;
> +	}
> +	if (hmac_id == NVME_AUTH_HASH_SHA512) {
> +		pr_warn("%s: unsupported hash algorithm %s\n",
> +			__func__, hmac_name);
> +		return -EINVAL;
> +	}
> +
> +	hmac_tfm = crypto_alloc_shash(hmac_name, 0, 0);
> +	if (IS_ERR(hmac_tfm))
> +		return PTR_ERR(hmac_tfm);
> +
> +	prk_len = crypto_shash_digestsize(hmac_tfm);
> +	prk = kzalloc(prk_len, GFP_KERNEL);
> +	if (!prk) {
> +		ret = -ENOMEM;
> +		goto out_free_shash;
> +	}
> +
> +	ret = hkdf_extract(hmac_tfm, psk, psk_len, prk);
> +	if (ret)
> +		goto out_free_prk;
> +
> +	ret = crypto_shash_setkey(hmac_tfm, prk, prk_len);
> +	if (ret)
> +		goto out_free_prk;
> +
> +	info_len = strlen(psk_digest) + strlen(psk_prefix) + 1;
> +	info = kzalloc(info_len, GFP_KERNEL);
> +	if (!info)
> +		goto out_free_prk;
> +
> +	memcpy(info, psk_prefix, strlen(psk_prefix));
> +	memcpy(info + strlen(psk_prefix), psk_digest, strlen(psk_digest));

The code doesn't match the description given in the function comment (which
looks like it was quoted from a specification).

The code does HKDF-Expand with info="tls13 nvme-tls-psk<PSK digest>".

The description does HKDF-Expand-Label with Label="nvme-tls-psk",
Context="<hash identifier> <PSK digest>", Length=digest_size.

Not only does the code not actually use <hash identifier>, but it doesn't follow
the definition of HKDF-Expand-Label from RFC8446
(https://datatracker.ietf.org/doc/html/rfc8446#section-7.1) in that it's missing
all the length fields.  So the info string used by the actual code ends up being
quite different from the one specified.

- Eric


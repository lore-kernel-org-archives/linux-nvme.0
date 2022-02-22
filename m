Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1EF2C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Feb 2022 19:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wl7YAS9DKMxix9AxZUGQ1Xy97Zpe35Tkm3dhZv+0rZU=; b=3yOes2BhzyqpjdPA6ye5VOX+8c
	1L61hyQfzfhF1ZZn7jgoJsc6tY6Wh1y3uMYGigWMG2hnEpFiKXCmPjk3qoM28heEYbVRFRgEFjEqk
	PmPpY9Dc586GkeOReC91szkea2bDBA9ED/KFWb/k6Tb0X51fKt9yS1vR0z/nNMQeoFqU2NHC7ckxD
	GaHy8aun135hW8zWa/2refiTkJI3zIdaF4N+dgw2w47CC3oNdUFmKM63NIeoHP3kkuIAM0pkqQu4x
	hytRimzRCruyos/sdlQufSSgsbDVj1zsWbgTwRTi1haw9+6VdZNhsOqTZP9HiVpYJcNH2wnjtzNfW
	GpH5WQUw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nMbBR-00BPWU-89; Tue, 22 Feb 2022 19:50:49 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nMbBO-00BPVt-I6
 for linux-nvme@lists.infradead.org; Tue, 22 Feb 2022 19:50:47 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 5F3846163D;
 Tue, 22 Feb 2022 19:50:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B671C340F1;
 Tue, 22 Feb 2022 19:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1645559444;
 bh=l639N21A2FrjSs/WG0rCtIuhybcq24CZv4Vtx+UKttk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Irx+SLoYYE4wGSeXxrVOr/7x0kf5CJU/O6kGp1PTQL0PoOg7Y8xTdt4gtt35pqirB
 Fz/7MdwiISDDp7bKfySLsgjR8Qa9A1slwZId5NyeipA/9gw2FoOd3RUN5RBquwzmpW
 TJdyT49+tR9n7os7o6Ksawv/yJzeePn+eb+zPG9rvtRz2JxF9+kpiSUeMHJeMK7vft
 Az4u2xE12wvsP6fTqA2tNXevWSysmu1Bakcg8EC86sjmQEQy04gh+ECR+cm49X6eG4
 y/xN1Z/ZQ5J+meMPKwY9oNMfgvLcirNzLkJ1a/FEK8Y3soyghpccFTKPMsaO61B7y9
 UIo1jhARzPBEw==
Date: Tue, 22 Feb 2022 11:50:42 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 linux-crypto@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, axboe@kernel.dk, hch@lst.de,
 martin.petersen@oracle.com, colyli@suse.de
Subject: Re: [PATCHv3 06/10] crypto: add rocksoft 64b crc framework
Message-ID: <YhU+kuMhueXVQvxe@sol.localdomain>
References: <20220222163144.1782447-1-kbusch@kernel.org>
 <20220222163144.1782447-7-kbusch@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220222163144.1782447-7-kbusch@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220222_115046_721293_79241C44 
X-CRM114-Status: GOOD (  23.06  )
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

On Tue, Feb 22, 2022 at 08:31:40AM -0800, Keith Busch wrote:
> +config CRYPTO_CRC64_ROCKSOFT
> +	tristate "Rocksoft Model CRC64 algorithm"
> +	depends on CRC64
> +	select CRYPTO_HASH
> +	help
> +	  Rocksoft Model CRC64 computation is being cast as a crypto
> +	  transform. This allows for faster crc64 transforms to be used
> +	  if they are available.

The first sentence of this help text doesn't make sense.

> diff --git a/crypto/crc64_rocksoft_generic.c b/crypto/crc64_rocksoft_generic.c
> new file mode 100644
> index 000000000000..55bad1939614
> --- /dev/null
> +++ b/crypto/crc64_rocksoft_generic.c
> @@ -0,0 +1,104 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Cryptographic API.

The "Cryptographic API" line doesn't provide any helpful information.

> +static int chksum_final(struct shash_desc *desc, u8 *out)
> +{
> +	struct chksum_desc_ctx *ctx = shash_desc_ctx(desc);
> +
> +	*(u64 *)out = ctx->crc;
> +	return 0;
> +}
> +
> +static int __chksum_finup(u64 crc, const u8 *data, unsigned int len, u8 *out)
> +{
> +	*(u64 *)out = crc64_rocksoft_generic(crc, data, len);
> +	return 0;
> +}

These 64-bit writes violate alignment rules and will give the wrong result on
big endian CPUs.  They need to use put_unaligned_le64().

> +static int __init crc64_rocksoft_x86_mod_init(void)
> +{
> +	return crypto_register_shash(&alg);
> +}
> +
> +static void __exit crc64_rocksoft_x86_mod_fini(void)
> +{
> +	crypto_unregister_shash(&alg);
> +}

This has nothing to do with x86.

> +config CRC64_ROCKSOFT
> +	tristate "CRC calculation for the Rocksoft^TM model CRC64"

I'm sure what the rules for trademarks are, but kernel source code usually
doesn't have the trademark symbol/abbreviation scattered everywhere.

> +	select CRYPTO
> +	select CRYPTO_CRC64_ROCKSOFT
> +	help
> +	  This option is only needed if a module that's not in the
> +	  kernel tree needs to calculate CRC checks for use with the
> +	  rocksoft model parameters.

Out-of-tree modules can't be the reason to have a kconfig option.  What is the
real reason?

> +u64 crc64_rocksoft(const unsigned char *buffer, size_t len)
> +{
> +	return crc64_rocksoft_update(~0ULL, buffer, len);
> +}
> +EXPORT_SYMBOL(crc64_rocksoft);

Isn't this missing the bitwise inversion at the end?

> +MODULE_AUTHOR("Keith Busch <kbusch@kernel.org>");
> +MODULE_DESCRIPTION("Rocksoft model CRC64 calculation (library API)");
> +MODULE_LICENSE("GPL");
> +MODULE_SOFTDEP("pre: crc64");

Shouldn't the MODULE_SOFTDEP be on crc64-rocksoft?

- Eric


Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B3C3CDE001
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Jun 2026 18:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Q0SVLg83SG3PTPWfxPfrZg/BRkjquTSYNHGY8gQqXnk=; b=jMTy9IuKfbAaeYNCEY/aGxapNX
	gQnvmAhdXhjFKmxTSSYaZUMeon9dSqLMU9iMvG0ltKfWAfrQa1mvM4sJCQp+kMx6PhpH8dmbk+JzP
	sqssmtJcFhkh7vt5PYyeWXOpkZDBfeivPO0OwlWzuB1YBmRNrkZi9HrnLHL1u3BESwaxHfP6AxNMt
	4G4EFNREkxK4lRtcwcQaQZ3NigdMLOCJulqN9e1AOMtjJmIhpwi1wYsINVQjQ/Wyj8/df8E3+E9qe
	Em5x7eDdnKy3sqeWuKP87/PpZTP/fvRI2pJyqPbCYb/vdnJ+reasFbeThB8qzKYNitKXB+naLXPqm
	v1AUPOyQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wcoOO-00000009eaL-1DDk;
	Thu, 25 Jun 2026 18:01:36 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wcoON-00000009eaE-3zzI
	for linux-nvme@lists.infradead.org;
	Thu, 25 Jun 2026 18:01:36 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 66E6060098;
	Thu, 25 Jun 2026 18:01:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9AB01F000E9;
	Thu, 25 Jun 2026 18:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782410495;
	bh=Q0SVLg83SG3PTPWfxPfrZg/BRkjquTSYNHGY8gQqXnk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=b5CBx9dTMH7bGiSEGRv81b9hUKYyqCl30M26u+2aipPWWt/jtxIoOr54+8/+6Cin7
	 3sv9MpM4PO7Hw2wbjavlAIzIeOzyC5JgCbA03OXUqYoFeamxZDgc2cs9ckJBvGh2MV
	 XUnXOi3DJLktR3bXRsgHd4FYKg7jsphWs63oAfN2xJGS88tygAdamhyby9lEChVz39
	 nhvFJ7QNmtvnh6SFn0cjV1d7JbbZMwr2Ifs2+FsNdLPoGQ/vx6ZEfpycOLKr5cdwjc
	 L/zjhG+maYjWVGLXmKIKYz34K8rDM7B0nmI/TWulM5Om7BjUWJslrEiX04zfMIgh5f
	 JBC3vYhSMoonA==
Date: Thu, 25 Jun 2026 11:01:30 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: linux-nvme@lists.infradead.org, Chaitanya Kulkarni <kch@nvidia.com>,
	Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
	Hannes Reinecke <hare@suse.de>, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH 12/21] nvme-auth: common: use crypto library in
 nvme_auth_derive_tls_psk()
Message-ID: <20260625180130.GA2514@quark>
References: <20260302075959.338638-1-ebiggers@kernel.org>
 <20260302075959.338638-13-ebiggers@kernel.org>
 <965a37dd-f698-46b6-9623-1099a13f7e60@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <965a37dd-f698-46b6-9623-1099a13f7e60@oracle.com>
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

On Thu, Jun 25, 2026 at 10:02:27AM +0100, John Garry wrote:
> On 02/03/2026 07:59, Eric Biggers wrote:
> >   int nvme_auth_derive_tls_psk(int hmac_id, const u8 *psk, size_t psk_len,
> >   			     const char *psk_digest, u8 **ret_psk)
> >   {
> > -	struct crypto_shash *hmac_tfm;
> > -	const char *hmac_name;
> > -	const char *label = "nvme-tls-psk";
> >   	static const u8 default_salt[NVME_AUTH_MAX_DIGEST_SIZE];
> > -	size_t prk_len;
> > -	const char *ctx;
> > -	u8 *prk, *tls_key;
> > +	static const char label[] = "tls13 nvme-tls-psk";
> > +	const size_t label_len = sizeof(label) - 1;
> > +	u8 prk[NVME_AUTH_MAX_DIGEST_SIZE];
> > +	size_t hash_len, ctx_len;
> > +	u8 *hmac_data = NULL, *tls_key;
> > +	size_t i;
> >   	int ret;
> > -	hmac_name = nvme_auth_hmac_name(hmac_id);
> > -	if (!hmac_name) {
> > +	hash_len = nvme_auth_hmac_hash_len(hmac_id);
> > +	if (hash_len == 0) {
> >   		pr_warn("%s: invalid hash algorithm %d\n",
> 
> ...
> 
> > +	i = 0;
> > +	hmac_data[i++] = hash_len >> 8;
> > +	hmac_data[i++] = hash_len;
> > +
> > +	/* label */
> > +	static_assert(label_len <= 255);
> 
> JFYI, this is generating a C=1 warning for me:
> 
>   CHECK   drivers/nvme/common/auth.c
> drivers/nvme/common/auth.c:746:9: error: bad constant expression
> 
> The following fixes/avoids it:
> 
> /* label */
> -       static_assert(label_len <= 255);
> +       static_assert(sizeof(label) - 1 <= 255);
> 
> Even though label_len is declared as const, label_len <= 255 is not a
> constant expression.

Only affects sparse, but I sent a patch:
https://lore.kernel.org/linux-nvme/20260625175911.35094-1-ebiggers@kernel.org

- Eric


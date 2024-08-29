Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22273CA0EC4
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Aug 2024 21:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=F0wv2ZIJzDreJNhyHRmad/BcCSkcjNWWJFA6u+MZZSE=; b=LIaNOZ02W49DyHi3kl5d/I8TEK
	hayS6Jp2wwu9qZMBaugpS0KVd6nmlZAb+hPXJhiztLENnUy85creDXkII6FvwDwLH3feYwL4s+M3h
	1G3xqpiaZvi1f+YPuYppU4sv/6PiCIl9JWNPEIrLXEnFXsMKZA0/7V35o/q8qpABVWBAIOUeF0Rju
	CgDTAfvjSngRrwAyK8j3q5wa/G8YK3QJslGCQXsZ8WH8IZSgdkNE5CM/VD0shh6m7jFg5B1AZZYoY
	ffqhsgGyyApukLDcVYdaYo4mebFkSIYWJiU+NfHKAivoczoiOZqSm9zdMmuygYhO1NyHKGuKtyKZh
	muP1BgQg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sjn5l-00000003lts-2O6w;
	Thu, 29 Aug 2024 21:54:09 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sjn5j-00000003lsm-2Wnp
	for linux-nvme@lists.infradead.org;
	Thu, 29 Aug 2024 21:54:09 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 9A580A4365E;
	Thu, 29 Aug 2024 21:53:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3DB2C4CEC1;
	Thu, 29 Aug 2024 21:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724968446;
	bh=VSf9lBepvKlhGDHu/xDYs8tQ20lRAHKY61GmFFScatE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ubc6NZb2GZ370cGoH33/CWQe7iCJpZgOt/Vprc2uJ/Sems1vEhcRYs4pVG8l9wPcC
	 IUOe4sIzA5cFM2rmFA2/Jqhdj6sCf0QUsLhZPUkQ3L7RslMATAbETLAt++SZurXUHA
	 B98q+/7j+M0wdGKQXdr/kni0gQ59L6JkcaEs77fEEIR/JW2hCNMx5mS1G71BivlJaq
	 Jk6P0As6TJhTNmYIAe9GhGQDhzrV1A7JgR9xLBUDpqiLNYv9Oiw+h1B+RLE56n1v5m
	 imwknTqkrM3BV1T1k+nQxb25OYkW2jSG6Cvp8FYgGr9CfAyOWEo/WrfjpPuO1ruHEW
	 iAtIuwgTmH1Vw==
Date: Thu, 29 Aug 2024 21:54:04 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: Hannes Reinecke <hare@suse.de>
Cc: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, linux-crypto@vger.kernel.org
Subject: Re: [PATCH 1/9] crypto,fs: Separate out hkdf_extract() and
 hkdf_expand()
Message-ID: <20240829215404.GA3058135@google.com>
References: <20240813111512.135634-1-hare@kernel.org>
 <20240813111512.135634-2-hare@kernel.org>
 <20240827175225.GA2049@sol.localdomain>
 <0697a6c9-85a3-4f56-879c-b096fb5072b8@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0697a6c9-85a3-4f56-879c-b096fb5072b8@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240829_145407_794548_2B957AF2 
X-CRM114-Status: GOOD (  27.62  )
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

On Thu, Aug 29, 2024 at 12:39:33PM +0200, Hannes Reinecke wrote:
> On 8/27/24 19:52, Eric Biggers wrote:
> > On Tue, Aug 13, 2024 at 01:15:04PM +0200, Hannes Reinecke wrote:
> > > Separate out the HKDF functions into a separate module to
> > > to make them available to other callers.
> > > And add a testsuite to the module with test vectors
> > > from RFC 5869 to ensure the integrity of the algorithm.
> [ .. ]
> > > +	desc->tfm = hmac_tfm;
> > > +
> > > +	for (i = 0; i < okmlen; i += hashlen) {
> > > +
> > > +		err = crypto_shash_init(desc);
> > > +		if (err)
> > > +			goto out;
> > > +
> > > +		if (prev) {
> > > +			err = crypto_shash_update(desc, prev, hashlen);
> > > +			if (err)
> > > +				goto out;
> > > +		}
> > > +
> > > +		if (info && infolen) {
> > 
> > 'if (infolen)' instead of 'if (info && infolen)'.  The latter is a bad practice
> > because it can hide bugs.
> > 
> Do I need to set a 'WARN_ON(!info)' (or something) in this case? Or are the
> '->update' callbacks expected to handle it themselves?

No, if someone does pass NULL with a nonzero length there will be a crash.  But
the same will happen with another invalid pointer that is not NULL.  It's just a
bad practice to insert random NULL checks like this because it can hide bugs.
Really a call like info=NULL, infolen=10 is ambiguous --- you've made it
silently override infolen to 0 but how do you know the caller wanted that?

> > > +#ifdef CONFIG_CRYPTO_HKDF
> > > +int hkdf_extract(struct crypto_shash *hmac_tfm, const u8 *ikm,
> > > +		 unsigned int ikmlen, const u8 *salt, unsigned int saltlen,
> > > +		 u8 *prk);
> > > +int hkdf_expand(struct crypto_shash *hmac_tfm,
> > > +		const u8 *info, unsigned int infolen,
> > > +		u8 *okm, unsigned int okmlen);
> > > +#else
> > > +static inline int hkdf_extract(struct crypto_shash *hmac_tfm,
> > > +			       const u8 *ikm, unsigned int ikmlen,
> > > +			       const u8 *salt, unsigned int saltlen,
> > > +			       u8 *prk)
> > > +{
> > > +	return -ENOTSUP;
> > > +}
> > > +static inline int hkdf_expand(struct crypto_shash *hmac_tfm,
> > > +			      const u8 *info, unsigned int infolen,
> > > +			      u8 *okm, unsigned int okmlen)
> > > +{
> > > +	return -ENOTSUP;
> > > +}
> > > +#endif
> > > +#endif
> > 
> > This header is missing <crypto/hash.h> which it depends on.
> > 
> > Also the !CONFIG_CRYPTO_HKDF stubs are unnecessary and should not be included.
> > 
> But that would mean that every call to '#include <crypto/hkdf.h>' would need
> to be encapsulated by 'CONFIG_CRYPTO_HKDF' (or the file itself is
> conditionally compiled on that symbol).

No, it doesn't mean that.  As long as the functions are not called when
!CONFIG_CRYPTO_HKDF, it doesn't hurt to have declarations of them.

- Eric


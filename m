Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60AA2EDEBFC
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Mar 2026 00:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DQhvrk1lt3rUvd/9V6dOTi2tJ9MgK7bVkSRPD0fPYNI=; b=BkvB8XlI0q1dOt/jR8cKaSFiaL
	1IBLllnd1hw2kH93xetVFE92ItSACMLIfzr3x2boOx6nfMtH6X+VnPaAwHkVQJnjEsFQhtc5F2vmo
	FzOftgouxY3anKgDrcbfrHUt/ooZGWaUXAqWfp057nmvCYUbuVGKbT69LDfXnU4T6qn6NRvb9fxVS
	7OOvHR1Gf9+UwzzXD9sWfKtoNALMkKIueZpjwC9Xtj3hMen1pT99MwIobtJOeQG69mJWPnY3QXMdo
	J2e/rDVLlk3tEoVv3EffaVOY2fDOhdMaIkeM1vAgkzhQWZjauLgNHnNPO3uDVGyEV9YtYhwMRN2p8
	zmSOyLTQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxa7x-0000000G9qH-3x9g;
	Wed, 04 Mar 2026 00:30:13 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxa7w-0000000G9pa-1U8q
	for linux-nvme@lists.infradead.org;
	Wed, 04 Mar 2026 00:30:12 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 6F978600AD;
	Wed,  4 Mar 2026 00:30:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2E8AC116C6;
	Wed,  4 Mar 2026 00:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772584211;
	bh=lNL1r64FGykHBx8grKvpUHjXyS8CCN+gZT8S1auxfQY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IxzQ4oXvdSg25kw31LYCLMdPw578Gk2qfBVTBAY9F219aZ0+nheKdJXAPz7SLxJfw
	 WkoJQWSZWHrRbbC1S1N9lyBGpAqkRA9+gm0taHtzVVbhZ2TpuFA8XUxJA2hLhFuuOJ
	 lzJw80wkhbPbCeyXfyp+N3lkIUA7Y3XBvZxeGaP2RHs6YSx2jDRHtPaXrDJKd5GKfe
	 n30OY2J65sEoaJ/BMpNanJeVJuPRMcn45eLWGeeyH8w5wi+sdlp/Kt06wjfqLYCFNA
	 9ay/zYCBQqx7Gs9wYAfisa7H0QVrOy08kmFLlaXTBNs+Zc+FmUthgMvzwHtBw7a0Je
	 vE93ZIxOoICXw==
Date: Tue, 3 Mar 2026 16:30:04 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Chris Leech <cleech@redhat.com>
Cc: Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH 04/21] nvme-auth: common: add KUnit tests for TLS key
 derivation
Message-ID: <20260304003004.GB57956@quark>
References: <20260302075959.338638-1-ebiggers@kernel.org>
 <20260302075959.338638-5-ebiggers@kernel.org>
 <1de7ef59-4236-4372-81f6-60d5a4f1e253@suse.de>
 <20260303002649.GE20209@quark>
 <20260303-slush-hydrated-8b1929ec6a30@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260303-slush-hydrated-8b1929ec6a30@redhat.com>
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

On Tue, Mar 03, 2026 at 02:47:56PM -0800, Chris Leech wrote:
> On Mon, Mar 02, 2026 at 04:26:49PM -0800, Eric Biggers wrote:
> > On Mon, Mar 02, 2026 at 11:04:43AM +0100, Hannes Reinecke wrote:
> > > Which discrepancies do you see between the specified algorithm
> > > and the implementation?
> > 
> > I'm looking at the latest NVM Express Base Specification, v2.3.
> > 
> > First, there's the following:
> > 
> >     The host computes KS as the hash of the ephemeral DH key resulting
> >     from the combination of the random value y selected by the host with
> >     the DH exponential (i.e., gx mod p) received from the controller
> >     (i.e., KS = H((gx mod p)y mod p) = H(gxy mod p)).
> > 
> > The actual code skips that step when deriving the PSK, and just
> > considers the DH value directly to be "KS" and uses it directly as an
> > HMAC key.  That is something that should never be done.  DH values are
> > not uniformly distributed and must not be used directly as keys.
> 
> I'm doing some testing with a patch to immediatly hash the DH value
> after the kpp request is complete, fixing nvme_auth_generate_psk(),
> while removing the hashing step from nvme_auth_augmented_challenge().
> That only allows the use of KS as the raw DH output is not saved.

Yes, that's the right way to do it.

> But, I think things are saved by DH values always being larger than the
> HMAC block size and therefor hashed within hmac_shaXXX_preparekey().
> Maybe more lucky than correct, but the same result.

Interesting.  Yes, that might work, but only by accident.

- Eric


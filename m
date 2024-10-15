Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF5E0D1D879
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Oct 2024 15:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=X83rdtstGPcdV4Kbzkniy/WTJmIV3GVhKBoV5akrZeE=; b=xi2uN/c6XGAf0aJ+8sPoutt19Z
	rpANEE5EtukRwzdhf4EIq1K0I7Hq58SShPpR9BBMrqlRyAZvr6RlQ7rAUQAUZJngTnUKt/4iA2CDV
	jjsoRhFoU2YbcQaMpobPKQ6ybuShKjC8NXqxbMpi6P8T4pr7fy8MhhowDZXCpp72aq0PpRo83MFgC
	e2PCIGVqAIc8PZYW3NTbM79cxcW/vLgJR70jf5sS4jZLcXzAMFhmeFeWcE1NnooQtB9WvzHnhO5Du
	lWspEVkJOR5I5s1z0m3iSY7MQJpSX2vMKGXIEv7Mrmb6JwQJLg5SA8KmGXyv9Rm8x1QDP6nbDzD66
	uqE1NItg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t0jfr-00000008lR4-0IpD;
	Tue, 15 Oct 2024 15:41:27 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t0jfd-00000008lMp-3UA8
	for linux-nvme@lists.infradead.org;
	Tue, 15 Oct 2024 15:41:25 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 937BBA41349;
	Tue, 15 Oct 2024 15:41:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 176C4C4CEC6;
	Tue, 15 Oct 2024 15:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729006872;
	bh=+jKJ64SK4ZGAg+8G5e2+KkhtdAvZb4xHyEmmlb7iVZM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lOB7/oHmaVwN0NAVVEIsObSvux2XZ7DCnlQpe6JaIQ5rq23iqNJf1WA6zDgljn1zL
	 g9X/JVq8X5vC9AB0KG+N4VFb9cP5AqmqF4Ti13FLsQV8FWvTiz6IOHTrJiZ/97y4r/
	 lnp7oh/bWXyIVNtTfv/x6jmEVL4f0yM5rzdteYwpSSrn8oM/mkcmQqAsPyC2E6PK2s
	 ESS7NVodOvX95UX7AonBNSRefIaJAY7DYkt99uJe57dLZp1293okq4sQ4lFrdQGvIB
	 J6DaDsc/v0Bo/fBdITPFgtkoOfTeg8tiDZ7p3o2Mb2rP36bwnMweVs9m7WWt1YcRTK
	 d40zgG5i9eBAQ==
Date: Tue, 15 Oct 2024 15:41:10 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: Hannes Reinecke <hare@suse.de>
Cc: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, linux-crypto@vger.kernel.org
Subject: Re: [PATCH 1/9] crypto,fs: Separate out hkdf_extract() and
 hkdf_expand()
Message-ID: <20241015154110.GA2444622@google.com>
References: <20241011155430.43450-1-hare@kernel.org>
 <20241011155430.43450-2-hare@kernel.org>
 <20241014193814.GB1137@sol.localdomain>
 <e9ea2690-b3ac-47f0-a148-9e355841b6d0@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9ea2690-b3ac-47f0-a148-9e355841b6d0@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241015_084113_961206_9E5BFDEC 
X-CRM114-Status: GOOD (  17.61  )
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

On Tue, Oct 15, 2024 at 05:05:40PM +0200, Hannes Reinecke wrote:
> On 10/14/24 21:38, Eric Biggers wrote:
> > On Fri, Oct 11, 2024 at 05:54:22PM +0200, Hannes Reinecke wrote:
> > > Separate out the HKDF functions into a separate module to
> > > to make them available to other callers.
> > > And add a testsuite to the module with test vectors
> > > from RFC 5869 to ensure the integrity of the algorithm.
> > 
> > integrity => correctness
> > 
> Okay.
> 
> > > +config CRYPTO_HKDF
> > > +	tristate
> > > +	select CRYPTO_SHA1 if !CONFIG_CRYPTO_MANAGER_DISABLE_TESTS
> > > +	select CRYPTO_SHA256 if !CONFIG_CRYPTO_MANAGER_DISABLE_TESTS
> > > +	select CRYPTO_HASH2
> > 
> > Any thoughts on including SHA512 tests instead of SHA1, given that SHA1 is
> > obsolete and should not be used?
> > 
> Hmm. The original implementation did use SHA1, so I used that.
> But sure I can look into changing that.

If you're talking about fs/crypto/hkdf.c which is where you're borrowing the
code from, that uses SHA512.

- Eric


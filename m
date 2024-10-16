Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9D06D2A52F
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Oct 2024 16:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WpkMyCi/ii7FO2tFC5KmzGTRyi8ikNF0jOg81bHt2Hg=; b=AAbv7FGGiq6gJw8ArwfJlsBgPH
	Pg00Yvgbc7rV8FW53+yTASOeiNYnVp60pyruXfVFH/IH5FIhkl2U9E3OzhPgihyX8idzUWqMhJ0qg
	rEOnvihBgxfZ+gTaSiVvi2jFh9wM1QoRKnBa085XloYcf5qDEPWuSW4ec1/cH8dUjrfxeAN/zjU5y
	JSdSWhDbTKpzxWfBiWMBT9yigZjmc90cBBQfvrs/CVl/HEseE9tVx3EBsZhfa3werC6tJlzCko4o6
	pay/+NH+t5VvJuyAxtbOFiZ1MXYLcL67nsdjNnxaGytoKqfYF8xo5l5MhumxT6DT7/ETH3HmCPx+e
	GFDYFVqw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t16y0-0000000CR72-15oG;
	Wed, 16 Oct 2024 16:33:44 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t16rw-0000000CPzS-1QXE
	for linux-nvme@lists.infradead.org;
	Wed, 16 Oct 2024 16:27:29 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 31D4E5C5EB0;
	Wed, 16 Oct 2024 16:27:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33C08C4CEC5;
	Wed, 16 Oct 2024 16:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729096047;
	bh=Sj4hHfajy07xXHZDC3iAWKW0T1zkzy/GdmxY5XAzHYc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kcKtRxtCXa501eMxIPR/9mPZSc4GwjCE+oKxZR/c6WhgB3+Urvf06JSqrmuP33iXg
	 dQ3RTyrB/U7AGc+wo/qGIatq2EGyWZ2QsjnmuMvFC8qmQetVqVbVU8jBiuaRp7Eru0
	 YPQ+9nsZHzSQ9EB4k9TH+tb3pIpd3FHJwopOfo2v7SE7GUD0d8uoHAS1nvsx6WQ7fb
	 gZv4Zt/cEkZLZnGdpD6fODB82i/onUwrew3m0zRxPfv4ccWhaGle871mvGIFy7wjrp
	 YKuqXznqV1/Yy0SCLRas6uoVxZQdyjSBmhpXm3MyKj8G+/JMokGGRgBSIP0aQPLLr0
	 XOCYR0YmR4azQ==
Date: Wed, 16 Oct 2024 16:27:25 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: Hannes Reinecke <hare@suse.de>
Cc: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, linux-crypto@vger.kernel.org
Subject: Re: [PATCH 1/9] crypto,fs: Separate out hkdf_extract() and
 hkdf_expand()
Message-ID: <20241016162725.GB3228925@google.com>
References: <20241011155430.43450-1-hare@kernel.org>
 <20241011155430.43450-2-hare@kernel.org>
 <20241014193814.GB1137@sol.localdomain>
 <e9ea2690-b3ac-47f0-a148-9e355841b6d0@suse.de>
 <20241015154110.GA2444622@google.com>
 <83934544-0e4e-42eb-a15b-8189a46273c7@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83934544-0e4e-42eb-a15b-8189a46273c7@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241016_092728_444710_E34E7CF8 
X-CRM114-Status: GOOD (  24.92  )
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

On Wed, Oct 16, 2024 at 08:40:54AM +0200, Hannes Reinecke wrote:
> On 10/15/24 17:41, Eric Biggers wrote:
> > On Tue, Oct 15, 2024 at 05:05:40PM +0200, Hannes Reinecke wrote:
> > > On 10/14/24 21:38, Eric Biggers wrote:
> > > > On Fri, Oct 11, 2024 at 05:54:22PM +0200, Hannes Reinecke wrote:
> > > > > Separate out the HKDF functions into a separate module to
> > > > > to make them available to other callers.
> > > > > And add a testsuite to the module with test vectors
> > > > > from RFC 5869 to ensure the integrity of the algorithm.
> > > > 
> > > > integrity => correctness
> > > > 
> > > Okay.
> > > 
> > > > > +config CRYPTO_HKDF
> > > > > +	tristate
> > > > > +	select CRYPTO_SHA1 if !CONFIG_CRYPTO_MANAGER_DISABLE_TESTS
> > > > > +	select CRYPTO_SHA256 if !CONFIG_CRYPTO_MANAGER_DISABLE_TESTS
> > > > > +	select CRYPTO_HASH2
> > > > 
> > > > Any thoughts on including SHA512 tests instead of SHA1, given that SHA1 is
> > > > obsolete and should not be used?
> > > > 
> > > Hmm. The original implementation did use SHA1, so I used that.
> > > But sure I can look into changing that.
> > 
> > If you're talking about fs/crypto/hkdf.c which is where you're borrowing the
> > code from, that uses SHA512.
> > 
> Actually, I was talking about the test vectors themselves. RFC 5869 only
> gives test vectors for SHA1 and SHA256, so that's what I've used.
> I've found additional test vectors for the other functions at
> https://github.com/brycx/Test-Vector-Generation/blob/master/HKDF/hkdf-hmac-sha2-test-vectors.md
> so I'll be using them for adding tests for SHA384 and SHA512 (TLS on
> NVMe-over-TCP is using SHA384, too) and delete the SHA1 ones.

Right, it's an old spec, so that's why it has SHA1.  Using SHA512 test vectors
from elsewhere, or generating your own test vectors using a known-good
implementation, would be fine though.

- Eric


Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D9CEC44532
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Jul 2026 15:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vDGDymem0VUfP+jqOIxAVTQPMbJkKt9Jjw02N2puQ/I=; b=RhMcvOO+YeX5Ocuh4knz1rzXrV
	Y2jQ/XgcmqJR5mMtQI1Od8DatHOJlp1tFPkzANnq/SYkwTtEfQed5egXW1Cg9GtuI6uQTdcT6l7VS
	qssZpQ+Xjop1jxJetGP0fAo8eS+78H4PL5spKr5Bs+9KoSmVcsTypm5w8gZZnidFEPKEKivvx/uid
	f3O2O7ndEcfgaGc94SwxYgObdxQlbOZYH3NLHtesXN1jn4gjUaT6j7suuWxuDK19JGwR/+JBPn/Ob
	WugwFwSjqzpVDspJ4KEE2UdbYx+AjxCHyemSCqOrwX536yCQe/akg3vk2id4uwtjqEfEHi/sXEL+E
	tOckv/9g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmC4h-00000009kFc-4BdL;
	Tue, 21 Jul 2026 15:08:04 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmC4h-00000009kFN-2cuM
	for linux-nvme@lists.infradead.org;
	Tue, 21 Jul 2026 15:08:03 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id ED5FD6001A;
	Tue, 21 Jul 2026 15:08:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 059ED1F000E9;
	Tue, 21 Jul 2026 15:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784646482;
	bh=vDGDymem0VUfP+jqOIxAVTQPMbJkKt9Jjw02N2puQ/I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cZNO1DWFHSlc5dUYPLLXxXoihBSMDKyfEILKNnFwSm6iNuLrFKIXKql255HXJJT1T
	 aOK6oBiM3eW4lVRqW6P323bmQCHyPT/j1mBNk48ko3aLTwlQUcsD4tdZMlhxDoqh0l
	 3PNtXzakqreTpOMsPa70GWLHYpX8FYXb8iRFILpetH7VgTg0yPPVCXx4bio/LwQFpz
	 d9lkyOFVzgQbtyrLohgj2r+VvU0ep2KLCcQCob09TPL4cAmaZjSsuL8hQO4CdsQ+c7
	 ptJBhikRfHfv16Hrl1+jE8zuGudIS+2dK/gHiMAgDN7W9DJLrUS5N06UmmbdFE9HXs
	 sCwmXs/0cN+Cw==
Date: Tue, 21 Jul 2026 08:06:14 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Marco Baffo <marco@mandelbit.com>
Cc: linux-crypto@vger.kernel.org, herbert@gondor.apana.org.au,
	davem@davemloft.net, Jason@zx2c4.com, ardb@kernel.org,
	tytso@mit.edu, jaegeuk@kernel.org, linux-fscrypt@vger.kernel.org,
	kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	hare@suse.de, linux-nvme@lists.infradead.org, andrew+netdev@lunn.ch,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	antonio@openvpn.net, sd@queasysnail.net,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] lib/crypto: add HKDF and convert fscrypt and NVMe
Message-ID: <20260721150614.GA1932@sol>
References: <20260721140644.780006-1-marco@mandelbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260721140644.780006-1-marco@mandelbit.com>
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

Hi Marco,

On Tue, Jul 21, 2026 at 04:06:39PM +0200, Marco Baffo wrote:
> fscrypt and NVMe authentication each carry private HKDF
> implementations. Add HKDF-SHA256, HKDF-SHA384, and HKDF-SHA512
> functions to lib/crypto and convert both users.
> 
> Patches 1-4 are intended for review and inclusion.
> 
> Patch 5 is RFC only and is not intended to be applied. It shows how
> the OVPN epoch-key code currently under development can use the new
> HKDF API. That patch has an additional dependency on the OVPN epoch
> series. It is included here to allow the API to be reviewed against
> a third user. The OVPN conversion will be submitted separately once
> its prerequisite code is ready.
> 
> HKDF-Expand accepts info as an array of segments and processes them as
> if concatenated. This preserves the byte ordering used by fscrypt and
> allows NVMe to encode HkdfLabel without allocating a temporary buffer.
> 
> HKDF-Extract produces a prepared HMAC key, avoiding repeated key setup
> when the same PRK is expanded more than once. The implementation uses
> the direct HMAC library functions and neither allocates memory nor
> returns errors.
> 
> The series is intended for the libcrypto tree. Patches 3 and 4 need
> review from the fscrypt and NVMe maintainers, respectively.
> 
> Tested with:
> 
> - HKDF KUnit tests
> - NVMe authentication KUnit tests
> - kvm-xfstests smoketest on ext4
> - kvm-xfstests generic/582, generic/583, and generic/584 on ext4 and f2fs
> - kvm-xfstests encrypt group on ext4 and f2fs
> 
> The following shortlog and diffstat refers only to the first 4 patches.
> 
> Marco Baffo (4):
>   lib/crypto: add HKDF-SHA{256,384,512}
>   lib/crypto: tests: add HKDF KUnit tests
>   fscrypt: use HKDF library functions
>   nvme-auth: use HKDF library functions for TLS PSK derivation
> 
>  drivers/nvme/common/auth.c    | 120 ++++++++-------
>  fs/crypto/hkdf.c              |  56 ++-----
>  include/crypto/hkdf.h         | 131 ++++++++++++++++
>  lib/crypto/.kunitconfig       |   1 +
>  lib/crypto/Makefile           |   4 +-
>  lib/crypto/hkdf-sha256.c      |  22 +++
>  lib/crypto/hkdf-sha512.c      |  34 +++++
>  lib/crypto/hkdf-template.h    |  97 ++++++++++++
>  lib/crypto/tests/Kconfig      |   8 +
>  lib/crypto/tests/Makefile     |   1 +
>  lib/crypto/tests/hkdf_kunit.c | 276 ++++++++++++++++++++++++++++++++++
>  11 files changed, 653 insertions(+), 97 deletions(-)
>  create mode 100644 include/crypto/hkdf.h
>  create mode 100644 lib/crypto/hkdf-sha256.c
>  create mode 100644 lib/crypto/hkdf-sha512.c
>  create mode 100644 lib/crypto/hkdf-template.h
>  create mode 100644 lib/crypto/tests/hkdf_kunit.c

If we're going to reintroduce an HKDF library, this is probably the way
to do it (no crypto_shash dependency).

But I think the positive diffstat makes having an HKDF library at all in
the kernel still kind of questionable.  HKDF is just a wrapper around
HMAC and it can "unroll" to as little as 1-2 HMAC calls.  It's not
really like the other crypto algorithms where the implementations can be
very complex and we often have multiple arch-specific implementations.

In drivers/nvme/common/auth.c, using the library actually ended up as
more code than not using it.

And in fs/crypto/hkdf.c this patchset only saves a bit (with some of the
savings coming from deleting helpful comments).

In the ovpn case, the extraction step isn't actually used.  Nor are
multiple expansion iterations needed, since all the keys needing to be
derived are at most the hash size.  So vs. using hmac_sha256_* directly
it saves maybe 10-15 lines?  (Note that the diffstat in patch 5 isn't
directly relevant, as the starting point was crypto_shash.)

So then we end up with quite a bit of additional code in lib/crypto/, to
support users where the diffstat is basically neutral.

And this is only HKDF, so this hardly solves key derivation in general.
Plenty of KDFs don't use HKDF at all, either ones based on block ciphers
or stream ciphers, or newer hash functions that aren't vulnerable to
length extension attacks so don't require the HMAC layer.  There are
lots of other KDFs implemented in the kernel in various places.  Just to
pick a couple random examples, extract_entropy() in
drivers/char/random.c is doing a KDF, tcp_ao_calc_traffic_key() in
net/ipv4/tcp_ao.c is doing a KDF.  Do those need to be libraries too?

So overall I would suggest it might be best to hold off on this for now
and just call the hmac_sha256_* functions directly from
ovpn_expand_label().  (And again, only one iteration is actually needed
there, so it doesn't even need to be the full HKDF-Expand.)

- Eric


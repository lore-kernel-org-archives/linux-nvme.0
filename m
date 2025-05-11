Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 686EEC3ABC3
	for <linux-nvme@archiver.kernel.org>; Sun, 11 May 2025 17:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M8hg/Wqt4TaTXpniJ1i2zuhpdABi+uWq1e5BtNF1BmU=; b=I2D5cN0D6fuF/eDPrf0OKwfqcC
	vNxtHF1sIqtDVC0VW7CYrp2viEMnQiPZliCZu5B7AM/TCkYMIMbiS+3fqjUimeqtZewqIHZMJ0Hun
	kSJuYjAK91Nsr5z2jm2/JdFbn26S0AfUFS2MDiE+6xurTK+Hpu9TCGV0kkVesA8L2CNtFWgltz4Zb
	y+aRIGYLHwoJ9+dTXk2wdGasoiQCfOqbNcUZAx2jBiGaonQ3QR05tdb1L2mlUTr8ruGoK9m5432Fm
	f7Hxf5VGpl5CF9ORw9W/+m9Epao1gaYg39hMXBz2OnDSvVo+P9YoRbZKD6cKag4myvO5ZKiwMiU98
	YpAAtROw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uEAV7-00000007bHO-11sA;
	Sun, 11 May 2025 17:30:09 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uEAUc-00000007bAJ-2Ae6
	for linux-nvme@lists.infradead.org;
	Sun, 11 May 2025 17:29:40 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id B97F9A4C241;
	Sun, 11 May 2025 17:29:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10463C4CEE4;
	Sun, 11 May 2025 17:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746984577;
	bh=SHyF1n7YIV4Y//zRB8/o+8Lh6KmT8QksNXJUTSUBUJs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RDqFBeUWVUol4xajWSZX318VjdXJwcBgz2cwlSIQ/r9Pa41P1AIz4o2sbbiAl22sr
	 YV6tYmXgYLYhsfU3+7GP+PJmKWFiNNR3Y5YLbkmpump0bXledonvjDd4rT7OVdz/do
	 9wnuG7zuM99pjwq21LYQmW3SCnSUEghD5qz8maz6HOI8tAvCTOu3x3IVinfH7NvBSj
	 /unTwWrFqi0nLDsogIrToB75vENmdp15g85aXRSpOPGmlZI4ir9TiqQRQzAud+Tkbq
	 wTQvqfhwX/ALPF1sW5xzC6pIHP2cZ0Ji7DxM3Pt383BpTFhNGs8A0K986MqGVwvdRy
	 C53Ky+39prniA==
Date: Sun, 11 May 2025 10:29:29 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-sctp@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Sagi Grimberg <sagi@grimberg.me>, Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH net-next 00/10] net: faster and simpler CRC32C computation
Message-ID: <20250511172929.GA1239@sol>
References: <20250511004110.145171-1-ebiggers@kernel.org>
 <b9b0f188-d873-43ff-b1e1-259e2afdda6c@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9b0f188-d873-43ff-b1e1-259e2afdda6c@lunn.ch>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250511_102938_623783_DF9758BC 
X-CRM114-Status: GOOD (  15.91  )
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

On Sun, May 11, 2025 at 06:30:25PM +0200, Andrew Lunn wrote:
> On Sat, May 10, 2025 at 05:41:00PM -0700, Eric Biggers wrote:
> > Update networking code that computes the CRC32C of packets to just call
> > crc32c() without unnecessary abstraction layers.  The result is faster
> > and simpler code.
> 
> Hi Eric
> 
> Do you have some benchmarks for these changes?
> 
> 	Andrew

Do you want benchmarks that show that removing the indirect calls makes things
faster?  I think that should be fairly self-evident by now after dealing with
retpoline for years, but I can provide more details if you need them.

Removing the inefficient use of crc32c_combine() makes a massive difference on
fragmented sk_buffs, since crc32c_combine() is so slow (much slower than the CRC
calculation itself).  However, reverting the workaround commit 4c2f24549644
("sctp: linearize early if it's not GSO") is beyond the scope of this patchset,
so for now the sctp stack doesn't actually call skb_crc32c() on fragmented
sk_buffs.  I can provide microbenchmarks of skb_crc32c() on a fragmented sk_buff
directly though, if you don't think it's clear already.

Of course, please also keep in mind the -118 line diffstat.  Even if it wasn't
faster we should just do it this way anyway.

- Eric


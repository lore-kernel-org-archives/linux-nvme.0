Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9563A109C05D
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Mar 2026 20:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=i6MkJ9WO56PmVVW9M4QIhq1TaDuwFSwcAXSmKn7LA4g=; b=0yOCixyMQmhiOOIPmIVlqJ7hGT
	rwaAwisHNGVjOxbhZ/5de6Z+NRcdeO/qa9s6Nvg+sXxoXhKSDWy2TH6lO3DV7At1Uuc7uDku8zqqn
	LxZy9Hll0XnwEFXixclg0m7LMd4ZQAcnbmpP1dn0UbWgo5EoTWmtMsJbulXNw+Csrmdawg25vjwbv
	V7TsG89eUd0UN+K2a82ENoZR0g9Tw2VdVPuOqg53QNG3GCSs8A4L5VGAY9A0Vr0SozwpdqOm37jPE
	E2htc9NeEgkESlN490Dnm/fmqwO+9Erkkte2C8valnUHanoh2Qe8tL9MTErknIvH5ZOLLidnO6OI8
	h4+bu6mQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w5Uis-00000004D4K-1sIZ;
	Wed, 25 Mar 2026 20:21:02 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w5Uir-00000004D4B-0VZx
	for linux-nvme@bombadil.infradead.org;
	Wed, 25 Mar 2026 20:21:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=i6MkJ9WO56PmVVW9M4QIhq1TaDuwFSwcAXSmKn7LA4g=; b=eq2nTvnbqmCuI3OPn/sYC9fz5H
	Bn22E+yB7/ZZn1pNZNMCsj60Whh5Ceft7UnidjT9tDB7KfsAx/YPw60axg7BTmCn8wqQjnn6JJoxo
	qvCTbDhbGdVBbcet7ugJuNcvUaPWT+Agg6naR9MJtCarv4R0rEbKzpXcskkYEWsMgksWytHJDYzLI
	+3EnlqnK7FpE8L6XF6/aj1XearsVbk0qFmdJCVqnsbLfDe38EHRO1lmNXlkfXhjTXkDHMWsAFZjpm
	OXz0U6DG5q1CkEzi/z7DHe5mOdYjgBpEvfTAhOuXLcuXZCKjD974iZEbj9qrsHsuFwxeAXuXkBmE9
	jEWbRCMg==;
Received: from sea.source.kernel.org ([172.234.252.31])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w5Uin-000000070nB-2liT
	for linux-nvme@lists.infradead.org;
	Wed, 25 Mar 2026 20:20:59 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 1D69A42DE5;
	Wed, 25 Mar 2026 20:20:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93746C4CEF7;
	Wed, 25 Mar 2026 20:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774470056;
	bh=vfTpAReEB03EgkWwWTy/7/I4kxr0oycMmdpafvTBqbw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X9kHOsCXpbnqPbnws8Re1eQA1H0SC5Du96Mv2YFteUdfF5XVSruS0MaMTDfc02+p+
	 Svq2FldytMFbjAf6QQfwXPa2nGNmdr7ziLF5MYKcLFsV9spuJUZoEcstFZmr8fepyW
	 1FWoY/dt7/8moXmt3csOCobXx4XTiZurUJFWdRZ6pSFjDwQ7kFdjYPZC8XeLZ5Sk34
	 Ir56s8WaJNUt/5mwssDfToL5ha/j/5tmd5/xPjPS7YrydBUg9UbjN+cY/17Hv29YTP
	 2eTzOBUlCi5P196CUBaq4fGzA5EjcX0NrxZyFzKHFHshDeLz7YSPGlNyMOJKekOblU
	 PJE8z6vGMVKwg==
Date: Wed, 25 Mar 2026 13:20:53 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>,
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 00/21] nvme-auth: use crypto library for HMAC and hashing
Message-ID: <20260325202053.GE2305@quark>
References: <20260302075959.338638-1-ebiggers@kernel.org>
 <20260304132327.GA15515@lst.de>
 <20260305193150.GF2796@quark>
 <aanbGwda2pHmMTMx@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aanbGwda2pHmMTMx@kbusch-mbp>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260325_202057_954219_B9D7E781 
X-CRM114-Status: GOOD (  14.07  )
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

On Thu, Mar 05, 2026 at 12:35:55PM -0700, Keith Busch wrote:
> On Thu, Mar 05, 2026 at 11:31:50AM -0800, Eric Biggers wrote:
> > On Wed, Mar 04, 2026 at 02:23:27PM +0100, Christoph Hellwig wrote:
> > > Thanks, this looks really great:
> > > 
> > > Acked-by: Christoph Hellwig <hch@lst.de>
> > > 
> > 
> > Thanks.  I assume Keith will pick this series up for 7.1.  Keith, I
> > forgot to include you explicitly on the recipients list (I must have run
> > get_maintainer on drivers/nvme/target/ instead of drivers/nvme/common/),
> > but I assume you received this series via linux-nvme anyway.
> 
> No worries, I'll start up a 7.1 branch and get this queued up. Thanks!

This hasn't made its way into linux-next yet.  Is that expected?

- Eric


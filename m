Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AEC2CD343A
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Sep 2024 14:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8Lh3fAo8mieXU/bFURs8Kb/gQNeLJ59plH7Pj7I1xRI=; b=GwgLRb/xXrZp7wF9bLwwIrBRKf
	S0YaxXRsqv1qpmqhRcCHPGtTgMt738gfgH3WwCAfMaLUWVcFheC632NrEJK3usIMM2duut7voJlBp
	idq2gjb51abV+thG3zejbjFV64Wp6EkCvOPtRgVA7sqTKDhzre+cyVOmnGkcqJ4wGTo029tCWolde
	GJQMNtVLQ0OKvSRA+oe562lPtZBEsYu3WD0rhaSWpU7cAyWtKgimNBZXpjxyd3/nhoEmUQ+2M4kzs
	CotxyQ+JQYUYnQsODstgUjWmQYVpVShiDC4n7pAgUZBy+wEzLdZaQiN1Xpfr02YolsPBfqfcqGxfi
	2ir4A2ow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slUdJ-00000000cTw-3pIo;
	Tue, 03 Sep 2024 14:35:49 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slUcs-00000000cHY-1Q5Q
	for linux-nvme@lists.infradead.org;
	Tue, 03 Sep 2024 14:35:24 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 2F4805C5977;
	Tue,  3 Sep 2024 14:35:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0B35C4CEC7;
	Tue,  3 Sep 2024 14:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725374121;
	bh=SXW9Lb7ZYF60TtJNxa2tzxDrQEAQyWEpctMJfc6+Lnw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eI2Ty3YGWuQvGA9egzniLii9YQG8AfW76NMVfcefuZrmPyHF4bE1yl47co3r94xpr
	 lNhNFIBfd7Y0gztaRlvnjUyXb19Ngt5hz/WgwYyYjoo9lfHoSQKPf3wWH65zGJMKi2
	 Arx90hFQceXXoDMQtcWokmLo9jzFEWRZ4rbh/iLoGd87XjmjfDpuSvH++Lr66wZg82
	 +zkUu/rWYqR291y8VeN48DA80+O0xdnW9HQFM+n8h6Tg+pInvmX70OxcqbV8yJi/V7
	 I8xz7TmjCusWsM7jIh9ivWozgayqxQXB9TjsCfQpdOeXT9BWK58O0HMtvrXSJ4s4ao
	 yaUovB82siFIQ==
Date: Tue, 3 Sep 2024 16:35:14 +0200
From: Christian Brauner <brauner@kernel.org>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: amir73il@gmail.com, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, 
	martin.petersen@oracle.com, James.Bottomley@hansenpartnership.com, jack@suse.cz, 
	jaegeuk@kernel.org, jlayton@kernel.org, chuck.lever@oracle.com, bvanassche@acm.org, 
	"axboe@kernel.dk" <axboe@kernel.dk>, linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-block@vger.kernel.org, linux-scsi@vger.kernel.org, 
	gost.dev@samsung.com, vishak.g@samsung.com, javier.gonz@samsung.com
Subject: Re: [PATCH v4 0/5] Write-placement hints and FDP
Message-ID: <20240903-erfassen-bandmitglieder-32dfaeee66b2@brauner>
References: <CGME20240826171409epcas5p306ba210a9815e202556778a4c105b440@epcas5p3.samsung.com>
 <20240826170606.255718-1-joshi.k@samsung.com>
 <20a9df07-f49e-ee58-3d0b-b0209e29c6af@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20a9df07-f49e-ee58-3d0b-b0209e29c6af@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240903_073522_470287_05E03DC4 
X-CRM114-Status: GOOD (  19.42  )
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

On Tue, Sep 03, 2024 at 07:58:46PM GMT, Kanchan Joshi wrote:
> Hi Amir,
> 
> 
> On 8/26/2024 10:36 PM, Kanchan Joshi wrote:
> > Current write-hint infrastructure supports 6 temperature-based data life
> > hints.
> > The series extends the infrastructure with a new temperature-agnostic
> > placement-type hint. New fcntl codes F_{SET/GET}_RW_HINT_EX allow to
> > send the hint type/value on file. See patch #3 commit description for
> > the details.
> > 
> > Overall this creates 128 placement hint values [*] that users can pass.
> > Patch #5 adds the ability to map these new hint values to nvme-specific
> > placement-identifiers.
> > Patch #4 restricts SCSI to use only life hint values.
> > Patch #1 and #2 are simple prep patches.
> > 
> > [*] While the user-interface can support more, this limit is due to the
> > in-kernel plumbing consideration of the inode size. Pahole showed 32-bit
> > hole in the inode, but the code had this comment too:
> > 
> > /* 32-bit hole reserved for expanding i_fsnotify_mask */
> > 
> > Not must, but it will be good to know if a byte (or two) can be used
> > here.
> 
> Since having one extra byte will simplify things, I can't help but ask - 
> do you still have the plans to use this space (in entirety) within inode?

I just freed up 8 bytes in struct inode with what's currently in -next.
There will be no using up those 8 bytes unless it's for a good reason 
and something that is very widely useful.


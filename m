Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A0E6D3ABCC
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Nov 2024 16:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zTgcIHsXo8XNxQNzweg1PtWUAWPaQVGO4TaQR50z4rQ=; b=0/GJGOIkAbsgpzjV3FrD5WuvMm
	Anzs8gTXPSc9yp5eLD4Sm7CN4wEqe7bUGTn9dMA+ODNx5Sru8EHJ1ittTJnYYrsx86nC2LWmRpBvQ
	3Lf9a+UooEktwye9BqMXJHsmspTgKt0H+npi7thT6kG3AR8H9U5ms3TLh/Ghx1SIUnM5nUOIs2O7G
	fBAwj88ndG51S+QgGiqO1Yrpvol8e1Pbrx6DJsKwgGa9oWoHQeJT3UHam+1+M/YXDnVbonCwhC9H2
	aHDH2eFr62reNayncuM0Z77JI7mHzDorJcbZzqQG+1C8KEsZkMnZnkqwapZ/l69+XLifOLg/5KeJG
	UYm/W5Cw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tAXN5-00000000aqY-0x1D;
	Mon, 11 Nov 2024 16:34:35 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tAXN1-00000000aqA-3wpo
	for linux-nvme@lists.infradead.org;
	Mon, 11 Nov 2024 16:34:33 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id D98C768D05; Mon, 11 Nov 2024 17:34:25 +0100 (CET)
Date: Mon, 11 Nov 2024 17:34:25 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@meta.com>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	io-uring@vger.kernel.org, axboe@kernel.dk,
	martin.petersen@oracle.com, asml.silence@gmail.com,
	javier.gonz@samsung.com, joshi.k@samsung.com
Subject: Re: [PATCHv11 0/9] write hints with nvme fdp and scsi streams
Message-ID: <20241111163425.GA17212@lst.de>
References: <20241108193629.3817619-1-kbusch@meta.com> <20241111102914.GA27870@lst.de> <ZzIwdW0-yn6uglDF@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZzIwdW0-yn6uglDF@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241111_083432_143236_77D69AEB 
X-CRM114-Status: GOOD (  27.94  )
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

On Mon, Nov 11, 2024 at 09:27:33AM -0700, Keith Busch wrote:
> Just purely for backward compatibility, I don't think you can have the
> nvme driver error out if a stream is too large. The fcntl lifetime hint
> never errored out before, which gets set unconditionally from the
> file_inode without considering the block device's max write stream.

True.  But block/fops.c should simply not the write hint in that
case (or even do a bit of folding if we care enough).

> >  - block/fops.c is the place to map the existing write hints into
> >    the write streams instead of the driver
> 
> I might be something here, but that part sure looks the same as what's
> in this series.

Your series simply mixes up the existing write (temperature) hint and
the write stream, including for file system use.  This version does
something very similar, but only for block devices.

> 
> >  - the stream granularity is added, because adding it to statx at a
> >    later time would be nasty.  Getting it in nvme is actually amazingly
> >    cumbersome so I gave up on that and just fed a dummy value for
> >    testing, though
> 
> Just regarding the documentation on the write_stream_granularity, you
> don't need to discard the entire RU in a single command. You can
> invalidate the RU simply by overwriting the LBAs without ever issuing
> any discard commands.

True.  Did I managed this was a quick hack job?

> If you really want to treat it this way, you need to ensure the first
> LBA written to an RU is always aligned to NPDA/NPDAL.

Those are just hints as well, but I agree you probably get much
better results if they do.

> If this is really what you require to move this forward, though, that's
> fine with me.

I could move it forward, but right now I'm more than over subsribed.
If someone actually pushing for this work could put more effort into it
it will surely be faster.



Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9259C7EE29
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Jun 2023 13:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2n9gTM7Fbu+GFGmtyRMiVeFghCZhSAGtaiHBEBXO6cM=; b=HffzLr1GJkuWegES/qV2traVBJ
	aN+2V5o+vpN6HeV15xcpU4R56TPplv6d1pgcR4Iv9ChNK2bA5QJLsRIok0Z4oxvSXOjT3BLEIp4/z
	FB7cEjp6bbYlRRguP3q6C8TxQz6cnI4RIDlGFGHdylLYIYo8CTfHQq70KZsOwjg8WCww3QDWjblpV
	7Y1WbE+jjZhXyEI8IACkIAVF/mcPrpn4sGR3VfBqYR9AA5R6z1X9GBu911lkk6c3maAU4q3NPwVe7
	475Pm9YprsDeROyHFXJTGLvSHUgtUzi0RSwMPbU9HGS0o3YN+ryVuxccfFFQRpUQttTe9ztkNlomq
	W811PHHA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q6tX6-0068rU-0r;
	Wed, 07 Jun 2023 13:49:04 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q6tX3-0068qc-0s;
	Wed, 07 Jun 2023 13:49:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=2n9gTM7Fbu+GFGmtyRMiVeFghCZhSAGtaiHBEBXO6cM=; b=kPrDLg01NmNjTO8R3MMDeug3sv
	8fyyAu96/Y7lkDWrdHt8KmgvTbtCdxwnd69QDJn7jBuXYlNFnraUiCq2UKyFjm+Q+XQZujXcQxLum
	UGLWRgVrP8lcbyy4W029EIuUg5NwvfiARkwcnUf4YXf9GEVfAbegJWvmGmiH0H5ZS5BDX9SJBTNjX
	8yyNNiiC40RP4enzSIl/CvKJtWXD68wDwXzxF8JzdOTNL0g8POLFcHvIylz7pscKbmBctnO9X3reI
	RiYe2ofEZw0p6okHc4UMpqTCPdVxAgEoP+owyysUTPExzF+NHzaznKjtO0zI1tzdF/1zcbBdy61Do
	cwtVCX4Q==;
Received: from dfw.source.kernel.org ([139.178.84.217])
	by desiato.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q6sZJ-0059RZ-20;
	Wed, 07 Jun 2023 12:47:19 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id D614963EED;
	Wed,  7 Jun 2023 12:47:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F576C4339B;
	Wed,  7 Jun 2023 12:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1686142035;
	bh=yQwyPVuAGoNHQWOMctts7HBR5pbTnomidetU1VDq7mo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KY16ohuxDUXf8jhwatNYz+c9Rc4twpyKWnQ7ldIraz/oidrRhEkgKjDaCyV7fu+/D
	 hyPEXDLCndSEKQzmdg0sd7RtJsiVXZkKH9YZD/rZPdkgDjEfakY63lgFslkki2sVId
	 9aw42j6uL8oCpHNIXRMF+V8IaaIdwDSR9Lo2IhWB34MF3i5ImLcmOTYcFE8YqPxQZy
	 vs7oB2HoHfPekk9Wo0uu34t8cgoDOIABPz67CJlm5dSZc8w51ypbNJGMVTv0G8WUu1
	 ficc1osgWKt3z27CzmGiEUD/rWC+VhJRlyKTAeZUUWmkZq8ur2sbvHeLvycrfjH5AS
	 qC1hC1l2dB0UA==
Date: Wed, 7 Jun 2023 14:47:06 +0200
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Richard Weinberger <richard@nod.at>,
	Josef Bacik <josef@toxicpanda.com>,
	"Md. Haris Iqbal" <haris.iqbal@ionos.com>,
	Jack Wang <jinpu.wang@ionos.com>,
	Phillip Potter <phil@philpotter.co.uk>, Coly Li <colyli@suse.de>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@ucw.cz>, dm-devel@redhat.com,
	linux-block@vger.kernel.org, linux-um@lists.infradead.org,
	linux-scsi@vger.kernel.org, linux-bcache@vger.kernel.org,
	linux-mtd@lists.infradead.org, linux-nvme@lists.infradead.org,
	linux-btrfs@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	linux-nilfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH 28/31] block: replace fmode_t with a block-specific type
 for block open flags
Message-ID: <20230607-bekannt-sonnig-c881b3228862@brauner>
References: <20230606073950.225178-1-hch@lst.de>
 <20230606073950.225178-29-hch@lst.de>
 <20230607-kocht-kornfeld-a249c6740e38@brauner>
 <20230607121658.GA13632@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230607121658.GA13632@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230607_134717_999750_B2C82562 
X-CRM114-Status: GOOD (  25.24  )
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

On Wed, Jun 07, 2023 at 02:16:58PM +0200, Christoph Hellwig wrote:
> On Wed, Jun 07, 2023 at 11:21:14AM +0200, Christian Brauner wrote:
> > On Tue, Jun 06, 2023 at 09:39:47AM +0200, Christoph Hellwig wrote:
> > > The only overlap between the block open flags mapped into the fmode_t and
> > > other uses of fmode_t are FMODE_READ and FMODE_WRITE.  Define a new
> > 
> > and FMODE_EXCL afaict
> 
> FMODE_EXCL isn't used outside the block layer and removed in the last
> patch.
> 
> > > +blk_mode_t file_to_blk_mode(struct file *file)
> > > +{
> > > +	blk_mode_t mode = 0;
> > > +
> > > +	if (file->f_mode & FMODE_READ)
> > > +		mode |= BLK_OPEN_READ;
> > > +	if (file->f_mode & FMODE_WRITE)
> > > +		mode |= BLK_OPEN_WRITE;
> > > +	if (file->f_mode & FMODE_EXCL)
> > > +		mode |= BLK_OPEN_EXCL;
> > > +	if ((file->f_flags & O_ACCMODE) == 3)
> > 
> > I really don't like magic numbers like this.
> 
> I don't like them either, but this is just moved around and not new.
> 
> > Groan, O_RDONLY being defined as 0 strikes again...
> > Becuase of this quirk we internally map
> > 
> > O_RDONLY(0) -> FMODE_READ(1)
> > O_WRONLY(1) -> FMODE_WRITE(2)
> > O_RDWR(3)   -> (FMODE_READ | FMODE_WRITE)
> 
> O_RDWR is 2.

Yeah, that was a typo. See the other mail I sent right after:
https://lore.kernel.org/all/20230607-kribbeln-dilettanten-b901b57dd962@brauner

> 
> > so checking for the raw 3 here is confusing in addition to being a magic
> > number as it could give the impression that what's checked here is
> > (O_WRONLY | O_RDWR) which doesn't make sense...
> 
> Well, that is exactly what we check for.  This is a 30-ish year old
> quirk only used in the floppy driver.

Ugh, it's f_flags. I misread that as f_mode...

This is rather ugly. Then please, make it explicit and check for
== (O_WRONLY | O_RDWR) and leave a brief comment.

Anything's better than that raw 3 in there. We just had fun with
figuring out why there was a raw coredump in fs/coredump.c 30 years
later.


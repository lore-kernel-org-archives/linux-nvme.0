Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B5E3C7EE25
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Jun 2023 12:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=E9faakThGtCW+0bU4cgq1GBsW1Ng9dSqZFBHRCf6MfU=; b=pKrZb+pVScVhdLKswBhWS8qs6Z
	J2zjJ3/NR2wC+MXDvFQYNbL+4yKPz8A3RrBBKvKVl4bPk/2J4mtY0XoSz/NzIwJgSxicbu8QkSDN+
	JlZV5jn6r3AleRKDLnZZgCAhXQ0pxzpPivNbpTRbpvOJ0nxa7ZEvQTzvMp4hje1womt1anUyJ9enQ
	p8+tr3PAXQ4rlyfNpC9wFOTpAk6ERIJ6Fn4FqJLgegrV6qVNpu501LsVfPyoK+sLtllD37es7HURH
	NPxqm/98ZKOaGIAqyPvH4PwOWbpIlCWpBCuMusB/T4ganL+bXypIyzoRTTMjfwD0X2cAdnXhyy3V0
	3wqNFdqA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q6s6A-005pFZ-0r;
	Wed, 07 Jun 2023 12:17:10 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q6s66-005pCh-2Y;
	Wed, 07 Jun 2023 12:17:08 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 52B4E6732D; Wed,  7 Jun 2023 14:16:58 +0200 (CEST)
Date: Wed, 7 Jun 2023 14:16:58 +0200
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Richard Weinberger <richard@nod.at>,
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
Subject: Re: [PATCH 28/31] block: replace fmode_t with a block-specific
 type for block open flags
Message-ID: <20230607121658.GA13632@lst.de>
References: <20230606073950.225178-1-hch@lst.de> <20230606073950.225178-29-hch@lst.de> <20230607-kocht-kornfeld-a249c6740e38@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230607-kocht-kornfeld-a249c6740e38@brauner>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230607_051706_969516_A3D4937D 
X-CRM114-Status: GOOD (  23.78  )
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

On Wed, Jun 07, 2023 at 11:21:14AM +0200, Christian Brauner wrote:
> On Tue, Jun 06, 2023 at 09:39:47AM +0200, Christoph Hellwig wrote:
> > The only overlap between the block open flags mapped into the fmode_t and
> > other uses of fmode_t are FMODE_READ and FMODE_WRITE.  Define a new
> 
> and FMODE_EXCL afaict

FMODE_EXCL isn't used outside the block layer and removed in the last
patch.

> > +blk_mode_t file_to_blk_mode(struct file *file)
> > +{
> > +	blk_mode_t mode = 0;
> > +
> > +	if (file->f_mode & FMODE_READ)
> > +		mode |= BLK_OPEN_READ;
> > +	if (file->f_mode & FMODE_WRITE)
> > +		mode |= BLK_OPEN_WRITE;
> > +	if (file->f_mode & FMODE_EXCL)
> > +		mode |= BLK_OPEN_EXCL;
> > +	if ((file->f_flags & O_ACCMODE) == 3)
> 
> I really don't like magic numbers like this.

I don't like them either, but this is just moved around and not new.

> Groan, O_RDONLY being defined as 0 strikes again...
> Becuase of this quirk we internally map
> 
> O_RDONLY(0) -> FMODE_READ(1)
> O_WRONLY(1) -> FMODE_WRITE(2)
> O_RDWR(3)   -> (FMODE_READ | FMODE_WRITE)

O_RDWR is 2.

> so checking for the raw 3 here is confusing in addition to being a magic
> number as it could give the impression that what's checked here is
> (O_WRONLY | O_RDWR) which doesn't make sense...

Well, that is exactly what we check for.  This is a 30-ish year old
quirk only used in the floppy driver.

> So my perference would be in descending order of preference:
> 
> (file->f_flags & O_ACCMODE) == (FMODE_READ | FMODE_WRITE)
> 
> or while a little less clear but informative enough for people familiar
> with the O_RDONLY quirk:
> 
> if ((file->f_flags & O_ACCMODE) == O_ACCMODE)

I don't understand this part.  Especially the above doesn't make
any sense as FMODE_READ and FMODE_WRITE are in a completely different
symbol space to O_*, and not a UAPІ but a kernel internal thing that
could be renumbered any time.


Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48AFEC87FDD
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Jun 2023 09:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=O+hcUcDfgstfOiV+FTBV2u5q1ErUaRIB5WUQos9T42I=; b=X56LxTz1N5gtQmKB86VmoOXUBx
	kCFgsvKI8i8NWWvMvWbjZBPt4q1URsonhHsyy9bAI3SESmzrRMA3TTxNN1zuagBETcWgCX/4D9/pV
	wgf8Ck6ck4gtJaQE8L3tQJBnbfZNWFEZBFOx9GDPuzJLhLZPs/bZU68Mc5rUr3wSXL641sEw8RsW8
	XDPjJkGYWcSIcr6b8HvgAflsv2WCEalnXGdlfMvMZ2wQhk0MJFO0mWAzIA55XJYU2DL7PHK8AJ2Hw
	wA/u7oZJbm+G0mQsLPDcTRGs30yx+eD2yBCeqRedCq0Q1VuOyFP86nIbjDWXicGaNHFqupB0Il8R7
	B0jPcDrw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q6pSQ-005FH8-1l;
	Wed, 07 Jun 2023 09:27:58 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q6pSM-005FG9-2P;
	Wed, 07 Jun 2023 09:27:56 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id F296A6242E;
	Wed,  7 Jun 2023 09:27:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB5FAC433EF;
	Wed,  7 Jun 2023 09:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1686130073;
	bh=I2UkqvXe3LAhxUZQ23TbbFjrzI8zVg3feJWvj1ZjawE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qIF5MQgVjaCU+MRlpJX9bdU66RYDnkWRk2lKrDnWx9ucpiPnToEUkd1U5Dy/rjQz1
	 7gmmu48tc7U+A8VzancF/0gAQHUGbi9FiTSsROsD+o+QHAjwmUEZjswQ+A1sXf6nhR
	 kfHjaFtOQj0xe1Ze/9BQpoq3Ja0IFOmMU6VIlaGRCOhubKRfuSMlKvTIwpFcJXDmH+
	 bMvjKaPX/w+ioU6o6Gr+Ofh5QFO4aw7AuFHZ7RCL6ScePZutaskI4egsGT7OJ0DEfH
	 pHBrWWb1KgIkb5itNtMApDVemlwylJZE6KoRZTn9hEkupDRw+s4gfju/aamXpLLVvL
	 mKtoh9S4m7YzQ==
Date: Wed, 7 Jun 2023 11:27:45 +0200
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
Subject: Re: decouple block open flags from fmode_t
Message-ID: <20230607-erwandern-posen-d5d15c9c2444@brauner>
References: <20230606073950.225178-1-hch@lst.de>
 <20230606-raumtemperatur-languste-045c5472f6a0@brauner>
 <20230606084042.GA30379@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230606084042.GA30379@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230607_022754_823913_E6C0C830 
X-CRM114-Status: GOOD (  16.68  )
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

On Tue, Jun 06, 2023 at 10:40:42AM +0200, Christoph Hellwig wrote:
> On Tue, Jun 06, 2023 at 10:27:14AM +0200, Christian Brauner wrote:
> > On Tue, Jun 06, 2023 at 09:39:19AM +0200, Christoph Hellwig wrote:
> > > Hi all,
> > > 
> > > this series adds a new blk_mode_t for block open flags instead of abusing
> > 
> > Trying to look at this series applied but doesn't apply cleanly for
> > anything v6.4-rc* related. What tree is this on?
> 
> Jens' for-6.5/block tree.
> 
> I also have a git tree here:
> 
>     git://git.infradead.org/users/hch/block.git blk-open-release
> 
> Gitweb:
> 
>     http://git.infradead.org/users/hch/block.git/shortlog/refs/heads/blk-open-release


Thanks! I pulled from your tree.


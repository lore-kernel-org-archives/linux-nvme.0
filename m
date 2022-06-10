Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A200CC43334
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Jun 2022 06:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bf+5MTYDbbWciaqTNiqaGXUYHarYc5wV318L/V2Ocok=; b=pI85Ln1CK1D0iVrwCZ5GTedB2G
	lNmhi1RalxM14uR+oRjM6/NMwm0nbpC5ngbZzRsOSE/464Ttikk5aBK0YPuwMuUwDguy7oWL4OajY
	Vclqzl7Km7utEv5W5Ec8YbuVQ0F2QmjyuHEUeuuFwx3F9B9QuPMF3ZA7VVEumIjPQJdJOxmgyghiI
	ORIbQrl89Ohfl0n3wz7kNQ7j3hgVDK3NBLI244pfshGkL+YH/23buaKFyvKqQGsxNQgXv0ijSl4jY
	WGtDv4bE5d+ki0tRhy3NtJDuJCVSdPNQa1j78LOvKex00gwBFhUePUpka4QN9DBfojbX3dkp8W1d2
	FKJmA0tQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nzXv6-0067Kw-Pk; Fri, 10 Jun 2022 06:14:56 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nzXv4-0067KG-5N
	for linux-nvme@lists.infradead.org; Fri, 10 Jun 2022 06:14:55 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4293467373; Fri, 10 Jun 2022 08:14:50 +0200 (CEST)
Date: Fri, 10 Jun 2022 08:14:49 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: "R, Monish Kumar" <monish.kumar.r@intel.com>,
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	"alan.adamson@oracle.com" <alan.adamson@oracle.com>,
	LKML <linux-kernel@vger.kernel.org>, Yi Zhang <yi.zhang@redhat.com>,
	Keith Busch <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>,
	"Rao, Abhijeet" <abhijeet.rao@intel.com>
Subject: Re: 2 second nvme initialization delay regression in 5.18 [Was:
 Re: [bug report]nvme0: Admin Cmd(0x6), I/O Error (sct 0x0 / sc 0x2)
 MORE DNR observed during blktests]
Message-ID: <20220610061449.GD24331@lst.de>
References: <CAHj4cs_iC+FE8ZAXXZPeia1V3ZX7zRbeASdOP_8c7DLiFozNfA@mail.gmail.com> <Ykyf5Zuz1W8yHhNY@zx2c4.com> <CAHmME9pwz4q0m-pSUy7ReWu4nNzxySNcYZrqyDZiTuGxHN=1NQ@mail.gmail.com> <CAHmME9o-orF52HzkT80054e3Op5fLOcTHb-KHpvvU7H3FpAJ7A@mail.gmail.com> <SA2PR11MB5115DCE45778910C96813CA1C3A79@SA2PR11MB5115.namprd11.prod.outlook.com> <YqG/pybFg0P5yQ9a@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YqG/pybFg0P5yQ9a@zx2c4.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220609_231454_388567_E98D7E9D 
X-CRM114-Status: GOOD (  21.27  )
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

On Thu, Jun 09, 2022 at 11:38:47AM +0200, Jason A. Donenfeld wrote:
> FWIW, all of that should have been in the commit message. Also, "based
> on analysis" - what analysis exactly? I have no way of thinking more
> about the issue at hand other than, "Monish said things are like this in
> a lab".

Please calm down a bit.  His report is at least as good as your new
report here..

> In any case, I believe the 970 ID predates that of the X5, and

Huh?

The 970 seems to actually be very slightly newer than the X5.  What
I suspect is that they actually are the same m.2 SSD or at least a
very similar one and Samsung decided to ship it in the thunderbolt
attached versions first.  Maybe one of the Samsung folks here can
confirm.

That leaves us with two plausible theories:

 - the problems could be due to an earlier firmware version or
   ASIC stepping
 - the problems are due to the thunderbolt attachment

Monish and Jason, can you please send me the output of nvme id-ctrl
/dev/nvmeX (where /dev/nvmeX is the actual device number)?

Monish, can you check if you are using the latest available firmware
and if not update it and check if you still need the quirks.


> destroying battery on those laptops and introducing boot time delays
> isn't really okay. So let's just revert this until somebody can work out
> better how to differentiate drives that need a quirk from drives that
> don't need a quirk.

While I'd really like to fix those issue, they are less severe than
not being able to use a device at all.  And just as a reminder: if you
want to get anything please be nice to people and try work with them
productively.


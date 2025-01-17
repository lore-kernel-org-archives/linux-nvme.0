Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84D2FC02183
	for <linux-nvme@archiver.kernel.org>; Fri, 17 Jan 2025 08:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vWrMYH2aR0a7eqCJDlvzFto9FUdSutYIc63YdURZTjc=; b=kPcSlsJCODxHjRC+PgNk6Ffoeg
	00ZaFz4ekrbd2tRIpMhd6jHoj4hj/deAQvnY7JESOHQ02PKbjoqDRDF4v7IuBlq0eTU1Tv85VJ/yi
	Ni6Iy6Rms1krPTLPGlso0OYjtRF8fym5O2YzPMk+QAUEBRcUYoxhjR/feugxOFYddohF6U50mAj0J
	zm0qfENMdF7ZFdtgk2sQHDPm5Pohj0KzxiyrFrD6oCg2HkiUJEEx7BuUnPjswJAAvPTYAPFDcpMNv
	UwYCcZevZnMcklEXfYtSJ4zDjXNW/6DDRjFGbwmebSCRbtHlqX4YWjmQGp4His+rrEtB4hS7L6Tb7
	f6uAOkag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tYhMw-0000000HHsS-448S;
	Fri, 17 Jan 2025 08:06:18 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tYhLv-0000000HHlL-1KDS
	for linux-nvme@lists.infradead.org;
	Fri, 17 Jan 2025 08:05:16 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id BDD1968BFE; Fri, 17 Jan 2025 09:05:07 +0100 (CET)
Date: Fri, 17 Jan 2025 09:05:07 +0100
From: Christoph Hellwig <hch@lst.de>
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: Bruno Gravato <bgravato@gmail.com>, Stefan <linux-kernel@simg.de>,
	Keith Busch <kbusch@kernel.org>, bugzilla-daemon@kernel.org,
	Adrian Huang <ahuang12@lenovo.com>,
	Linux kernel regressions list <regressions@lists.linux.dev>,
	linux-nvme@lists.infradead.org, Jens Axboe <axboe@fb.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	LKML <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>
Subject: Re: [Bug 219609] File corruptions on SSD in 1st M.2 socket of
 AsRock X600M-STX + Ryzen 8700G
Message-ID: <20250117080507.GA25953@lst.de>
References: <401f2c46-0bc3-4e7f-b549-f868dc1834c5@leemhuis.info> <Z36UsE5dj6j5HhkX@kbusch-mbp> <20250109082849.GC20724@lst.de> <210e7b28-de05-44bc-9604-83a79ae131b0@leemhuis.info> <726275aa-a3c2-4dbd-9055-a14db93efa29@simg.de> <CAOBLbT8103fAyoFNF8=YcEM1sM6HodcUe=Ee5NsE2hUkfCYv7g@mail.gmail.com> <3b693647-5e82-4c39-8017-22cada56eb55@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b693647-5e82-4c39-8017-22cada56eb55@leemhuis.info>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250117_000515_506053_BD9A5B7C 
X-CRM114-Status: GOOD (  21.24  )
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

On Wed, Jan 15, 2025 at 09:40:04AM +0100, Thorsten Leemhuis wrote:
> What does it mean that disabling the NVMe devices's write cache often
> but apparently not always helps? It it just reducing the chance of the
> problem occurring or accidentally working around it?

For consumer NAND device you basically can't disable the volatile
write cache.  If you do disable it, that just means it gets flushed
after every write, meaning you have to write the entire NAND
(super)block for every write, causing a huge slowdown (and a lot of
media wear).  This will change timings a lot obviously.  If it doesn't
change the timing the driver just fakes it, which reputable vendors
shouldn't be doing, but I would not be entirely surprised about
for noname devices.

> hch initially brought up that swiotlb seems to be used. Are there any
> BIOS setup settings we should try? I tried a few changes yesterday, but
> I still get the "PCI-DMA: Using software bounce buffering for IO
> (SWIOTLB)" message in the log and not a single line mentioning DMAR.

The real question would be to figure out why it is used.

Do you see the

	pci_dbg(dev, "marking as untrusted\n");

message in the commit log if enabling the pci debug output?
(I though we had a sysfs file for that, but I can't find it).



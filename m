Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07638C02185
	for <linux-nvme@archiver.kernel.org>; Fri, 17 Jan 2025 09:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2U7uceoWzXGUq0iH4XnHZ8xhaC+u9JdRB6f+dUZKSHg=; b=vzBQpWSwjYOckjLf5waDLLXtyV
	MQOrRboCGjZFU8+p8DHoTy6bJCDo/6Uz8qacqTRsIn08XgnYpyB/wv4m8i0n984bnzk9dNzQdgLMs
	2yFOrTshqD+ZaKoedz8Vm3wcejbY3MErjKOSRGzJZZ5yx/OtkNKeL/AoqTQyBzruYnfnSP9JJHmj1
	w93Cg5Ncl13OcG1cWxHGs66OXWawsgpHGcvooOlliz02t98SFUL1jgRxvb5w29mEmzciK8FSW05lK
	eLRL7bUskm8G/nKG6RVtmvJxvDlsClNgzWdziu7LOSYsQfRGTFHmnAastUasQriIXpncDnOrbuqGL
	k2NhaH5g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tYj6j-0000000HVtp-2qrU;
	Fri, 17 Jan 2025 09:57:41 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tYj4d-0000000HVQA-0hMT
	for linux-nvme@lists.infradead.org;
	Fri, 17 Jan 2025 09:55:32 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id DE8FD68BEB; Fri, 17 Jan 2025 10:55:22 +0100 (CET)
Date: Fri, 17 Jan 2025 10:55:22 +0100
From: Christoph Hellwig <hch@lst.de>
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: Christoph Hellwig <hch@lst.de>, Bruno Gravato <bgravato@gmail.com>,
	Stefan <linux-kernel@simg.de>, Keith Busch <kbusch@kernel.org>,
	bugzilla-daemon@kernel.org, Adrian Huang <ahuang12@lenovo.com>,
	Linux kernel regressions list <regressions@lists.linux.dev>,
	linux-nvme@lists.infradead.org, Jens Axboe <axboe@fb.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	LKML <linux-kernel@vger.kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [Bug 219609] File corruptions on SSD in 1st M.2 socket of
 AsRock X600M-STX + Ryzen 8700G
Message-ID: <20250117095522.GA2391@lst.de>
References: <401f2c46-0bc3-4e7f-b549-f868dc1834c5@leemhuis.info> <Z36UsE5dj6j5HhkX@kbusch-mbp> <20250109082849.GC20724@lst.de> <210e7b28-de05-44bc-9604-83a79ae131b0@leemhuis.info> <726275aa-a3c2-4dbd-9055-a14db93efa29@simg.de> <CAOBLbT8103fAyoFNF8=YcEM1sM6HodcUe=Ee5NsE2hUkfCYv7g@mail.gmail.com> <3b693647-5e82-4c39-8017-22cada56eb55@leemhuis.info> <20250117080507.GA25953@lst.de> <f81bb87a-c181-4973-be05-f7df84133a46@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f81bb87a-c181-4973-be05-f7df84133a46@leemhuis.info>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250117_015531_354780_A415E160 
X-CRM114-Status: GOOD (  16.55  )
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

On Fri, Jan 17, 2025 at 10:51:09AM +0100, Thorsten Leemhuis wrote:
> By booting with 'ignore_loglevel dyndbg="file drivers/pci/* +p"' I
> suppose? No, that is not printed (but other debug lines from the pci
> code are).
> 
> Side note: that "PCI-DMA: Using software bounce buffering for IO
> >> (SWIOTLB)" message does show up on two other AMD machines I own as
> well. One also has a Ryzen 8000, the other one a much older one.
> 
> And BTW a few bits of the latest development in the bugzilla ticket
> (https://bugzilla.kernel.org/show_bug.cgi?id=219609 ):
> 
> * iommu=pt and amd_iommu=off seems to work around the problem (in
> addition to disabling the iommu in the BIOS setup).

That suggests the problem is related to the dma-iommu code, and
my strong suspect is the swiotlb bounce buffering for untrusted
device.  If you feel adventurous, can you try building a kernel
where dev_use_swiotlb() in drivers/iommu/dma-iommu.c is hacked
to always return false?



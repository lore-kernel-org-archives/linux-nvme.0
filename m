Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DAB5C02183
	for <linux-nvme@archiver.kernel.org>; Sat, 18 Jan 2025 01:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PP/y/CvJvRNEhcX9UQOf0bfPisy7n1orM/6Ll1FE0hw=; b=iPJJ7F3YwAEvkWD3YplRkwQG3P
	MmznIglGuEQwFeKuVbawHX0B8JFTOxVgfrp654PBv9NzVaHvdndjp2EoHwvYHCMDjkBNjo4/QJdW1
	FVV6eKZ63n8ksqqA1YT/QhEYajxksUEm0s5kIH4PgZUkyqHSNNZX/pGXNMHd5UvgKUzRakbSAcJ4y
	7FTlo/LHmhNXO7mHDs7CP1FcozML9C4YLB1U6OP0MkpU/UT3w5EJrxEHPpZSP6DH/R3rEXxSc3viV
	cjuHigVXscM5ZFGG3wVgVh5dcmpswHX/BaaqzwCqfbwer7us9dWZVVIz3xXSX2FjFu7HcEQ6MGJDA
	NXEaIcNg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tYxFk-00000001eZL-1lrE;
	Sat, 18 Jan 2025 01:03:56 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tYxFh-00000001eYT-3zNM
	for linux-nvme@lists.infradead.org;
	Sat, 18 Jan 2025 01:03:55 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 914475C551C;
	Sat, 18 Jan 2025 01:03:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 282DFC4CEDD;
	Sat, 18 Jan 2025 01:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737162233;
	bh=zWGX9MPXZ+eT05lfY+zSlGG4+MCjUc0nj6r4y/eop1A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A5A4JJ00iRZwlrZHeRlT3YXeDYbUT5aWmbI/gl9MDBODe1bLqnN+ECj4FL6sQn00c
	 jbHpLSc/jefQmu2tDc3csjz2pywdk62sw7GvELSpSY1VuBKDpdHyBz+1INclZg1ZAU
	 mc557uV7XrpR+h3KI3HWhV+d8wjx6Ry2tVHjLKrYGIZkgEgf8j+VcMqisxefQRUzbd
	 8tzSXvB0ppbxIYpp6WwqwgMvNgQwJ+xL/VnyZHABvNP/ubYmFzvsHj9Ng6OgBTaqYi
	 nUofy4HSWgjY8booxIgSMElCMo8oUrMN7LAYPfEHlm4d/URbIbFn+KfgUHdNT9Ix2N
	 K4Pai9QxTZhAA==
Date: Fri, 17 Jan 2025 18:03:49 -0700
From: Keith Busch <kbusch@kernel.org>
To: Stefan <linux-kernel@simg.de>
Cc: Christoph Hellwig <hch@lst.de>,
	Thorsten Leemhuis <regressions@leemhuis.info>,
	bugzilla-daemon@kernel.org, Bruno Gravato <bgravato@gmail.com>,
	Adrian Huang <ahuang12@lenovo.com>,
	Linux kernel regressions list <regressions@lists.linux.dev>,
	linux-nvme@lists.infradead.org, Jens Axboe <axboe@fb.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [Bug 219609] File corruptions on SSD in 1st M.2 socket of AsRock
 X600M-STX + Ryzen 8700G
Message-ID: <Z4r99SQYV9v5vBuR@kbusch-mbp>
References: <401f2c46-0bc3-4e7f-b549-f868dc1834c5@leemhuis.info>
 <Z36UsE5dj6j5HhkX@kbusch-mbp>
 <20250109082849.GC20724@lst.de>
 <210e7b28-de05-44bc-9604-83a79ae131b0@leemhuis.info>
 <726275aa-a3c2-4dbd-9055-a14db93efa29@simg.de>
 <CAOBLbT8103fAyoFNF8=YcEM1sM6HodcUe=Ee5NsE2hUkfCYv7g@mail.gmail.com>
 <3b693647-5e82-4c39-8017-22cada56eb55@leemhuis.info>
 <20250117080507.GA25953@lst.de>
 <00b01ab3-ec9d-4a35-a593-c9fc764e0f04@simg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00b01ab3-ec9d-4a35-a593-c9fc764e0f04@simg.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250117_170354_032980_76BFC653 
X-CRM114-Status: GOOD (  12.01  )
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

On Fri, Jan 17, 2025 at 10:31:55PM +0100, Stefan wrote:
> As already mentioned, my SSD has no DRAM and uses HMB (Host memory
> buffer). 

HMB and volatile write caches are not necessarily intertwined. A device
can have both. Generally speaking, you'd expect the HMB to have SSD
metadata, not user data, where a VWC usually just has user data. The
spec also requires the device maintain data integrity even with an
unexpected sudden loss of access to the HMB, but that isn't the case
with a VWC.

>(It has non-volatile SLC cache.) Disabling volatile write cache
> has no significant effect on read/write performance of large files,

Devices are free to have whatever hierarchy of non-volatile caches they
want without advertising that to the host, but if they're calling those
"volatile" then I think something has been misinterpreted.

> because the HMB size in only 40MB. But things like file deletions may be
> slower.
> 
> AFAIS the corruption occur with both kinds of SSD's, the ones that have
> own DRAM and he ones that use HMB.

Yeah, that was the point of the experiment. If corruption happens when
it's off, then that helps rule out host buffer size/alignment (which is
where this bz started) as a triggering condition. Disabling VWC is not a
"fix", it's just a debug data point. If corruption goes away with it
off, though, then we can't really conclude anything for this issue.


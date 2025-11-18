Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43FE5CEE357
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Nov 2025 20:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tp8mrcKjcCI72odUIRWwIoj18UT8XqfPGy/VA44H01E=; b=Wxnw1CkI2SHUzv799Ski1FduMx
	jMQEZzLszDcc4YvkjzKEUm3SvoQMtX3LxN4Y0Hc1AP/HJFapU7otAwoaLOz7TxZdkD3x7EdBRVvpJ
	dJrsXG8EOrEcYOLH1GTMCanOFq8D+Wph9bHdj2S/4rCBGCh8UlDr/Mtprl4BZvzOz+KBiXMDl9LDt
	1cxZOQ2oGMSnmG9mw3gm3TKo6rxSXGhhL0cUUCXeO2SVjEVqjC0B2YTUu4UWYHrvSx98DdBBcOCXO
	Y8rPpw9T5obCetOSQmT/8v6bTMdA+NtXW/z9fHwSN3bg92mC1KTBgssu55RpzSNh/8y1mY0a4R5h2
	/ig2GyCA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLSeB-000000016EE-2Ajy;
	Tue, 18 Nov 2025 20:49:55 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLSe8-000000016DM-1IMD
	for linux-nvme@lists.infradead.org;
	Tue, 18 Nov 2025 20:49:53 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 1B4E24321E;
	Tue, 18 Nov 2025 20:49:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32649C4CEFB;
	Tue, 18 Nov 2025 20:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763498988;
	bh=GkRx614zWTda5iheqrQzFK4/apd3Zq7rMoKN653Ftps=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Dexhd1HIDxXnFHTaGONtWafpB8SGUUwoX0QQU8g0IxvjHxkQiERcGKiQhUAEUr9By
	 UrLcAdJOu2Y9LVLFvrnnMek/6WSB9R1ThUWvoc6iHemrJthNU2ysjk7E3/Wd/cEEE6
	 9CZ5pg9ZraLoWG7DY3SkzfbSICuzAdXfkriro19fHfk6j+HWQH7z7bNPbo5rQYMsqf
	 FOwpbodZlM03odZzjvmzzQizltce+uq5vO7A0aWvJ5FXUoISgtTyqRXe5qOZ5OTBnl
	 Psy6kC1jctMkmzcIvgpLxt+P7inoAX9RbnJeV5a9paaR0S4lNVavqF9emICHDA8iI5
	 eR0CrAfnY6PIA==
Date: Tue, 18 Nov 2025 13:49:45 -0700
From: Keith Busch <kbusch@kernel.org>
To: Thomas ten Cate <ttencate@gmail.com>
Cc: Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: "controller is down; will reset" on SK Hynix NVMe drive in
 Lenovo IdeaPad Pro 5
Message-ID: <aRzb6U1se40SrQRM@kbusch-mbp>
References: <CACbz5yFi8hiPD0Avg=KVTpdEeJC=3MMSkGtYOBQ=OmB_O0khyQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACbz5yFi8hiPD0Avg=KVTpdEeJC=3MMSkGtYOBQ=OmB_O0khyQ@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251118_124952_386791_B8B1F9DB 
X-CRM114-Status: GOOD (  20.73  )
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

On Mon, Nov 17, 2025 at 02:39:17PM +0100, Thomas ten Cate wrote:
> The log suggests to add the kernel arguments
> "nvme_core.default_ps_max_latency_us=0 pcie_aspm=off
> pcie_port_pm=off", which indeed makes all issues go away.
> 
> I haven't found a reliable way to trigger the latter error
> specifically, though doing something I/O heavy like compiling a kernel
> seems to make it more likely. This makes bisect difficult to do, but
> it's clear that something was going on in previous versions as well,
> so I wouldn't necessarily call this a regression. Either way, the
> issue is still present in mainline 6.17.8.
> 
> Since it happens only after some idle time, and disabling PM fixes it,
> this seems related to power states. But of course, I cannot completely
> rule out faulty hardware either.
> 
> Machine: Lenovo IdeaPad Pro 5 16APH8
> Architecture: x86_64
> NVMe drive: SK Hynix HFS001TEJ4X112N
> Full lshw output:
> https://gist.github.com/ttencate/5540c81454bbe1fa679955effba65eba
> 
> Distribution: Arch Linux
> Kernel version: 6.17.8 (vanilla from commit 8ac42a6)
> Kernel configuration:
> https://gitlab.archlinux.org/archlinux/packaging/packages/linux-lts/-/blob/b0cac6a69041703bbe1aba4a2a269585d77b108b/config
> (plus `make olddefconfig`)
> GCC version: 15.2.1
> 
> This is my first kernel bug report, so I hope I didn't miss anything;
> if I did, please let me know. I'd be happy to experiment or try out
> patches.

The "report a bug" message was originally pointed at hardware vendors
rather than kernel. Something is wrong with the SSD, the PCIe slot, or
both if the power features cause the endpoint to drop off the bus. The
only recourse we have in the nvme driver is a quirk to disable APST for
the device. The driver doesn't control the PCIe ASPM settings though, so
that would have to be a different quirk if it's really necessary. Do you
need all three of those parameters, or is disabling the nvme driver's
apst sufficient on its own? These parameters do have a negative impact
on your machine's power consumption, so you'd usually want to hone in if
it's just the deepest power state or if every power saving feature
really needs to be disabled.


Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6D73D2C56A
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Oct 2024 15:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7mO82svaRzxaq8okITs22fuifb/MvSsCZBk0DwMd5I4=; b=IjnBTKyRaEHi9WiWAO0zlFdmY2
	+sjzSNobyVfo+BoLry9hR+OisiYN1P5aGPR8hB3pklprMQoDv9XCHA7BsB4L7DOzIDxLe5LpARBcu
	pHCIOBILlnQ5/kywagfwuhVrkHsj8Lt7JRwaDOVepOkIlGWRhW2h6HR6PwZjtr3ybgx+5FNiOwEUk
	flGZRMt0BJG37aXJEPHCh4Ra5MBAW9Q4jXQeVgJ03JjDyJv5twHLuSrX7rvJ5p81twY39oJ7sfE2C
	tRX1RBVuhxI6BUiJvOi6Zvxs0fQCFofsj93Bf5HGpuXYb7SAjVpr1gRcHzpcGy4Bzdnrv/T1j2Nic
	r/sxayWQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t3GTo-0000000BCd3-0R0m;
	Tue, 22 Oct 2024 15:07:28 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t3GGc-0000000BAwN-3Ert
	for linux-nvme@lists.infradead.org;
	Tue, 22 Oct 2024 14:53:51 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 8A40C5C59E0;
	Tue, 22 Oct 2024 14:53:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42110C4CEC3;
	Tue, 22 Oct 2024 14:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729608829;
	bh=/fr7UordcSe/gxJRYh0FMvmJu2u/efKDwI+Z2bK9ygk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JNcJQEtsSNhY0sp0U44sxaQuFSqfIpPObekJALMS5CqzQ20sDFsqFGlaXflUR8U79
	 Rgmho8X+kddIdi13fgIA5PVWoMYiO2VR+qgITj7KjORpGLYF5rv+V/zTjZjHVo6yQF
	 /4tTxF3xiXH50YW9KRUyej2iK2O/IKwDVkty7rfOkWW/twbAyvB+ERDgfVCUg7sKyT
	 DxnwG/R2izP++D5OCIwooNtUn5uP/cT/hm6qe5DQ3E95fu16Bxthrjl4y3F2sGwmj9
	 QqEtKuYRKg85Cru2ofYbHBWi1OlieMNvS+jQsEreSwTeQc8/chZe1NUPZpAoj8fnLY
	 8tTVe4EQdppjw==
Date: Tue, 22 Oct 2024 08:53:47 -0600
From: Keith Busch <kbusch@kernel.org>
To: Abhishek Bapat <abhishekbapat@google.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Prashant Malani <pmalani@google.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-sysfs: display max_hw_sectors_kb without requiring
 namespaces
Message-ID: <Zxe8e2zS5dA61Jou@kbusch-mbp>
References: <20241016213108.549000-1-abhishekbapat@google.com>
 <ZxE-BE4hLVRR2Zcp@kbusch-mbp.dhcp.thefacebook.com>
 <CAL41Mv4_UjsD1ycpNU1xuQJdGWMf2L-SQYs=LupoM9BKurNXCg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL41Mv4_UjsD1ycpNU1xuQJdGWMf2L-SQYs=LupoM9BKurNXCg@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241022_075350_878992_A232D9D7 
X-CRM114-Status: GOOD (  25.73  )
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

On Thu, Oct 17, 2024 at 02:32:18PM -0700, Abhishek Bapat wrote:
> On Thu, Oct 17, 2024 at 9:40 AM Keith Busch <kbusch@kernel.org> wrote:
> >
> > On Wed, Oct 16, 2024 at 09:31:08PM +0000, Abhishek Bapat wrote:
> > > max_hw_sectors based on DMA optimized limitation") introduced a
> > > limitation on the value of max_hw_sectors_kb, restricting it to 128KiB
> > > (MDTS = 5). This restricion was implemented to mitigate lockups
> > > encountered in high-core count AMD servers.
> >
> > There are other limits that can constrain transfer sizes below the
> > device's MDTS. For example, the driver can only preallocate so much
> > space for DMA and SGL descriptors, so 8MB is the current max transfer
> > sizes the driver can support, and a device's MDTS can be much bigger
> > than that.
> >
> > Anyway, yeah, I guess having a controller generic way to export this
> > sounds like a good idea, but I wonder if the nvme driver is the right
> > place to do it. The request_queue has all the limits you need to know
> > about, but these are only exported if a gendisk is attached to it.
> > Maybe we can create a queue subdirectory to the char dev too.
> 
> Are you suggesting that all the files from the queue subdirectory should
> be included in the char dev (/sys/class/nvme/nvmeX/queue/)? Or that
> just the max_hw_sectors_kb value should be shared within the queue
> subdirectory? And if not the nvme driver, where else can this be done
> from?

You'd may want to know max_sectors_kb, dma_alignment, nr_requests,
virt_boundary_mask. Maybe some others.

The request_queue is owned by the block layer, so that seems like an
okay place to export it, but attached to some other device's sysfs
directory instead of a gendisk.

I'm just suggesting this because it doesn't sound like this is an nvme
specific problem.


Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92862D3C549
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Oct 2024 05:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xz1RDi2N3a+lsebDJdZMEdbkeHeLVwB2mU+CtIstVro=; b=VFvB31emIn+yjczcYQ5oNs/mmg
	cEiqKjPwYapKUsaGDTC92BPnRFpgsP1dRAJW/jtwQW/V8v4C2n22jlp9PhLn1mBgoAIdh5n/QCaKL
	4foac3yA10JIAesBKMdXc5Wi+cGT4jjL0ENhFYt2TUsS0uT6Jyz3SY+EHvWZZpda8jYDvVu5Xs/wf
	QADBJfGbTanYKVUPNbOjR8aDsOlWE8/x9cPIVGDG/dslLx8VS/HQtOVp65EzBNl9RpGUMfP4fgxHv
	O1sibtx6kG4AcB4yXQhZDukBK4cqFobWU4qjkPsveXEH40bwHQZJorc3EicqBP04BLh6F9YLC1+x6
	Qg9aUsQA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t1fJZ-0000000GwIV-3sSF;
	Fri, 18 Oct 2024 05:14:17 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t1fJW-0000000GwHm-2QiC
	for linux-nvme@lists.infradead.org;
	Fri, 18 Oct 2024 05:14:16 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id C5FF1227A8E; Fri, 18 Oct 2024 07:14:10 +0200 (CEST)
Date: Fri, 18 Oct 2024 07:14:10 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Abhishek Bapat <abhishekbapat@google.com>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Prashant Malani <pmalani@google.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-sysfs: display max_hw_sectors_kb without
 requiring namespaces
Message-ID: <20241018051410.GE19831@lst.de>
References: <20241016213108.549000-1-abhishekbapat@google.com> <ZxE-BE4hLVRR2Zcp@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxE-BE4hLVRR2Zcp@kbusch-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241017_221415_318048_E7AF350D 
X-CRM114-Status: GOOD (  21.57  )
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

On Thu, Oct 17, 2024 at 10:40:36AM -0600, Keith Busch wrote:
> On Wed, Oct 16, 2024 at 09:31:08PM +0000, Abhishek Bapat wrote:
> > max_hw_sectors based on DMA optimized limitation") introduced a
> > limitation on the value of max_hw_sectors_kb, restricting it to 128KiB
> > (MDTS = 5). This restricion was implemented to mitigate lockups
> > encountered in high-core count AMD servers.
> 
> There are other limits that can constrain transfer sizes below the
> device's MDTS. For example, the driver can only preallocate so much
> space for DMA and SGL descriptors, so 8MB is the current max transfer
> sizes the driver can support, and a device's MDTS can be much bigger
> than that.

Yes.  Plus the virt boundary for PRPs, and for non-PCIe tranfers
there's also plenty of other hardware limits due to e.g. the FC HBA
and the RDMA HCA limit.  There's also been some talk of a new PCIe
SGL variant with hard limits.

So I agree that exposting limits on I/O would be very useful, but it's
also kinda non-trivial.

> Anyway, yeah, I guess having a controller generic way to export this
> sounds like a good idea, but I wonder if the nvme driver is the right
> place to do it. The request_queue has all the limits you need to know
> about, but these are only exported if a gendisk is attached to it.
> Maybe we can create a queue subdirectory to the char dev too. 

If we want it controller wide to e.g. include the admin queue the
gendisk won't really help unfortunately.


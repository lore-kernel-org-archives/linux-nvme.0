Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF3DBC25B10
	for <linux-nvme@archiver.kernel.org>; Sat, 11 May 2024 00:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4gfwCtGJ/c4efvcE0tcYiOHcxkCJcNNjSfT/ofaAO6s=; b=H5w9Rbwf+IjMcLeYjQ6QCrpkZK
	Px/Oh4Fdj1+QM5r49g0VeOW/SJw5xDUappsAPnn4Iw2FMSBaCxGQ90urd1Ox3vHALaZxfVIRsgIet
	3gbsYIokg/g71nLtRl3pF5P1/jA/st4E+krIC9cgwQkl/l3ucgg/2uZKvn6/ZoH9rW4kmUez1N/Zr
	UIRzQD/R1PQVn1Lol3Xq87uS/T2alKfSTN5PzEUA2tbjWotItvm1hPD6/pRP2g55pQ8UTsBzap8jl
	JgyVxgk2nF1Uj1lV71bf4mWRmzqL4MuieDrLArMi9QDUgD0KcFQIAp7LiRygQW9WaJhLD+CG/uMd1
	4AJGGBHA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s5aoO-00000006uvS-29cE;
	Sat, 11 May 2024 00:42:04 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s5aoM-00000006uv0-0WZl
	for linux-nvme@lists.infradead.org;
	Sat, 11 May 2024 00:42:03 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 843DF61F5E;
	Sat, 11 May 2024 00:42:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C593BC113CC;
	Sat, 11 May 2024 00:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715388121;
	bh=JfkJCrRzMsVaxBdKSOt5V9y/UW7YoWut4OsHo5rBQiM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gs7Lr8gnacl8F67NIAa4R+Nv76M4FVuVz/g1Ftt06AzMiYx7Q5K4ixLDuEstx3ghp
	 OgN6ySSTVegeCLCXIeoiP5Jc+rpnnFP34iPanQ/NTUe8OyP2vxSTyxe0UHUhLruQ49
	 zpTEDWbUY3AdSctYwTtv4bGkojgN3M2cb8uPDhlCNi2mWJtWoeJw7NRMaJhniSI42H
	 tk+JXR5vChAlDJbygj3fL0J9VGPAM3gQ87y81Zp0XVfivTHldB6Zue+B/gIqjOJLEn
	 MwXptyp6W83ne0DQa5Lia0e/4atrzo9srWZ6oHjr9wTDT1slRmtox9L1CvcathZYNc
	 uEdFqpe5+AJEA==
Date: Fri, 10 May 2024 18:41:58 -0600
From: Keith Busch <kbusch@kernel.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@meta.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	tglx@linutronix.de
Subject: Re: [PATCH 2/2] nvme-pci: allow unmanaged interrupts
Message-ID: <Zj6-1sXvUNZWO1pB@kbusch-mbp.dhcp.thefacebook.com>
References: <20240510141459.3207725-1-kbusch@meta.com>
 <20240510141459.3207725-2-kbusch@meta.com>
 <20240510151047.GA10486@lst.de>
 <Zj5JMqWRY187PqnD@kbusch-mbp.dhcp.thefacebook.com>
 <Zj6yvTxIpUnOXl7R@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zj6yvTxIpUnOXl7R@fedora>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240510_174202_453270_F8F512CA 
X-CRM114-Status: GOOD (  21.51  )
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

On Sat, May 11, 2024 at 07:50:21AM +0800, Ming Lei wrote:
> On Fri, May 10, 2024 at 10:20:02AM -0600, Keith Busch wrote:
> > On Fri, May 10, 2024 at 05:10:47PM +0200, Christoph Hellwig wrote:
> > > On Fri, May 10, 2024 at 07:14:59AM -0700, Keith Busch wrote:
> > > > From: Keith Busch <kbusch@kernel.org>
> > > > 
> > > > Some people _really_ want to control their interrupt affinity.
> > > 
> > > So let them argue why.  I'd rather have a really, really, really
> > > good argument for this crap, and I'd like to hear it from the horses
> > > mouth.
> > 
> > It's just prioritizing predictable user task scheduling for a subset of
> > CPUs instead of having consistently better storage performance.
> > 
> > We already have "isolcpus=managed_irq," parameter to prevent managed
> > interrupts from running on a subset of CPUs, so the use case is already
> > kind of supported. The problem with that parameter is it is a no-op if
> > the starting affinity spread contains only isolated CPUs.
> 
> Can you explain a bit why it is a no-op? If only isolated CPUs are
> spread on one queue, there will be no IO originated from these isolated
> CPUs, that is exactly what the isolation needs.

The "isolcpus=managed_irq," option doesn't limit the dispatching CPUs.
It only limits where the managed irq will assign the effective_cpus as a
best effort.

Example, I boot with a system with 4 threads, one nvme device, and
kernel parameter:

  isolcpus=managed_irq,2-3

Run this:

  for i in $(seq 0 3); do taskset -c $i dd if=/dev/nvme0n1 of=/dev/null bs=4k count=1000 iflag=direct; done

Check /proc/interrupts | grep nvme0:

           CPU0       CPU1       CPU2       CPU3
...
 26:       1000          0          0          0  PCI-MSIX-0000:00:05.0   1-edge      nvme0q1
 27:          0       1004          0          0  PCI-MSIX-0000:00:05.0   2-edge      nvme0q2
 28:          0          0       1000          0  PCI-MSIX-0000:00:05.0   3-edge      nvme0q3
 29:          0          0          0       1043  PCI-MSIX-0000:00:05.0   4-edge      nvme0q4

The isolcpus did nothing becuase the each vector's mask had just one
cpu; there was no where else that the managed irq could send it. The
documentation seems to indicate that was by design as a "best effort".


Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E77DD35690
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Jan 2026 08:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1vo2SlSyLD++De3l59xeALGq7lDyhABU6W/zMYAefEw=; b=FZ/nwVp095gLm1ndjZPhAi2qgL
	TuuD/kwBEClrghH050fEw7bTU0cxcvmshUaSdRVGtqHn7zDbzAKjAyP8tyxTKIU1bCinkNfsJREX6
	c8/m+FTQX4KYNOvHOY7yoAJC7gM09gAI/hDd5IE0SNozpzVDKVftZaEbErYw8DnK4eAnE6dGLXQQU
	HmQdpBIep5eoZZL4+acFArIw14Frcgbb97RgNb5kEGqI6WQn5kZ89T+WUzIuMn2kU8zwLEAJsZ+P5
	oqZw+L9ZqV/yo9j3+LYRL3vH5cX9xUgvUYu0fQt/MWMbUShXtkSxhuYEzAj9s2cRFt/iaiZu4ZJTx
	Cj/obCcw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vl1AH-0000000FgRM-0UZy;
	Wed, 28 Jan 2026 08:44:41 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vl1AD-0000000FgRC-2Wam
	for linux-nvme@lists.infradead.org;
	Wed, 28 Jan 2026 08:44:37 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id AD20F600B0;
	Wed, 28 Jan 2026 08:44:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 026DAC4CEF1;
	Wed, 28 Jan 2026 08:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769589876;
	bh=mHh31OHVlCNHo2EHoX40CREsCDvpuC5j0yYV9f2HMvg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=My5FS7zfwEKjiVhU4LbS6H8CotIprJrRDkSVm4Ytj3pbpfRJzNUcfucSN7pey940V
	 uGOQYcq+SFrhlNby/bfFBLYjMwF1kiab//7c5SaSYMa7Irw5kvKclxcG9BgBLqv/I4
	 lOIuRrkfohVcjhj9WtIjOl2G3V8KVCKNHxaXvcOblg2Y2rm2aIDk8aSUjMhPZQlKZq
	 QBppQ3O04XVCUPT14UMImygloHoBuqWJyMVUAGM4vu2mETY1g9AZE8TDDbC2QFAG+R
	 IJJPPHuDSUxDzaUMgs/G7X9TAQHvS/sRyO+p2Og5guhnocfJUv6wNUP5mmYrjC2Uhr
	 v1AtGCQvke1RA==
Date: Wed, 28 Jan 2026 10:44:32 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Qinyun Tan <qinyuntan@linux.alibaba.com>,
	Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Xunlei Pang <xlpang@linux.alibaba.com>,
	Guixin Liu <kanie@linux.alibaba.com>, oliver.yang@linux.alibaba.com,
	Guanghui Feng <guanghuifeng@linux.alibaba.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH V1] nvme-pci: disable SR-IOV VFs on driver unbind
Message-ID: <20260128084432.GA12149@unreal>
References: <197d75a2-4286-41fb-ab4f-9ad744885bb4@app.fastmail.com>
 <20260127230912.GA385193@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260127230912.GA385193@bhelgaas>
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

On Tue, Jan 27, 2026 at 05:09:12PM -0600, Bjorn Helgaas wrote:
> [+cc Jakub, author of 38972375ef7b ("PCI/IOV: Reset total_VFs limit
> after detaching PF driver"), which added the message]
> 
> On Tue, Jan 27, 2026 at 08:00:42PM +0200, Leon Romanovsky wrote:
> > On Tue, Jan 27, 2026, at 18:06, Keith Busch wrote:
> > > On Tue, Jan 27, 2026 at 04:31:43PM +0200, Leon Romanovsky wrote:
> > >> On Tue, Jan 27, 2026 at 09:48:07AM +0100, Christoph Hellwig wrote:
> > >> > On Tue, Jan 27, 2026 at 03:33:44PM +0800, Qinyun Tan wrote:
> > >> > > The NVMe PCI driver exports the sriov_configure callback via
> > >> > > pci_sriov_configure_simple(), which allows userspace to enable SR-IOV
> > >> > > VFs through sysfs. However, when the PF driver is unbound, the driver
> > >> > > does not disable SR-IOV, leaving VFs orphaned in the system.
> > >> > 
> > >> > That sounds dangerous.
> > >> 
> > >> It is not. In a real SR-IOV device, VFs are created by the hardware and
> > >> are independent of their PF. There are several use cases where an
> > >> operator unbinds the PF and reuses it to improve overall device
> > >> utilization.
> > >
> > > If this is expected, should the warn message "driver left SR-IOV
> > > enabled after remove" be downgraded to 'info' level?
> > 
> > It is not important, no one complained about it. People who unbind
> > PF, simply ignore this warning.
> > 
> > BTW, the use case which I presented is for SR-IOV handled by
> > drivers. Maybe VFs created by NVMe are different here and they must
> > be destroyed.
> 
> If it's to be expected, I do think 'info' would be more appropriate,
> if nothing else as an indication to code readers that nothing is
> wrong.  Or maybe even no message at all.

The issue is that not all devices are created equal. Some devices from major
vendor rely on messages sent from the VF to the PF, and expect the PF driver
to perform certain configuration steps in response. These devices must disable
SR-IOV when the PF is unbound.

From one side, for users of such hardware, this message is important.
From another, for many other devices, this message is not important.

Like Jakub, I don't have any preference here.

Thanks


Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8FBDE7716A
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Dec 2024 05:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Dcb6g3k7LdQWKOYrstVqdbmh0DnvbJtjwQxf7Pk2URk=; b=MlUmk08j9mkLaEcP1kJiaSL+3X
	mmK9H6RrvgmnSUn7K0HhSl+slPy6EwNJAQCEsDaZbKL/mpxan3ix3VINzfO50n6FCILs1ywPcZpuZ
	7vu/UsEYHWQjbn1vawf94xm0lr97XguNimLvp4J0nVvKNxc0PZG0JQy9TUbSbDd3MZJ+El8ryInbb
	UBJS3gRMO3v//HaYTXchHgqXz4c0sIN/O7kiht+cpRpMVrW1ldvo3lS+pukA5oBZ3UykCVV4FO8QU
	x625HnG8lgKWILFSOO4UjJdrLx43aeGbjANhmssoAlEe3BPCwFwDXrJBZNMaOcake/BfOwgNnjohq
	HbAhPcJg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tNQNN-0000000CKXi-1v47;
	Tue, 17 Dec 2024 05:44:09 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tNQ6t-0000000CHTz-2BzG
	for linux-nvme@lists.infradead.org;
	Tue, 17 Dec 2024 05:27:08 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id B3D3C5C5F6E;
	Tue, 17 Dec 2024 05:26:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA2F4C4CED3;
	Tue, 17 Dec 2024 05:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734413226;
	bh=hlilBpHDIjEBNGJiFqjKYE8/nd6vUP2wlydRXVbEjoU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Dh1q6bU958wEZV82Rlc3TKh61qiYZzu3Pv2ka649lZpy6DoLoTHOqJ1TXKnUCu66I
	 tjBydLfS43YfYmHQeATbJ5letw7uhV8OMGub/wbPXgzN9InnuGhfQYYXIxlRoogMIq
	 ucTyjlhj5l5E90pWvr9iu4ji/IkAP1Hya9Q8O/iHs3Ck1xqlLZz/qqaTpkzpSVYlUq
	 8pkWyRpNh7DOMIvOR17MwFBwaRQxwW10WYsktpxLb60A6DlISu4vTCfi1IeiY6hC4h
	 SJyGsTTbK+qVvkLNqDXXy5VJDQM2FU/BDrbhbT9s3Cz/DZCr4+kHWxUlcEFhXzq/G1
	 kTZmqZI/J0XPg==
Date: Tue, 17 Dec 2024 10:57:02 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Niklas Cassel <cassel@kernel.org>, linux-nvme@lists.infradead.org,
	Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, linux-pci@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rick Wertenbroek <rick.wertenbroek@gmail.com>
Subject: Re: [PATCH v4 17/18] nvmet: New NVMe PCI endpoint target driver
Message-ID: <Z2ELpuC+ltp5wDay@vaman>
References: <20241212113440.352958-1-dlemoal@kernel.org>
 <20241212113440.352958-18-dlemoal@kernel.org>
 <Z1xoAj9c9oWhqZoV@ryzen>
 <Z2BW4CjdE1p50AhC@vaman>
 <4d20c4f6-3c89-4287-aa0c-326ff9997904@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d20c4f6-3c89-4287-aa0c-326ff9997904@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241216_212707_642507_4FD28C53 
X-CRM114-Status: GOOD (  35.62  )
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

On 16-12-24, 11:12, Damien Le Moal wrote:
> On 2024/12/16 8:35, Vinod Koul wrote:
> > Hi Niklas,
> > 
> > On 13-12-24, 17:59, Niklas Cassel wrote:
> >> Hello Vinod,
> >>
> >> I am a bit confused about the usage of the dmaengine API, and I hope that you
> >> could help make me slightly less confused :)
> > 
> > Sure thing!
> > 
> >> If you look at the nvmet_pciep_epf_dma_transfer() function below, it takes a
> >> mutex around the dmaengine_slave_config(), dmaengine_prep_slave_single(),
> >> dmaengine_submit(), dma_sync_wait(), and dmaengine_terminate_sync() calls.
> >>
> >> I really wish that we would remove this mutex, to get better performance.
> >>
> >>
> >> If I look at e.g. the drivers/dma/dw-edma/dw-edma-core.c driver, I can see
> >> that dmaengine_prep_slave_single() (which will call
> >> device_prep_slave_sg(.., .., 1, .., .., ..)) allocates a new
> >> dma_async_tx_descriptor for each function call.
> >>
> >> I can see that device_prep_slave_sg() (dw_edma_device_prep_slave_sg()) will
> >> call dw_edma_device_transfer() which will call vchan_tx_prep(), which adds
> >> the descriptor to the tail of a list.
> >>
> >> I can also see that dw_edma_done_interrupt() will automatically start the
> >> transfer of the next descriptor (using vchan_next_desc()).
> >>
> >> So this looks like it is supposed to be asynchronous... however, if we simply
> >> remove the mutex, we get IOMMU errors, most likely because the DMA writes to
> >> an incorrect address.
> >>
> >> It looks like this is because dmaengine_prep_slave_single() really requires
> >> dmaengine_slave_config() for each transfer. (Since we are supplying a src_addr
> >> in the sconf that we are supplying to dmaengine_slave_config().)
> >>
> >> (i.e. we can't call dmaengine_slave_config() while a DMA transfer is active.)
> >>
> >> So while this API is supposed to be async, to me it looks like it can only
> >> be used in a synchronous manner... But that seems like a really weird design.
> >>
> >> Am I missing something obvious here?
> > 
> > Yes, I feel nvme being treated as slave transfer, which it might not be.
> > This API was designed for peripherals like i2c/spi etc where we have a
> > hardware address to read/write to. So the dma_slave_config would pass on
> > the transfer details for the peripheral like address, width of fifo,
> > depth etc and these are setup config, so call once for a channel and then
> > prepare the descriptor, submit... and repeat of prepare and submit ...
> > 
> > I suspect since you are passing an address which keep changing in the
> > dma_slave_config, you need to guard that and prep_slave_single() call,
> > as while preparing the descriptor driver would lookup what was setup for
> > the configuration.
> > 
> > I suggest then use the prep_memcpy() API instead and pass on source and
> > destination, no need to lock the calls...
> 
> Vinod,
> 
> Thank you for the information. However, I think we can use this only if the DMA
> controller driver implements the device_prep_dma_memcpy operation, no ?
> In our case, the DWC EDMA driver does not seem to implement this.

It should be added in that case.

Before that, the bigger question is, should nvme be slave transfer or
memcpy.. Was driver support the reason why the slave transfer was used here...?

As i said, slave is for peripherals which have a static fifo to
send/receive data from, nvme sounds like a memory transfer to me, is
that a right assumption?

-- 
~Vinod


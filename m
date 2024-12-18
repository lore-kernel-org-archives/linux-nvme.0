Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7927E77187
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Dec 2024 18:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KHOJiqKVQnsNRRLSpJJOEGdGWwLsbYNqZkkarmfrdyI=; b=Xht2pskhCquea5bX7dgM+MudNb
	IS0Ape59fayGDN1xjZbxcsKw33sZ+SAthTrQSc49Z4DO8pUK+3caYJoZLuK7UBGtrOuaMG28b4yvW
	ia0+iZtTQU8MMI5yALMewRKfzNeAsdvVs4uVHv1hH3txoPsEYJXBSK02gYwxh2ea7CPBtmrCYpwl4
	oBL0mTKu0Vz0nSwxIYBjQWzzfGBHzQ3xOVNFLF9biQNcAXsADd1PEZ3D1Mi9Y5Bj3WEgk1FfOTK/3
	Jla7mYyBJ17GS56XXeZTvH2F7i3YroHSktINO3r9zSQ4lXSBPn5waQCjdWDjFWqJdrP9jZ8ThCT1Y
	LF0BAcxA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tNyMz-0000000HNn8-0B7N;
	Wed, 18 Dec 2024 18:02:01 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tNyMf-0000000HNlJ-20b2
	for linux-nvme@lists.infradead.org;
	Wed, 18 Dec 2024 18:01:42 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 1C20D5C6428;
	Wed, 18 Dec 2024 18:00:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FA06C4CECD;
	Wed, 18 Dec 2024 18:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734544899;
	bh=oo1XoA+T2fMiKQK400DKv9gyYOz3DxtC48YXgAsvIDM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NBLmJnlKZ2oXOFUv3aCuvXvcIPouWRfNBGB0InZQG68taH/+gRBzEBQl8W4EPqdU6
	 Q9D/Iz+lBClBJwvdejutr39FDguQ8EaBcbIl6RrVdpRKhIHxX/dQ1WpaHclYo03RhX
	 kEXzXxcbsxLsNPWJ1lpJRB48lEFfp0zlV5/665hAucxknJhf0uLH+NN/wYsDy36Yh0
	 Vxl3wXmlzaji1AVLQTqEwMaIw9XbqNIr2lNpPM/Xz0jsD3cBv3kHTeXhzVvqpm2pSm
	 8m2d4dHBeATAfsSwHQgwyHs7xnEKHmnKoF/q0uzL9Vm4ap9gdicVCU7AMZX7X0OMSZ
	 BRTeU1BsjuXpQ==
Date: Wed, 18 Dec 2024 19:01:35 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Vinod Koul <vkoul@kernel.org>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	linux-pci@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH v4 17/18] nvmet: New NVMe PCI endpoint target driver
Message-ID: <Z2MN_9FJnlUuP7vi@ryzen>
References: <20241212113440.352958-1-dlemoal@kernel.org>
 <20241212113440.352958-18-dlemoal@kernel.org>
 <Z1xoAj9c9oWhqZoV@ryzen>
 <Z2BW4CjdE1p50AhC@vaman>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z2BW4CjdE1p50AhC@vaman>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241218_100141_627776_ED49F8FE 
X-CRM114-Status: GOOD (  14.91  )
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

On Mon, Dec 16, 2024 at 10:05:44PM +0530, Vinod Koul wrote:

[...]

> > 
> > Am I missing something obvious here?
> 
> Yes, I feel nvme being treated as slave transfer, which it might not be.
> This API was designed for peripherals like i2c/spi etc where we have a
> hardware address to read/write to. So the dma_slave_config would pass on
> the transfer details for the peripheral like address, width of fifo,
> depth etc and these are setup config, so call once for a channel and then
> prepare the descriptor, submit... and repeat of prepare and submit ...
> 
> I suspect since you are passing an address which keep changing in the
> dma_slave_config, you need to guard that and prep_slave_single() call,
> as while preparing the descriptor driver would lookup what was setup for
> the configuration.
> 
> I suggest then use the prep_memcpy() API instead and pass on source and
> destination, no need to lock the calls...

Vinod, as always, thank you very much for your suggestion, it is appreciated!


Kind regards,
Niklas


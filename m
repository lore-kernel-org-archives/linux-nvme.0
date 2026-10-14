Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 775EECC6B1D
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Oct 2026 12:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Mj8eaYaIpXG5aOowSDKXmEZblE5fqC4gitnzcNXoRwI=; b=YH2MDxr8/VTSu2xlsuFGNc7A/2
	PGJzaVULSDeEVqnk/b6Syb36HeTlgepvi6rKqXgq23eWSuonzj5b6Ogz++k2HSC2Eh2rN4L7jOokj
	+eLce6P3umvEF5d0WBGzYBqurPUyL7pkYwBzCx4Cc3ymYAtAP6U+8WmmDZoi67muvfjnacFxQPezo
	+5FmCWteRGplYbTyjFBG9uOc+Ab8LDKcTA3Jju/qlgmk+i/F6RmCfCKjDFFyh4kOgjT9xH5ITDHZi
	DwtTrDgWcMZVWqVR2rmfxY7dMmwm0yCpWEHGUmKYRksyhuGAFVKJ6OSKQtbIrmLXuhD/7q5fSWOyI
	ykPAjoYw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGyO6-0000000FUIV-2rB2;
	Wed, 14 Oct 2026 12:47:18 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGyO4-0000000FUHK-11iJ
	for linux-nvme@lists.infradead.org;
	Wed, 14 Oct 2026 12:47:16 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id EA8E143A18;
	Wed, 14 Oct 2026 12:47:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A89A61F00893;
	Wed, 14 Oct 2026 12:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791982035;
	bh=Mj8eaYaIpXG5aOowSDKXmEZblE5fqC4gitnzcNXoRwI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lfZgzP1ZzwxxvqLRWp7aN+tlYKAO9q0U8aeBmnO5DFPSx5AbKmtFTooWNWZopjIpr
	 +UmAYGtVVqhUl7sQ1/VMHa6QUlPju6VVK8mkCm0XME/iaNCvnS7kQmfqEJjupm7xcT
	 XbXY89okp9BUPg/GLIOG2lMBO2FedX01FlkOnbahnEfxfVQmUfVriQcS7rkwcCF1id
	 Zkl6pzOr07ZX0JiV4sOweiiG7u7ISm+bjTNw1v9uDINDYAfyqFdEm98fKvTggBOTEm
	 LrMCrtO8CDOHq/dSVMvegJ4LKzn+IiBUFUOMUEkwRzA+932qnLxaj5pSpGipH0huTZ
	 AcIiiiboXFNhg==
Date: Wed, 14 Oct 2026 14:47:11 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Andrea Parri <parri.andrea@gmail.com>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Keith Busch <kbusch@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 5/5] nvmet: pci-epf: require SGLs to match the command
 data length
Message-ID: <as95z6cPBLnPRgbv@ryzen>
References: <20261012141239.156408-1-parri.andrea@gmail.com>
 <20261012141239.156408-6-parri.andrea@gmail.com>
 <20261013142830.GF14759@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261013142830.GF14759@lst.de>
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

On Tue, Oct 13, 2026 at 04:28:30PM +0200, Christoph Hellwig wrote:
> On Mon, Oct 12, 2026 at 04:12:32PM +0200, Andrea Parri wrote:
> > The PCI endpoint target sends the host every byte a read command's SGL
> > describes, even when the SGL describes more than the command transfers.
> > The excess is kmalloc() memory the command never wrote, so the host
> > receives stale target memory. Any successful read can do this,
> > including Identify.
> > 
> > nvmet_pci_epf_alloc_iod_data_buf() allocates each segment at the length
> > of its SGL data descriptor, but sets req->transfer_len from
> > iod->data_len, the length the command implies. Once the command
> > completes, nvmet_pci_epf_transfer_iod_data() sends every segment in
> > full. Nothing compares the descriptor lengths with iod->data_len, and
> > the MDTS check only bounds iod->data_len.
> > 
> > Fail the command with Data SGL Length Invalid when the data descriptors
> > do not add up to iod->data_len, before any segment is allocated. The
> > tcp and rdma transports take the data length from the SGL itself, so
> > there most commands already reject a mismatch in
> > nvmet_check_transfer_len(). PRP lists are built from iod->data_len and
> > are unaffected.
> > 
> > Found by code inspection. Build-tested only (x86_64, W=1): no PCI
> > endpoint hardware was available to run it.
> 
> Looks good, although again having this validated on hardware would
> be really useful.
> 

Tested-by: Niklas Cassel <cassel@kernel.org>


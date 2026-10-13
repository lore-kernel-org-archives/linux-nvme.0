Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7CEECC6B15
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Oct 2026 14:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=e0bXnIVmQPzeeN3i7gTcD65OsjFJKEnBQphVM3A1HKc=; b=ZpY/OyjKc27UdAfOmEZiMYfH3X
	Ie5QgZZTwIkIl60YK4Tuwpi2efOuOZaEBLbfGMx3ez3r0T0jeNxFaDziExVwI6xqWa4LkBiGzKT5/
	526u3nitlVeDur2ryQLMHZ0hwfAOh0GjHm98tRBGnvgH4i2ajk1IW+yGSb1uCjNeLLPeWlB4cmI2/
	QAZGA32EgSpAVIFv2meMJu0C8l2qvJgOfKmmYIGt36n6JOEd1lcHdSIXvZPxaMTm+ReHlqaON1zd1
	KxdiEU6q+oQoASH7hr6kcbZt79qpuC60/RwVTj7NdRYD9ey/G29oa2QxNShG7DgRabVvnSOZdV6pV
	kbTxJWOA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGdUb-0000000D64j-2OKh;
	Tue, 13 Oct 2026 14:28:37 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGdUY-0000000D63k-2A9j
	for linux-nvme@lists.infradead.org;
	Tue, 13 Oct 2026 14:28:35 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 170A0227A88; Tue, 13 Oct 2026 16:28:31 +0200 (CEST)
Date: Tue, 13 Oct 2026 16:28:30 +0200
From: Christoph Hellwig <hch@lst.de>
To: Andrea Parri <parri.andrea@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>, Keith Busch <kbusch@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 5/5] nvmet: pci-epf: require SGLs to match the command
 data length
Message-ID: <20261013142830.GF14759@lst.de>
References: <20261012141239.156408-1-parri.andrea@gmail.com> <20261012141239.156408-6-parri.andrea@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261012141239.156408-6-parri.andrea@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261013_072834_709759_7C99B597 
X-CRM114-Status: GOOD (  17.33  )
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

On Mon, Oct 12, 2026 at 04:12:32PM +0200, Andrea Parri wrote:
> The PCI endpoint target sends the host every byte a read command's SGL
> describes, even when the SGL describes more than the command transfers.
> The excess is kmalloc() memory the command never wrote, so the host
> receives stale target memory. Any successful read can do this,
> including Identify.
> 
> nvmet_pci_epf_alloc_iod_data_buf() allocates each segment at the length
> of its SGL data descriptor, but sets req->transfer_len from
> iod->data_len, the length the command implies. Once the command
> completes, nvmet_pci_epf_transfer_iod_data() sends every segment in
> full. Nothing compares the descriptor lengths with iod->data_len, and
> the MDTS check only bounds iod->data_len.
> 
> Fail the command with Data SGL Length Invalid when the data descriptors
> do not add up to iod->data_len, before any segment is allocated. The
> tcp and rdma transports take the data length from the SGL itself, so
> there most commands already reject a mismatch in
> nvmet_check_transfer_len(). PRP lists are built from iod->data_len and
> are unaffected.
> 
> Found by code inspection. Build-tested only (x86_64, W=1): no PCI
> endpoint hardware was available to run it.

Looks good, although again having this validated on hardware would
be really useful.



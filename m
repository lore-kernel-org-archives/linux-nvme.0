Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA2E7C44515
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Jul 2026 16:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MH4EA/9Q4vMcKE/csYBaDf7EHyZDIanIpVZcoirKkdg=; b=RPv6tLHPLzVpDlVGfDgDCMaPv1
	spd4YVY5FaRJOW4LwQBrZP9TdzQ+sKCz9e2dJgov7TTcFgc0lpYlzjORkEc46UvNGHYPH2vqP3ylY
	V2EP7i05Rc0kMLR3EJ7fFbIkxhu6/fA9RDXpIEGGyV8K2OdKlMvgkSR/z7oB6AjP6eOKXNQR84MgK
	uwMmV3tk3DmmBc7MoIcBuB3DPjF0pAHGHrKPardGDG/gljjNR9FxSRLiB43NUs4Ho6m7M+JVlSlIq
	8qs59lXbPgor3qWTbo46Yq5wHistfwJ9JWSIxRBM9JsQGOe9ZqXscZzTUL+8IgWvxjgR1YBLjhspr
	i6OJ/k9A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wlqYP-00000007Jbo-1OKO;
	Mon, 20 Jul 2026 16:09:17 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wlqYO-00000007Jbd-1H6l
	for linux-nvme@lists.infradead.org;
	Mon, 20 Jul 2026 16:09:16 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id E0F1D4048A;
	Mon, 20 Jul 2026 16:09:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8428D1F000E9;
	Mon, 20 Jul 2026 16:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784563755;
	bh=MH4EA/9Q4vMcKE/csYBaDf7EHyZDIanIpVZcoirKkdg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ErsymfqArlZZKEf+CLB2/QdT1mzzA/cRgFIFpe98cOTFEiWPpaYpfYlWnfRMWjq4M
	 tLoCBRONpYk5+lv5xFxdHud8HFrpiASAExqGmhwpQpvVJKQdIFcpDDW5mYmmILpgn3
	 vr0bNkj0Arj0NzZs4Aip+6NJqJpv66AOMKHhdyCsWj5f6D56OdMnP/WjLFaUYM6SUo
	 U7ilIkf3ow30r7TOo85OMtLokulfhSnh0LijlS3YhsAUN11UKWJ/OJ1MGx6qAxDx73
	 evZy8dhdcN4nB8ZtwYlRpkfMDPv/EsxfaNcQCWCMDzQcxiDFD5zDkqfELK5NS2/M8U
	 btAXQhiihU99g==
Date: Mon, 20 Jul 2026 10:09:09 -0600
From: Keith Busch <kbusch@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: Mykola Marzhan <mykola@meshstor.io>, Jens Axboe <axboe@kernel.dk>,
	Song Liu <song@kernel.org>, Yu Kuai <yukuai@fygo.io>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-block@vger.kernel.org, linux-raid@vger.kernel.org,
	linux-nvme@lists.infradead.org, Li Nan <magiclinan@didiglobal.com>,
	Xiao Ni <xiao@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
	Kiran Kumar Modukuri <kmodukuri@nvidia.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Shivaji Kant <shivajikant@google.com>,
	Pranjal Shrivastava <praan@google.com>,
	Henrique Carvalho <henrique.carvalho@suse.com>,
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH 0/6] block,md,nvme: correct handling of unsupported
 P2PDMA transfers
Message-ID: <al5IJb-L0FpztnYz@kbusch-mbp>
References: <20260718162547.448892-1-mykola@meshstor.io>
 <20260720124304.GE110966@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260720124304.GE110966@unreal>
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

On Mon, Jul 20, 2026 at 03:43:04PM +0300, Leon Romanovsky wrote:
> It would be great if developers supervised their AI tools and kept
> commit messages and cover letters concise and readable.
> 
> Everything above can be reduced to a simple sentence: "MD treats an
> unsupported P2P operation as success rather than failure; update the
> code accordingly."

Thank you for TL;DR summary! The verbosity from these things is a bit
annoying.


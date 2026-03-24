Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F533FEC118
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Mar 2026 21:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uavJxVJD6COofSIdoLQ9QdM6HmYshFmtHbhL7rFiDYk=; b=Zttd8yt258Az5VJQUYwuKjsITm
	GPj8h1CaWPr2LCuO/lVA2Is1/Ak+cEnkkfPKI+VC/S4eqo4/CUDRV69vGE43riGjGv4K3qCzg3McW
	Cixpr8YwfOFf1Q0SCmtK05slBv7jnQPQcFeUwnkfkD264xZqx5Z1OcNB/56JsfVqNPHn0INf3chm7
	nWntj7IGxkHac75lku+Au77YtZ4u03HZHs1I5i9IdcpAi6cIUx2cZyy6/ubDBf8vpeR4/T9E6tuxH
	44qRj94/oSEqDzOaAnVjeB8BfItESXmVy5ZaQP5tHpRXjEE781haDXXhQs8xaLVcP/ZMMPShIaUp7
	vyDElW8Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w59Jn-00000002G0q-0ywO;
	Tue, 24 Mar 2026 21:29:43 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w59Jl-00000002G0O-0Yum
	for linux-nvme@lists.infradead.org;
	Tue, 24 Mar 2026 21:29:42 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 117A340200;
	Tue, 24 Mar 2026 21:29:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ED46C19424;
	Tue, 24 Mar 2026 21:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774387779;
	bh=u5/JBwfDXGvNqTWVPuFo0bB9nPHgweRS2A8ofbk3anE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j3n+HMLcWcBDA1xwtxPBKSsyNo7kCRij22d7lJyXjqnX8Oaqqic6ujJogGFevjmR1
	 EWFjEh/mxxXftRtpUpnnj4UZ6Mz4Wtq1HxQAZSWgn9T2VdrJjtQn1YJY4NmY6AST5x
	 csJOubrm4P7VakSKBb2RtAjjaaTLitu7AgHJ6WFzNaIfBk7Ivv7P3l4NelOM1i6yhd
	 V0dGgy28y/5nZmpJdOue/48fongIqSmzklKbs4NUXxKLU0DGo3jEROuFSw/y5ur0XS
	 rrQyf3JiOdHceDrM4Tf+vvfU7JhLGxvbXK7uhxWy7H8cIyBXxchONECQOZFfaIdW7Y
	 sZJT6BNNWqT3w==
Date: Tue, 24 Mar 2026 15:29:37 -0600
From: Keith Busch <kbusch@kernel.org>
To: Kiran Modukuri <kmodukuri@nvidia.com>
Cc: Christoph Hellwig <hch@lst.de>, Chaitanya Kulkarni <kch@nvidia.com>,
	"song@kernel.org" <song@kernel.org>,
	"yukuai@fnnas.com" <yukuai@fnnas.com>,
	"linan122@huawei.com" <linan122@huawei.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"sagi@grimberg.me" <sagi@grimberg.me>,
	"linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 1/2] md: Add PCI_P2PDMA support for MD RAID volumes
Message-ID: <acMCQaEOAqZEfyyT@kbusch-mbp>
References: <20260323234416.46944-1-kch@nvidia.com>
 <20260323234416.46944-2-kch@nvidia.com>
 <20260324064816.GA1409@lst.de>
 <DM4PR12MB8473B3907CAF51AEBAE573E5D548A@DM4PR12MB8473.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM4PR12MB8473B3907CAF51AEBAE573E5D548A@DM4PR12MB8473.namprd12.prod.outlook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260324_142941_191193_B79FA30D 
X-CRM114-Status: GOOD (  12.43  )
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

On Tue, Mar 24, 2026 at 09:13:55PM +0000, Kiran Modukuri wrote:
> Hi Christoph,
> 
> We tested with RAID0 , RAID1 and RAID10 only. You're right that parity RAID personalities
> need CPU access to data pages for XOR/parity computation, which won't
> work with P2P mappings.
> 
> 
> We'll send a v2 that moves BLK_FEAT_PCI_P2PDMA out of
> md_init_stacking_limits() and instead has raid0, raid1 and raid10
> opt in individually during their queue limits setup. raid4/5/6 will
> not set the flag.

I think the parity could work with P2P memory if the calculation is
offloaded to a dma_aysnc_tx. It doesn't look like we necessarily know if
any particular xor is going to get offloaded, though.


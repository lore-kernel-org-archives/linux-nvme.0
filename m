Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C3D7C4451C
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Jul 2026 12:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8dGgGRBOnBqV+dsZYwekjiT3b3Pykl1Pm0cR51M/NkQ=; b=N3RxpjiM+jO1m4jcuFInfFKxbr
	hegYOZ/DlY02gLKy2d7JgTUpnM0+CXYR2vWVcFz4yfevWURmKI33pqO1cxgCgHGN08pzNFKMRs0hx
	4Q9mzD2UL2WyV65YGBYykM/6UvDiI7jKprDdAqXiUGBYwwxoTC5nBqLbuTKQz+TC7ZSgwVSrnVjnK
	uwwkYH0NnAb7X+RBPHCA3njc1y6w2UdI67/ZyTo0vAj6CgWbmCgAlSheCMfrGWuK6yvoFPfM0w/4G
	CWuonSm6aQVsdS22Kf4WC+ToEf6G2MUTZdvIVEuINjR3F1LO7Ar+4Sef5kBfDVdPlYrs4pyi00kCv
	nb0hokrw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wm9ux-00000009SeX-47gE;
	Tue, 21 Jul 2026 12:49:51 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wm9uw-00000009SeM-2AbA
	for linux-nvme@lists.infradead.org;
	Tue, 21 Jul 2026 12:49:50 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 09A8F41767;
	Tue, 21 Jul 2026 12:49:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B73771F000E9;
	Tue, 21 Jul 2026 12:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784638189;
	bh=8dGgGRBOnBqV+dsZYwekjiT3b3Pykl1Pm0cR51M/NkQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=okewHL+lQSDnUkDIe2rF+y7YkwCHCcmd/szsIxxFs4ibtQ5SYQ/CphtjH7/Nff+3R
	 z6HEDUzWCTWvNhZVR1boGfBEkyeJB4cIviKoY2Dptu6FZ0F+0/xBRRc2ka+2WyJGgI
	 h6Ls9njrym2Hpv8cPoRX1sFqfAZzaMH+S04RVEdWI0YBIuQ27+DvqPibezQHVC+jDz
	 rQirZKMhVPZgkqmuf4U7jWUz7e4fTtp3rq/5GzXthgmKOECeq3Szp6/7PkOMTEmOuP
	 VWjlwKV/ctX4ywshg4yznc+UnhpK6aKXyHfRg0l9DVPuUZl35SaxCDTupORSoHpTml
	 0sRUjgpLTRGsA==
Date: Tue, 21 Jul 2026 15:49:44 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Keith Busch <kbusch@kernel.org>
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
Message-ID: <20260721124944.GL110966@unreal>
References: <20260718162547.448892-1-mykola@meshstor.io>
 <20260720124304.GE110966@unreal>
 <al5IJb-L0FpztnYz@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <al5IJb-L0FpztnYz@kbusch-mbp>
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

On Mon, Jul 20, 2026 at 10:09:09AM -0600, Keith Busch wrote:
> On Mon, Jul 20, 2026 at 03:43:04PM +0300, Leon Romanovsky wrote:
> > It would be great if developers supervised their AI tools and kept
> > commit messages and cover letters concise and readable.
> > 
> > Everything above can be reduced to a simple sentence: "MD treats an
> > unsupported P2P operation as success rather than failure; update the
> > code accordingly."
> 
> Thank you for TL;DR summary! The verbosity from these things is a bit
> annoying.

Yeah, too verbose and conveys almost no useful information.

Lately, I've started ignoring such submissions to prioritize commits
from people who put real effort into explaining what they are doing.

Thanks

